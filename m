Return-Path: <netdev+bounces-67547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285F843F8E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51FF1C21ECD
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59F7866D;
	Wed, 31 Jan 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRguDUDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C979DB6
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704877; cv=none; b=aJRcNMRInB9aUN9lm8H+xJmgyDto216IEfsxChJKNkDdsg9CsXwxNLSVUSASXgP4q6W7JQVcdHo+5QTvn5Wa7rgnwn3VD+8ntESCOkPpAJJ9Ufy6+oNvGo0TWNG1Rp0Tx6ghmvCuzuWZfsx1ArC9kl8YQsnHMMbwi69QtUaWsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704877; c=relaxed/simple;
	bh=C9FvG+muFxnWM4gWPk79YjLj/clQ7ayjm9pqfpYTWHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EY6v08xkTAJmY9iE+6zAL0T6CJLWI8DFjL2MnBSp2aiPypITud990I8ogZEFMxJKhrGlPUYS9DZGvPnic92X3j4Wwzh+qXw/ObCu3ZZMIfc+RqVy4hQVFP9XfunbL/fSd4KaCi8+ER8cY57SPfKnZReTmlkt6gBE/CVzEqbqKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRguDUDM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5101b4e46f5so1826132e87.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 04:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706704874; x=1707309674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAPLkgJQPwV/XsK/O2PNU5hGuOCBaPIAMiaaW2E/Eb8=;
        b=PRguDUDMFx2vxYgVGYXiSqAKyQ/+o3hYe/H3oEB2dNdM+4nCgkW1AMkZ1Zz6Pm6+8K
         deDhafg2Qkg6D/D2ax7jj/WXK3RV+fhjaw32p4PhZ2oO9WANiQt7PZnXMY6M7u2k/Vo/
         Ni0tDoYgXoB/739F7jvXffoXTRDCHuvqimTWtVR2t1tBvgHwE14q9XBW24GLtiFUzjhY
         oIF+18YYioEfvfhJLZv9Yql02VcbX/Ig3F+lC//Amdfeqtdp2f0OG14ro/ZcGE2QtZMx
         FLX+Srr9A1r3Mx8c2ieUCo2Z8VMjc/No0K3sFaIjtWkABvUfOCF2ePn2I3bW10gPQlSM
         Woug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704874; x=1707309674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAPLkgJQPwV/XsK/O2PNU5hGuOCBaPIAMiaaW2E/Eb8=;
        b=cjoej0a9g1EkP5lpZxKBTTS1Tu88IpDp2Gl5YQc1ls5UT3txZjlb8Z1/BL9gKaRagz
         WRQ58IxmncxN2lI+rdUyAMd1BsTgeFoDrXF3dQEvjp3Ti1P/gaTOHrd2wyaVsjKR4m3I
         LESXi0BeFL7FITNy18AJMbzjyk0agrbTlpVp0MhyN3EQeCYndG2C70cZhFbH4E+eXcI3
         1siLXygf4SUqfM+jALBBEEnOSVRse7HJ1Yji7J51EKBJd2YMzF7Oh+Sx/6NnFYC/qKI+
         01Jb3VpCte2SZDjjmoa4820P9HmZFxjyP+/qvXNnNOOWATOhSqEFN31mWlkINxOmCou6
         yoRA==
X-Gm-Message-State: AOJu0YwC0BUziNBs3sdx1xpyfq5ILYvSJ4gZx6LmdyngPcym+P3ztKKl
	3PcqZkYQCVLK2gxOeO2z1WHQQ2AjJDaagVXCgKzYnkmv/n7WtRoF
X-Google-Smtp-Source: AGHT+IHKYw6Pyz6zBQy4E6iIqg9vYCQijoKD7ogp/01vZc2zhwFYJHUghTeJfjvDsDQwD6jNGl8dxA==
X-Received: by 2002:a19:8c4b:0:b0:50e:337b:f316 with SMTP id i11-20020a198c4b000000b0050e337bf316mr1093880lfj.1.1706704873610;
        Wed, 31 Jan 2024 04:41:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVuh2Bh/eJ7HxZGdOd5Z/QdaQT4z1vHOFWkihDme50RveCE0dapzIvl7q7gCZE0owUak7zwaL0cdsYYxR07CDYRBg==
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id y3-20020a199143000000b005111abf2a65sm594840lfj.121.2024.01.31.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:41:12 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] ifstat: convert sprintf to snprintf
Date: Wed, 31 Jan 2024 07:41:07 -0500
Message-Id: <20240131124107.1428-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use snprintf to print only valid memory

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..08a13d7a 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -379,10 +379,10 @@ static void format_rate(FILE *fp, const unsigned long long *vals,
 		fprintf(fp, "%8llu ", vals[i]);
 
 	if (rates[i] > mega) {
-		sprintf(temp, "%uM", (unsigned int)(rates[i]/mega));
+		snprintf(temp, sizeof(temp), "%uM", (unsigned int)(rates[i]/mega));
 		fprintf(fp, "%-6s ", temp);
 	} else if (rates[i] > kilo) {
-		sprintf(temp, "%uK", (unsigned int)(rates[i]/kilo));
+		snprintf(temp, sizeof(temp), "%uK", (unsigned int)(rates[i]/kilo));
 		fprintf(fp, "%-6s ", temp);
 	} else
 		fprintf(fp, "%-6u ", (unsigned int)rates[i]);
@@ -400,10 +400,10 @@ static void format_pair(FILE *fp, const unsigned long long *vals, int i, int k)
 		fprintf(fp, "%8llu ", vals[i]);
 
 	if (vals[k] > giga) {
-		sprintf(temp, "%uM", (unsigned int)(vals[k]/mega));
+		snprintf(temp, sizeof(temp), "%uM", (unsigned int)(vals[k]/mega));
 		fprintf(fp, "%-6s ", temp);
 	} else if (vals[k] > mega) {
-		sprintf(temp, "%uK", (unsigned int)(vals[k]/kilo));
+		snprintf(temp, sizeof(temp), "%uK", (unsigned int)(vals[k]/kilo));
 		fprintf(fp, "%-6s ", temp);
 	} else
 		fprintf(fp, "%-6u ", (unsigned int)vals[k]);
@@ -675,7 +675,7 @@ static void server_loop(int fd)
 	p.fd = fd;
 	p.events = p.revents = POLLIN;
 
-	sprintf(info_source, "%d.%lu sampling_interval=%d time_const=%d",
+	snprintf(info_source, sizeof(info_source), "%d.%lu sampling_interval=%d time_const=%d",
 		getpid(), (unsigned long)random(), scan_interval/1000, time_constant/1000);
 
 	load_info();
@@ -893,7 +893,7 @@ int main(int argc, char *argv[])
 
 	sun.sun_family = AF_UNIX;
 	sun.sun_path[0] = 0;
-	sprintf(sun.sun_path+1, "ifstat%d", getuid());
+	snprintf(sun.sun_path+1, sizeof(sun.sun_path), "ifstat%d", getuid());
 
 	if (scan_interval > 0) {
 		if (time_constant == 0)
-- 
2.30.2


