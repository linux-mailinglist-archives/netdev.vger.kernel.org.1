Return-Path: <netdev+bounces-177803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F39A71D49
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2469B189F15E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877923C8CA;
	Wed, 26 Mar 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/NwoluI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485821931F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010598; cv=none; b=D9mLDb939qfNuzqYmvtmIqBk7ncksBBD6Jh19bxhuc41Wa7fUS5DvsdZdPfD2XHLGa8zj9N17GKjx9YVF4Z9OfX1zLeFD8p26Ok4MKLAuboIUOo5QMzSwFsTdeMXTZmbn/f1TyjCa6r2NZQoS5HdQ6vLkGY+nR7Le7r2lCTL4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010598; c=relaxed/simple;
	bh=vGIy/gqnHFyYw1zNLX74nL87hgxD+AOu8owi54326H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P088VMxpGW4dL6lefTMmbtdQtP5erV9h9Lk83YNyb+FKFFCvMUHo3294Y5Kj2LybwuQCjmZBIWXAuYbxt/5uSFWJmjDHA2s3JZTqTr4jdl9nmcap2kA+dKiLpda6B8yQFh1Bldn7xz0bPw9ozUs8LlBGy89QwcX93NMymqeLSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/NwoluI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286DCC4CEE8;
	Wed, 26 Mar 2025 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010597;
	bh=vGIy/gqnHFyYw1zNLX74nL87hgxD+AOu8owi54326H8=;
	h=From:To:Cc:Subject:Date:From;
	b=C/NwoluIw2uxtp/Q1bkhSy2FVK1ShaeROoMzw3K8a5EK0J09hDYm/SrlwjoMqKvuw
	 wolrgDvX2Vyy4LP7q13KaijEuwFlFncB0Kh1Djlh6zP5Lj3juDs67GVDc8NgvlFqg/
	 15qA9zu4E6rpBBBFhtrOa7sDg4BHW8nyCYnBndhwI5dE9PpQRR5y12kwFBoJUhIC0K
	 rZm1r6bUTeV2hjq3oP8bb2pAYP3+utMMoKIZK3Gr4JA5BBul9dpOOzpbN2r2dQKNgX
	 Qn2uO6jTHh7F2sMQFzjkXo8bKIWQdEdWkGekRx0KFSNRWEWN9YFCbcXi34xWdB83PF
	 rrdk6GAg6t9TA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: decrease cached dst counters in dst_release
Date: Wed, 26 Mar 2025 18:36:32 +0100
Message-ID: <20250326173634.31096-1-atenart@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream fix ac888d58869b ("net: do not delay dst_entries_add() in
dst_release()") moved decrementing the dst count from dst_destroy to
dst_release to avoid accessing already freed data in case of netns
dismantle. However in case CONFIG_DST_CACHE is enabled and OvS+tunnels
are used, this fix is incomplete as the same issue will be seen for
cached dsts:

  Unable to handle kernel paging request at virtual address ffff5aabf6b5c000
  Call trace:
   percpu_counter_add_batch+0x3c/0x160 (P)
   dst_release+0xec/0x108
   dst_cache_destroy+0x68/0xd8
   dst_destroy+0x13c/0x168
   dst_destroy_rcu+0x1c/0xb0
   rcu_do_batch+0x18c/0x7d0
   rcu_core+0x174/0x378
   rcu_core_si+0x18/0x30

Fix this by invalidating the cache, and thus decrementing cached dst
counters, in dst_release too.

Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/dst.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dst.c b/net/core/dst.c
index 9552a90d4772..6d76b799ce64 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -165,6 +165,14 @@ static void dst_count_dec(struct dst_entry *dst)
 void dst_release(struct dst_entry *dst)
 {
 	if (dst && rcuref_put(&dst->__rcuref)) {
+#ifdef CONFIG_DST_CACHE
+		if (dst->flags & DST_METADATA) {
+			struct metadata_dst *md_dst = (struct metadata_dst *)dst;
+
+			if (md_dst->type == METADATA_IP_TUNNEL)
+				dst_cache_reset_now(&md_dst->u.tun_info.dst_cache);
+		}
+#endif
 		dst_count_dec(dst);
 		call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
 	}
-- 
2.49.0


