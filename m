Return-Path: <netdev+bounces-271940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFXnK1f7xGn+5QQAu9opvQ
	(envelope-from <netdev+bounces-271940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A03323FD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83B77315BF5D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD039023C;
	Thu, 26 Mar 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZyQpkn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7873B19D8
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516252; cv=none; b=MM2qUDrAOppNof1BuR7WZdjapOGPIJmLyyew9Va08tmunsG1EJq8lJumMuOuDKVFryfDBYr7MBn4UmUPhIfnNvUAr6zOiWKY+sJvZKfZcad6//CqaKeiiSI9DyhmW2H2U6r41KEEUvYnbvp35C/0aHCmCn5XC1k4vynPV0VmPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516252; c=relaxed/simple;
	bh=jlfzUqL5XaI195zD9OLF2Th7Si2B8ruPet0hTv9v4Ns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QLybys5Sx9NDnGQbrmHHz1fBVFK0tGYvMkzT8pcLYifu7AIluFf+5Y40zyO8Rzqa+fSw9Ow5D6+lkytF8ZtPJwmtoj+nguCSdqrDkg5wZbLM9J5QFSCvwp65mjmQp0VZu195peuj5bZySTbXs0s2khN+LIjxjAWZK/QaJlOSWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZyQpkn5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso405766f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516250; x=1775121050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMvbvGrl3e3VBg8APBt/Zd4LqlkyH4JNJs+/pCZCmgc=;
        b=OZyQpkn5FzvoPEFNDwTrBGjW/fgxRCufxDhh9yGPZtbd4ZFkkqWVt5HYb58IeHqrOT
         DJi5Y54CkJG6n8uLOukJ0iVBhJS+E5GC3znv1CbCozodUgjfeU/zdHFdZXteQRS8fXdh
         8QCg15By3Q+YzB+yAOLFb/e8Zqw+9TiAbfFaRqTGBhvyImKXajUBTIzp2A30UHchQXoI
         L5OPrnM7qlwH/b0bADnSS+uOsD/a1aKsRaYIcH2PXUK8rIz4VY3DaeZikU18Y5l2RMVD
         9zV2hhaz2yWuaLUuqhDB9tcQBNBG1YYZr9AINs01Y2yDPwbGw/fvKvC5X4ptdaQ3OWoo
         nsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516250; x=1775121050;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMvbvGrl3e3VBg8APBt/Zd4LqlkyH4JNJs+/pCZCmgc=;
        b=P1HHyqP3UeSs4Pu3LUxE6AxE+ktksoYABei8qdIofsnY8dPZzSngbbQjd45BcDgV8G
         sGjlE+NPKtqbDFDeAkcoq3XbY17nuir/VJkepjlDhAvIEF1Qcyu1V9FzF0AO+yEk0Ox7
         trJZmr9uYEtvSE31EC7Lxt3hfKMf3qX1S1Pl6RNmG3JfiTMLcWTcdNoqtjAxh8LMDtxs
         bm70k7+9oMWai20eTKah0LrsIrvgrCKrvnL8FClMA2kLtVuVk4xRb3mYaLZmIAhBVF2k
         MW9a+wh3PMPIjXB9e2udVKFheAwnMQAUF1eC2Z5VhD+fGIn4vKcuARM8oiBg3dNvj90v
         4m5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZRK6+Gql/SLzABfjwYHsQCO1CSHziUqrqFF5lqMg7GXr4vstK1BIIifBfGjr8zyGY4eEVXxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+9E/730aMMc4Bs2LIRZU+T4Q3YqghlOsNwbCP22+vHdEi3Ec
	scZ9LKHGh5RworWlIe2KHaOp0pskA3hhChwxqdOOHJQb2dy1H2c0JU82
X-Gm-Gg: ATEYQzxA+ytYAbhBANwjO4W3P0egIjuzncWFqB3nMSFLv9ZgN6g1luBoCUg3syZgYsk
	IwpiWhYUbdURY4f1ss0WfGYCFBmEqNmR2z3pobOK4+2E0zLz3vvs+ZlegykG4965Lz3BkZjsOln
	l47qyxvmXYfkjY475WmN3m2Dqu2EWLSQb2WuayoIV7H66cPBDypg3DdHVu6Dqawl6iUOAAiEt/u
	oTvBawYqcThlmz2pQxjGHI7360WMvrt3wZ5egwfUqjIJMzZMQ+/k6U6vYGPfYtQHUoZA8vybXD+
	rOXLfzASU8FMtTB2/f0fmeDLCtAMZj/SQhIaOPtvtedVKcR/K/C4d7nvJrel08MoqbozpS+/ZZU
	3H2X5m2LXlh0bpW06Bmwn57HzrOWQVRQ6uEISDaLl2IHNhWD95Bj/lJE0/EKc8AichryfOUxz5G
	D2pmOLtEgnIs21tJ+r/09C8DlSfh+fFrqUNSD54unNo1mpHU3+n2D9M/htl4+7DQh8zgijdwU24
	cVHub2oSA==
X-Received: by 2002:a05:6000:60f:b0:43b:5765:96a9 with SMTP id ffacd0b85a97d-43b889af1d0mr9982897f8f.24.1774516249379;
        Thu, 26 Mar 2026 02:10:49 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm6381199f8f.37.2026.03.26.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:10:48 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
Date: Thu, 26 Mar 2026 10:10:20 +0100
Message-Id: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPz3xGkC/yWNwQrCMBBEf6Xs2UBMair+ikhI4qpRSWS32mDpv
 7vqYQ4PZt7MwEgZGXbdDISvzLkWgfWqg3QJ5YwqH4XBaOO0NVbd+L0dWvNIFMbg73WSMPtUS8E
 0ypxVdBscHJrYawtiehCecvu97A9/5me8Sv2rhmX5AGYdrFmHAAAA
X-Change-ID: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774516248; l=1968;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=jlfzUqL5XaI195zD9OLF2Th7Si2B8ruPet0hTv9v4Ns=;
 b=S/roDsVN3Wq7zvzTF/aHCH1/5dfMWW/cty9n3DjadfYyFJRUSGTSmsQ7sEQzyfLTGePzH4qFA
 C9n3mmOj4v1CP05vTUtTDjYs5aj3KsTim7BTPyQuXA3t5uKvt8HucI8
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271940-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 099A03323FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This patch series adds support for the "Module 3: Equalizer fix for short
cables" erratum documented in Microchip KSZ87xx Errata DS80000687C.

According to the erratum, the embedded PHY receiver in KSZ87xx switches is
tuned by default for long, high-loss Ethernet cables. When operating with
short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer may
over-amplify the incoming signal, leading to internal distortion and link
establishment failures.

Microchip provides two workarounds, each requiring a write to a different
indirect PHY register access mechanism.

This series introduces:

 - Device Tree bindings to enable the errata fix and select workaround 1 or 2,
 - driver-level parsing of these bindings,
 - implementation of the indirect register programming sequence required
   for Workaround 1 and Workaround 2.

If the errata is enabled but no mode is explicitly selected, the driver
defaults to Workaround 1, following Microchip guidance.

The feature is opt-in and does not affect existing platforms that do not
enable the errata.

Tested on KSZ8795 with both Workaround 1 and Workaround 2.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
Fidelio Lawson (3):
      dt-bindings: dsa: microchip: add KSZ low-loss cable errata properties
      net: dsa: microchip: parse KSZ87xx low-loss errata from DT
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 18 ++++++
 drivers/net/dsa/microchip/ksz8.c                   | 71 ++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h                   |  1 +
 drivers/net/dsa/microchip/ksz_common.h             |  9 +++
 4 files changed, 99 insertions(+)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


