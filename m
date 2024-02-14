Return-Path: <netdev+bounces-71665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AA8549D2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F8E1C23E99
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719752F65;
	Wed, 14 Feb 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJSsdEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA31A58B
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915440; cv=none; b=CDjZgaq7nIHowtSnGl+I7NkiZ9wiwdjCjbgpwnevaSF5EBJSvtzn0O8015tQmSijNDuInp+Po19XpOkiXceQKXi0PGVfJksQKDv8ViJztgkaQHH0X7T3gEHVstO//QVnrWq3glIH2rPUhYsJE78ggKNWmAzyL6JyYKE3y4QxkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915440; c=relaxed/simple;
	bh=NuSdwFRk0DO/x9itqw7bv9C8lAYMghMKAClLd/VBNWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MFvD9ks00wVJbwwXBzNr0AiE4dATBThyb12D3hA2LS4fZfkXd1ffMrM5XQczRypi2XZrWgqUU9nzTzt8U/01DBz5j8zY2QRkPds5VA2yCjcqKAnnYHKR5R2wA81HaggwthyfWjGmGRZoTIEvMVTg9hJf2NYMYLTwjMYjKEH3Khs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJSsdEw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0bdb8061fso10834611fa.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 04:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707915436; x=1708520236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t409pfsDa+gzCAIaIkPj0DYMM0PdaZcLKRhJ4RiAGsQ=;
        b=AxJSsdEw6YxCntzGOAebAMgnVu1JL5QJuqXLegylgNbC7IU6C4VjHnTsJxYaGF2mly
         cZYBJ6qK5vu6HJOOMwgtLTrN7ea2qs8qX6Oqiy2Ycpuh8xIORiOjDn/dD/yi5H+qW72C
         6BEOWcmSMaM3sL8rBkh1yrvw/l48zqHlKEIzs3kuG8zdMkPq9x/7FGBoWbQZgFX1RhTX
         wEVm3O2wEVvNm6UwliXlGWjcLMQprOO6wZIW/B/eAXXrXr3QyikEqsbO9an3NZlOj3wi
         gtitUYt6mebAcUf9eLebv4nQB7igaTTxSOA7TU6blQCie42uGtGkDfaslrPPSUrlw1pQ
         9wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915436; x=1708520236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t409pfsDa+gzCAIaIkPj0DYMM0PdaZcLKRhJ4RiAGsQ=;
        b=BdIinxhFNcb1sqStTmBXmpVJqUQOnWJGyprU47oBLGqupzU72SCKumaTM7Zsx6lHH3
         WRkfd1kNsr+/sikTCNnoEm1yZ5kl8E5kKdZXT1I/S9Znrch7kQ04atY66iISu9TWQdgj
         U2YXr65TcCsMTkst+wYWYCMmDApg4dICDG3+FCgREkTJ3QhuUACXm5vDYCbg6CPngQWl
         SO+gUdzdLsowtZ2zYoQh7vh6J3jEncFJyVZEJ1F8HAVhYAfLlbM5wq8vWrjCmyQ34Ypj
         gPdn/AVCxVVxz/iXNB3IFEQOYhvx5VICqvq086T+0OmGvu173OxJodguwsyaj4i7J2Lw
         q7OQ==
X-Gm-Message-State: AOJu0Yyyyqq8GJ8VFGOr9oMBhbAu+kSK5OZrx4sPDhFDNMr3t7wQRUiJ
	L1P8L42rOyOJ5ase38dkxFgZx6zfPKD+IicTRJxaLyeYQqV97FZw
X-Google-Smtp-Source: AGHT+IFBY/xtnHLHRywWHMc8QbXqv19HI1uYbsvpPO3M3TTa5rbnd1E/CJoautUW7VZld8BjQ5qlJA==
X-Received: by 2002:a05:651c:b13:b0:2d1:1e03:e2c6 with SMTP id b19-20020a05651c0b1300b002d11e03e2c6mr730979ljr.4.1707915436039;
        Wed, 14 Feb 2024 04:57:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGdZzmKzd57MS7IoPDeUC0A29ekw+1SSz/51Ceon2KfkrqgSc0AvavaFZSwM5xV4eUJsPjRUamkXTE/tjLLwUTpA==
Received: from localhost.localdomain ([83.217.200.232])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e98d6000000b002d0ca6e0f9fsm842085ljj.15.2024.02.14.04.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:57:15 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH v3 iproute2] ifstat: convert sprintf to snprintf
Date: Wed, 14 Feb 2024 07:56:59 -0500
Message-Id: <20240214125659.2477-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use snprintf to print only valid data

v2: adjust formatting
v3: fix the issue with a buffer length

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..4ce550b2 100644
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
+	snprintf(sun.sun_path + 1, sizeof(sun.sun_path) - 1, "ifstat%d", getuid());
 
 	if (scan_interval > 0) {
 		if (time_constant == 0)
-- 
2.30.2


