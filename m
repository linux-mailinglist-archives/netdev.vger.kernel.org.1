Return-Path: <netdev+bounces-238504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EEC5A10C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8F9735013F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9A028506C;
	Thu, 13 Nov 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b11lfJ1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A02C11DE
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068148; cv=none; b=gQF1K4Lq6D0DfSRDWp3xD9ZXO6lS/IM/fZv3k+gqwlRqRMaBT5I1T/xLqWUhMEYhUvfkpuMxzNtPxI5A7ZN4R+RU4AszGb8PRtY+AdxRlLHgCdRdXUc9Jqq+AiQAJ+V66SzB5xxWt/Mwz1M01M7ehzOzbvN3UFcYYg6uSwYY3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068148; c=relaxed/simple;
	bh=9xg7SIjeVcRJUKve9Cm+xfJ1t8QOsOMxDhVGXOvEbEM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PtjqbyqxoAYY58fKpk2F9yHN7/rhZ4HZjFYpKbzeu/z64Jvzfkb5Yp0RacSvSOggrPVPU1YldaBFovdpSgohINgxrlfPCgzeSMGM2syILiS11psBHEFa4ghVffGYGUkK3VzELrXre8bNUtiPsveZgbYEVAFSx+jQvWYEKgZt3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b11lfJ1Q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so813429f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763068145; x=1763672945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J+F1bt/5m4Z+FJaS5IA7wDF91rwgP2xfQz0H568uAw=;
        b=b11lfJ1Q0+E2tDTPRD6T/2txut42AxCv5I9Hr9rK7O9AWDhbWCvfjddgqEHRQ3HOqk
         duE1+nPNRLfTKoTj7Kk4yThTWnweNJ0MW47LD70ukuFudUPvUwp3jpq9xm+hy+tWiHUO
         f4TDG9kJoejXoYEM0yyk8NXLnHxnGSjOSC4LkW8Q0uegvkcmsw4ddKRMOtCl/4HJwAxF
         MQCPBOfs0MInAJTxM8RYdTt9X3dXzokMhU1xyP0+OhM3JAOgBmnp+LLLaDCcl3uVRLjn
         VSwvwxiBs5J/rKjohFLVCAfnQCjN5mAd9y1XVmwqtoaqRmlidoIjv06n+3rHJRvEnCMV
         Zf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763068145; x=1763672945;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0J+F1bt/5m4Z+FJaS5IA7wDF91rwgP2xfQz0H568uAw=;
        b=VydpEn1cX9fKjxUKKwfugvZB+5JGhAdEWUATUmklQHfmyn9xAhlOM3wwlS3Hg3mI6H
         iJd9QPCwXHPotlB54vyA7c5KutInBLKpBUnWCK1VuLQuHEuXj7G9Pseu6JDxrvgtbroW
         iQZZetJDMZ7L9BsusXAz8gnPgs6Kl19jQn9DwRarL2tw5WUQLiCxOWPU12Q1tiQL3RAn
         SLhBQyiQ8onvv8fsK9vTjCOwefNfEPdJzrvdJBvBuHem6LAJrmP5h8d9rEzh0KyntEss
         hCPd375+vO+oyOBuZcb8NziYyDaoyhEI5zCFyRL0Ug/3uR0Pyjht9BxfvcVuJc3JLb0C
         rFmg==
X-Gm-Message-State: AOJu0YxLgmu3+hTqTPPeHWsVNYP6TBql1qF2uDs/ntQRCo0++VGVO9G2
	tSTOFVBDIPVICGHDTvxWbFyeh301lumDvNlV/zVZKMoFx526diWzNcox
X-Gm-Gg: ASbGncu6Ik5wbKovk4Im3ymqs5jTU4UDhSa7JiuoTuj2tSzS6TD68yiGoGbuySQ0D/Y
	wbNp4ebZPndc113Z7H1JqDNC4KKMQO7oRbYTk21zxmZS9rTUrPta1anK60hzoroCfJXNq2zS/xy
	fiKHN7/hTroyj2s892ojiG7nTfLgZr/zgrGvqkCkE4YfUHcFTNPHSVpt+4EA4QX0jdqIeefurky
	W0xdCCHT5cs5H5L9RuXjm4K8HR5fhTATsug3nOvUzGSFNznJVQ7f7n9Cq2nlo6AMniFx2bXAGYQ
	wGh5qzvgVSkZHpG8bm4C0oWGf7qjU9XVSrfW6mK46AAWXIO4xDx9J7FIKiJA16/5PGEyi8zoAO2
	K4a/KntqBdeoWDKh8Qc4ZwgeeGdKbLyw+EZZF+OY1N7977eebTlnRc8GU2rBe2uzqrsfHF6m+Kr
	hXU9WiNgl2qNtZRM0TNt6k0hQdafP/nvk4uowp/hIStc+HCvO+m+AYdXMbBLoer3v52UNQ55ZKx
	nd+bia2tLs81irENbt7Xj29GM6kvLl6Iaf5/9l2
X-Google-Smtp-Source: AGHT+IGLwewZ3qKeHhP3mYa6VJkK9xY6X9yXkCD8/gDmfaAwguIW294LN9DpJYYFVS9PUgXp7nMa/Q==
X-Received: by 2002:a5d:5f45:0:b0:429:8b01:c08d with SMTP id ffacd0b85a97d-42b595a4923mr590010f8f.41.1763068144792;
        Thu, 13 Nov 2025 13:09:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4e:1a00:f17f:a689:d65:e2b2? (p200300ea8f4e1a00f17fa6890d65e2b2.dip0.t-ipconnect.de. [2003:ea:8f4e:1a00:f17f:a689:d65:e2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm5896668f8f.30.2025.11.13.13.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 13:09:04 -0800 (PST)
Message-ID: <fab6605a-54e2-4f54-b194-11c2b9caaaa9@gmail.com>
Date: Thu, 13 Nov 2025 22:09:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: bail out from probe if fiber mode is detected
 on RTL8127AF
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It was reported that on a card with RTL8127AF (SFP + DAC) link-up isn't
detected. Realtek hides the SFP behind the internal PHY, which isn't
behaving fully compliance with clause 22 any longer in fiber mode.
Due to not having access to chip documentation there isn't much I can
do for now. Instead of silently failing to detect link-up in fiber mode,
inform the user that fiber mode isn't support and bail out.

The logic to detect fiber mode is borrowed from Realtek's r8127 driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2a4d9b548..d9113b6c6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5448,6 +5448,15 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	tp->aspm_manageable = !rc;
 
+	/* Fiber mode on RTL8127AF isn't supported */
+	if (rtl_is_8125(tp)) {
+		u16 data = r8168_mac_ocp_read(tp, 0xd006);
+
+		if ((data & 0xff) == 0x07)
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "Fiber mode not supported\n");
+	}
+
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
-- 
2.51.2


