Return-Path: <netdev+bounces-75757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E386B10B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C831F248CB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D87150990;
	Wed, 28 Feb 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cngv/J/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949414F9D5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128764; cv=none; b=uElg/hpEHt3OsOsZLPOzxsC/luQtd2rAsbAIRsirqeQ8Dv3rzhLxEqveIgYDeZeA8PiDFlZK+1uwu+pbkhT4kvUrCXfr4RKtR1B2hC5gcO5lYqwMqrpWSSVMdLseZlts3nwrpFA+6o30yPX+C5g46JUdE6/VJwLmEPprqu26qBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128764; c=relaxed/simple;
	bh=sEX8rksW4kCJJt+qOL39gPQ/indXjd1rWJLQMlfDaRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EterdL9AOhr4Qj5/9bT8g9byeQlFvKmSB7M+8ISgodcY3QDAiJg9Mhihl7jeFFdRGoxsHpF/IfrNba4sqOSgaZFxry44nfmB3QnDTWHCaTcUzcIVsbf9IlXmHOXvByLE5um2u1h74JNiC6AJ6ZqdfSm2FLpkhTniWiSV3nAaY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cngv/J/E; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2c8c1b76cso2586621fa.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128761; x=1709733561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrWCtetzfWjHWy26UrmGWzBFAhdo+uByz8UeFKzNpBo=;
        b=cngv/J/EsNhlmTDL03W7fdjP24Qa5uKsupw+E0ZqfxXuePNOz9mQCPL+sx7viEWA//
         Csdvs+Tas0Nc7ofUmzD4CecmFeiYNLAYjd6LBnuCZ+lfmR2cE82h5H4s7jPwDIogNUuQ
         OZE0o5iRE/8nxOa2AXvmTkstH4HY5MxMoNk3Le3XHM5/OrlQ2ce5Qq/FBRmaTZHzF9dv
         koeMTXN4xLJ0SYsyvYktFEVyx0+Es9czImjhHK460qZOT+jw4g3U6aYwt7VCCuHmTSrJ
         yLOhbz/x4dwOBdzeS3kF6kDawrmaBdit7gYI8aa6pYg5a4TO50WEdtK7Gz7cA9O+Ig2c
         CvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128761; x=1709733561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrWCtetzfWjHWy26UrmGWzBFAhdo+uByz8UeFKzNpBo=;
        b=qyffEiH6n3aIl2Cj3bzMLepltIKUM5tK/dyy8ex84vO4SCcZV4masOttKq5lLGzm6T
         QFwqcl6C1rGNQytnBYsgcoH8bC9Cf2SWzaD2ZBjnkMyVDpNWvPfo6kdjOD3vq31HszOC
         Ivz6oV1HVe6iZyybgm50m4aViwrqdwka8F/Uzn/WQh67uZcKqrqVZmIqTTlPRzWdaDsi
         XEqbpJLLy8WRZe9YZZGo857QcOk3C3x73B8pZFcj5046yI3eVYOu5xTp2eRbQoC0PfWW
         U4mPN3G0yD85+7MNFPNQutpYX+Z5svZE0e3YPhqP++/67ykCPwq/JBAD0vab6+nGaX7F
         /mYg==
X-Gm-Message-State: AOJu0YxjxITV9jmBlz/77A2NldARZnPHeX9+RmcmIucy7VXG1T7V37oI
	cJHTeEWSyCoM2kPRJi2G0oBtm0ehtejeExuEPL2j2QqDDvMRm82naCW1DKGIzopZ18q8
X-Google-Smtp-Source: AGHT+IEp0x0cJ0oC/r9xq3GnMcbzWpj8RgzX7ZwIMiNuxSAuD7DXERELZGGOUj0MgCGrAR83t7fQPQ==
X-Received: by 2002:a05:6512:3d88:b0:513:16a8:4292 with SMTP id k8-20020a0565123d8800b0051316a84292mr2452456lfv.2.1709128760853;
        Wed, 28 Feb 2024 05:59:20 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id b19-20020a0565120b9300b005131e8b7103sm95204lfv.1.2024.02.28.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:59:20 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 2/3] nstat: use stack space for history file name
Date: Wed, 28 Feb 2024 08:58:57 -0500
Message-Id: <20240228135858.3258-2-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240228135858.3258-1-dkirjanov@suse.de>
References: <20240228135858.3258-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

as the name doesn't require a lot of storage put
it on the stack. Moreover the memory allocated via
malloc wasn't returned.

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/nstat.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/misc/nstat.c b/misc/nstat.c
index 3a58885d..ea96ccb0 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -580,7 +580,7 @@ static const struct option longopts[] = {
 
 int main(int argc, char *argv[])
 {
-	char *hist_name;
+	char hist_name[128];
 	struct sockaddr_un sun;
 	FILE *hist_fp = NULL;
 	int ch;
@@ -668,10 +668,11 @@ int main(int argc, char *argv[])
 	patterns = argv;
 	npatterns = argc;
 
-	if ((hist_name = getenv("NSTAT_HISTORY")) == NULL) {
-		hist_name = malloc(128);
-		sprintf(hist_name, "/tmp/.nstat.u%d", getuid());
-	}
+	if (getenv("NSTAT_HISTORY"))
+		snprintf(hist_name, sizeof(hist_name),
+			 "%s", getenv("NSTAT_HISTORY"));
+	else
+		snprintf(hist_name, sizeof(hist_name), "/tmp/.nstat.u%d", getuid());
 
 	if (reset_history)
 		unlink(hist_name);
-- 
2.30.2


