Return-Path: <netdev+bounces-79569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91810879E4A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E14A284852
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0C14405D;
	Tue, 12 Mar 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0HvPLUWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600A14402F
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281677; cv=none; b=m/ltINcuyeyo+PuCLmre6AXmxSs8unX/EkbiOmk37R59YBcy/3g8pmlH8TkuuIUk7m9RvY5oCcHty0jQhJGpu1cGMfLHyjtyYfRx584niTBkf9H9M6i/ZGMXZFJCD5jeKWT5zZzkNiRO4lYewdIgoxsqfLGNjSqtgCWDT4257H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281677; c=relaxed/simple;
	bh=5ZwCF+rs7lCtGdo8KOoL+qGcDQAW7t/YnIkrC77Nd2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMFCZRzyLq5Ea/d8ftidPb72X6dknr8C34nPeruKbO6OpxiYkHHYCB88+fLaRPm98dHsm1Bl4WfeoiqrkERIv0emrFdvoVAZtiFgJrvzMiWY6aUZ3qZyb6Jk4A3/BNfnqh2YJlbE9wfb/HZGVDY+4A6rlnaqAAjPUcPk6bmQsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0HvPLUWe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd68d4cff1so34127565ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281675; x=1710886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqUagkvWJXywn2IxPi0bRayOpXinOg94l8rLXSzDkU8=;
        b=0HvPLUWeqdEdeckTab8pRqvjJmUSZWX6zPeeJXllo+Di5AjPrm02lFCjvqKHQQhCm0
         IEAhwtu2HzWLnFLm15x2dDz5ZgbFsQKFyR8p1YRGtfANRSKrPUyaDgLy58WU0udp7EBC
         inneIbRk18sB8DtktGDaGIOwW5TV7qVQ2mbYNSKtmfQ1iy2bIF48dsQporlK1iMg0Vtr
         2/8n5Rrp0EgTXqBG/7dHf6LJDUUD4rslYDH4VTHa602m8bMM24Um1qRCcYDsbmfLAcMt
         pZyeJ9v+Quq5QqW3MOf7QEYgns95+CJykG7wYAN+OcAiuQ6OmvoRex8R1xrt38UxoACq
         uhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281675; x=1710886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqUagkvWJXywn2IxPi0bRayOpXinOg94l8rLXSzDkU8=;
        b=iSQHyVMe2EiNpGd9P/M4HKduu6sKXmlC4YxexgCUVu/74A5ZXUQ6EW0217QQHG1Sle
         tf+AKW2XCXBC8BTIOurL/EjZDIiErAMBBsyO1vMxjfvfM3AT79Fe84gpFk3zHOyUxWH8
         GnvZBA5QTK/8++B6rBDfdsZe0x8FDTXy+uhhmlI7HuiQ2z0OhxGDAYtACO3xkdDldsWk
         BlJYwhndFEhQOdSzGJ3gJM/qx7ShiGN/m/a6SaHpUq04HTbMuzfh0Fab7oWhJyUroWx1
         HYXCJmt8NHqsZbVrA6507eSEi0SO7mkrvZtLxMPEDzX8u09eswMDFnNBVzvbxYIMwXKG
         vRAg==
X-Gm-Message-State: AOJu0YwCiWZFApqwQXI2RbYR8i89qUf5sifdmmZEkQHfPfvOnb80xF6x
	RQGIIgUa3gaI/O2uCzdbOdaOFumabV+2gtgjYefkNAYNM4XPilimCwj1DDyfTiF0FyZW4z2WQxs
	M
X-Google-Smtp-Source: AGHT+IGXa0W0ae6kEQwbD/BZzW3iwdkIex3PIj7J3cpTFfgch0OV4AnuHwwrnaAs06mURTnhyPyARA==
X-Received: by 2002:a17:902:d486:b0:1dd:7d20:63ef with SMTP id c6-20020a170902d48600b001dd7d2063efmr12248619plg.11.1710281675452;
        Tue, 12 Mar 2024 15:14:35 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902e28a00b001dcfaab3457sm7240473plc.104.2024.03.12.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 4/4] tc: make exec_util arg const
Date: Tue, 12 Mar 2024 15:12:42 -0700
Message-ID: <20240312221422.81253-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312221422.81253-1-stephen@networkplumber.org>
References: <20240312221422.81253-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callbacks in exec_util should not be modifying underlying
qdisc operations structure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/e_bpf.c   | 2 +-
 tc/tc_exec.c | 2 +-
 tc/tc_util.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tc/e_bpf.c b/tc/e_bpf.c
index 79cddace96a4..cca853f95299 100644
--- a/tc/e_bpf.c
+++ b/tc/e_bpf.c
@@ -49,7 +49,7 @@ static int bpf_num_env_entries(void)
 	return num;
 }
 
-static int parse_bpf(struct exec_util *eu, int argc, char **argv)
+static int parse_bpf(const struct exec_util *eu, int argc, char **argv)
 {
 	char **argv_run = argv_default, **envp_run, *tmp;
 	int ret, i, env_old, env_num, env_map;
diff --git a/tc/tc_exec.c b/tc/tc_exec.c
index 182fbb4c35c9..fe9fdb1b5aa6 100644
--- a/tc/tc_exec.c
+++ b/tc/tc_exec.c
@@ -26,7 +26,7 @@ static void usage(void)
 		"OPTIONS := ... try tc exec <desired EXEC_KIND> help\n");
 }
 
-static int parse_noeopt(struct exec_util *eu, int argc, char **argv)
+static int parse_noeopt(const struct exec_util *eu, int argc, char **argv)
 {
 	if (argc) {
 		fprintf(stderr, "Unknown exec \"%s\", hence option \"%s\" is unparsable\n",
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 5ae3fafd2dd2..bbb2961dfe93 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -68,7 +68,7 @@ struct action_util {
 struct exec_util {
 	struct exec_util *next;
 	char id[FILTER_NAMESZ];
-	int (*parse_eopt)(struct exec_util *eu, int argc, char **argv);
+	int (*parse_eopt)(const struct exec_util *eu, int argc, char **argv);
 };
 
 const char *get_tc_lib(void);
-- 
2.43.0


