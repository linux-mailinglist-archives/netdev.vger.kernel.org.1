Return-Path: <netdev+bounces-74607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E77861F95
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E41286D87
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0614EFFF;
	Fri, 23 Feb 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VICrc6At"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4414D432
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726999; cv=none; b=nZI5xuuH72kETyVTSF7b8CgjH33WweE6i8VLQfhH0UqR4BXoeYtjT+44V8UuFyde7ebL8OBv2b9xV0cdU1e+RZKdX54NyGrXjvLvCx1gb6vF6QM8Zpx82K0DEsm6TJVSEWXLRa4ttSAlgpNyTvSePTkwhPWaCxrEFuZzpocJtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726999; c=relaxed/simple;
	bh=9560acJIy7ilDx1QzS1StF1QMg0Kq73ghv/oyVS13Qc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TaNxZGlQVVUFuNDZ4LIC5CksL8VwwQOu+N9yNmCcAjCSErkqsgN4X8XcpG5mxyhcAagIo8ksoHdNxDZKbpqC4olyWdotVdl+FWK/LpcvD9vc3PX9RtJl7DaN9ZieLNEqxnPZnOY1tpgEdk1VE44goZyC2jpYBzlfXaxCJUzaAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VICrc6At; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7bad62322f0so129516939f.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726997; x=1709331797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czV3hjPDZ+WaGRN3o07ieRDipwYvLnthyFOF9HxLgvA=;
        b=VICrc6AtEDTjQxZKaHeBljszCR35alpTskumo4N3kjNEgmfVr9PbLgZicRhibWPSAt
         5jXv0KfEAFov/yhpNS00hT1fmlGE4RSwKN/gzY3y72ca2UrNF7fIfWQB8AX1zGc2PrwW
         3JsPDtPuSj4tHVXkPecVt3UgybzS2omxwpZZuAY1SHEXHOQJvIMpqdM49+GTtcevPybr
         +EJL2s3fQ5r5LpaTQ2ZM1gxTgPLX2bouHg6mTgLqjGYa8jTQZZRrN4fF+NGv4pc/ldMD
         gLbCOAHp7+z9dIbRZ6bVuOdizfKKG71qYyLI7NvZBPSUFj3R3YbDIXkuVeZhubgNKtqA
         AOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726997; x=1709331797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czV3hjPDZ+WaGRN3o07ieRDipwYvLnthyFOF9HxLgvA=;
        b=b3QAnBL2y+eNQ9ZtdVjhmMP0px6+f6JVw/phDe2mTZTcJIPFesYnXA7VDqnZsuz//f
         fvcJZH7eJ7pFkgUKBlpDDZuAGmrNlrEokcSArV72+sLelkr/fUwHts/3flHyAH2w9BLk
         Ppuf8v3//Jxi3i7Ak6sPotyFcWBYdoMdTvconzKT7WNXA0gV2HKWCKco3CUhQ8+DfDF7
         qDmmd2FHN/RmcCB74RuIqGgHEOYhl/kpgNl49my7OlHGDDCjKFYuCvjp5Eec3IPzLOKz
         sBiHxsnHSoB38gEPFqEEpxIiMzozWsG3ZcUgRXZSA1vqW6dmghiTVVeQxhcJQDn3yePe
         egzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6xnihJC3x6dkQngKdL2/Oi+JihdbY1A9f9+rqe+2NXuttlHBcXiyMWUMCIkwIcc+jCLhVFx7sCizMYN0HMX8VTJVTGuYQ
X-Gm-Message-State: AOJu0Yyl1xrnz8KrJh5xVIkgOMFRfXf01APr3yBpt74HiXDtDfPneN62
	J6m42pbXW6Ltxir4n8dOYu5C2fMAx0mBjgKdjYYUcKAmzXBKfNsJwLkIkv5do8LqTVEQOJ6ygYc
	ePAESPq3piU4DAj76wXxSLQ==
X-Google-Smtp-Source: AGHT+IElqjzzne5BNIqhnkcUtA6nWavUz3w2rbpNTXjtK97/dsw2QwmyE74rvpS4+T0D2cnfj8mpCZOXkAqdOJHhRg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:62a4:b0:473:f943:24f0 with
 SMTP id fh36-20020a05663862a400b00473f94324f0mr52093jab.1.1708726996738; Fri,
 23 Feb 2024 14:23:16 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:08 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=2289;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9560acJIy7ilDx1QzS1StF1QMg0Kq73ghv/oyVS13Qc=; b=hqIGDXAVb+Q1HbrJj2lv2pqekNzNxAZYfLcLsSsVx2XaIZcVOsiYweO2RMpCkdyK2SKo+0MG5
 x5+lMM88Tf3DsEi32Cj7SabZ09D1iK3QVAlerCCDAnnUQSch6ituF78
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-3-9cd3882f0700@google.com>
Subject: [PATCH 3/7] scsi: qedf: replace deprecated strncpy with strscpy
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

We expect slowpath_params.name to be NUL-terminated based on its future
usage with other string APIs:

|	static int qed_slowpath_start(struct qed_dev *cdev,
|				      struct qed_slowpath_params *params)
...
|	strscpy(drv_version.name, params->name,
|		MCP_DRV_VER_STR_SIZE - 4);

Moreover, NUL-padding is not necessary as the only use for this slowpath
name parameter is to copy into the drv_version.name field.

Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
instances (one of which is outside of the scsi system but it is trivial
and related to this patch).

We can see the drv_version.name size here:
|	struct qed_mcp_drv_version {
|		u32	version;
|		u8	name[MCP_DRV_VER_STR_SIZE - 4];
|	};

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 drivers/scsi/qedf/qedf_main.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..d39e198fe8db 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1351,7 +1351,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 				      (params->drv_rev << 8) |
 				      (params->drv_eng);
 		strscpy(drv_version.name, params->name,
-			MCP_DRV_VER_STR_SIZE - 4);
+			sizeof(drv_version.name));
 		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
 					      &drv_version);
 		if (rc) {
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index a58353b7b4e8..fd12439cbaab 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3468,7 +3468,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
 	slowpath_params.drv_rev = QEDF_DRIVER_REV_VER;
 	slowpath_params.drv_eng = QEDF_DRIVER_ENG_VER;
-	strncpy(slowpath_params.name, "qedf", QED_DRV_VER_STR_SIZE);
+	strscpy(slowpath_params.name, "qedf", sizeof(slowpath_params.name));
 	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
 	if (rc) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");

-- 
2.44.0.rc0.258.g7320e95886-goog


