Return-Path: <netdev+bounces-282264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFLYAdCv8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBE4904A6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE87D300614B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E043A380A;
	Wed, 29 Apr 2026 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXiujZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155C3596F8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446861; cv=none; b=mqigZtPrwowF9udk5Ft0meI8l7vc0kjh1aT1Eby+58a3kQ4kMmzdx9JypFxkQfhrTH0Te6X48fDdKD5zyKZip8yg4zZn35j1GGJdLfYVyn1IVzuB6BPbygnR/aBg8xJHCYCzXjIlhbRAR//etmTRuw60UzFgJXzXp+rLQpoTa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446861; c=relaxed/simple;
	bh=Ms3QAY077lghlESoMz4cmu/HHhwxOm5OtQ9Q3cVsBZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prHLnUqMb22WJCHO59z211qklQB18D8314Dj/3ljbAJzu9HmH+rWbKlHi4Hu34pN9TD8XlIC9VbsRIcyBDNx38pDYZ2fMyfsX4JHH12B5UaCnAv8U3NgoqtSNrTCPjF/7NsH5Gs2sQN+ZYpYtXa0S74g4pqLkCYFk2aHWT415Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXiujZA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38ccde812ecso6389261fa.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446858; x=1778051658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z19nRFaT8/kYHTBgQjxsWY7McT0fpcEner+6VJ01bbE=;
        b=GXXiujZA6sgGAOLk3UWVkFJ2FnYBhBH88SLArKYKVtErv6uQJxdTJ1jCkNt7e70I1P
         +yaWVROSYDgAqLFhz2GDxZqjsssFaAL5Sg1LMb3mBXgg6s1ycRDYuEV1ipPmBCybR0Vu
         LiCakfldgTJdPN+4u4yEnCN+3HvYnh8L7G+tWi+iBiwW9ZVSG36KeVCnAzrs2OzFAcjV
         dg+blocFeBf57Q91zLCRcJ2p0fBvL4RX0Dc4SxnyNgnV0Lmzu0PBEWHnVPmk7XVehEV6
         39YLqCkFO1AS3E6swjT0+XGer/dzRmuhN7bxLcHnK3KOcDGpCLux/Fb1/CxMB84bO6Nq
         SOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446858; x=1778051658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z19nRFaT8/kYHTBgQjxsWY7McT0fpcEner+6VJ01bbE=;
        b=JcgT3nPMUjipYg3CCJ9iwSug1uTWB9Oldpdp0FEncP3I2MjJGWv/3RBcZne8rf5We6
         qDFY81uxu5Lc6MyDNHGaekKsueQyZk1TxVIQcmsK+54chsaRnFRMjQBn4N+kR8ontQ6C
         FjVLHHuGsGbEJli0k2sduEONC7oNICr4pmoRTD3Q0QDVPO3QtdtQima/K0JjPuYKnw6J
         +GudH07odDq+NDfDvYmzS0AzSoNNBYS4qnVKSDvKuiUtn9PwBMijMzbWjdouMValdgsN
         tQQouRmbknJe+YP5X3Shc8pyUC4dmTs6j3xguNoP/ov5QVQu2jLTSOate1TU8HO2Gdnc
         kuFw==
X-Forwarded-Encrypted: i=1; AFNElJ/H5qOh4W6PiPOgh1AVOOGaSGqgjOXR7qbC1ZUoiy8Q/3TVftrb2jUacNAHCPPOWYX/Ukh1jsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzp56TUp8LywzLJwRYb15YL1EcNRSJrQLuJeTm2CkFtxY09oH5
	MZqCfhFOqUU8fFveYFXpaQQOesDo9HhY2wkB+A03aFNQQiTcwb4fYy+X
X-Gm-Gg: AeBDiev1z9FsTQetAEkYloBJAP/p8+gP+71Z3g/WaIzyroJQCjvT6v/DzQRuGo49ifl
	o9b0YN4w56pg/leAs/iMxebT4sOOmbVBJAOgIktkZSLfjgvu3WXvRsPlk6nHOolPOOW0WJBmJ1U
	oCtPQCSGULXGUnmiSuAO8sCR3j9q0iafIJCbeGni+c7mRi6GhX6ViIKIXA7lkG3I/fCG0oRb0JJ
	3YZDAL94RF9nmwNDa1lnbveRj+Xop+rnkTQz+3p8NvC0NdDXQCOM17tKgK5KMlnn6ZqWGBDol9T
	TZpopM2fbKYoThy1eDU8t+w6TbCROkZmph7xRIZMikb/53lsWs3pb3HoH2+YFZwbjhaekf+g5b/
	2mkEFBgj28H5WGpfH612TBBASKSKSWxXLXfJMEMJzpb6AmMR19VO9ow9cBWFReQaA0ZKsCtjco8
	sAuVbEjE+DzE7qoB1iYjZi+0+MMPQF2/o=
X-Received: by 2002:a2e:9896:0:b0:389:e6e4:3c7d with SMTP id 38308e7fff4ca-3924d716d8amr5232581fa.19.1777446857723;
        Wed, 29 Apr 2026 00:14:17 -0700 (PDT)
Received: from thinkpad ([188.225.109.225])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3924fa7c93bsm2861151fa.23.2026.04.29.00.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:14:17 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/2] mfd: rsmu: fixes and new IC support
Date: Wed, 29 Apr 2026 10:20:45 +0300
Message-ID: <20260429072047.1111427-1-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CDBE4904A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282264-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi!

First patch fixes Renesas 8A34002 SPI driver.

In my setup 8A34002 is connected to VisionFive2 (via SPI or I2C). I've
discovered that upstream driver does not work:

[    4.728771] 8a3400x-phc 8a3400x-phc.0.auto: 4.8.7, Id: 0x4002  HW Rev: 5  OTP Config Select: 0
[    4.737389] 8a3400x-phc 8a3400x-phc.0.auto: requesting firmware 'idtcm.bin'
[    4.744462] 8a3400x-phc 8a3400x-phc.0.auto: Direct firmware load for idtcm.bin failed with error -2
[    4.753547] 8a3400x-phc 8a3400x-phc.0.auto: Failed at line 1273 in idtcm_load_firmware!
[    4.761576] 8a3400x-phc 8a3400x-phc.0.auto: loading firmware failed with -2
[    4.769411] 8a3400x-phc 8a3400x-phc.0.auto: No wait state: DPLL_SYS_STATE 0
[    4.776374] 8a3400x-phc 8a3400x-phc.0.auto: Continuing while SYS APLL/DPLL is not locked
[    4.785206] 8a3400x-phc 8a3400x-phc.0.auto: Unsupported MANUAL_REFERENCE: 0x00
[    4.796930] 8a3400x-phc 8a3400x-phc.0.auto: PLL2 registered as ptp0

This being caused by a piece of code in rsmu_write_page_register() function:

if (reg < RSMU_CM_SCSR_BASE)
	return 0;

All addresses in include/linux/mfd/idt8a340_reg.h are less than
RSMU_CM_SCSR_BASE so functions was returning early, before any modifications to
the page register. Valid read of versions - is just a coincidence, because
default value of the page register is zero.

There were 2 separate patch series which had to be merged in one time: mfd and
ptp. The latter have been merged, the former [1] have not. As result we've got a
broken driver.

This patch can be reverted later when the second part will be ready (of course
if it is planned to do so). Any comments, Min? I could support with testing.

Second patch just adds support for 8A34002, which is compatible with 8A34001. As
I can see there is no need to update bindings, everything is already being done.

Link [2] to v1.

Changes in v2:
- Fix page register issue in rsmu_i2c
- Add support for 8a34002 in rsmu_i2c

Link [1]: https://lore.kernel.org/netdev/LV3P220MB1202F8E2FCCFBA2519B4966EA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM/
Link [2]: https://lore.kernel.org/netdev/20260421090710.395591-1-dev.mbstr@gmail.com/
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>

Matthew Bystrin (2):
  mfd: rsmu: fix page register setup
  mfd: rsmu: add 8a34002 support

 drivers/mfd/rsmu_i2c.c | 8 +++-----
 drivers/mfd/rsmu_spi.c | 7 +++----
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.53.0


