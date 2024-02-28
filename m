Return-Path: <netdev+bounces-75940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71386BBC5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DAC282477
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF2161B66;
	Wed, 28 Feb 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7FQIIbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6115E5B7
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161160; cv=none; b=O08o4hNhnql9VmJS3xvF4RgpGxzFZZF/rNT+jAByE4s72j6N2RwKecGpvxNDgiB9azpdTa/sxszWIGHENgd/i8wBdB5xOzARNxJUUXdwZpKOgV4s8EaV8UorSv3k3zwbJkhXCL4NMErhXeiNVT0gLQ2PWDs3jbtVIQxd4ooxfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161160; c=relaxed/simple;
	bh=sByDsDMKp44vyq2pot5Hhxm/eaP0ttE9ltVB3LqVHFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjOSvXrQMQL1cxe3LA3eDBwTC2q5fgjTUpEh3uYn+fSXv2t4Tqw2X1jPan+1lZfg5OpidmguLLERyeXKwnk97ZD557xUvGeEtiO4oUL9azTcWsJsh4qx/TF3IjwbYSmHE+1y4tUaO0X1Y9rKItlMgJapAO/pdFZ20jU2T2mqfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7FQIIbi; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3652d6907a1so3460725ab.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161157; x=1709765957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAj5OZXxeaW4sKlBVmOyaWiE/dDaeK+k40BuTuu533I=;
        b=x7FQIIbiUTu8GEWN+AawAD1f6igoVfjJyAGlagzRpY4ZMwmrpQBQ370WbKMVvyJnip
         p9gK4lILU51xV0OTG+Lvb10hA1fIzcOUKq6L+GZjHVlVKNTQsu+e2WUhw/Ioadiuu7Eh
         cHiitHCRQ3PL8HP8gWrcViZIT8MUn13REIhbsGbC0ZKIVEOnTZD2pcORiLGTrWEo/GkD
         eGT9EFaOpFMEehUh+fi65Sz02YD6f7lSAsS3ZZsVDFLO/d6TOLGpPI3Q5VMoDPM1GlVX
         +5iksbasBiZp4rwR9GfEaYQc80Ika3S3bxBwFkR6QVLuuj66jo8A86wHRBNVFtgLPVVh
         XMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161157; x=1709765957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAj5OZXxeaW4sKlBVmOyaWiE/dDaeK+k40BuTuu533I=;
        b=XC08O4IfwB4DgXT6m78zLbr6Of0W22KLOUj0RT4Ga+uDqFvmQojQ8YC59wpcM4c3Ng
         +ZLziza0Xi7Iie+UpKSsZE6Tvi5w2B8ShzTcy8TZouwavkkkEjn7Q7BoUVYEhF7RGdOa
         z/wTBAXgLXHULnSHDsKjkT9ag3xdOq2OvAGhBHDgivf+4wZv6NdfhLaD5wvwv6XKPQBd
         rSWxUVzimLZBmKVE8eEGo5oi080xPuuv4PvY+NCJFoz+qb55EegWvomdU8B9Eq5UvAJv
         NQVLrFQyxHKnA/CCar3PQklq7/i+TZsGMGcIOYPunBSmTLQkNJcQlXHYprwyfx25TWCW
         aqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs7Z6iPDysZXFOHX2bL9rW5+xAqo4qktkMY7LrKSPB7mmb+xv4I/vIBFNNNPRie3d2nKK/M7gER/sr2+WsHU8b420NKHmm
X-Gm-Message-State: AOJu0YwwiSRoZoNVCIIYHQ/6p0Btu53R6HltXa9Gdqa3MKVHdcX4u9vc
	G1n1DWRNotqhBNpEZZ3VTjqP3z/l8/7qtAyLpUlmOyvob2Smc0tigB3AUpPYSRYR4xZuIPUZidu
	jnMqcb3MURXx9WrMwSK+2Cw==
X-Google-Smtp-Source: AGHT+IHoQVSAKtTKWMR9HqVfcdvMQJ5TQ9kT4Qfz/mA8h9PaGzJ6iHCM0QJAjUXmqcpaYEmHg0FOvRz7HtCHG9nbhg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a92:c563:0:b0:365:21f4:700d with SMTP
 id b3-20020a92c563000000b0036521f4700dmr34184ilj.2.1709161156751; Wed, 28 Feb
 2024 14:59:16 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:06 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=1441;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=sByDsDMKp44vyq2pot5Hhxm/eaP0ttE9ltVB3LqVHFs=; b=MQmDO4s1joPg8qz5k1DfkUDPX+8AhggVdiQ9eJscb4HSloFwaCNCdz/nFzT/ALueyz6YmZ8NY
 6fbXI+QlUapD1QbsdKWY+t/Yuw1thXdsz72jHdrFaniAPlmI60I+0Zw
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-6-dacebd3fcfa0@google.com>
Subject: [PATCH v2 6/7] scsi: smartpqi: replace deprecated strncpy with strscpy
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
2.44.0.rc1.240.g4c46232300-goog


