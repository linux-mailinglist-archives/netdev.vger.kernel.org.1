Return-Path: <netdev+bounces-23965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD476E53D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852E61C20371
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6A15AE0;
	Thu,  3 Aug 2023 10:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C511548F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 10:08:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F030C7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:08:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9BA081F889;
	Thu,  3 Aug 2023 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691057293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=23Ay3hsrYo2VYj+VfNj7TJtj73oCBJt38UDK+duMnBI=;
	b=QYaxrtm1kJI+1Ksg+y71AKI90h/WzSfRJk7Y0Zc93S/bbq5ya45TLSpNVYVJG5uBocklDk
	Gv3JC1JbK/ytDqYNmnsmNC4l6KN6cRsz4wKaEcQYVBvITDl4MCFVeTb9cZIV6tixOXWWfh
	kCEivq4YfZiTID90mWlK7FzxtHg0JYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691057293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=23Ay3hsrYo2VYj+VfNj7TJtj73oCBJt38UDK+duMnBI=;
	b=kG3/8PQBqpXoSNZD8Qr1v3lspQ3PtvivUfQ8hrH7fMLdq9QzCyIh+NJMALAvhcxTuwwBz5
	i9r9yq8Ir79k+NDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 789502C145;
	Thu,  3 Aug 2023 10:08:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 65C5D51CA7B9; Thu,  3 Aug 2023 12:08:13 +0200 (CEST)
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
Subject: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Date: Thu,  3 Aug 2023 12:08:09 +0200
Message-Id: <20230803100809.29864-1-hare@suse.de>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When flushing the backlog after decoding each record in ->read_sock()
we may end up with really long records, causing a TCP window full as
the TCP window would only be increased again after we process the
record. So we should rather process the record first to allow the
TCP window to be increased again before flushing the backlog.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c1f13541708..57db189b29b0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2240,7 +2240,6 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 		} else {
 			struct tls_decrypt_arg darg;
-			int to_decrypt;
 
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
@@ -2248,20 +2247,16 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
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
 			skb = darg.skb;
+			/* TLS 1.3 may have updated the length by more than overhead */
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
 			tls_rx_rec_done(ctx);
@@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			goto read_sock_requeue;
 		}
 		copied += used;
+		/*
+		 * flush backlog after processing the TLS record, otherwise we might
+		 * end up with really large records and triggering a TCP window full.
+		 */
+		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
+						  copied, &flushed_at);
 		if (used < rxm->full_len) {
 			rxm->offset += used;
 			rxm->full_len -= used;
-- 
2.35.3


