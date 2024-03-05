Return-Path: <netdev+bounces-77699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7F872B2B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9599F1F214D5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35931135A67;
	Tue,  5 Mar 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk4+kK4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3112D21D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681692; cv=none; b=mNrKGY3E9jmV25eknwAlVGjiP0f7mHDhdsdC4DWlTPuRiZXAR/KNtPVvJ9g40MZj1grzWDFg6xSha8b8mUuU6Yl5JHIBemSNrH2XLl2L8K2PJFwSkyI+gnnjoRt9a+s78uOc5xMyNZDXHA7253hgPT6ci69xv9/xDDWLepMMUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681692; c=relaxed/simple;
	bh=FcEcSMUZOi/4Oj8G2zljZCZLH3SJcgxPb0qa54lykhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IeiSapqbSInp97WSEjC7JcbaEuWvv0u7zKCcOdybGsvBWlVaMlEowZkmTzOEUJBQPdFqb0+wLU0aY64UOw11rPCn6ZjguVO3GL2u2XIkRV13EhSJWRDUVOVXs6eMRjo5Fdwe4dOfcUokV+rr1x5VDHUbM37rBHlJjeNKFCXYIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk4+kK4O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso2360776276.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681689; x=1710286489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGEY9f3OqM6eFdMybydMZbUAGFeLoZyzbi8Mpvwi9w=;
        b=sk4+kK4OEtHjRB4RdWR/f4HFlTaYxrWMs3oYAilZqqqSTiLt3y0J6XN3zbILtB32+0
         /XZPJ/eaxgY8bDFtYRWdngUaVo7rE7llv13BWh3kgss2+6zKOrItFggOACk/UmZYatA+
         +At8Khwx+U56gUVqO8C8yBpbEzCnvU8V+JAlwtJHB0rYdqvpa9AAHRRPxBHEfEWtNrgn
         Gk5rVR9FiqpvwTNVy5ii7PNTvR8ftr4THmxH/dKM4cKydDHnvmD8ZspPuQ3r0DCrwQ+C
         Y5Uu0dJM8DgL6a5Qsn8qB9eBbnDpnHWbp9E/igbXcpKHk3Fm545P1XdND/poPQOL/0dP
         XgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681689; x=1710286489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGEY9f3OqM6eFdMybydMZbUAGFeLoZyzbi8Mpvwi9w=;
        b=jYEYWtj+uEhTfnpz0P8mVGUbtdOGPoD6/AW0LMTUB2m4YONtijuYMrMRUVAvE3/p0i
         uRr6bXPOW9rEhoBRfySb/7qWLHzCKPCshhXIib15JBSyoR2trTZ98Qj83E0atlmgv1vj
         co4b7EbxfyyDKEsFuP8QsLWflNPFo7CInLELfC+wsLXU5Nhg8UTlyANgzwl2bUg/uUfa
         EUf3oWMuE0JzYQwbkXq6TRfgfnnEKjUf2a2KNrn4SDCqK+JkRJ2DNmw8jgKt3hsEgE7j
         ye4iVEuGpJSTEyxbKeuEmsnl1GO6vXqKXAnxV8NGo91yh9gnnDWfoMBAQQBfwMg8i8GB
         I4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCuXx84Q/tyiA3dEZ73h+gbh0ykL1DDKx1UOWV4fk4TTiKuD2OV5ymW7AsB/sozuiHzL8E7rv4JMer0uLt/ow5DAytBlS9
X-Gm-Message-State: AOJu0Yxdhhd6FVHwm4mKmzjP3hSNTXlxOLEa5hi/BkCS2KJpKDDTo0o/
	7Psjbti3z3wLX7XOCNTHUFt/z0Kbf9JarBHDmnZWFKj0fANResaibovFrL+z89HjPURlCpISLiS
	105WUAn+TDqFTrRgA27YsiA==
X-Google-Smtp-Source: AGHT+IFhY7mSFiskrXLQQcLXv+8xGkstxo5w0gS60+blMyypRYZeekyCqzmmOLRjPz0ivi7dNVpAi02DPBov+hPrzw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:210b:b0:dcc:50ca:e153 with
 SMTP id dk11-20020a056902210b00b00dcc50cae153mr3627471ybb.7.1709681689467;
 Tue, 05 Mar 2024 15:34:49 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:42 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=1300;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FcEcSMUZOi/4Oj8G2zljZCZLH3SJcgxPb0qa54lykhA=; b=rEqSK5v7RadAxWbNgUvH4x8qZTngDbd07BNkbZ1Pq1tjrnZ0h0MlU2EsBQmYekMKYg7eDKhfc
 Gc5GYce/HG/AVosyZo89GfoU8y1DHcrWZSkiwbH+zU8Q/7Cwo+zcboR
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-7-5b78a13ff984@google.com>
Subject: [PATCH v3 7/7] scsi: wd33c93: replace deprecated strncpy with strscpy
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

@p1 is assigned to @setup_buffer and then we manually assign a NUL-byte
at the first index. This renders the following strlen() call useless.
Moreover, we don't need to reassign p1 to setup_buffer for any reason --
neither do we need to manually set a NUL-byte at the end. strscpy()
resolves all this code making it easier to read.

Even considering the path where @str is falsey, the manual NUL-byte
assignment is useless as setup_buffer is declared with static storage
duration in the top-level scope which should NUL-initialize the whole
buffer.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/wd33c93.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index e4fafc77bd20..a44b60c9004a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1721,9 +1721,7 @@ wd33c93_setup(char *str)
 	p1 = setup_buffer;
 	*p1 = '\0';
 	if (str)
-		strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
-	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
-	p1 = setup_buffer;
+		strscpy(p1, str, SETUP_BUFFER_SIZE);
 	i = 0;
 	while (*p1 && (i < MAX_SETUP_ARGS)) {
 		p2 = strchr(p1, ',');

-- 
2.44.0.278.ge034bb2e1d-goog


