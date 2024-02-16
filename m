Return-Path: <netdev+bounces-72401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50492857EC3
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ADC1C25132
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9C12C55F;
	Fri, 16 Feb 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sznp/xIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53C12BF25
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092553; cv=none; b=XEXdiZuT1lku3esJgOW5Wd4qeHCLaU0095JFrHtZTh35lvQmNBJeuaZsCvU2L5DO2WALEODQ15fOxfRhyAXSSm3mzHYwRzTMVKQPAmqa4FTJEy5XceP+Mv8ec+yGdEaFU0qlDaubQnVTCUcsKPRXWm9TK2lBD8ttbWF7jfItPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092553; c=relaxed/simple;
	bh=iC8OfTlpD6CiwjJQGN2dLRP6kSbr4Kw70y2EAzMojOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tieg/8AmpoW5CsI1S1WG/p+Y2L6SqVlt/tcJhpNrgjp2hjF5K9c3KZ+4MQAzFo2kVwocJ+DusVucES2LiGbaAOzepLJt/cSWnNXlDJv19+iN+W4MEEVlcISR4DGK8jV1vvmOjcKAQx1x636z7iKeOYt60jD/XhDWPgZu/fMywpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sznp/xIp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d12bdd9a64so7382521fa.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708092550; x=1708697350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEj5JexTouLScRj18CbLhZLlLt1uHEPqZkcFoZJYiI8=;
        b=Sznp/xIpyMtts4+AVlBoGxQNqFf0in8xQqz9+cJ7tHmTvs4ri0Cr3w1o5g+/IvFgyu
         Ucgbs1EqrOii5PqKoEFdFq6CfKu62UU3kSR92SbVI80S+tBbr+6eW1bAjJKm0wWudXB/
         QnVAA01bLRNMd6BUzkOOLO7tlxoSOWzkV5DGMVYR87nOZ2YvmX+R9E0W9PXu/G4XtUTO
         +R8qisvt0A6ZHjCdIQvr7MxOiT4AuTVWzGOA/E0pI7qNffISiUPHlp67Y1lC+ywYYtCs
         ThiFz1a4TAYR+I7B3nl/78F9ZBj4m+HhtLqGJxn46PD1A1f3adrDHlvafdhp/p6FBZJu
         dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092550; x=1708697350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEj5JexTouLScRj18CbLhZLlLt1uHEPqZkcFoZJYiI8=;
        b=bFsDWhArJ1p5QVr0OdD2DlU32BzcX2DK5TvXEIaqjzpCrqwr0qBOz2rt6LD0lEsC0p
         URdtgb1N9B3AulkKAbyoWAVsqj1XjT3+niA4SxxLpp+kD5bfhaL+7mMOcEbGpdX+d077
         VMxcH2hF7vOCIZeGsDx/JkDd00QsY6nKf+zXD9Fqm6MX9vyyOoO9oDc9IRtarDoY2hgU
         OeHtByK4FIL/eyrWvo7/hyCNhQ006DqdC2UkCL3kXI/nABxc5SolixjaTrbpFwtX+K2k
         S9W/+v5JjOAH7bzO1CMDkrVCF1vtUWquWuJtkvYc+FJm0qBY01oilUvlpe8Jy6p04PD3
         Zl2Q==
X-Gm-Message-State: AOJu0Yy/xw46Wm59PUYSgf4UTB4pGJPjU7oQ3RRFoOUzQGXEaK0i0Q0R
	fUntYUx8jhIrPFJfXUoVx7pUTDzI+30xtFevzhDj3dnDDBI9o4jH
X-Google-Smtp-Source: AGHT+IHlkA922cwaz8mMvlouQ6qGy4ymZxYncrREhxh2jbOfrdifBDw0z7IRtl4+PyuAag+spqY+HQ==
X-Received: by 2002:ac2:430a:0:b0:511:680c:94e9 with SMTP id l10-20020ac2430a000000b00511680c94e9mr3007710lfh.3.1708092549325;
        Fri, 16 Feb 2024 06:09:09 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.232])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b0051166fc7faesm605535lfn.75.2024.02.16.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:09:08 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH ethtool] move variable-sized members to the end of structs
Date: Fri, 16 Feb 2024 09:08:53 -0500
Message-Id: <20240216140853.5213-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch fixes the following clang warnings:

warning: field 'xxx' with variable sized type 'xxx' not at the end of a struct
 or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 ethtool.c  | 18 +++++++++---------
 internal.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 3ac15a7..32e79ae 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1736,8 +1736,8 @@ get_stringset(struct cmd_context *ctx, enum ethtool_stringset set_id,
 	      ptrdiff_t drvinfo_offset, int null_terminate)
 {
 	struct {
-		struct ethtool_sset_info hdr;
 		u32 buf[1];
+		struct ethtool_sset_info hdr;
 	} sset_info;
 	struct ethtool_drvinfo drvinfo;
 	u32 len, i;
@@ -2683,8 +2683,8 @@ do_ioctl_glinksettings(struct cmd_context *ctx)
 {
 	int err;
 	struct {
-		struct ethtool_link_settings req;
 		__u32 link_mode_data[3 * ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NU32];
+		struct ethtool_link_settings req;
 	} ecmd;
 	struct ethtool_link_usettings *link_usettings;
 	unsigned int u32_offs;
@@ -2752,8 +2752,8 @@ do_ioctl_slinksettings(struct cmd_context *ctx,
 		       const struct ethtool_link_usettings *link_usettings)
 {
 	struct {
-		struct ethtool_link_settings req;
 		__u32 link_mode_data[3 * ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NU32];
+		struct ethtool_link_settings req;
 	} ecmd;
 	unsigned int u32_offs;
 
@@ -5206,8 +5206,8 @@ static int do_get_phy_tunable(struct cmd_context *ctx)
 
 	if (!strcmp(argp[0], "downshift")) {
 		struct {
-			struct ethtool_tunable ds;
 			u8 count;
+			struct ethtool_tunable ds;
 		} cont;
 
 		cont.ds.cmd = ETHTOOL_PHY_GTUNABLE;
@@ -5224,8 +5224,8 @@ static int do_get_phy_tunable(struct cmd_context *ctx)
 			fprintf(stdout, "Downshift disabled\n");
 	} else if (!strcmp(argp[0], "fast-link-down")) {
 		struct {
-			struct ethtool_tunable fld;
 			u8 msecs;
+			struct ethtool_tunable fld;
 		} cont;
 
 		cont.fld.cmd = ETHTOOL_PHY_GTUNABLE;
@@ -5246,8 +5246,8 @@ static int do_get_phy_tunable(struct cmd_context *ctx)
 				cont.msecs);
 	} else if (!strcmp(argp[0], "energy-detect-power-down")) {
 		struct {
-			struct ethtool_tunable ds;
 			u16 msecs;
+			struct ethtool_tunable ds;
 		} cont;
 
 		cont.ds.cmd = ETHTOOL_PHY_GTUNABLE;
@@ -5494,8 +5494,8 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 	/* Do it */
 	if (ds_changed) {
 		struct {
-			struct ethtool_tunable ds;
 			u8 count;
+			struct ethtool_tunable ds;
 		} cont;
 
 		cont.ds.cmd = ETHTOOL_PHY_STUNABLE;
@@ -5510,8 +5510,8 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 		}
 	} else if (fld_changed) {
 		struct {
-			struct ethtool_tunable fld;
 			u8 msecs;
+			struct ethtool_tunable fld;
 		} cont;
 
 		cont.fld.cmd = ETHTOOL_PHY_STUNABLE;
@@ -5526,8 +5526,8 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 		}
 	} else if (edpd_changed) {
 		struct {
-			struct ethtool_tunable fld;
 			u16 msecs;
+			struct ethtool_tunable fld;
 		} cont;
 
 		cont.fld.cmd = ETHTOOL_PHY_STUNABLE;
diff --git a/internal.h b/internal.h
index 4b994f5..e0beec6 100644
--- a/internal.h
+++ b/internal.h
@@ -152,12 +152,12 @@ struct ethtool_link_usettings {
 	struct {
 		__u8 transceiver;
 	} deprecated;
-	struct ethtool_link_settings base;
 	struct {
 		ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 		ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
 		ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
 	} link_modes;
+	struct ethtool_link_settings base;
 };
 
 #define ethtool_link_mode_for_each_u32(index)			\
-- 
2.30.2


