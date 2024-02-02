Return-Path: <netdev+bounces-68404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4123846CD4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBA297AAF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B997762B;
	Fri,  2 Feb 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a88gZDhN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86160DC4
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866951; cv=none; b=GGjtpE0zrDkN9wACUEvjkpsXAbW+sL4QCBqaMH+ktLn13Xs4Ix69thHPlVFg6oxjd3S9JcBJUBsWlUmpgsCslI2Rx4dG1cf9QKtTchc9WLu9msapwQxZNejK3x9gAZNwTxbmZ64tRNIc/VCe6iZKNghRqFsYJnQKlBnFWZMkmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866951; c=relaxed/simple;
	bh=YeEYoE9krvWE8HxLiSX48eRhIlY3b07KBj1cAKY3RvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tJdfi0yGqLTly2eMfJphogQ0Rj+RC8JAEdH/WAIBKqhWPHH8QP+t2n6478Cr5r5+PkI81t+0LX1QNF8WJO/zbEF+0KdrmDfJEj/f3US3qYRWNGiL8Rxufcf08vGzf52GVtFzh7wtRE7J6rDIMrE5la7FiHKaRoVrSkLLeRBeUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a88gZDhN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d08d9b9667so17791fa.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 01:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706866948; x=1707471748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+7LihP8DP3wH+X25H5cARh5+a8lCxoNvUnXm+bDB7o=;
        b=a88gZDhNHHpuciq+omzKditjTkyxWhnVTp84BMR5PNbVEsTt3owO0JeG4tpmjv7oE3
         tcpsRTEX/Sc+tfukuuEftoBnX25Yy7ShjqgE6mCgvUv8+vfArSWjmmsrwDRT+R0X9Ri7
         7do0TPPzJXme6Bh2CbjZzvQusgxm7JQOSl3ncn3qxTm9qVInFZR99oFO0DXqa7gbrG7o
         QSky4weyA83R1XCuLVVC0VnepEQj/FlAMe3AxRTntS3K67cxY1DC1jy4rsrMcrdKI0Hn
         76EOlJMYCjdC8yq3D3WEz/0v9ehJYmk+Bs3HvqI0H9YbrDcxN0hcTdD2o4a5uI3c4s6B
         Y0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866948; x=1707471748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+7LihP8DP3wH+X25H5cARh5+a8lCxoNvUnXm+bDB7o=;
        b=qSkbJN7AWIGrqg0UBb7i4uekWrxS2RXYjXVyvq6SZboKxGTiuI3Qu560Ryr9MIXw56
         +hkbuh8YN70lz3ptk6jIQv2qi7ocuyTl0RcCc7P/9JKd03d8qRxmlkDnJsko5jS1r8Hh
         7OBJKyoYUH9ixqxFcdfd0D0k9ubVZDAI0vy2q8DHBIcZmUriSrO6KF68xXiQWkRItfH9
         xQZnuycwfjjz6AGKWYZWsufFeTQ2g41+Adt5jO3ONdDXKuZYKtnAQFrNtXlyHtKrC+TN
         rHeH53s4VBIPbBpJwzzzuE4HZQWEGXWADIyYk2jlTBbQGYqhSSYUNi3YrW5OtHrTwdKD
         C8rw==
X-Gm-Message-State: AOJu0YzbOwOHy4bhBlLIicTKO1PRxj230W+szrNA94Y4BiL6htzCUkxm
	ZxsJtoKBTRKDXvp9YCuKUq1hv64ZvjzMoCS1xhdFTwHnwfbnauulxbymqJvQEIIrcQ==
X-Google-Smtp-Source: AGHT+IExfya8bEkNlL+JKE4mzoAISNoiD22wCIgHPXnMk3bvb0TpLoELe4obEz6HO/HAXWWjjCWceQ==
X-Received: by 2002:a2e:6102:0:b0:2cf:1325:342 with SMTP id v2-20020a2e6102000000b002cf13250342mr3058483ljb.4.1706866947454;
        Fri, 02 Feb 2024 01:42:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsi0C2CO4wCmEKtroEwlt6wcrw3j/EoV4aW8GxV/2kiLZUu3ClGNLSZTCxbmETuVChI1Xfa46W0RyyYEoQmFAHkA==
Received: from localhost.localdomain ([83.217.200.232])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e7303000000b002d072c446c1sm216437ljc.34.2024.02.02.01.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:42:26 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Date: Fri,  2 Feb 2024 04:35:27 -0500
Message-Id: <20240202093527.38376-1-dkirjanov@suse.de>
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

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..779c2a5a 100644
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
+	snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());
 
 	if (scan_interval > 0) {
 		if (time_constant == 0)
-- 
2.30.2


