Return-Path: <netdev+bounces-77693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E907872B1A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724E11C24960
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958B12DDBD;
	Tue,  5 Mar 2024 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcHm0lOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACA12D74C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681685; cv=none; b=mw1nlaKKxKAKcUjR53fg7lZYuUBVilSFsQCXbxdTfbMOkD/xK4ooNL28jeM14WLu1RJ5dv7FVX7cW0IYKTam6lAY88jDYovLJdDiLD48VtC/rOuQ1mlP3daXtbsR+MTgTVuO6XeZxhOzI9MlNakutOjnueg4nzNckYoMxN8fK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681685; c=relaxed/simple;
	bh=MCTI5WU0q/OjSWo0DYnEwQ71Bx+4NnviT+l0Jn0Vwtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TyrWKaOUvkQWt1lOgjtQBWlaTB1I52k+OOxHsovd6cZbDOsNo3YcwehIT+Gs9DU+ffxmCVp7+xmAdwVpVJkang9f0WNMdap/KqqziNhxLceDxemhv93+6LqgjY9Pc4Zwra/za/SEDfMI856PhFWS6a9j5mTmBefz30CTpGRp1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcHm0lOD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6096493f3d3so84292447b3.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681682; x=1710286482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xf2dq5GdDyi4s4WmIv33iVv6HbbqbNsFgxWnhqrXlo=;
        b=rcHm0lODl3Xe6qAaVQRO42Ws3xVfyYPFO7PNs0ASoo33BZFJHstOSnUWpe1FplxvMh
         dmFQ4KNP06yw1bJ/PEKcsYJP3HBNDtiYxuXoU2xnYeUmRvhWm0agTlRbVtdnj7I99BXY
         ngZhNTGFqzDu4v/gV2ehRjCUhhx5cDUba9XIbk6k9JkS1Rjo2wWaTkvH6M52OozTOvIj
         n7d8GC86lxPHyb/EOC+v6mwMyfQp8NjNOKdgZeWlK0QfT54D6ZTlUkWCStN/RPUtQ41r
         AQkb9eYUhkEnH/8U5kROraM/EAlVf6M4IMi0BGyIxk+lWVHQAuHug8gTwHsHhosNMi6Q
         df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681682; x=1710286482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xf2dq5GdDyi4s4WmIv33iVv6HbbqbNsFgxWnhqrXlo=;
        b=iUbyMFAlfupTqmT3C9nZvEG61PvKhdvzn/B8IkpdbqmD2HuGupsJ+25NA5U78dWddY
         mU8pxqqH7aeB/Dq5kLE2fT2CMROjLoHwzwpRuRSTU3OYZJ4SohgmhIFDHfqfnMes6a5Q
         o7UhU+SfYzdSwEfFjzlBZ+SkB8nKT2mjCi2bmKR74/gXLZTq9BIDVwXfSgsifGDmhq89
         TI4ZtOUVkZ5L9wUAEq3l+NVrs75ThFfDFcUDqyZqEteRmr2hLtFNYyR/rEMgqNJmHY0X
         W+/n7sAotLVshrZglsKktsYD64RGuZZ5rttea5fr9rvqIccJs+PnBqbX7oY1CjZw0lOK
         jf1A==
X-Forwarded-Encrypted: i=1; AJvYcCVVWNuk4LKfdE/H1aNf4Sv4BUvzozlHn4zUUkrifGl3Gg6cBqZyQn8jk2ZCkct1gD7xqKjfFhr7DFrr+a2F8rXv/LVBvyti
X-Gm-Message-State: AOJu0YzCh0jJE/VJNleA4mE+p+/WvQbD9fky6OeSrKtoL12kZnoxKKCE
	FDY7zVY+Ez8Uav1LXgvAP+6HFsD7Ay9QGkgKrXzwXdqMlBIlaw83DopYxeg3IxysxAj59qlRjCL
	BVyvx7cbPzfmnt7rLG+RbGA==
X-Google-Smtp-Source: AGHT+IGjXP7xV9ruZsbeD4aaELcTYAXgic0nA0Hrjs4+Y+HNFaz12SX4X0SEt6kHvtfxKoyr/JXIYEI4l6ExCkDDYA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:2fc1:0:b0:dc6:ebd4:cca2 with SMTP
 id v184-20020a252fc1000000b00dc6ebd4cca2mr457031ybv.11.1709681682039; Tue, 05
 Mar 2024 15:34:42 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:36 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=2052;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MCTI5WU0q/OjSWo0DYnEwQ71Bx+4NnviT+l0Jn0Vwtw=; b=rnmRj8jm3GgjTZnumlpPOaOkMDVx4IdzWrhmcsZBaHHv305Z07EM4eMErQjpOQbvDLsSNgotZ
 fSo9MlyGZrDCLxYGXzFNWqNQYlSPCU1xKVTxKIi/dth8EzpyrB/5tvE
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-1-5b78a13ff984@google.com>
Subject: [PATCH v3 1/7] scsi: mpi3mr: replace deprecated strncpy with assignments
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

We can just copy the const strings instead of reserving room on the
stack.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
changes from v1->v2:
* use const char* assignments rather than strscpy (thanks Finn+Kees)
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 528f19f782f2..da0710cdac1d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3676,7 +3676,7 @@ static const struct {
  * mpi3mr_print_ioc_info - Display controller information
  * @mrioc: Adapter instance reference
  *
- * Display controller personalit, capability, supported
+ * Display controller personality, capability, supported
  * protocols etc.
  *
  * Return: Nothing
@@ -3685,20 +3685,20 @@ static void
 mpi3mr_print_ioc_info(struct mpi3mr_ioc *mrioc)
 {
 	int i = 0, bytes_written = 0;
-	char personality[16];
+	const char *personality;
 	char protocol[50] = {0};
 	char capabilities[100] = {0};
 	struct mpi3mr_compimg_ver *fwver = &mrioc->facts.fw_ver;
 
 	switch (mrioc->facts.personality) {
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA:
-		strncpy(personality, "Enhanced HBA", sizeof(personality));
+		personality = "Enhanced HBA";
 		break;
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR:
-		strncpy(personality, "RAID", sizeof(personality));
+		personality = "RAID";
 		break;
 	default:
-		strncpy(personality, "Unknown", sizeof(personality));
+		personality = "Unknown";
 		break;
 	}
 

-- 
2.44.0.278.ge034bb2e1d-goog


