Return-Path: <netdev+bounces-204747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B2AFBF5B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23FC169890
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FD1E2602;
	Tue,  8 Jul 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSuxMlr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99461DF979;
	Tue,  8 Jul 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935423; cv=none; b=T2fkwJm0BG4L8lS+vZscRayYz85ds4Uizy2lFgOCo5c1i7BOhwqQFKnz2hypEcH7BBVwm+QdwlwtQJ3IKaxdMBenESQezNTamxShGn/tGRJRJ2feDPtlzKwldsDMp984ZZFPi6z4gPK6iRfppN/wesT70IfZeHwgrU3E70ohljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935423; c=relaxed/simple;
	bh=4mUddNyIZMoc0+/EWYdyRKVhOzlpPdSiJd4VHdNAkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyaP+TkZ7QvWNnBgjXDO+pDvwzll/5OfGDLk2pe73KTZaI6h0GKnWPKXwbaooKQ+xkqy2rK1PtcBQJuX2HQSR4ymCLSAUvGvZyuIRTzKPJ17XoYBx81TAlcy2grSARimletY70pHp0wPML1thRGPsU0xZk6Jiz5JPHiCW2czcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYSuxMlr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3121aed2435so3679847a91.2;
        Mon, 07 Jul 2025 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935421; x=1752540221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80QJ0/Ue2d8FrJNLQszWtMH6jtF7MtGxYGsWhmuyfGY=;
        b=BYSuxMlrglTg1QK+RHCdg32KccRNy7CSS68NC44ujXHQV06N8NIiVKRLsnQlDSL9Pd
         FuxPFp+7OxL5xBAyctCzM4oY3lGEJG8/xbIfCfMA8wmRDMTnZyMNyCLuUjv9YF5ipwoE
         vfv0UMWC4/LOlkPO06fnQENVuQ4i7AfzstUlT431cC0dR/b8QBU3SJdbEAHlvyc2kd6R
         eutMZwuIxt+S6T3QOzjjzxZmSMW876sfQk1uc/ZNklYMR+mLx1Rvr3DYmcpijl6NNiJ+
         R+G0PH2FLXCxSSL8hy1c+B2btoJczg23a2TGgHFcEdfGLl44lubEDSUV1M5FiptvIQRM
         p+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935421; x=1752540221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80QJ0/Ue2d8FrJNLQszWtMH6jtF7MtGxYGsWhmuyfGY=;
        b=ohlI8k5HnaKID5EErADMQVBSLlW0fkTX3l16RukE63SQnQDxM2JngChdkSane6c2g+
         2KHYg1mlis1KZeS3wJ8UbUUJeYXZtz41cQ4jKgu8wTOpPDYcMn3ii9+QaU29Zz393zqi
         U74pNMQooP2opQqkd2eZfj8iZXmOS1J0kNBj46w/fb6gXFDcAeva8l/xfWq0hDxAXcZz
         Xjlnpb7b2TsFS2+mRxEK+PEHrFezh3MNpBNFyHBjkTJfm7MSbrpaOIasKUb3UyOy5hfN
         EPGD/t5jDZRCmgDRhK5K9AUJEkAz97uJOgbN+y6ni5jH//w0DdXLFBAzseIwxK5mRIy2
         8Pzg==
X-Forwarded-Encrypted: i=1; AJvYcCVr72Z2/+hYA1VB/WAQGU0R1AL33vCB3BX50/n5tYyGXipAX3p5Bsh6wAB0AX4FyF74jfB+VZQ8lC0=@vger.kernel.org, AJvYcCXWBIy09YoRQkQSMXgUZPi1dg1gDDLrDCgH/9nCO0OmqJbTL31kRUJoY1Gt6hMnfW8PCW03hToE@vger.kernel.org
X-Gm-Message-State: AOJu0YxXH5H+vQPE0fbiqFTTvGAddrn9Keb+/QYCkmdRYlmEOMFLJe2k
	EXay1MxBHOZQLvJRluaynftbEKQLfzHkiyvCNG0v1GAi8k96lbujHj3a
X-Gm-Gg: ASbGnctAL7DtZFKBtLfIvjDpJeTtPvbxoF9m1pw5r2vFp41Lasb4fX5PxisP5+z1jVS
	BSla9JxRFldHKteY7IZ1T8yZGMtitFN0FQJkIlfzXeA7TwW7KbMmmv0GnKRoQhQT6pZTio8aSm4
	x5VzCYdqNxC86L8dP3k/fs9JL0j/2vLXz+O6NTotRR1vSpp4okGfg8XO3Gq2GqmWWYulmqfnsxJ
	iNQ8k8FMqvrBhqRbvNEUh4CC5inrCGBbAqWvq25gkKu/5AjU7rK+642C2ONiUFVrKxT7QTS4prz
	R6cojTgVcL227TKsBCOEm7cDllp9RenxEVnjvNZZ6ZnIT4kS+NL0sl82R3L0ZA==
X-Google-Smtp-Source: AGHT+IFe8F/6MhIOc4/g/1xKDc2RRUCNzZnJaHFCn/n9+RvFT2IEQBV1yqq8tbNy5BKpH8Penv1AkQ==
X-Received: by 2002:a17:90a:da86:b0:313:176b:3d4b with SMTP id 98e67ed59e1d1-31c21d8aab8mr1047884a91.22.1751935420944;
        Mon, 07 Jul 2025 17:43:40 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21d67987sm571774a91.13.2025.07.07.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:43:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 61B0D42805E7; Tue, 08 Jul 2025 07:43:37 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH RESEND 1/3] Documentation: ioctl-number: Fix linuxppc-dev mailto link
Date: Tue,  8 Jul 2025 07:43:31 +0700
Message-ID: <20250708004334.15861-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708004334.15861-1-bagasdotme@gmail.com>
References: <20250708004334.15861-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=bagasdotme@gmail.com; h=from:subject; bh=4mUddNyIZMoc0+/EWYdyRKVhOzlpPdSiJd4VHdNAkZg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk5mbpHNA3+/mDxjXz8o3Svz5zMw3uSFfZYp1RZZ52LP r1+XsWyjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk9hgjw5bLinlFofrnLBWT 3M/mP5N+ulbi+MG93cvi41qqn/a9ncjwT+/A+3vr9825K3Mm7ZrZLslEBVa5BK2Vk3ddrjD7Kma +nhUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Spell out full Linux PPC mailing list address like other subsystem
mailing lists listed in the table.

Fixes: 43d869ac25f1 ("powerpc/pseries: Define papr_indices_io_block for papr-indices ioctls")
Fixes: 8aa9efc0be66 ("powerpc/pseries: Add papr-platform-dump character driver for dump retrieval")
Fixes: 86900ab620a4 ("powerpc/pseries: Add a char driver for physical-attestation RTAS")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index bc91756bde733b..a4782e566392c7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -362,15 +362,15 @@ Code  Seq#    Include File                                           Comments
 0xB1  00-1F                                                          PPPoX
                                                                      <mailto:mostrows@styx.uwaterloo.ca>
 0xB2  00     arch/powerpc/include/uapi/asm/papr-vpd.h                powerpc/pseries VPD API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  01-02  arch/powerpc/include/uapi/asm/papr-sysparm.h            powerpc/pseries system parameter API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  03-05  arch/powerpc/include/uapi/asm/papr-indices.h            powerpc/pseries indices API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-dump.h      powerpc/pseries Platform Dump API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  08     powerpc/include/uapi/asm/papr-physical-attestation.h    powerpc/pseries Physical Attestation API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
-- 
An old man doll... just what I always wanted! - Clara


