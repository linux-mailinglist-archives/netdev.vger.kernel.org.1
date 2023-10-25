Return-Path: <netdev+bounces-44318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9D7D78B3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0978FB21300
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B238FAD;
	Wed, 25 Oct 2023 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfnDFh29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930A381C9;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7242AC433D9;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277033;
	bh=14cp60kxcA5TVRPTGt8VB60tSh4oksh/vqRJXjj+jbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NfnDFh29/lHX0BPfEhKUwJ8adq4UjmBRIPZoOGX+f10umDk+V+XzRX0VWGLRII3d4
	 k6qrOWSUkZx3pssac70sGtp4/QufTYZgmJ7UQemm9zeOwizX5kFD97dmq6u7U4ieHJ
	 E6vu/1m3WcmRCshN9NybAY9veSUEg14td2Nc8pHeuGkOc+bQnXq0NylUbVLKfJe+Go
	 5ZwMueWKXFBVjGFhlclYCOQUoxIQQx+wXE8uk++HUGykNazA0y8GuYgjV0DfkSqOHJ
	 Cxt19Psl4i/ukk86QRSaLGQ4gCnmjb1Q869Brk02uq6OpSkPNfCjpdo613++uvnEvC
	 H9971ptOop2jQ==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:07 -0700
Subject: [PATCH net-next 06/10] mptcp: use mptcp_get_ext helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-6-db8f25f798eb@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

Use mptcp_get_ext() helper defined in protocol.h instead of open-coding
it in mptcp_sendmsg_frag().

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a29116eda30a..a0b8356cd8c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1267,7 +1267,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 * queue management operation, to avoid breaking the ext <->
 		 * SSN association set here
 		 */
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
 			goto alloc_skb;
@@ -1289,7 +1289,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 		i = skb_shinfo(skb)->nr_frags;
 		reuse_skb = false;
-		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
+		mpext = mptcp_get_ext(skb);
 	}
 
 	/* Zero window and all data acked? Probe. */

-- 
2.41.0


