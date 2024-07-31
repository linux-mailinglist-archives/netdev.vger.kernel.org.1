Return-Path: <netdev+bounces-114501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB43942C03
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99A7283AFB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44F1AC422;
	Wed, 31 Jul 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2IiFpDh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45D1A8C0C;
	Wed, 31 Jul 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422063; cv=none; b=M52GYOXisteNQXlPxoFEkKwTTqQ4D61Pkg1uFLDf2x1diLcW0tj4Xi4KEkEf5TWcnPl2RV2HMc2RafrVr51Gs+GEflzdQ4w7OMfXz/BUeNSTMEAOSOu2J3bPjXSf+9CN9/Rfe6kleEDi9nVBQKWQPGTLaUEfdXknhq0HfWs2gt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422063; c=relaxed/simple;
	bh=s0qQWYiBST0sfG+TnYUyQi2+ybVB4FIxJdf63NDyYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIffFINtGdf/+1wD+kgqCWITS1AW7doCy6BEXsB8RfqFYbWL6/HcoftdPdJchMC7RYGZY0dr7XaUHKMxiYIryEhAMVd3lpqNfgddFdIcv7wtK/Pe/UppyiGJ6hCh4lgLKWKNpm9BgjTryd1tvvQ/CGmK+d1k3poe55EmyGjX/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2IiFpDh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so336988566b.3;
        Wed, 31 Jul 2024 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422060; x=1723026860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPEV5By0PnGctfSuYUXpXyoR9YEsrnIIgcpUVEf6JDs=;
        b=S2IiFpDhCd0AtNsBbg+cgbIi9zhEQah8p9rVEc6ZykM2wFTFVig6Q/MJ7XPNh10YWR
         fQUv7jNV52qXj8NK6wQCs2JV7zLlGOt1alBWBHSfGdLTBPCXhV0B3xkR5KE9m4bp/2wf
         HqYd5bAQrtjdZnvnjM71SCOxD9H5tJ26AEOi0sekshfds/QQASrWpUe2ywdpq7xgeWYr
         dl5WXP+g9L7A0RFk1bjVQ5mhCoG0YCo1WFGnfmaTl8SbTz8RNJLe+D2zHzwR2l1Q97Sj
         2ZYArlYoDfg+/5lmRV4WwVtV93ZyVBfir71ViF6g1E7PUD11pycsZsnYGV6Yc3dgdmzq
         DVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422060; x=1723026860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPEV5By0PnGctfSuYUXpXyoR9YEsrnIIgcpUVEf6JDs=;
        b=II14Gmf/4EcjB24DewYWkLW+dTAHof/tpwUrGIXaUCnzhml7Ahgw5ixOS93idJVB0f
         +8yqDTI0LFI3RJ35a2JJ4068pPXdxrYZXq+bRnwHQ1ZF0xTcu45PcZg9auxViMJ3qFdI
         F+9klaji/+jb0ZH+Embp0kgGWFZ7Fr/j8DX+p6vdxG3N5RgyqeXoglvU8L+iYrj9RSz5
         bam6Y9aZfcJCGNTqhjcb4PWn6Xrr/n0cwPwqIeHDmZCEM9MiLg1/LrDfeSAbvtm736Zx
         WPAZeQU7Bls2Rqg60/rWrG5FXcMfYicQYk1+/pOPMl73V0o2G06CLU/PNaqwhG5uxeYb
         BhKA==
X-Forwarded-Encrypted: i=1; AJvYcCWWBCyjQa81chqN6tsY3E6J4t5DENPRtOYsT9jbFdD6kYw+N4blkV3H0xUmBbliIqyIvRXoRe9SPIistxGT+PpC99jnK5dm
X-Gm-Message-State: AOJu0YweGpYUCeuCHlBPIqKNBClMxa07ejCkDpwKrOYOcWFxfQX0neOP
	0en4oeIokDrzvaKsY+qdp7nM6SrnLxK8MNH/qxhKTGMB3i7CIsRqPAIs26DUOy4=
X-Google-Smtp-Source: AGHT+IFnZ/1F564sg8Uegkk10EAOdaVRkkEpzHT3ZoNAF/RjRlfpA97w/Qta8y91ieXy8XHJiZVCiQ==
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id 4fb4d7f45d1cf-5b021d22ba2mr12570524a12.18.1722422060150;
        Wed, 31 Jul 2024 03:34:20 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:19 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 0/5] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Wed, 31 Jul 2024 12:33:58 +0200
Message-ID: <20240731103403.407818-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

Strongly based on existing KSZ9477 code which has now been moved to
ksz_common instead of duplicating, as proposed during the review of
the v1 version of this patch.

In addition to the device-tree addition and the actual code, there's
an additional patch to check the erratum workaround application using
the now available indirect register read.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v2:
 - generalize instead of duplicate, much improved
 - variable declaration reverse Christmas tree
 - ksz8_handle_global_errata: return -EIO in case of indirect write failure
 - ksz8_ind_read8/write8: document functions
 - ksz8_handle_wake_reason: no need for additional write to clear
 - fix wakeup_source origin comments
v1: https://lore.kernel.org/netdev/20240717193725.469192-1-vtpieter@gmail.com/

Pieter Van Trappen (5):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
  net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
  net: dsa: microchip: add WoL support for KSZ87xx family
  net: dsa: microchip: check erratum workaround through indirect
    register read

 .../bindings/net/dsa/microchip,ksz.yaml       |   5 +
 drivers/net/dsa/microchip/ksz8.h              |   3 +
 drivers/net/dsa/microchip/ksz8795.c           |  99 +++++++-
 drivers/net/dsa/microchip/ksz8795_reg.h       |   4 +-
 drivers/net/dsa/microchip/ksz9477.c           | 195 +---------------
 drivers/net/dsa/microchip/ksz9477.h           |   5 -
 drivers/net/dsa/microchip/ksz9477_reg.h       |  12 -
 drivers/net/dsa/microchip/ksz_common.c        | 219 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  31 ++-
 9 files changed, 350 insertions(+), 223 deletions(-)


base-commit: 0a658d088cc63745528cf0ec8a2c2df0f37742d9
-- 
2.43.0


