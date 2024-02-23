Return-Path: <netdev+bounces-74605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C56861F91
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA71F22D38
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0C14DFF8;
	Fri, 23 Feb 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMnXYrza"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D814AD04
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726997; cv=none; b=BwAwROTEEHrtBV8yTuaCZ9fSVJfiWqREZkINsIjc5CcMx2gZs7DBA36KXwrx4LqjsutgRedYtg15OCTn02cck11DzN530Lx7lmwne0kuFJYrK04hCpwd6N6Ay0M128jjV4RBOxzwN7t7pSjbF5l5AdFumelmooaH5/o/UiQBoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726997; c=relaxed/simple;
	bh=atw28RqPC1GSaqT/dfgmT16ohbY/e8gGhibx8N7VvH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lmDre2L+xah/87yySf93qvhqKFkrCdo+Uzwep5m5I4dPi0aNMl5aMhcRznGaF2GH/Wn/A4tqQwY+TAd/gPFq8Au3WvZMt59J6PxgybDQGZ0THo+GTuTRyFGqpF1k1O7/7P+lj0Zl1OlxkJD12z1t8a61195PFoafruKPdPS8vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMnXYrza; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so125920439f.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726993; x=1709331793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqA4FNr+Yd3pWgWiaXUbZeiapBDt2cwHD2dL9aqpno=;
        b=HMnXYrza7hdCWxoOUTuuhQ+EPJPfVtOKayFMEwzRR40+hkAuDlXWsoanL+cn5rHElq
         OV+ASA600QgY0omymT9XI0naiPL5pNBFZSQM3Ml0Dzyj71nO7KNGdnGzGIp9QysVNRcE
         eGWyvdT5H3Gf/L+vNF1saHfFz4Oaf+HIoA/dIRa3ahkiB9RXssiJ2s+2A+jqz2w89DQk
         GeB2jXyZUKHE9nreDRGx69RrCYiY8rxffm8E94ZR0LhvkE81Z2FEHLeLAytZUKCe61ZR
         Dj1aR/aCTKrlmJgVj3Qs647fh+I22DMifW16LbP41UlTxsXBy+Oubp8kavxPNb3FYDwt
         e9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726993; x=1709331793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqA4FNr+Yd3pWgWiaXUbZeiapBDt2cwHD2dL9aqpno=;
        b=tO/2v9l5upqh8ZgoO95epZUu7t1tjiL9xxiFZY6iw7itQds5M+2lrDgpDpVYlgQPDA
         ZmCfgjBafL2jkzfNE2V5zbyEl8DP4wlTYUFrW8a3TfbMPkonBz9ODUHPwg0guTLtDAXq
         nna/IGvjYrjI3z6RlzR3dbxf/iRO95njOl0sNwnVFKgU+YDyKTlJoO2ru30+KRd8mNga
         xnKSCwmoKBtx4rJClxqwqTMkmhifP5uxXPF37c4qKAqxIMW31nirQM3B9+ny1b4Pq7Ue
         4gA0Kg85dbG2ho7XYMlmNETzhpswIKmsVqP2O34OXwjYZvJo4RDYgIfuKsS8mZh6h5ut
         AfiA==
X-Forwarded-Encrypted: i=1; AJvYcCVYmG15Y8O6bYTmIV8ijE7UhGO9vtXNvjqXpQyx0HJAvpGJJvZ8r9Mr+lgYqItbxqiXGDZu2VAmppfRndMR8KH+LeSuItxV
X-Gm-Message-State: AOJu0Yz/bM/cyzzwwpv2ECRz/HStMbfoxHzICNRxSHseQVUGiQjy9aWh
	cit+VIbwRWH5TL6ledeoNQjn7TKRg5kgoVGZP+PodjQA6yOD+muu0zeyEzqyz7hnosvEwBe16Rx
	GEtj1wfreNSV3UewCygETXA==
X-Google-Smtp-Source: AGHT+IE9+d0DRwTaeVewC0YykYc/HcpVSbDdP6/Eix18NC4jUXTr9YGVPfn/8i6i1Pk/1PXYSNhu/wipCxOavTAnOA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:13d5:b0:474:64f0:7943 with
 SMTP id i21-20020a05663813d500b0047464f07943mr49078jaj.4.1708726993338; Fri,
 23 Feb 2024 14:23:13 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:06 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726990; l=1723;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=atw28RqPC1GSaqT/dfgmT16ohbY/e8gGhibx8N7VvH8=; b=Zvl4/th/GfAIwNdwiIACuAJKgQj0NY3dOqOorRPnpe6UqpqYi8UI5Uf+3a555kNtR3f7/JOik
 kCs0S6g0ulQBscaFHM5dfq7WwUlqC7LU6SbX2NPjr4u4+A/pWw2bD8G
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-1-9cd3882f0700@google.com>
Subject: [PATCH 1/7] scsi: mpi3mr: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Really, there's no bug with the current code. Let's just ditch strncpy()
all together.

Since strscpy() will not NUL-pad the destination buffer let's
NUL-initialize @personality; just like the others.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 528f19f782f2..c3e55eedfa5e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3685,20 +3685,20 @@ static void
 mpi3mr_print_ioc_info(struct mpi3mr_ioc *mrioc)
 {
 	int i = 0, bytes_written = 0;
-	char personality[16];
+	char personality[16] = {0};
 	char protocol[50] = {0};
 	char capabilities[100] = {0};
 	struct mpi3mr_compimg_ver *fwver = &mrioc->facts.fw_ver;
 
 	switch (mrioc->facts.personality) {
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA:
-		strncpy(personality, "Enhanced HBA", sizeof(personality));
+		strscpy(personality, "Enhanced HBA", sizeof(personality));
 		break;
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR:
-		strncpy(personality, "RAID", sizeof(personality));
+		strscpy(personality, "RAID", sizeof(personality));
 		break;
 	default:
-		strncpy(personality, "Unknown", sizeof(personality));
+		strscpy(personality, "Unknown", sizeof(personality));
 		break;
 	}
 

-- 
2.44.0.rc0.258.g7320e95886-goog


