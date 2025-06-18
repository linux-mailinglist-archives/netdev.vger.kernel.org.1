Return-Path: <netdev+bounces-198889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD4ADE29A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B844E7A262F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60831FBC91;
	Wed, 18 Jun 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKfaLjoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F21F4C85
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221305; cv=none; b=FHp3lx9u3ldSZNVkuHfQ/T/KZEs/qXqMQD3VfQ1rB4lbG8Hfixw4DxqqkbrBwVDraKRFjnvgw22AaRLMaqKdmWI0bcKjK6cqUQif3nC1oD59W+ug3ResOl3WyFMOIJqzi7wJAF5KnBqrZayW93jSKBcYLTz6z4OJmmZOrf6mbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221305; c=relaxed/simple;
	bh=ssb4GBm5dYYBnXsZMUcW8gg9zOCe4d+NFki7j5/W7To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2vC9xF/GLIKtnYzldqp++flmnmGK/C2QFO02B/kFr3j5zO5EB/zXgrw8dfEVIZL3LsVVBEK89/7IPBKlCWPl5+OdpuoYgH391j728joqmuTKARNSeh5y2ihV8xIlaM5Sq670m73xYAVr6MPCB2T0W+L4dOLCVWwwFZX0ZY6bCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKfaLjoj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23636167b30so58104945ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750221303; x=1750826103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy6tf3vR0GcPt1uBsbwoi4exvIqNxkRHRZYhK6JzlJM=;
        b=JKfaLjojtJjU4x+pkaPkvGqOovRsGbaNDhQw/VxiqBuUa7KwVkr2V8t77ZMTlA2kw3
         OT6w0+KrW2B+wapT6ZbKAlBBmwT7YYC050eAZnahk9MWJdLRU/GINaueHL+/EdRSn8pO
         ymdv8OcFGadRWAtQZrh42LGWliZANA7FMxyAQOVWat7zkLpHRD4UBUme3A8qavmBJ+ak
         D5qBdSWppJpzLWCex0ApmExAhG3kN+SZFOudYKXxUfeX2T/E6LOb/S/LFvIgs3wt/17A
         ixT806xJXTuGxkmsIOIH+a7TWHfoJZhtfaFYsJVNWNHxcLYogyd271QgKTaldJdRMHBZ
         IRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750221303; x=1750826103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy6tf3vR0GcPt1uBsbwoi4exvIqNxkRHRZYhK6JzlJM=;
        b=AuhJYbY+Jd3HBqm9Hlj7ummAhcPMfA1kMwxAkGkbTev5thRrRjoLQx2xSDuDFEuWy5
         weJT0PpeBthGgTHQ2tYs9jtGBDxoPxcGWu1VeJeb2UM9+haj5ez0XYaaAVJNSSwBszTd
         icBlOixaq/tYuJncZSZHWqgjg2P8m7HzOHMxiExkIIB10ruoVCvyziaWzc9ueLy3bM+6
         1Fxc+ZmgSrF2J9gglp9sWkykou1RyksIGf5yPH34wpThyLuuK+JX0Sr7SGIswTyiP1nD
         kpG7IDWLa60A3/BMXVJcavBaiGB72OGPd13ph+g+zD5mHwaIXjmPDLOYng6jXhIT/23R
         ncyA==
X-Forwarded-Encrypted: i=1; AJvYcCUerKQ1X86tJ5DHsw2cqO1QCPymslzNe1wYgkNWSfrVNyuUd7nAuEHuvvPKUr6vguJJrF6dPps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZLkXPMWTVnl91863fkeryiCpiMiDqU5+5y3m/kiE+WbQM06g
	eS3uSffyP8iXtneDf1Fo42pU2msD9OEo4QGHoaIT9AWkLcfrQ24kRGc=
X-Gm-Gg: ASbGncvfmiQbdSnw5JyfDDRajFCXDNLhZU/GMBc9hSMnDIykc73ItxOExc42EJ4Ym8L
	ofKU4xPECMU1/5tLAshlg4F8aakdRGJ1N2DfI64YXjJBRRtvAJXbWfxCvwFrKBUPhP9oQg5Cii8
	1KVY2doNI+RSX3Gzcv0bYHRy5u4/jjVKPQ0I4m/A5GPnJODGWwATwRdL8W9CClP5xj95P7oV+LO
	7xTW5J3tD1zgRoj53S5+YRadTJuuJX/OFNg5VAS0/eKuVQUNLcf0P/8R47W/NgVUSPAsrH75KLL
	Jdx2mckrCarwYHffhz45Gyyu2qM07CdFdfi6JWebRt9+ZiUV5g==
X-Google-Smtp-Source: AGHT+IEHdyB7b3BxreKysfBUjEqjZe6HYLXNBDArGY7i8WCH8KpKgqoR5szAN2lsbyk7GqrbUmLDVg==
X-Received: by 2002:a17:902:ce8d:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-2366b3e3b48mr227732675ad.45.1750221303309;
        Tue, 17 Jun 2025 21:35:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77610sm90072225ad.135.2025.06.17.21.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 21:35:02 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net 4/4] selftest: af_unix: Add tests for -ECONNRESET.
Date: Tue, 17 Jun 2025 21:34:42 -0700
Message-ID: <20250618043453.281247-5-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618043453.281247-1-kuni1840@gmail.com>
References: <20250618043453.281247-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

A new function resetpair() calls close() for the receiver and checks
the return value from recv() on the initial sender side.

Now resetpair() is added to each test case and some additional test
cases.

Note that TCP sets -ECONNRESET to the consumed OOB, but we have decided
not to touch TCP MSG_OOB code in the past.

Before:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob ...
  # msg_oob.c:236:ex_oob_ex_oob:AF_UNIX :Connection reset by peer
  # msg_oob.c:237:ex_oob_ex_oob:Expected:
  # msg_oob.c:239:ex_oob_ex_oob:Expected ret[0] (-1) == expected_len (0)
  # ex_oob_ex_oob: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.ex_oob_ex_oob
  not ok 14 msg_oob.no_peek.ex_oob_ex_oob
  ...
  # FAILED: 36 / 48 tests passed.
  # Totals: pass:36 fail:12 xfail:0 xpass:0 skip:0 error:0

After:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob ...
  # msg_oob.c:244:ex_oob_ex_oob:AF_UNIX :
  # msg_oob.c:245:ex_oob_ex_oob:TCP     :Connection reset by peer
  #            OK  msg_oob.no_peek.ex_oob_ex_oob
  ok 14 msg_oob.no_peek.ex_oob_ex_oob
  ...
  # PASSED: 48 / 48 tests passed.
  # Totals: pass:48 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 119 +++++++++++++++++-
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 918509a3f040..b5f474969917 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -210,7 +210,7 @@ static void __sendpair(struct __test_metadata *_metadata,
 static void __recvpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
 		       const char *expected_buf, int expected_len,
-		       int buf_len, int flags)
+		       int buf_len, int flags, bool is_sender)
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
 	char recv_buf[2][BUF_SZ] = {};
@@ -221,7 +221,9 @@ static void __recvpair(struct __test_metadata *_metadata,
 	errno = 0;
 
 	for (i = 0; i < 2; i++) {
-		ret[i] = recv(self->fd[i * 2 + 1], recv_buf[i], buf_len, flags);
+		int index = is_sender ? i * 2 : i * 2 + 1;
+
+		ret[i] = recv(self->fd[index], recv_buf[i], buf_len, flags);
 		recv_errno[i] = errno;
 	}
 
@@ -308,6 +310,20 @@ static void __siocatmarkpair(struct __test_metadata *_metadata,
 		ASSERT_EQ(answ[0], answ[1]);
 }
 
+static void __resetpair(struct __test_metadata *_metadata,
+			FIXTURE_DATA(msg_oob) *self,
+			const FIXTURE_VARIANT(msg_oob) *variant,
+			bool reset)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		close(self->fd[i * 2 + 1]);
+
+	__recvpair(_metadata, self, "", reset ? -ECONNRESET : 0, 1,
+		   variant->peek ? MSG_PEEK : 0, true);
+}
+
 #define sendpair(buf, len, flags)					\
 	__sendpair(_metadata, self, buf, len, flags)
 
@@ -316,9 +332,10 @@ static void __siocatmarkpair(struct __test_metadata *_metadata,
 		if (variant->peek)					\
 			__recvpair(_metadata, self,			\
 				   expected_buf, expected_len,		\
-				   buf_len, (flags) | MSG_PEEK);	\
+				   buf_len, (flags) | MSG_PEEK, false);	\
 		__recvpair(_metadata, self,				\
-			   expected_buf, expected_len, buf_len, flags);	\
+			   expected_buf, expected_len,			\
+			   buf_len, flags, false);			\
 	} while (0)
 
 #define epollpair(oob_remaining)					\
@@ -330,6 +347,9 @@ static void __siocatmarkpair(struct __test_metadata *_metadata,
 #define setinlinepair()							\
 	__setinlinepair(_metadata, self)
 
+#define resetpair(reset)						\
+	__resetpair(_metadata, self, variant, reset)
+
 #define tcp_incompliant							\
 	for (self->tcp_compliant = false;				\
 	     self->tcp_compliant == false;				\
@@ -344,6 +364,21 @@ TEST_F(msg_oob, non_oob)
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(true);
+}
+
+TEST_F(msg_oob, non_oob_no_reset)
+{
+	sendpair("x", 1, 0);
+	epollpair(false);
+	siocatmarkpair(false);
+
+	recvpair("x", 1, 1, 0);
+	epollpair(false);
+	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, oob)
@@ -355,6 +390,19 @@ TEST_F(msg_oob, oob)
 	recvpair("x", 1, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(true);
+
+	tcp_incompliant {
+		resetpair(false);		/* TCP sets -ECONNRESET for ex-OOB. */
+	}
+}
+
+TEST_F(msg_oob, oob_reset)
+{
+	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	resetpair(true);
 }
 
 TEST_F(msg_oob, oob_drop)
@@ -370,6 +418,8 @@ TEST_F(msg_oob, oob_drop)
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead)
@@ -385,6 +435,10 @@ TEST_F(msg_oob, oob_ahead)
 	recvpair("hell", 4, 4, 0);
 	epollpair(false);
 	siocatmarkpair(true);
+
+	tcp_incompliant {
+		resetpair(false);		/* TCP sets -ECONNRESET for ex-OOB. */
+	}
 }
 
 TEST_F(msg_oob, oob_break)
@@ -403,6 +457,8 @@ TEST_F(msg_oob, oob_break)
 
 	recvpair("", -EAGAIN, 1, 0);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead_break)
@@ -426,6 +482,8 @@ TEST_F(msg_oob, oob_ahead_break)
 	recvpair("world", 5, 5, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, oob_break_drop)
@@ -449,6 +507,8 @@ TEST_F(msg_oob, oob_break_drop)
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_break)
@@ -476,6 +536,8 @@ TEST_F(msg_oob, ex_oob_break)
 	recvpair("ld", 2, 2, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_drop)
@@ -498,6 +560,8 @@ TEST_F(msg_oob, ex_oob_drop)
 		epollpair(false);
 		siocatmarkpair(true);
 	}
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_drop_2)
@@ -523,6 +587,8 @@ TEST_F(msg_oob, ex_oob_drop_2)
 		epollpair(false);
 		siocatmarkpair(true);
 	}
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_oob)
@@ -546,6 +612,31 @@ TEST_F(msg_oob, ex_oob_oob)
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
+}
+
+TEST_F(msg_oob, ex_oob_ex_oob)
+{
+	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("x", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("y", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("y", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	tcp_incompliant {
+		resetpair(false);		/* TCP sets -ECONNRESET for ex-OOB. */
+	}
 }
 
 TEST_F(msg_oob, ex_oob_ex_oob_oob)
@@ -599,6 +690,10 @@ TEST_F(msg_oob, ex_oob_ahead_break)
 	recvpair("d", 1, 1, MSG_OOB);
 	epollpair(false);
 	siocatmarkpair(true);
+
+	tcp_incompliant {
+		resetpair(false);		/* TCP sets -ECONNRESET for ex-OOB. */
+	}
 }
 
 TEST_F(msg_oob, ex_oob_siocatmark)
@@ -618,6 +713,8 @@ TEST_F(msg_oob, ex_oob_siocatmark)
 	recvpair("hell", 4, 4, 0);		/* Intentionally stop at ex-OOB. */
 	epollpair(true);
 	siocatmarkpair(false);
+
+	resetpair(true);
 }
 
 TEST_F(msg_oob, inline_oob)
@@ -635,6 +732,8 @@ TEST_F(msg_oob, inline_oob)
 	recvpair("x", 1, 1, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_break)
@@ -656,6 +755,8 @@ TEST_F(msg_oob, inline_oob_break)
 	recvpair("o", 1, 1, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_ahead_break)
@@ -684,6 +785,8 @@ TEST_F(msg_oob, inline_oob_ahead_break)
 
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_break)
@@ -709,6 +812,8 @@ TEST_F(msg_oob, inline_ex_oob_break)
 	recvpair("rld", 3, 3, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_no_drop)
@@ -730,6 +835,8 @@ TEST_F(msg_oob, inline_ex_oob_no_drop)
 	recvpair("y", 1, 1, 0);
 	epollpair(false);
 	siocatmarkpair(false);
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_drop)
@@ -754,6 +861,8 @@ TEST_F(msg_oob, inline_ex_oob_drop)
 		epollpair(false);
 		siocatmarkpair(false);
 	}
+
+	resetpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_siocatmark)
@@ -775,6 +884,8 @@ TEST_F(msg_oob, inline_ex_oob_siocatmark)
 	recvpair("hell", 4, 4, 0);		/* Intentionally stop at ex-OOB. */
 	epollpair(true);
 	siocatmarkpair(false);
+
+	resetpair(true);
 }
 
 TEST_HARNESS_MAIN
-- 
2.49.0


