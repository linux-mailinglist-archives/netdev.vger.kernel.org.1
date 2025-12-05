Return-Path: <netdev+bounces-243852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE1CA8928
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950DE30840D3
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36FA34C128;
	Fri,  5 Dec 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgLQK5KO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFD346A14
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954757; cv=none; b=Fj1NGwfMABzZTvh/myCluzUbLkXLK35mCZc88TrJ5L5hTTF9OmGSeUcgr/zIs3xzLccs5YQGN0ldwSBpSI5vfdJiLDbpixnNyQIFD917sadmfxBN/7PwyOqQhQl/qf9noeu/GJWEeoAAFNXZ+n1yanwWVl4r9Zpo5SoYfv1zqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954757; c=relaxed/simple;
	bh=yuIIgf/alWIG+QnlbE0mlEBwwSslOpyY/5j2tQg/iS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXO0RFAhjOhL6LpNoSGS8Z0n3V6ChGOzcOSljN0T7sHbBKYSq7uTbNvEs24quo36k9wPwgcxy1iQ455z+f0n8rLqtxKgq4ReaByn9b/eXhPW0GCkVpTKb1vt6sslGSxCWPKlZlXtKqVSgUK0e0kfyIup4twnJcfMjMfaGJ1xFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgLQK5KO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so4083224b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954744; x=1765559544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=HgLQK5KO1PT5LLG8pa1wfajjkS3nhaQVsSlNLlmuAp7tLqBCnx64dM3Nqr/H/dQKRu
         1bs3e6eJXb10j5mBn2YJPHLC4vdf9keDT3y3jFI2+k88UXm2CFM/S9Y0gvrLtAr3brDR
         Z2sdrXHDlj/3+VOVBOist5mCdzbnCZFVjlknMYK6N3KrbM3tYO17YQfhxg5exdA/0Gb0
         qZ4ABMR+iDEz+sowXHc0Szym3OAOuWm9bII03Jn0e8pRCOcD/LgqGvSg7X6uUQDlXShK
         vIxuIaDa9K53v/02iFIEU5XuQe+5RXz6bgrYhXNMxTnNYkn1bG6THXdUnLPTVukCBoV9
         Dp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954744; x=1765559544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=CxvgigOEkIgNsDklcGpxGz8Zyf+2bc4peRrXnN7ui9VtbiGHg1WkbuNhfJQFyvzEfr
         ALuqqTQklRbrZRG1pes3p6lRsykIaprMfCIOMndrFFOeiKY8HMjy6lq+KIrg7Dg3Jw/6
         hpffZiStogvEwRIGUpXuQszn/JOX12wQFp32zRULpueBsquXUbk5qnNIFVo/GqOtMei8
         xsr04awb4hQCuikWHHU2Jq/ysJjm3Kkmsp5CrCMCynZw1Msupa+EWQ7G2H4ZxvuqfFMe
         dtYZZLR9WAWfXuksWdNP38RvqpncVq6XaiWKNzJY44b/JyLSz2vM06fxZHw50b7sMgPf
         pcZg==
X-Forwarded-Encrypted: i=1; AJvYcCW70nm1MTDPiwPMXGTpjlIrliwaVzj1EbjXyHzPEYnEsnKwO+Xw5gciioDWJ6BjbaRvgZEHpjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7F+LFQhcpa7E8XIbyB/ardvZnkNo42sVNvBsYKQAmyN1qBSkI
	mC9Tv1j1ra3iBac8NI4glKzZD64rVtdjhDeJzcjiQSu05eG/UppcewhM
X-Gm-Gg: ASbGncuu9G4z7x3iwILeunodc6zlVDGFEmdGtC/910F2tpFcDjhBs4i8CPSsmZpQY+s
	yKC1OMDhiMHbTuc3NGpyYXj+ftt6wuoDWjczQVi5+eUzNq+qNYorN4jJ/TD9pkCPQVSMVjxUpDY
	Owt3GSImt0ZN+KWgKX/V0dtfQlAv6A8ot6mjTckIEmlNHMEsVT4B50P8RsMo5M00JMToZNzfOH5
	/PNy2TWWz4Q25jbsh+mg4vwEiG8KCgeDoI5o8ClReed8V8WdukFKKTBiJtaAt6hqbgHLMWZE4NL
	Q7TV9taHUmfTI7ymkCjewjVkGInqJ55Ak1/gqgUaOMgHsZg7PQLDG3a+gB/UnV64rH7PMnZVHwk
	c7E7HJGJ8NJ6MMVHGpw+E2CSnauMEKKkj8YH2j8Pt6mQ3Kbxh4h+8KM5cjW+eSIdoEnILH6hyHh
	tks6BqC+06TfDB0wXlnfdp9Kk=
X-Google-Smtp-Source: AGHT+IF6pVDWfDwXkq4xnlvBOGGFZK9hjfQ59/B+jw1lZUA9k+IMOEvrgSx0HezsT2H83Dv+hHEutg==
X-Received: by 2002:a05:7022:4191:b0:11b:8161:5cfc with SMTP id a92af1059eb24-11df0cd9712mr8471296c88.36.1764954743550;
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm20210155c88.4.2025.12.05.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH v2 10/13] selftests: net: Fix build warnings
Date: Fri,  5 Dec 2025 09:10:04 -0800
Message-ID: <20251205171010.515236-11-linux@roeck-us.net>
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

Fix

ksft.h: In function ‘ksft_ready’:
ksft.h:27:9: warning: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by checking the return value of the affected functions and displaying
an error message if an error is seen.

Fixes: 2b6d490b82668 ("selftests: drv-net: Factor out ksft C helpers")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings.
    Use perror() to display an error message if one of the functions
    returns an error.

 tools/testing/selftests/net/lib/ksft.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c6..03912902a6d3 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -24,7 +24,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	if (write(fd, msg, sizeof(msg)) < 0)
+		perror("write()");
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -48,7 +49,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	if (read(fd, &byte, sizeof(byte)) < 0)
+		perror("read()");
 	if (fd != STDIN_FILENO)
 		close(fd);
 }
-- 
2.45.2


