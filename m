Return-Path: <netdev+bounces-24790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB9771B32
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EA1281184
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB973D99;
	Mon,  7 Aug 2023 07:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B7210D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:10:28 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890ABE78
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:10:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2A5D22189B;
	Mon,  7 Aug 2023 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691392225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdnNPe9x6gIbmIISAnn80bWKgLVTtTKLyV6yho1UrN8=;
	b=gbPVndzk1qiyMm3VX8KoGMLIUAxrAmu9qaYVdL7neQWrd9SF8+3HMsHkSyiO5fqqpBgDP+
	Dpe03HBFA6L8vs9jPn9ssZqabSvsSBZ3GMdgR1zDcts+KOVdJYrBpRm45niUH4YcQuTZtd
	DwJ/Lva1PzimXsBhQbC8JrCfiJIKz+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691392225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdnNPe9x6gIbmIISAnn80bWKgLVTtTKLyV6yho1UrN8=;
	b=eSSZ6X33K8v63XA64TqfEbTUzXPEUwm4I9h73y1FRNlnnzuzrdklU9Gq7dI2ZKxiM7tG4x
	dWocFqVVqHmCpjBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 38ABA2C142;
	Mon,  7 Aug 2023 07:10:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2671151CAB59; Mon,  7 Aug 2023 09:10:24 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
Date: Mon,  7 Aug 2023 09:10:22 +0200
Message-Id: <20230807071022.10091-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When flushing the backlog after decoding a record we don't really
know how much data the caller want us to evaluate, so use INT_MAX
and 0 as arguments to tls_read_flush_backlog() to ensure we flush
at 128k of data. Otherwise we might be reading too much data and
trigger a TCP window full.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c1f13541708..5c122d7bb784 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2240,7 +2240,6 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 		} else {
 			struct tls_decrypt_arg darg;
-			int to_decrypt;
 
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
@@ -2248,20 +2247,18 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-			rxm = strp_msg(tls_strp_msg(ctx));
-			tlm = tls_msg(tls_strp_msg(ctx));
-
-			to_decrypt = rxm->full_len - prot->overhead_size;
-
 			err = tls_rx_one_record(sk, NULL, &darg);
 			if (err < 0) {
 				tls_err_abort(sk, -EBADMSG);
 				goto read_sock_end;
 			}
 
-			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
-							  decrypted, &flushed_at);
+			released = tls_read_flush_backlog(sk, prot, INT_MAX,
+							  0, decrypted,
+							  &flushed_at);
 			skb = darg.skb;
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
 			tls_rx_rec_done(ctx);
-- 
2.35.3


