Return-Path: <netdev+bounces-264199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnoAnsrqWkC2wAAu9opvQ
	(envelope-from <netdev+bounces-264199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:06:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8B20C294
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5579302AE35
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CF2E1EE5;
	Thu,  5 Mar 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD25DdNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8013FFD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694353; cv=none; b=A9creqWpF/OOF9B6hn/MhYYYzs6LqhP0a9TCe2Slw6+/cEakjM/4a+lkbp1hk6gnpw9xARjn9YSR6vA8gOTnlOVH2iGZxiBT2Q01v79ubu1H7QOFJYgBMaTdjECNz4hACPZVtW/ZRp4Pp4yIHNzqBqtmfTTOXk50/1ErrWw7VUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694353; c=relaxed/simple;
	bh=zCHBKX6fR5XH4eMY5hlfkn9cGEBI29jvG5jRD+AfJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=likP8xgxz3Lhgs9he9/buP9Or1tbDFhiXcL1pjYpascbzdrqwCtRcbiL03jsZua7edmcEMnQJq0Mr3o0v+QJROjATpaQZfa6AlgAGLL11+89uVBPsZ/gVhu0Bu/EePNLOFuwbzlQYMe7agpoZjELfotbACMiqVgYygk6ku891ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD25DdNC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82980945556so296568b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772694351; x=1773299151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4rcC0QLYqGYT0hKcQ1570hvL6BTAAP3s/ctOq3zVbQ=;
        b=LD25DdNCIkFYjjzZ3+vboHe7RNW93B2EPTSsr3Q6AVbsuy4NCMW0JR5jO88i8UBpxz
         OvAuH2nxOdQ8g6OZY8yz+3wW2fRyttuLcNe2sZGYFDHQMzSiYgLAp1U+aBroY0c1TXn6
         MwSoAoiNg3wLbX9Euf/VyFKj+DXVTIw+WrSletPCoMdQzNzRSQnBYUTfaxOELVCYrK4D
         +EoGAw7U9uJcCFMk/LnochMjReqsFTEbfFJ2FHJ/w7OBvCf/gJcqeFcGMi2+4kAodH65
         8dt3gmtjlGVKLh/GvVk/mUz3SuTMw8A1OXRjYeTT/Afcd0FtTudNV5Nq41An7iiBxnHP
         JVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772694351; x=1773299151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4rcC0QLYqGYT0hKcQ1570hvL6BTAAP3s/ctOq3zVbQ=;
        b=dOMbrhHcTO7XwHfRPvW3iOwCLJBKcqqcxabA6fABIaxuoy8I5gn2H8qT+A/D9AZEBB
         gd2Pmm1bO094mhNoETRiKkc8OHIMlfRe9ZCtqHNLZsmbQXB+DVNYFEwj7y3oy3K8sJ+q
         h2JVdA+deLshl/TPPCs5Az/nuwTHqIZU7X81JXxOti5pVjRYs1w/VOx/3gNknGbqxtax
         TP92WfILeRusLQ774WKT/ILkCqbvDjuPnovRKmy1A8Zxq+64oTAJrZ/HNgstzv0QCTSB
         iwuq2uiZSGpn7ESDBzW7UZQq6IV/RzpDQj/UeCOpknJ+WCXtx0g8VNtrFGIsWLXc4pKW
         PXig==
X-Forwarded-Encrypted: i=1; AJvYcCW/3ThyWWPk4gh3qdSz71cD7GZx9QyNnTK1X+5GwF58G9MvAqL7udcAV7Dtz6Gr4KoW2oHXoLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDGjsIBpEM4vU7iMxVZ7nVd6nqTH9HDjWZ14yOMsnh7zIq0K8
	DfCgYWAtPLZ8KX3u2xMKh8DNRhaZiJp7gDKdBYWNnmfKYh1WptLn5KHo
X-Gm-Gg: ATEYQzz24W6FRx7cSOs4h+GBlVigd8LviYwcVtBLxpscU4Xd5bKycMmxTkvmhR+VLe9
	BCjK+ECwcy2E+gitVSdV4O4URtD0uuId4bOJ3heNqbIGh2KMYZlmqv5pMLWXF/WnO6Lk2pyiCnR
	B1bnjxqf4q262GEpOtdykr0OH6nnlHAnF+k1dU/qe/Gl9qai8y7USpeQ95b9nu0Txt1FCJ5c0iA
	TiYCuw2tmOSL5lWqz00WVKRQlqov5hXqkzixbWoD4es2sVNXfalvilQ4iTanLXP7GCD+gEfroev
	EDNyjoQEKXKAh5nCPr72AZfBlLGoBZ9gR08yQ2XtwexzX+T0JyYtIexDrWYAVt5rfSjghWgu/zW
	dZJwGTOjqdjnUeDHNSt7L00wxcww0kUq1xqYpU6cXE9GGqkH9NmNjk7mAw9Q2FlPZT8kW+gZG2e
	cZjzLxBO2V6k7b1HC5X8hYiirDI5cO+hLHSrNGHM8iXrLF/tcT/DBMiE4h2W4LVLGimcr+N17DQ
	a3L4JqFDag=
X-Received: by 2002:a05:6a00:4f8b:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-82972bcc04bmr4198718b3a.22.1772694351233;
        Wed, 04 Mar 2026 23:05:51 -0800 (PST)
Received: from saza-a1.tail796f7.ts.net ([2001:ce8:130:e043:5f48:7c12:1017:bc82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829793ae135sm2617599b3a.32.2026.03.04.23.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:05:50 -0800 (PST)
From: Soichiro Ueda <the.latticeheart@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Soichiro Ueda <the.latticeheart@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Miao Wang <shankerwangmiao@gmail.com>
Subject: [PATCH net-next v2] selftests: af_unix: validate SO_PEEK_OFF advancement and reset
Date: Thu,  5 Mar 2026 16:05:15 +0900
Message-ID: <20260305070525.184945-1-the.latticeheart@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62E8B20C294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264199-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thelatticeheart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
---
v1 -> v2:
- Add peekoffeq checks after MSG_PEEK to verify offset advancement
- Unify the length in the non-peek read

v1: https://lore.kernel.org/netdev/20260122033605.148626-1-the.latticeheart@gmail.com/ 

 .../selftests/net/af_unix/so_peek_off.c       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
index 86e7b0fb522d..9640a3975aee 100644
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


