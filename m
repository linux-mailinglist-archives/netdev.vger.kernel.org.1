Return-Path: <netdev+bounces-74604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89A861F8D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F441B22709
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B114CAD1;
	Fri, 23 Feb 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY1blRTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36314142649
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726994; cv=none; b=plzcVITc67FAPPkOtnZrPtg3oB/EcKwczl0fk2Qs/L01mkEQEUheSdEV2kBA2JVz2fEfVfDqBW6fPQNIVONC9rr3Ko3RDRHb6DxqsRHeRdpuSJpLMIxZtKZwUD7dou44cy7i+FbRX8K4ehYeF6Htn511O1RDh7WBJtJQjgX4vAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726994; c=relaxed/simple;
	bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HHC/TRXnTpbAB0pDdxmFeAWiErn/iXuNcRJANT6GH4kS9keT8Q1XDgRLCsA3YzXxAJWOXo1mlVTeRnWxX/ruXq6OnqU0afiYeA+KzQOQmu1x0v6i1/l1pmH8hZJvCW3uaszsjOvRMOWyPHb1Jv82URnD18aS3feruoGDCFNqyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY1blRTU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2227820276.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726992; x=1709331792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=hY1blRTUIu/7qOkJO+c+Mx8xrzFy8m3C4BfImk4ERUZLeBrmqReZ4BKI6Sd+j650CK
         pTuDfL+n/SWYEB3Qrps1id7GSCoIc/74zw5ziizUb9w6JcSFTQKsWVbEZG7gaXmPXgcl
         gxEfueKbdrdzKoQwOT4ndWRR0XV7vO39pquNcqo8fJEOe5TJM6juQsxChOf3sArCIVkH
         QC0JVFIQoLycFBQ6wXaAu8RrfX9mAy65gr6EKryWk2Ui2D4CPzTMu5YMb5LH3cY9FPFB
         ZSNLyJGsW6Gb8mo11uwCvQw51+UIi80x2QH8pT4TUMJZMdh01TFl0djdBidcm9P7/NdY
         J/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726992; x=1709331792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=iPVs8VW4Q0eAW7+WVGlI4EmCqqiR8c5ioWGYj/bh9Z3IFsj+/fKTiBrNPHA+7hUuLV
         FpWjvHUKiOnxIW+kdzB9KmkJ7drdGvmD7gzG+0fiBu6sHw/kWkc+W/kwe+E9CmvqVRsX
         91G7BrvY6Axh4LN0OPDHKCulCbHt0ct8ZzRiB5sc/sHJJCthb1X1tuW5VMwttw8gd75E
         Po/HqZ3osWCs+FevJgBH2r6gP1d8DImbJZMR5MIR3ENDjccYdJTHC4onclCYFqjSaBrx
         Gl3YhU07J5v4yYrWeRcN8RMX50NruM/XzXhf5FF+aFHiE9v6OWtOKQsMKIl/lszSDHqe
         7tgA==
X-Forwarded-Encrypted: i=1; AJvYcCW0jGetU+PGKxR+qkK3eGQgzWha6lIloxI0SvEqJMiv3XseH/JthTHn21we36c4RoKVGa2FDjOOYPaFL36cBEnqaQH19qQF
X-Gm-Message-State: AOJu0YxSHwvtPBgAcBYeAmnhaNTPiK+MZhm16L0ZBsNebnLScWI2QKUE
	nYvJNM6CwJ+Oi6AyuEbqqOlFy6E7CkzplN+qO6fy4LJEdLiA9spBYg1UeFcb1L3yG2E5sR2W/Tm
	mWTonjjb+cq3maBZZx/tj4g==
X-Google-Smtp-Source: AGHT+IG0uQbPxc1yyNgunzayUFgBE0inCJgcThk//nbvp5YWKlRWOsmqTc7k8Sg+UNpvKbR9RzLmjRurmL8xIB+Cxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:188a:b0:dcc:6065:2b3d with
 SMTP id cj10-20020a056902188a00b00dcc60652b3dmr305504ybb.8.1708726992262;
 Fri, 23 Feb 2024 14:23:12 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMka2WUC/y2NQQqDQAwAvyI5N7Ab9eJXpJSajTUHt0tSbIv49
 y7S0zCXmR1cTMVhaHYw2dT1mavESwO83PNDUFN1oEBdICL0l2UuX0ymm5ijsyuuRdvV/rjNb2S MU2xD6uOUmKHWismsn/M0Xo/jBwE0zgZ5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726990; l=1611;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=; b=wIzkR9ttslj+b0wOPreTc5A7WUjUtgLZ2xJXIkoRRFJsTFFrBDRhsGJXQELHXar8zcNXJPLEG
 QWJPhdh/60KA1FJbeNXbShCZBnrhP5rvNT8yLUyTqCnRH04Xdhxj2KG
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Subject: [PATCH 0/7] scsi: replace deprecated strncpy
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
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with strscpy
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            |  8 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 48 insertions(+), 42 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>


