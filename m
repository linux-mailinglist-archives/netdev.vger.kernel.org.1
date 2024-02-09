Return-Path: <netdev+bounces-70475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82F84F257
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9241C21024
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4F67A0E;
	Fri,  9 Feb 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1DVUfgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FC664AC
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471460; cv=none; b=oQst5XPDTr4tVeYMjib/gKkW9Q+6wVnez3Xk/DFgBbWuezEQ/yOtN7vkllCuPMcBX4fnRnkRNPQKxp6bCxljDp388cUS5Uktyd18wCCIuP3/5MUbUBMHHptUBywwvZUpWEapSCL6HJ3Ak5MRPccrH6KTEdSkgfze9ftvOTwjt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471460; c=relaxed/simple;
	bh=+RI+UfoJgxND/+bJlc6Ob65S7aonmRfy53IzorOPk4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPnfqegOzcE1XiGAUq4llia/JiXrbnZUssox91wLl//+IpekT4r/eArPqEsqEO2zmW9KAT5rUVeXZsBB5L0A+VMx/XZHbw5Wz+JqE0AgUSkPJvSoNDxXzhOmxDXSDFgMhmXxpv87MhI8btVj0j+BLuocfHZOXmuKGMSSBkUyfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1DVUfgg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0cc05abd3so3444101fa.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707471456; x=1708076256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ged2+EmYXVpHpcnrvAq19WriE+z/AxxAUjrYqs6VoOo=;
        b=K1DVUfggv3r9+fZjiaeJTqHX925xAaBGMcDHKhDWQ9Q+pAW8if2+wGnFMRn2CkwfAQ
         W7GyeMXjKsMI9CpGKrtEXMJj6Qh6Ld4ZtW1ufF7RZt4jJO0ryIB3ePt+DKffLtRB1NqY
         BHaIBmFq4Va2qpCastV0kVSvHJ7MhGNq8+RbUs4WQzdpkuscokpKgqBnWidKcS7fqUJn
         +bo0YbokKu/EUIP+LZe1Ec9NsBrhn7XIWl3YxQ3l7s9t01JD9zaymdFtKq456lIu2ici
         aHn5kf9hhRmwBSeLhahgu5xa4+1JJ4m0WFE5Mh8GGJ1IiTB1kJRnC2BOkaApSF91g8c8
         Hsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471456; x=1708076256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ged2+EmYXVpHpcnrvAq19WriE+z/AxxAUjrYqs6VoOo=;
        b=kSlDsyQrc7BzVFJtQvfmasU8QWIHMfzZ3FgOD0EN9yV103IYWx67XI598Bl0yqcBk/
         5AmxOURMI/F1J7q/JOyXXAS07NckZRBnVf16xWNtIyGeYJI/WG0y5mp2VcN5kyvdpfrb
         toefNf0sT+TFlBHLr2+u1dSJZkrT4xUeuRlBC3vx3rCj3zqN1ju3xDnKx/EYwSfNJzZG
         /eStIusKyu3ktA/ets9uwVujlmXmUokl+QUmwBHkF4V8vyVei/361UJjLRPOSycS656Y
         z6mpOyQNC8hNnc10AjpvuQ8gubwS/lpqhF99R1MTIoI+0Ey1rvybUAD2Np0nGM8jFh1d
         178w==
X-Gm-Message-State: AOJu0YzV9RwhO8nT8w4aornCPu2us7XUMf3PbyYkB90aEr/fYEd6L+3W
	TzfuwjY/FrIY4+6adUfpW1OmcGqclQ/L1JFGU6mG6nRtdGYY/Fz4
X-Google-Smtp-Source: AGHT+IGucg36cX0Dxi5j6FGLxju1pBPk5ib/WoFO/eiC3g4byQEtdBOELhiM7TBpV6tyEdJmBiUALw==
X-Received: by 2002:a05:6512:3e26:b0:511:79ce:804c with SMTP id i38-20020a0565123e2600b0051179ce804cmr592804lfv.0.1707471456158;
        Fri, 09 Feb 2024 01:37:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2KJNVWIZzYux2Z6Aq8Z/IEVnxd48Aokzait6KB+5+p6Lk7LokPfuwe6iN5+BJZQOl2O8D90Ly+pUAq9DY6EzSCiobv95WGfTVc9T9kvFiMv9rRL0S
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24828000000b005117ac9cd1asm49659lft.88.2024.02.09.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:37:35 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 2/2] ifstat: convert string formatting calls to scnprintf
Date: Fri,  9 Feb 2024 04:36:19 -0500
Message-Id: <20240209093619.2553-2-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240209093619.2553-1-dkirjanov@suse.de>
References: <20240209093619.2553-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scnprintf to print only valid data

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..288e9064 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -379,10 +379,10 @@ static void format_rate(FILE *fp, const unsigned long long *vals,
 		fprintf(fp, "%8llu ", vals[i]);
 
 	if (rates[i] > mega) {
-		sprintf(temp, "%uM", (unsigned int)(rates[i]/mega));
+		scnprintf(temp, sizeof(temp), "%uM", (unsigned int)(rates[i]/mega));
 		fprintf(fp, "%-6s ", temp);
 	} else if (rates[i] > kilo) {
-		sprintf(temp, "%uK", (unsigned int)(rates[i]/kilo));
+		scnprintf(temp, sizeof(temp), "%uK", (unsigned int)(rates[i]/kilo));
 		fprintf(fp, "%-6s ", temp);
 	} else
 		fprintf(fp, "%-6u ", (unsigned int)rates[i]);
@@ -400,10 +400,10 @@ static void format_pair(FILE *fp, const unsigned long long *vals, int i, int k)
 		fprintf(fp, "%8llu ", vals[i]);
 
 	if (vals[k] > giga) {
-		sprintf(temp, "%uM", (unsigned int)(vals[k]/mega));
+		scnprintf(temp, sizeof(temp), "%uM", (unsigned int)(vals[k]/mega));
 		fprintf(fp, "%-6s ", temp);
 	} else if (vals[k] > mega) {
-		sprintf(temp, "%uK", (unsigned int)(vals[k]/kilo));
+		scnprintf(temp, sizeof(temp), "%uK", (unsigned int)(vals[k]/kilo));
 		fprintf(fp, "%-6s ", temp);
 	} else
 		fprintf(fp, "%-6u ", (unsigned int)vals[k]);
@@ -675,7 +675,7 @@ static void server_loop(int fd)
 	p.fd = fd;
 	p.events = p.revents = POLLIN;
 
-	sprintf(info_source, "%d.%lu sampling_interval=%d time_const=%d",
+	scnprintf(info_source, sizeof(info_source), "%d.%lu sampling_interval=%d time_const=%d",
 		getpid(), (unsigned long)random(), scan_interval/1000, time_constant/1000);
 
 	load_info();
@@ -893,7 +893,7 @@ int main(int argc, char *argv[])
 
 	sun.sun_family = AF_UNIX;
 	sun.sun_path[0] = 0;
-	sprintf(sun.sun_path+1, "ifstat%d", getuid());
+	scnprintf(sun.sun_path + 1, sizeof(sun.sun_path) - 1, "ifstat%d", getuid());
 
 	if (scan_interval > 0) {
 		if (time_constant == 0)
@@ -926,14 +926,14 @@ int main(int argc, char *argv[])
 	npatterns = argc;
 
 	if (getenv("IFSTAT_HISTORY"))
-		snprintf(hist_name, sizeof(hist_name),
+		scnprintf(hist_name, sizeof(hist_name),
 			 "%s", getenv("IFSTAT_HISTORY"));
 	else
 		if (!stats_type)
-			snprintf(hist_name, sizeof(hist_name),
+			scnprintf(hist_name, sizeof(hist_name),
 				 "%s/.ifstat.u%d", P_tmpdir, getuid());
 		else
-			snprintf(hist_name, sizeof(hist_name),
+			scnprintf(hist_name, sizeof(hist_name),
 				 "%s/.%s_ifstat.u%d", P_tmpdir, stats_type,
 				 getuid());
 
-- 
2.30.2


