Return-Path: <netdev+bounces-243850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06DCA8922
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970CE31DF7CE
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C734B664;
	Fri,  5 Dec 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcc/leu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3E346FB0
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954752; cv=none; b=SysEHXd7LH3rA8NZYT8GSu3ywR3orUNkbtdwPvE+r+z5kAkqZkCxiAejJP7VuBsGLITCfjzxBKOW1u7+UpnF/HTsqJnexjE7/yMxeaXnnG+H5hFNo4d3AwRBS0xBfsAcFskDaAkqGEv6qdHS+nnhWslMJudQfW/t2pCAPveV7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954752; c=relaxed/simple;
	bh=do1Bg/NFLX33ofPgfO966WaBXgkhnoSqIQc8ImWQeBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+UTxUA/VtVYSCdSveh3J1dENvi12GI0Db/pyztThIn4Fd79hPgrLwkrQTY1E7gbOLPdJZN3t18xnUNzYYkRO+PfxZQVT+Cx1OgMP+M6MVglVrQd7N4u5QP5Yxkl08hPWjysyF885gl3uJvjvoajkG9qU58owbSxoGNLhlZPf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcc/leu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1916244b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954741; x=1765559541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=JJcc/leubWpbR6RaFOVl0RXLRBCSczZylWdedplWoRQG8mdVWZ+zJQjfODMK291mvj
         t3pUpRf5u9YyPcJFXg2udcz7N/H5mfJ1h9/mMDnJN5VdKXV+E6dWEp5oIh4n8cvkmxdw
         tAKxsG9OdWEsRZAgjfhQCnAg3i0e6iit9eFbVTzOSkplGDEpNwbwCGSyrAjuFesV65Th
         HLFfOChvCg4B7wUs/2uq009bbRBd+Y61OW4F/q5uOXROne/qYlj3uwxTQYxLSPxa7MS+
         JCSeQCffGWKsEA9leDcJ89AtI9JpHWpxWELnyAwV6L8J9GuvftacqM8bTC0UoAtvardk
         UXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954741; x=1765559541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=ZwngE/PVv5VliBXITObT/7fjVPcpPYrKD+2zRLgURSLnqET/+uwHjavZ6fd16EbCHD
         naSdlnJZsAbX2I3+7IiSN66xTV5mPX1ancaHUt3TFsmVb9SXvOzm2YEQTG5/DNaZxAdC
         kLaoNCnfT895gc960uuzNrJ4PTLrvAKCj3aIsgFDE58BPqaEtaMKcRzZ9PoJFrANy5V4
         Dr1I9mlaHdwJwi1Yi8kx/YMuqBO/g3kWlU2Agj4nYb4W1kvSclxTHZhXR+T4Fbea10OF
         0LVg5RIvFdE3O75cpfrt7cqN4p894X3usFV+bxz0qOk2ergdNtXd+W0aRFoEOeRtAyzS
         rNPA==
X-Forwarded-Encrypted: i=1; AJvYcCWenipbmuIWsMkSnTqjglRkAUZOyOLWy6uFJ/LEFY6fUlqxeOIxu760ti05wbvS8mbyFVKZQTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbQz8iUn4WO07eTXiTnZafO3+SMV9fOI/AvoocxvjjTQa4Z6j
	LLk5xkUtixYwVJjsB2q3USvuxGqFhsuZ3EcwxxnVd9P4R2Dc0G6UNNG4
X-Gm-Gg: ASbGnctOz6Ghz43XOJ1a62sRmALXjTSWPgReypB2azTWCq7BY13wus48uOyKSYjyHC0
	b03yGE+uK6D6La7nLzQlZ1wje2+wFPTsEfZqqcDtLLIZS9zVWTlZk6H6miZ3ZlI6DG30inSjMjT
	pUqc6KiGfhdu2UdBenpe1xDeY5CWDivBhwyAo3bvPhjdg/sGuCQ7+VJuyDPXPwzI9gYHAu0pEbB
	T+ZaHywTm43ku0Vz2RISot8F8nHt+1nOAhUqjYjG/2u26M5CRjv+vY3XI7eI9CLChMOtygLolQB
	W9q9ZqR2c1dpGWbsbYaY45QNRvlHT3YONNfpY+33XcVbAs5Je1hrxcTOlA8sf06XgO6/6ydobB8
	oLPqo8qfYLUBTOBCE8rBm9RktKRah09PVoElboT0BEfpwpvZ2ChoWD3vjmfgyjvVbTeSlGDdTpF
	8zjZ4PaKWL4T8l2FKVCjCexvE=
X-Google-Smtp-Source: AGHT+IFUqGTh0jfpOherdnSNnGlDOOKwq7w7579tMDelh6u7LEtZVG3BYcM84jhxsPCvqwA1KoLyZQ==
X-Received: by 2002:a05:7022:ed08:b0:119:e56b:98a4 with SMTP id a92af1059eb24-11df6463bf3mr4137737c88.11.1764954740834;
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20699034c88.9.2025.12.05.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable warning
Date: Fri,  5 Dec 2025 09:10:02 -0800
Message-ID: <20251205171010.515236-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following warning is seen when building netlink-dumps.

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 679b6c77ace7..67bf3fc2d66b 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.45.2


