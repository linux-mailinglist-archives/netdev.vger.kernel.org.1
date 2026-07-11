Return-Path: <netdev+bounces-306832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k+ouNxUgUmojMQMAu9opvQ
	(envelope-from <netdev+bounces-306832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227174152D
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:51:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IQ7fzOMN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306832-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306832-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981FE301E58E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAB3C1406;
	Sat, 11 Jul 2026 10:49:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8743C10B6
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766992; cv=none; b=a7SHBXTGfX36R1nZQ04PLGnjAqDfo6Ibi1nuG0mmchGnT1kwfxguid/i2aTNn6Rp12WjBq935KLuLN5Olny5bNlYyCabgdGfC8gY7vv+ksLkVctj/ggowqURJItDlzEmCqiZmdLVsfWOHLhEfMao7sr7/1uAe4/PDhyMXnHswc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766992; c=relaxed/simple;
	bh=qVH0rE+Dp0zBRmazSYq5tFlCk5UQ1xZNYgpiizSO5ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+qq/jiDaIHRqKZnan11AmUjpQCGNzKvMMKlhVfTiEIgFGxPCaR0XxOPl0SpNZWJs3G8IXgEZMT7gE/5MUq2bKiNLQo9BGLDisDjN1wz9lTPPp8D33u4QN/x7E1rGvwfrJLM69g6nOmD+hp7+UZ5K+TC9VEspKQemcs9QvbDA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ7fzOMN; arc=none smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15f6d667bcso219762066b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766984; x=1784371784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mm11Mo8gVI7sbUw9uPDF2V0V7cWThUCpdiq94YuU6K4=;
        b=IQ7fzOMN1VCvYfvW42f9zDhOiemWAxXFQAwp56Kh1EgNo8q3C+FcrSdccnxBw9kMbm
         kl58kyPYKF29Qzkqyj7G5hnIiRnWdf3yo1mfX8LM09J76b0ElkciImc1RkUBzOyW2s+w
         hNNPcmxyMLzm5ueMQ3D530F7qLUpMBbLeVkKsokROE2G55Wp/K6RmW81l0xCg/fa2O14
         wOha6M+yv0OU53M9sOV1M4BvDDSMbXArEMUl4HX43FxFIPzInl4hakLyp3qqbdd/sM1H
         APf7UX1AvhjzaLhTDtqfnfKqn2JFDC2oWfSfmzzV5ahaxbjBolZFaQLB5Lcvs2/DQwLX
         jiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766984; x=1784371784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mm11Mo8gVI7sbUw9uPDF2V0V7cWThUCpdiq94YuU6K4=;
        b=PN4JTMJHSSKv/EW2fSqxq0cPcHyT19RWSP8BEiF0OuHkqOFN0Tgn08yJz1mJKYVbOZ
         o6TerN7W09/b6zWyvAPBQuka9ltZgrIXUZmn07fbiPd9TRz/5z4pnT+h/mjanpNqK5dE
         zpi5zODd9nkQIHBBT3kEaVFxviTzyL+3Q45GspCFr7PU/zxWdfaTk1EwIDv73yosVTTi
         TBrnmlpke14RyEsuDfv//idBuHhto6+KlNviFkCMjWLVrwYnAJQ3RCeZh/rQq9wRe8Je
         tp/jwqWc7QjzEIq79uilSlgVOTQydPHhH4nemroZi9LzFQxwU9VLbCiS5h50ItMJc43W
         y/8Q==
X-Gm-Message-State: AOJu0Yz0lGaxpLOnmk196FTfTKzyiH5dZfYTsL7KsrQZpK+X47xtPEff
	3mHf19qxEweZnHEhof7lHKNBkxdwqk/WWJbDD5nqILfPCLYd7QU0sH5J5glw5w==
X-Gm-Gg: AfdE7cnJHwyLT7diQ8eCwUpw5yxsV6uFffoabFmdFAuxE7eZk+90+MtMqGp9bhX8V0g
	3+iIcovlIDr7II6IDbA9Xn5ivGrVvqP1020+sP7UfO5ITOeOEwzjPdt5bVZx4Ax7L4IH6DDP4Uh
	YqjFxIvc1qGIdXa9yifIyz6mvRZ9QkmQT+4f5lT8fAWwrKL/RUnPRxYL20AaNjICPyaHtZr41BI
	bm21kHCWntiJ4pEEnSEI9wDJDH4lruNuVR7u3R0/hQmr5kowjnbFPAKIZV3oklmO2SVqWqo570K
	jZscLNNh5oBhteopoApHrWL8dpeQTkbJWlcIA/KV24OA8hFV1OiqeMd3bu+64mRzclTy/92usIo
	jx9PXF5ERNWVrbnBJL4otTIDJt6oHCcHbAZwOORFEG9wzhAq9xP+9G4rTJvUC55MiSdmtlZP+Nh
	d1d08qJd7+N2/o3ODVF8V1wyVpYSKcgwPrWysSp+qXuf/yKJlJIuu+rhRt5ylh01Myhx622//gT
	ojvqOLAkbvWVXKenx3PNSiw2HZlw7dbixZoBlzM0Gh3WiXaKw==
X-Received: by 2002:a17:907:c510:b0:c12:8c41:3beb with SMTP id a640c23a62f3a-c161eaa5c2bmr89717366b.50.1783766983872;
        Sat, 11 Jul 2026 03:49:43 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:49:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 10/10] io_uring/net: implement device memory send
Date: Sat, 11 Jul 2026 11:48:39 +0100
Message-ID: <ad3d2185448cf828c65336fa4b71233098473a4a.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783614400.git.asml.silence@gmail.com>
References: <cover.1783614400.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306832-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6227174152D

Enable zerocopy sends with device memory by teaching it how to work with
IO_REGBUF_TYPE_ZCRX. There is no iterator type to represent what we
need, so do a little hack, pass an iovec instead and let a custom
sg_from_iter implementation to fill skbs with netmems.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/net.c   | 29 ++++++++++++++++++++++++-----
 io_uring/notif.h |  5 ++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index cf273d6f02b1..2ffbb59ceee4 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1497,6 +1497,14 @@ static int io_sg_from_iter(struct sk_buff *skb, struct ubuf_info *ubuf,
 	return ret;
 }
 
+static int io_sg_from_zcrx_iter(struct sk_buff *skb, struct ubuf_info *ubuf,
+				struct iov_iter *from, size_t length)
+{
+	struct io_notif_data *nd = container_of(ubuf, struct io_notif_data, uarg);
+
+	return io_zcrx_fill_tx_skb(skb, nd->zcrx, from, length);
+}
+
 static int io_send_zc_import(struct io_kiocb *req,
 			     struct io_async_msghdr *kmsg,
 			     unsigned int issue_flags)
@@ -1510,15 +1518,17 @@ static int io_send_zc_import(struct io_kiocb *req,
 	notif->buf_index = req->buf_index;
 
 	if (!(sr->flags & IORING_SEND_VECTORIZED)) {
-		ret = io_import_reg_buf(notif, &kmsg->msg.msg_iter,
-					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+		ret = __io_import_reg_buf(notif, &kmsg->msg.msg_iter,
+					  (u64)(uintptr_t)sr->buf, sr->len,
+					  ITER_SOURCE, issue_flags,
+					  IO_REGBUF_IMPORT_ALLOW_ZCRX);
 	} else {
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 
-		ret = io_import_reg_vec(ITER_SOURCE, &kmsg->msg.msg_iter,
+		ret = __io_import_reg_vec(ITER_SOURCE, &kmsg->msg.msg_iter,
 					notif, &kmsg->vec, uvec_segs,
-					issue_flags);
+					issue_flags,
+					IO_REGBUF_IMPORT_ALLOW_ZCRX);
 	}
 
 	if (unlikely(ret))
@@ -1545,9 +1555,18 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 		return -EAGAIN;
 
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
+		struct io_mapped_ubuf *buf;
+
 		ret = io_send_zc_import(req, kmsg, issue_flags);
 		if (unlikely(ret))
 			return ret;
+
+		buf = sr->notif->buf_node->buf;
+
+		if (buf->flags & IO_REGBUF_TYPE_ZCRX) {
+			kmsg->msg.sg_from_iter = io_sg_from_zcrx_iter;
+			io_notif_to_data(sr->notif)->zcrx = buf->priv;
+		}
 	}
 
 	msg_flags = sr->msg_flags;
diff --git a/io_uring/notif.h b/io_uring/notif.h
index f3589cfef4a9..2dfd5bf23302 100644
--- a/io_uring/notif.h
+++ b/io_uring/notif.h
@@ -17,7 +17,10 @@ struct io_notif_data {
 	struct io_notif_data	*next;
 	struct io_notif_data	*head;
 
-	unsigned		account_pages;
+	union {
+		unsigned		account_pages;
+		void			*zcrx;
+	};
 	bool			zc_report;
 	bool			zc_used;
 	bool			zc_copied;
-- 
2.54.0


