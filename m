Return-Path: <netdev+bounces-243619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9CCA4735
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A8130BEA5A
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE64347BD7;
	Thu,  4 Dec 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GimTvkxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A30346E5A
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865073; cv=none; b=hwMvhDlv4jN5DuyDjhnL6fE21pzGPaVJJB9FgpP8qQu9O7GU8ASLmvCoMCwuYCPIQLVyd8sBPHcA9i0u4YF4D+VFfb8ax/LJm5CvbWY1Z9HnENny4HXArewRlR0djJVSDq1LORk5CSSOa5Tyf9elpOxQ1Jok0qDMDgSoYqZkjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865073; c=relaxed/simple;
	bh=hvBzVJ/t5S4W+0QfdLWGGsqd7XL8k70zq4O5nv/Dcr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQcwHpjlPgkUj2IE4QUBkscAvpP0ohx6oLaXgDegmeFugkR9OZ5wjQ7ORLQphK3vjpbPML+A0taZVrFbF/Z6jYnaZEzOoVs2hRiyfp6mwHZq/GiHfgRQarkyObXU+ATaUExeJ7C5WwUqD7F0wC+UXtQUqXcu4KAq8Ainu+zLl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GimTvkxD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so954403b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865071; x=1765469871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtcDJ2mVgyjaj6aViXY89VVDbVIB5/tZZgz8kR81SQ4=;
        b=GimTvkxDa4GEmS6OaSYR+NRO2eV5nVMVGkuDX6w106taj0O1qrBchWogoZsORUXn6v
         Q0oeu+COkHIhXi6s1vqu4j97YS7PE4v0wYbgMS3+f5r4vOP/y+df08GcUPdtn18y1CNy
         HydH/w7M437Cjcw1vrQLcIdnqBf/DCZ90q39AQ+4uPtnkUHTGPznvKco6cdiYBsYlOeT
         JGdpsBJfyWvCRyYgWE73XxDZuLo4epi8XWXziNUah0dH4tde782c3ZEei7B0VJ6Dibxu
         vlxw/fs+p7aVibauTg6IVlYPZyFLOeBpv3h/8NSyspJvJBWMib16BhzpsbCiOASu367G
         1NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865071; x=1765469871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtcDJ2mVgyjaj6aViXY89VVDbVIB5/tZZgz8kR81SQ4=;
        b=d6cd1G27q9uSRvGrTNT3E0CYpD5HZWLRWOUkHhSDuD/u/v02Q3md/wazqqwEDtx+1k
         erblpCcR29DKeOcske+4RRvJrm5sZpDPp3ATRTVpcZhMXvxtVTR+8LQ0ENQSAdNABjgj
         q2nF4DYfbtGPKb6X1pxYhrFfIlRyBPFwtXkHRKGSJOsZy91nxbpG4LZHwO4RQBbr3llD
         OOSjiP4MLnAZ/9OEJvr4fsgiLt5GV0SH9DUm9MUxMqSZ1jMQrvZrkWbPSKtBYx2eo78K
         esB1OPwF2cGIeAASf6TvkIxWr+r/tyoJUdy2eaD3xPX/IsOqcAHw/xKqmFZc5SiXDVTG
         LNeg==
X-Forwarded-Encrypted: i=1; AJvYcCUMBovD9ABbstVCZeEwXywpzdNqRLkwn2Hr7u9qR0XjhJIcviMgf4OkTDMAtMwsdU4aBfb1ISw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjz/YKmED6bOA34tm9Sm+E+bKm/mx8sQO5WpMcDGXnor4pQj6
	Zh5C6f7lzI3kGkCnGZHlbOMs+IX92vaN8U1OWfpxwR3UinICin07QPNR
X-Gm-Gg: ASbGncvt7UbwWiOMBN6PuhduoKelY88x/IlALDXKW1QJWtZ0exo3dkj+L2XY5KzAFxJ
	Xn+M+CKWu/WQEWS/oLOd82BCo7RQbqHtcg1q9LvHhN1Nzl+L1Es5ga9UjuK4UGUzJmiyYWZkBb2
	VsF3eP3fePbLO3PEK8FbgHZi/g64BXueHyBDe+RGpJcu+ygwLDwJa7Yc11uBzqes734BSlNWT3M
	FBwpmyP3rmboL893AkQnSsIB6egZ5qXZUxfEmcQDN2H33Gk+uQDkz0ugwz1dMYXTo93brYyi/YZ
	EdAAKzdoiP6R9nczkDoLhqus9CYnGc+ZPMYwx6U+Y9VOlZBS0jkCQWqGLtg7/6qPxFir6K6P1Xh
	db2uBdQNRq0Ir1YxMAgaGdTdC+PPBaGnyqb5YlaQtEYU0krijR4fFiNkBXaWlXKnfKZKfwdtk9B
	Rbyx0wz2zaeBlN1AW40LoY1mU=
X-Google-Smtp-Source: AGHT+IELXCFH6Mtkssje8B3cs8uw1+jhPH5HgX3Ko8rfICAbJsoeX6/ZNHe8e/JC9Q9qMDz8dOKgnQ==
X-Received: by 2002:a05:6a00:92a0:b0:7b7:a62:550c with SMTP id d2e1a72fcca58-7e226f2b644mr3780242b3a.1.1764865071205;
        Thu, 04 Dec 2025 08:17:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm2640524b3a.7.2025.12.04.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:50 -0800 (PST)
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH 13/13] selftests: net: tfo: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:27 -0800
Message-ID: <20251204161729.2448052-14-linux@roeck-us.net>
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

tfo.c: In function ‘run_server’:
tfo.c:84:9: error: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by evaluating and then ignoring the return value from the read() call.

Fixes: c65b5bb2329e3 ("selftests: net: add passive TFO test binary")
Cc: David Wei <dw@davidwei.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/tfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..0126e600a36b 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -81,7 +81,8 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	if (read(connfd, buf, 64))
+		;
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.43.0


