Return-Path: <netdev+bounces-106314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2239915BC6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A792B210B2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BC1862F;
	Tue, 25 Jun 2024 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WU24Ow2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4971805A
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279598; cv=none; b=MVJrenuv239WIpAV/czP4ohK+3QA3euznUEZtjcM9l5HMPL21froqDLGlWwAzZBnWaXoDg49sRIUMuZleVm37cV7zAa45fLsW7yRdZxPLnO8N2HOuewEvzDjNrY1qGte08XwEJAg71xisfnJD3PI+jcsKFAkryIbuiUaDmv2ZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279598; c=relaxed/simple;
	bh=kB3UF95fdqcid43d/4FfQLa+iACq8k/w/lH1lF8lpM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhANN3KYCrE164jl1OME28Gd8irXgon+noojOsztHHDpQPzqy5vxYpZQxLAYePYinzay/Ww6J/XjtNSOjHFAvEoVIVOf1IOZZF6fSnH07cDq8j/RpfMN0xDqgTmP5Mw+ZbOBv5v9rGkB0IZ12HGafzpSz4fTneBIf99wdWaxo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WU24Ow2U; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279597; x=1750815597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZasVir3fKHeM+OsoqX1xNfmIaAAUA2GBWOt5qfE77I=;
  b=WU24Ow2Ud4nS7G1CflosuXvt9hgqhiGOxO1h8kLsCBsS2PblsJk1tvNh
   kvDd/4Fayp8TXX84MaKIIFHszZOc4pr6aR/MkQ1Qk5OWp6t0rPwysYoCC
   VolydjJhvd08tbieeBMABEFnpWzhJcoZ8dpGBOKzBs2gTf63s6WTALGpz
   E=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="405471322"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:39:55 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:28682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.158:2525] with esmtp (Farcaster)
 id c98df811-e80b-4311-8df9-97bd9bdd35cf; Tue, 25 Jun 2024 01:39:54 +0000 (UTC)
X-Farcaster-Flow-ID: c98df811-e80b-4311-8df9-97bd9bdd35cf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:54 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 07/11] selftest: af_unix: Add SO_OOBINLINE test cases in msg_oob.c
Date: Mon, 24 Jun 2024 18:36:41 -0700
Message-ID: <20240625013645.45034-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When SO_OOBINLINE is enabled on a socket, MSG_OOB can be recv()ed
without MSG_OOB flag, and ioctl(SIOCATMARK) will behaves differently.

This patch adds some test cases for SO_OOBINLINE.

Note the new test cases found two bugs in TCP.

  1) After reading OOB data with non-inline mode, we can re-read
     the data by setting SO_OOBINLINE.

  #  RUN           msg_oob.no_peek.inline_oob_ahead_break ...
  # msg_oob.c:146:inline_oob_ahead_break:AF_UNIX :world
  # msg_oob.c:147:inline_oob_ahead_break:TCP     :oworld
  #            OK  msg_oob.no_peek.inline_oob_ahead_break
  ok 14 msg_oob.no_peek.inline_oob_ahead_break

  2) The head OOB data is dropped if SO_OOBINLINE is disabled
     if a new OOB data is queued.

  #  RUN           msg_oob.no_peek.inline_ex_oob_drop ...
  # msg_oob.c:171:inline_ex_oob_drop:AF_UNIX :x
  # msg_oob.c:172:inline_ex_oob_drop:TCP     :y
  # msg_oob.c:146:inline_ex_oob_drop:AF_UNIX :y
  # msg_oob.c:147:inline_ex_oob_drop:TCP     :Resource temporarily unavailable
  #            OK  msg_oob.no_peek.inline_ex_oob_drop
  ok 17 msg_oob.no_peek.inline_ex_oob_drop

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index acf4bd0afe17..62361b5e98c3 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -178,6 +178,20 @@ static void __recvpair(struct __test_metadata *_metadata,
 	}
 }
 
+static void __setinlinepair(struct __test_metadata *_metadata,
+			    FIXTURE_DATA(msg_oob) *self)
+{
+	int i, oob_inline = 1;
+
+	for (i = 0; i < 2; i++) {
+		int ret;
+
+		ret = setsockopt(self->fd[i * 2 + 1], SOL_SOCKET, SO_OOBINLINE,
+				 &oob_inline, sizeof(oob_inline));
+		ASSERT_EQ(ret, 0);
+	}
+}
+
 #define sendpair(buf, len, flags)					\
 	__sendpair(_metadata, self, buf, len, flags)
 
@@ -191,6 +205,9 @@ static void __recvpair(struct __test_metadata *_metadata,
 			   expected_buf, expected_len, buf_len, flags);	\
 	} while (0)
 
+#define setinlinepair()							\
+	__setinlinepair(_metadata, self)
+
 #define tcp_incompliant							\
 	for (self->tcp_compliant = false;				\
 	     self->tcp_compliant == false;				\
@@ -304,4 +321,78 @@ TEST_F(msg_oob, ex_oob_ahead_break)
 	recvpair("d", 1, 1, MSG_OOB);
 }
 
+TEST_F(msg_oob, inline_oob)
+{
+	setinlinepair();
+
+	sendpair("x", 1, MSG_OOB);
+
+	recvpair("", -EINVAL, 1, MSG_OOB);
+	recvpair("x", 1, 1, 0);
+}
+
+TEST_F(msg_oob, inline_oob_break)
+{
+	setinlinepair();
+
+	sendpair("hello", 5, MSG_OOB);
+
+	recvpair("", -EINVAL, 1, MSG_OOB);
+	recvpair("hell", 4, 5, 0);		/* Break at OOB but not at ex-OOB. */
+	recvpair("o", 1, 1, 0);
+}
+
+TEST_F(msg_oob, inline_oob_ahead_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("world", 5, 0);
+
+	recvpair("o", 1, 1, MSG_OOB);
+
+	setinlinepair();
+
+	recvpair("hell", 4, 9, 0);		/* Break at OOB even with enough buffer. */
+
+	tcp_incompliant {
+		recvpair("world", 5, 6, 0);	/* TCP recv()s "oworld", ... "o" ??? */
+	}
+}
+
+TEST_F(msg_oob, inline_ex_oob_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("wor", 3, MSG_OOB);
+	sendpair("ld", 2, 0);
+
+	setinlinepair();
+
+	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
+	recvpair("rld", 3, 3, 0);
+}
+
+TEST_F(msg_oob, inline_ex_oob_no_drop)
+{
+	sendpair("x", 1, MSG_OOB);
+
+	setinlinepair();
+
+	sendpair("y", 1, MSG_OOB);		/* TCP does NOT drops "x" at this moment. */
+
+	recvpair("x", 1, 1, 0);
+	recvpair("y", 1, 1, 0);
+}
+
+TEST_F(msg_oob, inline_ex_oob_drop)
+{
+	sendpair("x", 1, MSG_OOB);
+	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+
+	setinlinepair();
+
+	tcp_incompliant {
+		recvpair("x", 1, 1, 0);		/* TCP recv()s "y". */
+		recvpair("y", 1, 1, 0);		/* TCP returns -EAGAIN. */
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.30.2


