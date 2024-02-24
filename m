Return-Path: <netdev+bounces-74689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59F8623A5
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7600F1C21C69
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AC3D970;
	Sat, 24 Feb 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Jx4GLIgY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AC3A1B5
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765497; cv=none; b=YXZlW0GZyXeh1e/vWQUdsiArFbZlUCVJ2kGXUtZ/2RIUwE46T1gocYh0du05sg3jbAuD6/Q5iJb+KtYq0DGT3fH05Bd/qFLCsc/ueNpae3T75Tv/3ZcW8Fx5v1WExYfVjjtY44M0VVyb70j4a/jskSEtPFuSfIwR3sPL23mE6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765497; c=relaxed/simple;
	bh=ekmIBLlaWKu+GWzGOa6EvRs4/d/ZpqSM2Pqyjmg1O/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbJmZE6LSTdu7pdFROGl7Tes1MwJN8D01j/RJRuvZAAMwUeq/dD3p7hM5koB1qLiNwrCf1GKus56oYMm9lAIZfkpHk0trllvZl/hltxmgIL2daN8SMCxgjizc7ddhI2Lh4VIxHqHw8u4mHX3B389pm55UDarmv/z6a2NNqPKp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Jx4GLIgY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129f33d2e8so292155e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 01:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765494; x=1709370294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuTwnbzDtMh7F3yHVkzWlgR2wGNYW8RXz1s/mbtmpWk=;
        b=Jx4GLIgYHXyqmSu+OLh3pBMYkyFh05gOApUjpjYqiq3SMBmdZtwStujpVvwYpgXj46
         vTJ1XNFWAKUTxLG7ObcnOkUHrOKGNQ+WNNnRF1xRm2u3kl1l1u0L0wwt2nsQgyA0yl4X
         8QF4JLmr+zmywRCPfaybQw8sa+D9vdHV0EzaIjc6AV4nV/EStm2BikHDa2V4DO0UWKP2
         V6P3MOnQMF6kTZLdr4szK6JuRVknVxNNRVTvzUbpYqmsg1d9M0fCjZVoJFtUIYYY0UIX
         XY5CT7iO22ZBDCkwooaiH8Hvooz2geCtZPfAQIl1U2IknKg/v2U5Lmt+UtGb3D+Bv+gs
         MbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765494; x=1709370294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuTwnbzDtMh7F3yHVkzWlgR2wGNYW8RXz1s/mbtmpWk=;
        b=xIn2x6azeLNPu7Jj4qGg1niwx3c/LjIMfF2YpnkFLi1pYyHDW2S8lbwQR7m9BrEgj0
         z6DPacA7Sf48MsjTg13uBjqyqwBfA9LbNof/3gZgTqZGJ/G+fqmSEN9MoGKD1xp0SykH
         MK4Y0LaE0QKATssmGVmMJmpXNWg8kGM5mzr4iSrziq1xHxHkaWtfT/Y7g4dJ92qjbK+w
         jNYc+POVlbVF+2hmemZGTlGBWs3uv8hAUCNmpydRfSOr/cE3PsXPTFn9iKwXxY9i4Njk
         DlPaJsYRcrWAkl4b2NhXkQmPiLXMBO/bbuZMNkpSUQj6Qi7nWJJwwKhKNZwcoRaV8aHC
         n9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxX9DMiJWzcnyeFHuNbySkYuJBpZ5T+5N+7He5eK08H0cu2XQEyft/+QLq+usK76ikyk8X5cdDRucjseX9Jy0qeyhJWb2t
X-Gm-Message-State: AOJu0YysXX7c97cONH1yNAgcSoGJdWmLyQVKLa19J9u41rDNmrjodVBr
	CfFJmeqxdJ+M+J0wwt54l7t2bUidIkrkJNfbFnzBnJo6oAdZrXnv/BFp9NHYIA==
X-Google-Smtp-Source: AGHT+IFjmi7saCM/UfHVyR0TQt+nRXG9hiKhS1Hy2SCvXp/ltJpiumI8VzAUgAFN+AtiuS5NZuYetw==
X-Received: by 2002:a05:600c:3b90:b0:412:6488:bbff with SMTP id n16-20020a05600c3b9000b004126488bbffmr1332546wms.30.1708765494014;
        Sat, 24 Feb 2024 01:04:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:53 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 07/10] selftests/net: Provide test_snprintf() helper
Date: Sat, 24 Feb 2024 09:04:15 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-7-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=1992; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=ekmIBLlaWKu+GWzGOa6EvRs4/d/ZpqSM2Pqyjmg1O/Q=; b=SGrLpjSzyoyJAX0/GI418io3uNbysLNAQ/zBPgtrgvHzRmp5sbt/Fl6o4nB0s9pLOE0EsixHB WIzmgkJA7qtATuXNnV7O0XD+Jk0vg11taa5p18BPXzBk167YiCxddP+
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Re-invented std::stringstream :-)

No need for buffer array - malloc() it.
It's going to be helpful of path concat printings.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h | 56 ++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index fbc7f6111815..fdf44d176e0b 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -37,17 +37,59 @@ extern void __test_xfail(const char *buf);
 extern void __test_error(const char *buf);
 extern void __test_skip(const char *buf);
 
+static inline char *test_snprintf(const char *fmt, va_list vargs)
+{
+	char *ret = NULL;
+	size_t size = 0;
+	va_list tmp;
+	int n = 0;
+
+	va_copy(tmp, vargs);
+	n = vsnprintf(ret, size, fmt, tmp);
+	if (n < 0)
+		return NULL;
+
+	size = (size_t) n + 1;
+	ret = malloc(size);
+	if (ret == NULL)
+		return NULL;
+
+	n = vsnprintf(ret, size, fmt, vargs);
+	if (n < 0 || n > size - 1) {
+		free(ret);
+		return NULL;
+	}
+	return ret;
+}
+
+__attribute__((__format__(__printf__, 1, 2)))
+static inline char *test_sprintf(const char *fmt, ...)
+{
+	va_list vargs;
+	char *ret;
+
+	va_start(vargs, fmt);
+	ret = test_snprintf(fmt, vargs);
+	va_end(vargs);
+
+	return ret;
+}
+
 __attribute__((__format__(__printf__, 2, 3)))
 static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
 {
-#define TEST_MSG_BUFFER_SIZE 4096
-	char buf[TEST_MSG_BUFFER_SIZE];
-	va_list arg;
+	va_list vargs;
+	char *msg;
 
-	va_start(arg, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, arg);
-	va_end(arg);
-	fn(buf);
+	va_start(vargs, fmt);
+	msg = test_snprintf(fmt, vargs);
+	va_end(vargs);
+
+	if (!msg)
+		return;
+
+	fn(msg);
+	free(msg);
 }
 
 #define test_print(fmt, ...)						\

-- 
2.43.0


