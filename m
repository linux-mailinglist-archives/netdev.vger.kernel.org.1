Return-Path: <netdev+bounces-77698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FAD872B28
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F581F2592B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA1134CF7;
	Tue,  5 Mar 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zR9ob2xc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9612EBCC
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681690; cv=none; b=rL63Tvlpj6oOOKLhTXKSefTXIT8xRY2GKQoT8sHq5ZYxc4iVXHG90d+5eY22jUvEELLxyzLyEpzjZbbwdNqzVPmB6LwGMJ29/NLS627Ox9WzIgOVBshxnx9jBYEFfhozFoxn8mIPDKTYRLHAGm80w4b3r5AT22X9FFudul4ADsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681690; c=relaxed/simple;
	bh=eWczkNLyxUvTeaPj7py9PZ0UxpZQDpHPCSVdmRIMnbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mf4VVuK4/OdtH0V5BuRXJFQnjYQtUVkDHfDz121VYZsdRZ3TcHSfxXWCgS4E4aofIJu7LHAo4S1Ucydm0+V0oi5EfsL7LxV2Ai2sf9wAKulDzuoIYmkfM25driY971XAnFU9hLbspjRO/MmCLzde/jXxVZ+Tb+hD18MVOHyDXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zR9ob2xc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so12154716276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681688; x=1710286488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBdhLZXYYhg9dizdXkfUGWj63Hy4tFxJG87qbeyzQbo=;
        b=zR9ob2xcGrShZqxYwT3/twiY07zYJu9O9+Rs7kEedN7RC7B+elpSweLYmAxNyrLDxV
         3jvNYJV0Qv/2wTnqDLz7SmQdGPXUQgsk9spWolUubtW/0DdORx9scGp6BRSeUPd4Pzki
         47dS437pxMq9t6ehf019fY9+FVPRlKCtOo2Zqe6qwZbGEyBxQnTfPZ157uMCohmep2NC
         fOG23lDpP+Y4N/CUGv2fOqvjziKYFs0LXLy+Og46eztQyUfNZr0EKfeyWfABCvG9oyfl
         vTdvF5e86FdxGIrc6H5nrx8RowreyY4o2A/dwPrP4CUFZ1XY9j2EfsJ7q/0WUkTLjO3D
         B3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681688; x=1710286488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBdhLZXYYhg9dizdXkfUGWj63Hy4tFxJG87qbeyzQbo=;
        b=TrQU4eRXZ/Zq3J0RC6Vx9wdtr31WarQLGQ/LgNaK+3u4znam/4FkbgFOz2lza6YT/G
         uV4siCaB9soBhiPtyJjQQ/9EBLe740chmbbPhZ4ZFgPeCWAgFnYjaxjJiCwj65eE6PwX
         zewzbpkg3HU6u0DR5ENYfl3hrJRE7qkAkXWxS+ljuDPbTgefvIIkGYlNv/h4gz2QweMT
         5D0C4CCtsOdBOFd02edcC66fy2oD4p+a9rfI7GGCozz4rSZ/93phlpjy+ib/mWizyY5l
         eRHvWxKSWaIh+puH6Ap5fa5OrkHgcy7JX++cLkUgiGX6Kfc6cXFbAxcy2JkH8GZBuGqK
         0ajg==
X-Forwarded-Encrypted: i=1; AJvYcCWd8DhrWvZ9Y4xSa9JPvnbOk/OA1aDcv9YfResgS8Hxp28ZGfpAqyYdLBav2VU4NT2EHaqlVerIqEmk36h8uRcdNK2Z6LHM
X-Gm-Message-State: AOJu0YzrMdnndzuNFGPea2eH+m0xoVTmizw4YecRSLIXuCu5ORkSMoNF
	qjtGfkO7zgKv70J86xAFW1sCSYL3y/C5BLW3toblmJzSKKLB4MoND6mI8LqmCqyrX33pxIY5Aeg
	nOIc4X4VJaqOmIHQzjY5PIg==
X-Google-Smtp-Source: AGHT+IEcfC2kqUdFcpJebJibmkd3MEykdtlXV90KSAjS+crdwyms+df6pNbl1+KyifeufIg+Zet9xLlccF+YbtQizA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:154b:b0:dc6:d678:371d with
 SMTP id r11-20020a056902154b00b00dc6d678371dmr3334366ybu.3.1709681688139;
 Tue, 05 Mar 2024 15:34:48 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:41 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=1485;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eWczkNLyxUvTeaPj7py9PZ0UxpZQDpHPCSVdmRIMnbg=; b=GBgB6OjQexdWYhcQvFNShhxQybtX8760riu0Jt3EE6cComY2f+0docGRsCcs/GO1kkdvT5L1R
 3Nmjh2x/65pBVPkRcC6uOERtx8MFRcINZrrZk6GV52DV1xNP8NRNWRa
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-6-5b78a13ff984@google.com>
Subject: [PATCH v3 6/7] scsi: smartpqi: replace deprecated strncpy with strscpy
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

buffer->driver_version is sized 32:
|	struct bmic_host_wellness_driver_version {
|	...
|		char	driver_version[32];
... the source string "Linux " + DRIVER_VERISON is sized at 16. There's
really no bug in the existing code since the buffers are sized
appropriately with great care taken to manually NUL-terminate the
destination buffer. Nonetheless, let's make the swap over to strscpy()
for robustness' (and readability's) sake.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ceff1ec13f9e..bfe6f42e8e96 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1041,9 +1041,8 @@ static int pqi_write_driver_version_to_host_wellness(
 	buffer->driver_version_tag[1] = 'V';
 	put_unaligned_le16(sizeof(buffer->driver_version),
 		&buffer->driver_version_length);
-	strncpy(buffer->driver_version, "Linux " DRIVER_VERSION,
-		sizeof(buffer->driver_version) - 1);
-	buffer->driver_version[sizeof(buffer->driver_version) - 1] = '\0';
+	strscpy(buffer->driver_version, "Linux " DRIVER_VERSION,
+		sizeof(buffer->driver_version));
 	buffer->dont_write_tag[0] = 'D';
 	buffer->dont_write_tag[1] = 'W';
 	buffer->end_tag[0] = 'Z';

-- 
2.44.0.278.ge034bb2e1d-goog


