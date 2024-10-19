Return-Path: <netdev+bounces-137232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19E9A5053
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B431F23569
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB018EFD2;
	Sat, 19 Oct 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMj8F01/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352E320E;
	Sat, 19 Oct 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729363039; cv=none; b=A51cURbAKK5nyEBQCiUXGSwyQjCSdSrkjhCqAexvzVF15mLCbXPNuZ30+Yik2x4j/eJ9y4jEWtXCyC4tXylBsbSOQx+xvrj0D05la7/IsqM/jyk96Lq97FUQv6F83mYkpACbIjPkC4kMEhJvaJX6ry+iZ3AvipQshhb6j3QM4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729363039; c=relaxed/simple;
	bh=f2raWUzbwuynpcQFtcZA6RIABMKNwsByHhYe8vTxMso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EqXMrjaht3OI4SOJmmXHiICUMJuNvyEjn9s3VtxMse3lgeIE/mvyBAxCNxVvPRPsyleA9aAUNXEh+ZWO7L+JzrYn3I05NlV8sGX4m+TOB264XhDPa1FWjEiDVYeHhRDsT+MO4lSQwXb/EHcExJUeFvVcQiMWhfZgtW4PPxc80NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMj8F01/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c1324be8easo3089474a12.1;
        Sat, 19 Oct 2024 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729363037; x=1729967837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zanKzOorteppgez4TRhIZl5bp9bo2C4LWtEvlOPyEhY=;
        b=PMj8F01/N5hnKM6G1qfMH9zz144fuszVbAJsdsDseKKH5PO4XNWBdw2uov32exufEy
         JgqRIcfm+g/PUdF939jFbJf9ixxWX4BWxuZXFlj5QwE2Tq2RA9OkWu5BniyA9F8GWLml
         cDWmHFZnQmlgqKvDQN3RkHSFNwlgShJ5kx2+WJjKvQfen6Ylk3eGgwt6WTbOAB1YEvrg
         pJZficog9C8fl2FPREtFPeyL2rlgZIYk7vlWBiPX0E1auBibmoFDZiE6TmvCSbcR9CHt
         bKbBF/VQ6a133Yjsmj9DqK9rZBEt/olSwnlUzWnXa16mOtsv54im5nUSX5LUUvrai1Ya
         MeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729363037; x=1729967837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zanKzOorteppgez4TRhIZl5bp9bo2C4LWtEvlOPyEhY=;
        b=CwxRscCHN1nbnXTuXIvxiL/LFuhb5AylfewIgoYxtV49ekLoNPwpnb2yT2kFHOu4HU
         /ZdnWiL/oJdRxKUTQkYK+/FhLM0eU1LNph62m2MbK9/MfPBMj3g36mMiYtk2hOU5znYV
         19uCXhWnFVusuHNTlA7dJ1pNYGAZqmeZh3qEetL65OWyPlkXXrxUJhLgK75AE3aSwnEP
         1rmEBsylLEq0b7oi3BG0RlDkCCu1ArdSzKBD1q3+tGHIyz/VTh/UlH3fuANj8YZ3GcNo
         fr6Dymf3A/V0nCovG7DqVTk60e1V6VFyDhAjMo70dZKeqp9415RPEaVeV/L48VsKrQeh
         Z74Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCnFVoSPlDjpekzLN1NuTyLT2I7XTt1ItiyXQaUdJBqNa0JjDv+VU/nEkyTFPQUv4mrM9nKgbo@vger.kernel.org, AJvYcCXldt6dvrSPAouIFIrUGfQTyPLQ1I03cgQbMCoy3g1AIlyz25ic5ANmaqPHtpOWTDN4UvmSdy7WvV8qXiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWeoIEQ0Xxnx5KuV2UeJvLTYvTHssI2usdWT5V5rTafSJZ325
	7LRpl9bVSihe4YFkkgtSshLqRriT1QhOxyhiocuminInw16KJQxixgy/RfuJXvikdozHlwJWUzz
	jGlcapCbtKX2vI7B1e1eNU1kNjse5ynS5Fs4=
X-Google-Smtp-Source: AGHT+IG63gEpPr+N0wBA7B6sdGV88dKu+f6xrgCLnnvuxg03L9kjYV8IdCPsqwlRLhjq93W2DUlPKeyK7OxsjxgD5KE=
X-Received: by 2002:a17:90a:17e4:b0:2d8:9fbe:6727 with SMTP id
 98e67ed59e1d1-2e564499702mr8875243a91.4.1729363037388; Sat, 19 Oct 2024
 11:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Benjamin Grosse <ste3ls@gmail.com>
Date: Sat, 19 Oct 2024 19:37:06 +0100
Message-ID: <CAPvBWb=L6FVwSk7iZX21Awez+dwhLMAoGe39f__VC=g7g6H2+g@mail.gmail.com>
Subject: [PATCH] drivers/net/usb: Lenovo Mini Dock, add support for new USB
 device ID 0x17EF:0x3098 for the r8152 driver
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From 7a75dea5721225f4280be53996421962af430c8b Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Benjamin=3D20Gro=3DC3=3D9Fe?=3D <ste3ls@gmail.com>
Date: Sat, 19 Oct 2024 10:05:29 +0100
Subject: [PATCH] usb: add support for new USB device ID 0x17EF:0x3098 for t=
he
 r8152 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
r8152 driver. The device has been tested on NixOS, hotplugging and sleep
included.

Signed-off-by: Benjamin Gro=C3=9Fe <ste3ls@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index a5612c799..468c73974 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10069,6 +10069,7 @@ static const struct usb_device_id rtl8152_table[] =
=3D {
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+    { USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
     { USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
--=20
2.44.1

