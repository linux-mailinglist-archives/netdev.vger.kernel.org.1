Return-Path: <netdev+bounces-252167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIOALZiccWmdKAAAu9opvQ
	(envelope-from <netdev+bounces-252167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:42:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B561616A6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB7DC34AC06
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8133469F;
	Thu, 22 Jan 2026 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrCP5EWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85A3E9F60
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053014; cv=none; b=fPQgNyLeH06d/cSI7dbOouQHDj7DZQ460a04dpgejDfmWXcYVC1XJPHUR/KlG6Ep1MGPB/omG6pueAsz43RgI+khWVs2eXjvzQR4pGgw79ILeiKDl+MFcaeoCnyzh6X/4ZWyFUzpzpdj1sJbmEN9WmNNFpfKFOXl57aaQBdKlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053014; c=relaxed/simple;
	bh=uyuvM0aNLOnUjRqDllF4aL0tkS2LZhJoag68I+HYTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSrUC+CNIyh9EAmdGfxuYjEuRUbadC30cS0Hul6ZYA2T+FYFWZBoBpYGG0cl1LSux+Abezj1UyjJcXnK9NP9UVoKPjC8I3qFgbDUtSSrbdXpjAoyJQLPQyQS33tyOBDXjerd3qgBMDiAoudtX92xO4KeI2jlZZig4Kf1H6Nm+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrCP5EWX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so319799a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769053007; x=1769657807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bw6r+Xu1T/HE7zupN8AkFEzrp4XxiXbr52xrEg03t8=;
        b=PrCP5EWXUidsEONTmzu9TfcI2I/EkgA29HiiYttgd+17p4OLdzerLnZMEi1bEDd0kz
         4F1b4ljOQYksVKJO8RmgmuRAJ0r9rbNCHY2r/SRA7Mj6zoau/XmpC43zy2fEG5Bsxsgc
         p3NDDilry03pNHY/kDw3jVLlbfgteh/xy7FDsgqMHkl0yjp1g6HOVUOnCVcBhFm4kvsb
         FJJ9fbb0+aYg6HlXfv9/uMvvDLum8zDnXJ1iFtpqt6tbeLaSgvyaoldRpEShnbqLgIO3
         ATQUX/DhwXMXqPzW72gQMwOWFAXE4oKUyzQWW/PVq2Jcd1QilJE+BLG3qNCnEyZumWWk
         BrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769053007; x=1769657807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bw6r+Xu1T/HE7zupN8AkFEzrp4XxiXbr52xrEg03t8=;
        b=dIfCVcrVBDhH7ncHyumpGybZOz5wCbIYQHK1zcBVoB6Z/XJrEmc/tHahuUtTgYMtcE
         qmuaGu3R0BB/JGpba9aBhJuGjNB3hGT9sZZqYtTCb3Ugfw6f9B6erMF4I4MUdoXC2Myy
         3wHV9/rRu8Ebhv4W0ZtF9ALqOBusM8WcEIjgR7RJNua7Ym4/EZh8emU9a2+qFad4h9kQ
         83k/7A798HMUiELDSx/1tm/jTRbt57JAZgG4dm6qPCBrxdovLhHE5y/e1qE6TWgayFAT
         a+Dz/qg1gA4A5m0zUCN+a2RGavaCnAL72EQonjk44y9VuQ4u3LuULpKrl5BzqJXkUVx9
         4B4w==
X-Forwarded-Encrypted: i=1; AJvYcCUAYhdbvteWUYUhxWEpL4RoTQ3z1MMVWujnpbWVt2CmsHwuOiOQa3DFZYoxMqB71lmlNqu1uww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuy9jtR7Ww07vBuIJ4QTHMrSmX7abVWpMmIlIi4lqHs93AUI6f
	FDLDLC6/jr8naaWXV9asSs0qc/n9BLCRtjqGEEvbzAD5NDr6USdDmy55sX2ugg==
X-Gm-Gg: AZuq6aK9GPuib4o1/Dj/NLVVybe/NEhQMDJdhgxmMjUm4unDRs9HqDFT7vrg1Bl5gWB
	X8kfZnKdGphxMzqMuMv4y6E7QZSavr/bVEH3xf5RzF7E+tgoeZl4C70as/HY1B/dIcp2+QIr/vb
	ZnJCGaX4O9Tb7eafQ+CsrZJtC8h6LCL9b+d0oJoVEpkuuqYIj/SiqGKYVSkYFLx7lTcly77K4Tf
	EsVwY8CpUAF4Gb5OtF97aYTM0Mb3xuHG106CuxWrRnHVQSWAGoOb2aIWa8DaFZNS2ySJJISZS2T
	UpXHVZJFgRlJJVVSoomRfOa4OF4ij7FX1inrD3f/EFAog7sY7fSLCPtqWv7otm8y53FpwBNDmrc
	BBdArG6aov3VQV5vuPtR1vAJ/I3YmM8wT+tT4nbhWaWHTLwcgqofbSnkDzt+VAFhGTdd1ePyiWf
	0xU5A/9Ttq7chVUyfZ8zHGEAlKaR5D/yY85DpC9TTV2alP8ACWGZz0aTp5sNdmsHw7bv6ZizbO
X-Received: by 2002:a05:6a21:6088:b0:334:a523:abe7 with SMTP id adf61e73a8af0-38e45d56ab6mr6526512637.27.1769053007414;
        Wed, 21 Jan 2026 19:36:47 -0800 (PST)
Received: from saza-a1.tail796f7.ts.net (nat-12.kuins.kyoto-u.ac.jp. [133.3.201.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf357044sm16428514a12.25.2026.01.21.19.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 19:36:47 -0800 (PST)
From: Soichiro Ueda <the.latticeheart@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Soichiro Ueda <the.latticeheart@gmail.com>,
	Miao Wang <shankerwangmiao@gmail.com>
Subject: [PATCH v1 net] selftests: af_unix: drain after peek and verify SO_PEEK_OFF reset
Date: Thu, 22 Jan 2026 12:36:05 +0900
Message-ID: <20260122033605.148626-1-the.latticeheart@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-252167-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[thelatticeheart@gmail.com,netdev@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[ams.mirrors.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4B561616A6
X-Rspamd-Action: no action

Extend the so_peek_off selftest to validate behavior after MSG_PEEK.

After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
non-peek recv() and verify that it can receive all the content in the
buffer and SO_PEEK_OFF returns back to 0.

This improvement is suggested by Miao Wang when the so_peek_off selftest
was added.

Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com/
Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
---
 .../selftests/net/af_unix/so_peek_off.c       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
index 86e7b0fb522d..813e3b3655d3 100644
--- a/tools/testing/selftests/net/af_unix/so_peek_off.c
+++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
@@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
 		ASSERT_STREQ(str, buf);				\
 	} while (0)
 
+#define peekoffeq(fd, expected)					\
+	do {							\
+		int off = -1;					\
+		socklen_t optlen = sizeof(off);		\
+		int ret;					\
+								\
+		ret = getsockopt(fd, SOL_SOCKET, SO_PEEK_OFF,	\
+				 &off, &optlen);		\
+		ASSERT_EQ(0, ret);				\
+		ASSERT_EQ((socklen_t)sizeof(off), optlen);	\
+		ASSERT_EQ(expected, off);			\
+	} while (0)
+
 #define async							\
 	for (pid_t pid = (pid = fork(),				\
 			  pid < 0 ?				\
@@ -92,6 +105,14 @@ TEST_F(so_peek_off, single_chunk)
 
 	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+
+	if (variant->type == SOCK_STREAM) {
+		recveq(self->fd[1], "aaaa", 4, 0);
+		recveq(self->fd[1], "bbbb", 100, 0);
+	} else {
+		recveq(self->fd[1], "aaaabbbb", 100, 0);
+	}
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks)
@@ -101,6 +122,13 @@ TEST_F(so_peek_off, two_chunks)
 
 	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+
+	if (variant->type == SOCK_STREAM)
+		recveq(self->fd[1], "aaaa", 4, 0);
+	else
+		recveq(self->fd[1], "aaaa", 100, 0);
+	recveq(self->fd[1], "bbbb", 100, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_blocking)
@@ -119,6 +147,13 @@ TEST_F(so_peek_off, two_chunks_blocking)
 
 	/* goto again; -> goto redo; in unix_stream_read_generic(). */
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+
+	if (variant->type == SOCK_STREAM)
+		recveq(self->fd[1], "aaaa", 4, 0);
+	else
+		recveq(self->fd[1], "aaaa", 100, 0);
+	recveq(self->fd[1], "bbbb", 100, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_overlap)
@@ -137,6 +172,13 @@ TEST_F(so_peek_off, two_chunks_overlap)
 		recveq(self->fd[1], "aa", 100, MSG_PEEK);
 		recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
 	}
+
+	if (variant->type == SOCK_STREAM)
+		recveq(self->fd[1], "aaaa", 4, 0);
+	else
+		recveq(self->fd[1], "aaaa", 100, 0);
+	recveq(self->fd[1], "bbbb", 100, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_overlap_blocking)
@@ -157,6 +199,13 @@ TEST_F(so_peek_off, two_chunks_overlap_blocking)
 	recveq(self->fd[1], "aa", 100, MSG_PEEK);
 
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+
+	if (variant->type == SOCK_STREAM)
+		recveq(self->fd[1], "aaaa", 4, 0);
+	else
+		recveq(self->fd[1], "aaaa", 100, 0);
+	recveq(self->fd[1], "bbbb", 100, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.52.0


