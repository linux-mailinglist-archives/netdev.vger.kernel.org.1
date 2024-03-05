Return-Path: <netdev+bounces-77692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919A872B16
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DC71F25FA9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BE12D754;
	Tue,  5 Mar 2024 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmN1ZzW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1C12D744
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681683; cv=none; b=TdiHZHH+frJZcaLFDwKoq/PXNb7JgZx2TFUjZYxuzzzH3TWAnRyjYEwy33IdX/fyjwlftJ2bS4iptNL4PXePnkNB8YdwH/Op47kWxm0JbbTGXfFS1yVZw8k6wjtdoJ5DL7Yv4dqtzMLGvf0dzqX4FIusRJ4Hhm3A5p0h0yBCQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681683; c=relaxed/simple;
	bh=S2o1sUo5KPLCPT2eyiGeGCz4MtuFwjosW26PC//SCFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ecVi3Ehn4TFsbmy8Yj/tIu8v5osLDR1Dh6Vq4rzcbi3QxTlS4CgdTfBquhMoqzB+diiC5hVIXV0HoYPmlkOaUGCwDuGoxbYKUetWKmmFGNzzIiHPZjX8xtU922EcPc+3+8bP23YWsK+NB0RjueTZFMlaZDW3g8A99YMBYgxAP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmN1ZzW9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2175453276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 15:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681681; x=1710286481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fm3EeStFIzAk85+vETH72VSgC7KPPApaIiaC0eURHqc=;
        b=RmN1ZzW9FdcuR7PVuB/v7qcXHrQFO0w5STOiKBtu4S+YuYNxAL3kO4wiD2IBNpx1zj
         mr9hy/1d+92CxI0Lkaz37cMlcmonqqk/P2J5pA3yR8YWUwRPAn1rUWL5MHZZ7nK6r7Ny
         IikuzMXR1g3GphqN781L1EjWKFIafm1qlyoqk+rAnysaa54OlQpRUXI8e/KKeIPgpuxy
         xOnDgDXCe/dIHmDfaSodMS7G6HeYs27nJgyvtZlfmRo762lv6aBBv7wsL7QApuMw/Zv3
         RFUW6a3MVh6KN1MlMmsGz8jyIXSWQysyP49UXwG/F8NS6ohCTMp1IlKLo16+2aq+2qZX
         9Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681681; x=1710286481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm3EeStFIzAk85+vETH72VSgC7KPPApaIiaC0eURHqc=;
        b=OUivnSWvOLmnBpDWTwiDsO8sxfVgbbWBC+ZksQiGKT181YrOk3rgwu7kp50nc8PVia
         lsHzty6Vlo48sHtrQ1UdwUN0VILlcrWaNVI8dkXp3FmxPFnO6DukK9kGS/LSEoS43dAC
         txF0K5pg0mmmaZGAVlHaqEsLX+agwqg9cEMdinzA131wV4tBsKM7rJMyXh/DYaTVq10e
         lNuioMtTAX7WV8s/rHua2aeGtgKZaJijZSoq0NV5jfMyJehm0T9GqDtdgkBHgiq+3Yhq
         cZa+W7a+O6691Fb2zOCaBSe3fFYBmOJQCJY14ZHh5jMW4f/1upX9NJcWCkNUPOulCiwO
         qQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJtIjHWJF9jNcNnsnmyfOtAgLn9cuQSFaPaiUElQcn55oF2iJ3k+s+IWbVpl+wDSUi0fAIkTQeu1Ii5RTXheqvRQPJVPs
X-Gm-Message-State: AOJu0YwRqKX4ksgAedSwuaf607YdPO3dj08tQSWa0XLVlXUtxL6Qohmc
	G/QaHVp649cx8VDYnXNIR2va1shbHqW7HTznGL5rxfr6/FOcoyOSgrWjZpIXDQsVEzBBOkCn6dZ
	Xb949Wu6cJFtDEOHmSgxoHw==
X-Google-Smtp-Source: AGHT+IE+EhihKFp1AV0Ks/kBpof4c1iU4PMM+jPwxyvoWQq6aQK8OKeCF5YhNVfPqDUvBkRb9ZGIsn+AXaILjgfRtg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100d:b0:dc6:cd85:bcd7 with
 SMTP id w13-20020a056902100d00b00dc6cd85bcd7mr3654071ybt.3.1709681680784;
 Tue, 05 Mar 2024 15:34:40 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAys52UC/42NQQrCMBBFryJZO5JMFKsr7yEi7SRpB2xTkhIV6
 d1Ni4Luuvq8v3jvJaINbKM4rl4i2MSRfZdBr1eCmrKrLbDJLFDiViIixCF01D/BBE42RIgUGdq
 edRs+c3V3IFCV0tLsVGWIRLb1wTp+zKXzJXPDcfDhOYeTmt5vQy9uJAUSDmR0UaCTeylPtff1z W7It2KKJPwVF8vFmMWmJFsZ7ciV/+JxHN/chAtgOAEAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=1992;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=S2o1sUo5KPLCPT2eyiGeGCz4MtuFwjosW26PC//SCFw=; b=7+8qHAZ3oM99JvbuQ8eRN3JlnaRULZJKRxqW9xULkS6m9ejvTAmpvoT4okFTNUEmqyWppEJMS
 /ubJMnIj5IHBaWp0g/NyZfEQ9Q/5xWAYcIJ7VQlBmgLtDPyP70qCPpJ
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Subject: [PATCH v3 0/7] scsi: replace deprecated strncpy
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

This series contains multiple replacements of strncpy throughout the
scsi subsystem.

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The details of each replacement will be in their respective
patch.

---
Changes in v3:
- update trailers (thanks Kees)
- Link to v2: https://lore.kernel.org/r/20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com

Changes in v2:
- for (1/7): change strscpy to simple const char* assignments
- Link to v1: https://lore.kernel.org/r/20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com

---
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with assignments
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            | 10 +++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 49 insertions(+), 43 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>


