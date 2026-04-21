Return-Path: <netdev+bounces-280055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IREFTA+52no5QEAu9opvQ
	(envelope-from <netdev+bounces-280055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9B438A08
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8448D3019B80
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE113A1E66;
	Tue, 21 Apr 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM76s56l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38E39EF2D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762053; cv=none; b=leOJgRq7K/z0rLKoK6hv+QaFy+OCzVsfIMH2WmXbLqTgf4ut+yjSuWzS5b7EBe++mBJXY2J8soaW8sssAYqaZeyA3vzNu19J7IV+02DItNkSx9zbXcsoOWxVi8WysgevLjdd5PsDqXGgOzXOWUXQ67jaWawxi8aN6QNizP4aels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762053; c=relaxed/simple;
	bh=y+/AIiRTJdMKJNGPNWVH8nSZsggF71AOLdWzKUHA+M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4M5v4nFuIWkbAAoKgfpJqTVQVpHGCKKbrNvBzjMM424gtwm/9CDn6MWjmMvzs0MWWZnKv2LVFKDTasN1oVuV+bmGflkEyvtTAEurZNUQvI0L07iGlCCBU2tsvbetvQi1eu8Bxd7JrVvGf/UNrZ6jnNT0VKzEkHfKZ521JPlp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM76s56l; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a283c44478so6927643e87.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776762050; x=1777366850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIHT3F2PNAZPkCdPUPHQsxeMRfyG2lVqjjmEWm4QMoo=;
        b=tM76s56lTVu9L3yTL42tSmOHHuj45F0eRZKT+i6hVDzwhyjyJTzTAw/zFXgDv6PBaK
         RuYYMXoQY5SOhPwO8dk2R+2brtOX9luXrW7sN+6LZeK3pU44ARBjWV7XoEaTOIzrhtZ6
         JuJfx9fPuJjgKl1E6plWgeePWRsu0SczpuOhnL+OT6ExD0mWgUzQwVwUM0JroLLv0im/
         9nsoPK58IoJd71HDLnV5wXoLC20k+aERlhSRJumXSUa35+wDwiCpK7h0iiYIBXsIdkWR
         Rc9Q72j1ml77/GVNxZ20JDHlvKr+PsaR3ccBeg8/8+1+xUEi144iEL5daBDSi6zM0wWE
         38Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762050; x=1777366850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIHT3F2PNAZPkCdPUPHQsxeMRfyG2lVqjjmEWm4QMoo=;
        b=L0VnKU5MpKhAXwNSUyiMrVh6ezl+d5gJXwpKsLWBLSbZYtaqGYqmzlSHcK8kGnCnrz
         piTPpxjqZ36w+8CnCKRzDM0YK5c7iiNEX3c/QHc61Y8Eh2NNfP1V4GNxiTR4inS9QJ0D
         MUdZMjNWiYFUiF6/uW9p6woTTYzB3AXbh1N5cTPpjDWg5okhb4C2nm53r++TiXIgIDtH
         P4YGbLSf8Y6MXLiqvVabCyiYGgHEyB0J9hdO1H3NyoquIQpuolSv8EQMIPuNFolyfdRH
         /jp2qH7mPORjPfLkjQmyK7FMppUfu4E3ALoGoWYgXh57DtUhfe+icHSi/bGPFvoxEQTV
         wVRA==
X-Forwarded-Encrypted: i=1; AFNElJ/9alStdS9WSthE8/Vmqe6nxM/N+4fd/W55Qz2Sr4iBwmp9QQHTFWNj4Rs5Ypi1NIfjBttCvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcwSWha/1Eqx4p+vcSesjjtFBIro3nvDaTl18b6YAVnsNEvih
	gPM9T/OjRlg/jEhVjNgGsC3ze4neM5cj5D3GxuOKMbpC/B6w835M6wj0
X-Gm-Gg: AeBDievOnGpw9Xj8WGhllJMSF7dWNFVftISnQJL5D0uC8TGfCoOVVrgSqZzFFWRdPR1
	dY3J1tRzJ7cQy1xz1eSkyoAiXzAQZzE7YXkIUfyhoeIifBuF1+aNgOP2z8kLHTl308DXV+eM6m8
	EpZxwRqr/OCTrvElqSbSl39pOmBDmjVflGnRkeAoJXBHPXgxsHqgA9eY8MYKYowtDXl6xCFZsCa
	yYDqBwT2wEesx1tTB/+l79JJXmRzB7xltUJykf9IqFS0LiDszsCLBxpWFHWZp6p/TAuDy5LBMxr
	VlTnAzvHBQF+2h9685oQ6aIu9sLLUgybhsuaI3qS5D2i1LBKkhG3J/WB5PH8sEze7XnhfNoImPH
	dIPFRf0Mh1UJJFltA7onhytk+8YqzpZa5heS89a0uCImp8h/nCOFYmSfuPG+clm20oR5SCPDGSz
	gA5KBUdI+kTvcuan3TRj2p564SmN6v6II=
X-Received: by 2002:a05:6512:3b8d:b0:5a2:9bd8:838d with SMTP id 2adb3069b0e04-5a4172b7afcmr4858988e87.6.1776762050063;
        Tue, 21 Apr 2026 02:00:50 -0700 (PDT)
Received: from thinkpad ([178.205.156.194])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb75b033sm28583931fa.39.2026.04.21.02.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:00:49 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] mfd: rsmu_spi: fixes and new IC support
Date: Tue, 21 Apr 2026 12:07:08 +0300
Message-ID: <20260421090710.395591-1-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280055-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7C9B438A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings!

First patch fixes Renesas 8A34002 SPI driver.

In my setup 8A34002 is connected to VisionFive2 via SPI. I've discovered that
upstream driver does not work:

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
RSMU_CM_SCSR_BASE so function was returning early, before any modifications to
the page register. Valid read of versions - is just a coincidence, because
default value of the page register is zero.

There were 2 separate patch series which have to be merged in one time: mfd and
ptp. The latter have been merged, the former[1] have not. As result we've got a
broken driver.

This patch can be reverted later when the second part will be ready (of course
if it is planned to do so). Any comments, Min? I could support with testing.

Also I've had a quick look into I2C part. It may also require the same kind of
fixes to work properly. But I didn't tested it. I could do some experiments and
return with patches later.


Second patch just adds support for 8A34002, which is compatible with 8A34001. As
I can see there is no need to update bindings, everything is already being done.

Link: https://lore.kernel.org/netdev/LV3P220MB1202F8E2FCCFBA2519B4966EA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM/
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>

Matthew Bystrin (2):
  mfd: rsmu_spi: fix page register setup
  mfd: rsmu_spi: add 8a34002 support

 drivers/mfd/rsmu_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0


