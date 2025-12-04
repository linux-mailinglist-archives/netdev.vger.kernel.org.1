Return-Path: <netdev+bounces-243616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74904CA4C45
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D542300C5C8
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B6346779;
	Thu,  4 Dec 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOlq2iP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B83446CE
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865069; cv=none; b=F5Syz8/cpFJVwaIukFh6ZJ/ZClokqHPCeixZUbdzYbHTYti2kAFjlQLSa3EIlKhca4e2kaDBJ2+WbWB97SmKx5uvSf8jsE6Bq7xhXY2IBfhotQ/9/SK6zlwnvpQbBfHMaGIq03MbZvdIJJq8ObfOUk+cMkKf7WIAS+XkLaBB/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865069; c=relaxed/simple;
	bh=n+63PlaZKOtY3JC7oD0NHAoiyAMuX1R4DVqHT3OXT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2GDuifK1W0ANzqif814mgZe00s/twA2Wj9EEomDsINZ5Nh9tqwRa+XeapvSPeLog5x56tKYMtgdJ+FhWSJJdfuy0BmiblMVpesyVrw0dHbBHvKQ4EmfD6ve2Ag/z/mE2yGqUZ2WfusdTleOfITvfkaCI50B8WM6I/qNTE1SkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOlq2iP5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298287a26c3so14397805ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865067; x=1765469867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCCLpF4Ehq3zOwzYA8afoq69odsanopMUq/fUvlXjFQ=;
        b=JOlq2iP51J7G3YXdkCYgXKa6DEwLRAqdXBk7GTE+ekyqGBf5p2DqIaAz4kE63DZN4P
         jJBHrOVyKZ2lpP1NmPTgSVwpyj+v2Rpes31ye0UIcjQXXrpK8w3ry+aNdQMPN2VbQI5z
         L5S7OLUH++YM1Ypv5Gjj2ElPF+fSpt7/W+p6OyByTuI8bh6/5DKVY0BFN8YgEKIpkYmZ
         ZaMm3pfQWxHJk874mk1iWjctUw+sKF/+LVRPEFJ3jWBzFRXB0WJ7twBOhSmUF+TNTBFJ
         WyF98J/khfEOnh8ReBqBgfRqTv09PXtfGz7lP+93STATQDxQWzbenlao/l9RQWWbWsBI
         a2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865067; x=1765469867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCCLpF4Ehq3zOwzYA8afoq69odsanopMUq/fUvlXjFQ=;
        b=EGNFTVFZY6D0acFC4Kz10JmJ9FH+aiXRZTC8AGDJG3YzXTxzTS5ozwCbJLck3+1twP
         vuCRLGIBwNKNMaTymI9jl9JeI/PJnqr0jO9Ladec8KCKVPJPhhRwgprcG+1FcZHqIDMJ
         k0Gf5cmp5vP6NxsGj82X1if1vUCjBUVMdb/A3MT3PFa0fp37i0hj0q/Kll2Qk0lx3Vhs
         98U9tmbaBJ3JasEGqKwwqkW1wgIawUh04DzavDVd/5M0iH+3dqX0VG4v5OhE79H39JKw
         toSGzLX3y2kTwHnnKBMZbs80GplOhdL/G5/h0Ab3XeFf/V119bHg597zHDV8HNEY6sI+
         1qVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT30pPjxaRra1rzYspjJP1jPln21iQtIk3xlIS8L0DSNtHbzPlpTz26mqVTyrfEO1jw8bQBMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJ/IQS8sv1T7vmPpZ5utWZw/0mppfM6eeRbHuyu3kshFUpB3T
	j4tAngSrVYam/OqvX5DJg81Cdi+KP3jH4rnMEZrKILTjRXwQzne/eqVL
X-Gm-Gg: ASbGncu+gPeU+TKf4kkEdpmMPG+62ymManUCl/z+V8mRNE6OVNmbu77qIrtxGlmIvLm
	608BU2la3YXS1vbCOk4XzL9FnFQ1I3l8hsCbA+tyHjc1Iz8UL2N9/f+A+two2rJkyR78yEenHn1
	y1fiIY3RgdDlxRsmShF3rJwDML26Y2SJ0RUtb+5SLUd69X+pSgfxudVbc4dc5I7uSVKNsxEHqIR
	Z1MN7ktJGoPaF36GZL6BjtK7ezeNQxHHrib8BiE5wnHFRW2/lWLrjYNqgSQlGof4smqdW7FE+ji
	FqRE1VeKMFWcbfXlZ5rqMGEurt2pyO1yp3Im5yF/ryPK+t+zhQORG1RWyY0ZBMtI20radEMvXCw
	PGGEarfIIcFOpVwS36HIl1VBY5xY22FiDN50OQmfepJR8rVEy/SpkqObetiPPH+wig0rH+VzgFA
	Kcy7h0EucZXSulz5tGBr1t54g=
X-Google-Smtp-Source: AGHT+IGwXZtkCtpHlnxx5n5SCCk5+vCVmV28uuWId4Yw4ZJRYdebw+DO5VRN6jCZbGc+ZKgDSsauCg==
X-Received: by 2002:a17:903:11c7:b0:298:603b:dc46 with SMTP id d9443c01a7336-29d6841440dmr81074015ad.39.1764865067038;
        Thu, 04 Dec 2025 08:17:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49c8a0sm23922255ad.3.2025.12.04.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH 10/13] selftests: net: Work around build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:24 -0800
Message-ID: <20251204161729.2448052-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
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
ksft.h:27:9: error: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: error: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of the affected functions.

Fixes: 2b6d490b82668 ("selftests: drv-net: Factor out ksft C helpers")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/lib/ksft.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c6..b3d3f7e28e98 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -24,7 +24,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	if (write(fd, msg, sizeof(msg)))
+		;
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -48,7 +49,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	if (read(fd, &byte, sizeof(byte)))
+		;
 	if (fd != STDIN_FILENO)
 		close(fd);
 }
-- 
2.43.0


