Return-Path: <netdev+bounces-265901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Or5GT3Ir2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:29:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9F246538
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726F0302C6DC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CC3E5EF5;
	Tue, 10 Mar 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECLqjXlF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD73451AB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127717; cv=none; b=OyeDJuI3FDHB2qgNu6o7fMuMypS95DnMYZMtKdiIoa/blV4+AXp6kgoJ1mcQoeeTuijZM5nrhrQ6u+Zal8kB7HFMRIwfD/aTkF0Xt7GjyQpa3h6rs1VAVtZkxjPtH9w03tcPxcubK1UqNR3W9mIWwbB7Zp0i5f5y3pQWqNe6c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127717; c=relaxed/simple;
	bh=RaUCuVLqqaAz0qqCFRLgvY1/9vy7sYbyn9KfSGSSmFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDxKiIOlpj/QRX3vRSqGm8eTUAsTyCrigDSojrtchchN3kkWje/f1HKc49LTuzgf1qoH0BljqEutCwsRCnwMUwAFSl0Go4OLdrAzNyzY8LPffoylqVKxnyIbRxX9RNn7uYM68q/QqCF2VZiTT1yUyZx6v669kdchzmXiEXyLAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECLqjXlF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35982fd8910so4132339a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127716; x=1773732516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5b7x3iexx3oDwiXrtY9eVbEYVTCyP5aQdngDqmKFek=;
        b=ECLqjXlF79Cqdd/sG6QgiKyVNKlPBU8uIorb8iZ/ORjmuDCbSP5o4IV/r8uazk2SmP
         CdM/m28AKep6Tx6P9cN8yd3rls0+83nN7UC3qcGj2Edk/JosScLh1RbEg8ewhgAbDLVT
         dSLxYwwipfwBgFtxT5dw17OgpMvp/7u6TB/l0NuUW0A7cJ0ydRsE+/H4Igp9Y/Jwr7Um
         9leWznuE0EG7JnQyASEuof1mqb7fZ3NuedyOEl72hYvddYjcvPLmDBBHCcCPvM1vWzs5
         vj1UJYvjc5ZtZ72ns1XFK7wNm+ySQI3HAfVHf0n4YLa2aYDLqMt1vQdv34tozV+u3h6P
         nHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127716; x=1773732516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5b7x3iexx3oDwiXrtY9eVbEYVTCyP5aQdngDqmKFek=;
        b=bdB/N5GI5BQ2WXbXJwIx15P6iZUTsBiS/r3uxWfGj4jbTsuCBetGuczVTu85PmnBeo
         mcYONTkOTZYVJacaFlo+QySbQwBF3aQk3gEtg6d8aZA19Jaj3uWmDK8Z+N94n8LZ1068
         MGIE/L2NfB1UkVc7O7Ks6Rq7zba5T8Y2DzOKLqgtgXPj64vV5XzOjTlddgO5CPruuJ5T
         TqaYrKo4gne82FvmozkugXSAsUI7yUroCqg94Af7dqSstGsXvbalfWp2oRl/5DpgLkxl
         WyW67lwWT4jw+SAfcKaewlum4hIkQnslH4Qc5kOqKfiNOqOw85K5ULEZoyIIeHPFJ+Yc
         Cbpw==
X-Forwarded-Encrypted: i=1; AJvYcCW4s0nOW21xxQAkOWOFkBJPjCtKmv2AcX+IppVHBgABNSSCU5KsJuRFmXdEYADQkuCwxvltn7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIO9oAiytQqBiQdBGQ3cBRFrKRKXPgcdrRiAerBBN/NC0iWE+3
	1SQTChKBttQKRZ5VcF4Z5fi8CecCvOZENsRQ+tBUbRW6A/hu8FiaXFey
X-Gm-Gg: ATEYQzwleXk6R88kCGHj/zbrjnsm/Di9n/r48udmEPp/19Z6WWY6ETqC1T72T59FlAU
	q5TIzyO1qElpr5bSeElG+OdJi7olfPO7i6evLSr31lsv7QyXdKJk0f1YZaYh7pd5uj45K0z9vdg
	vq1YvpoMXZhce+SMuR9d8Jk7XICQSLZ7Nnz28kgxTn5ZXDsum1Rp2pBaazZzhOaBdRX4DwhWdij
	PEwP5gdiUJ5+9Gav3agq60zarza91aRlPSAZqvnh7rSTYhmkYmN34VekmD3fAcKnYWuOLbIpNU/
	ZtkaOSc0Ji2dECSDI6Giq2Sx/rgZFUmPFxnvVqTU+4gDnjPydEpTSb3Np9zsnNEFTbkPSyPFHBc
	HfE/nDMQJU5f39pqFNJLrR9EU13bEP5TUL1/LWD32x2npkRDYWipuiyj/RFD/LlzP6+GWwRhKqJ
	gvknXNWHSJ8TOKlf4vxWKo480ne56yyawdIxwK1i3H7dcoFMXT7dF0T7H2bYM+Yl8FOSRybWVaf
	xZDBDLzjzU=
X-Received: by 2002:a17:902:e5c6:b0:2ae:7f84:79e3 with SMTP id d9443c01a7336-2ae823840ebmr144117205ad.16.1773127715773;
        Tue, 10 Mar 2026 00:28:35 -0700 (PDT)
Received: from saza-a1.tail796f7.ts.net ([2001:ce8:130:e043:5f48:7c12:1017:bc82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8baa3sm151371455ad.65.2026.03.10.00.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:28:35 -0700 (PDT)
From: Soichiro Ueda <the.latticeheart@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Soichiro Ueda <the.latticeheart@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Miao Wang <shankerwangmiao@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3] selftests: af_unix: validate SO_PEEK_OFF advancement and reset
Date: Tue, 10 Mar 2026 16:28:31 +0900
Message-ID: <20260310072832.127848-1-the.latticeheart@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0C9F246538
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265901-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thelatticeheart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Extend the so_peek_off selftest to ensure the socket peek offset is handled
correctly after both MSG_PEEK and actual data consumption.

Verify that the peek offset advances by the same amount as the number of
bytes read when performing a read with MSG_PEEK.

After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
non-peek recv() and verify that it can receive all the content in the
buffer and SO_PEEK_OFF returns back to 0.

The verification after actual data consumption was suggested by Miao Wang
when the original so_peek_off selftest was introduced.

Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com/
Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
---
v2 -> v3:
- Reorder variables in peekoffeq() to follow reverse xmas tree style
- Fix formatting by adding a missing tab
v1 -> v2:
- Add peekoffeq checks after MSG_PEEK to verify offset advancement
- Unify the length in the non-peek read

v2: https://lore.kernel.org/netdev/20260305070525.184945-1-the.latticeheart@gmail.com/
v1: https://lore.kernel.org/netdev/20260122033605.148626-1-the.latticeheart@gmail.com/

 .../selftests/net/af_unix/so_peek_off.c       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
index 86e7b0fb522d..f6466a717f49 100644
--- a/tools/testing/selftests/net/af_unix/so_peek_off.c
+++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
@@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
 		ASSERT_STREQ(str, buf);				\
 	} while (0)
 
+#define peekoffeq(fd, expected)					\
+	do {							\
+		socklen_t optlen = sizeof(int);			\
+		int off = -1;					\
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
@@ -91,7 +104,12 @@ TEST_F(so_peek_off, single_chunk)
 	sendeq(self->fd[0], "aaaabbbb", 0);
 
 	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+	peekoffeq(self->fd[1], 4);
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+	peekoffeq(self->fd[1], 8);
+
+	recveq(self->fd[1], "aaaabbbb", 8, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks)
@@ -100,7 +118,13 @@ TEST_F(so_peek_off, two_chunks)
 	sendeq(self->fd[0], "bbbb", 0);
 
 	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+	peekoffeq(self->fd[1], 4);
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+	peekoffeq(self->fd[1], 8);
+
+	recveq(self->fd[1], "aaaa", 4, 0);
+	recveq(self->fd[1], "bbbb", 4, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_blocking)
@@ -111,6 +135,7 @@ TEST_F(so_peek_off, two_chunks_blocking)
 	}
 
 	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+	peekoffeq(self->fd[1], 4);
 
 	async {
 		usleep(1000);
@@ -119,24 +144,38 @@ TEST_F(so_peek_off, two_chunks_blocking)
 
 	/* goto again; -> goto redo; in unix_stream_read_generic(). */
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+	peekoffeq(self->fd[1], 8);
+
+	recveq(self->fd[1], "aaaa", 4, 0);
+	recveq(self->fd[1], "bbbb", 4, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_overlap)
 {
 	sendeq(self->fd[0], "aaaa", 0);
 	recveq(self->fd[1], "aa", 2, MSG_PEEK);
+	peekoffeq(self->fd[1], 2);
 
 	sendeq(self->fd[0], "bbbb", 0);
 
 	if (variant->type == SOCK_STREAM) {
 		/* SOCK_STREAM tries to fill the buffer. */
 		recveq(self->fd[1], "aabb", 4, MSG_PEEK);
+		peekoffeq(self->fd[1], 6);
 		recveq(self->fd[1], "bb", 100, MSG_PEEK);
+		peekoffeq(self->fd[1], 8);
 	} else {
 		/* SOCK_DGRAM and SOCK_SEQPACKET returns at the skb boundary. */
 		recveq(self->fd[1], "aa", 100, MSG_PEEK);
+		peekoffeq(self->fd[1], 4);
 		recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+		peekoffeq(self->fd[1], 8);
 	}
+
+	recveq(self->fd[1], "aaaa", 4, 0);
+	recveq(self->fd[1], "bbbb", 4, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_F(so_peek_off, two_chunks_overlap_blocking)
@@ -147,6 +186,7 @@ TEST_F(so_peek_off, two_chunks_overlap_blocking)
 	}
 
 	recveq(self->fd[1], "aa", 2, MSG_PEEK);
+	peekoffeq(self->fd[1], 2);
 
 	async {
 		usleep(1000);
@@ -155,8 +195,14 @@ TEST_F(so_peek_off, two_chunks_overlap_blocking)
 
 	/* Even SOCK_STREAM does not wait if at least one byte is read. */
 	recveq(self->fd[1], "aa", 100, MSG_PEEK);
+	peekoffeq(self->fd[1], 4);
 
 	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+	peekoffeq(self->fd[1], 8);
+
+	recveq(self->fd[1], "aaaa", 4, 0);
+	recveq(self->fd[1], "bbbb", 4, 0);
+	peekoffeq(self->fd[1], 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.53.0


