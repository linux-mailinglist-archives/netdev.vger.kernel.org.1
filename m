Return-Path: <netdev+bounces-279739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPrhFFsm5mmgsgEAu9opvQ
	(envelope-from <netdev+bounces-279739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:12:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9542B525
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A813038F65
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08B39FCD0;
	Mon, 20 Apr 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2sAVYW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEC39E6FF;
	Mon, 20 Apr 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690334; cv=none; b=hnNfpC1+ExMSZBKZ7yVCT4MbFtrO26N+KkKvRN9+gm/U/tF48+EnLzsox9TkPq696iBgj0MB6m2mll+EKz0W/wHxczLg5Dk88zJ4zEct+I/2JveKJvhaGK8CCjVgR4vZ2VWrrASZuZIFTTUBgrlXydhRu4aKtIOOZfpwEc4hvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690334; c=relaxed/simple;
	bh=2tdnNmWhva210aPxlaXggyu0lNkDimgucQTQrZ/IvEM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l4Nsc4ntRTNixwf48kNMjLTQRjgWhCYgpK7QwomO+zl2+CTtVX0adEo2fHzsYNA/P0SXQTyGnULV/Wsu2GwMnN1o1dQJj7JHpSVzaBN6K59QWFhC5X8tY9y19DvojqYAz8hBmAdj+WMvdvrLnBmQwdu+2GKTKhLUV3XCAlL8rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2sAVYW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C8C19425;
	Mon, 20 Apr 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690334;
	bh=2tdnNmWhva210aPxlaXggyu0lNkDimgucQTQrZ/IvEM=;
	h=From:To:Subject:Date:From;
	b=G2sAVYW50VkKFXdKuo2+trfqqw7NUQ4emzjUSDFdplMP9eMNPc2ub1AMADKJ2bPPU
	 3A8KrU4IgdjRv/ljhZthRuSOPQVmHURx/LxDOUE7ZqCDUcJewT2mH8LTNmZOVKEfXi
	 iitaAHg/uDSmxmRPdqnf+hpBQ8Hs7Y6+7t/5pP0MHTRu6vMF+OOWcUHXEOk7r/YKSy
	 QdZtOCWAPWGO8L9/CrritOG8IBrarReTXE/lC633fCndfeUXCsk+9cJRKVBiERs1/a
	 rdju4Xvur+XCRqylgnaZ1JL7Na08wdeBwkmldZl9l2XS23v1k2nC4N0fMch2VyO0PC
	 eGY0BkZiUC5bA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Date: Mon, 20 Apr 2026 14:05:23 +0100
Message-ID: <20260420130524.3527420-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A1F9542B525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tipc_msg_validate() function can potentially reallocate the skb it
is validating, freeing the old one.  In tipc_buf_append(), it was being
called with a pointer to a local variable which was a copy of the
caller's skb pointer.

If the skb was reallocated and validation subsequently failed, the error
handling path would free the original skb pointer, which had already
been freed, leading to double-free.

Fix this by passing the caller's skb pointer-pointer directly to
tipc_msg_validate(), ensuring any modification is reflected correctly.
The local skb pointer is then updated from the (possibly modified)
caller's pointer.

Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/tipc/msg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..9f4f612ee027 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 
 	if (fragid == LAST_FRAGMENT) {
 		TIPC_SKB_CB(head)->validated = 0;
-		if (unlikely(!tipc_msg_validate(&head)))
+		if (unlikely(!tipc_msg_validate(headbuf)))
 			goto err;
+		head = *headbuf;
 		*buf = head;
 		TIPC_SKB_CB(head)->tail = NULL;
 		*headbuf = NULL;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


