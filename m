Return-Path: <netdev+bounces-94869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCEB8C0E9C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB421C20A97
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929612EBC8;
	Thu,  9 May 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwZ+LDTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DF3715E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252353; cv=none; b=iKKLwoNmZUiqGfdSmGnXmg1Ymt4DKALqabo6lOzSZjclSfkKxY9C8Pc+0dhlkPmFgTU20WipGL6+oRCK2ioWv9Pive6qQoRNcUOmLOwCDv+2nYrmNijzB2nayrImxKlWsgV0reYoHWD3dTbbTKlDfskStD1mJgDgJarDBEXHAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252353; c=relaxed/simple;
	bh=e8J1VXsTVLSJrNx/Z3WlGMkS2jcS3LF/98JSDjL+u8M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DO4Ew2fzrc1jp/G3CFu7u405CgyD9/XR3f+XsJPelyLBAI47FlzSZtJgcSX6BRFBqhQIGkRsQeCdHTKU+THloIayqCI6jgjQA1tA57+FCR7Udx5QCM61Xh1czOcAWm4w6OyIiUgtZlgsHcRXxITNsoL9aPdWNAuh+poQrx2RRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwZ+LDTh; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ebddef73b5so100314a34.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715252351; x=1715857151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IkOAXUx3tHgZcUiJ6wigE1dqY+HU5i/i31Ie65t5Yc=;
        b=fwZ+LDThblbHge6ws9p8B5P+9nHQfsBrUhOkEuO3FWfrN5vrN7m6zr+sMlicqDax+D
         gZaR/2vdj2aF66IfLoZ87aFSajNqiey4Y4GJ8J94TGl5ghpk04PaVNCFDbEkjyMByd5z
         ZWF/LrOShKpBAn5gGrizdUIiIFqPWr9Mz6OPwUXQcBIatmtMBDNPFKt1pexHq1LZZxHR
         cuMIF8iNkZUCqoI6gZ5gJ/cuz2T+g7Ri/8JnMedRE00p2mlSxZi4hroweJMjQ1uc7cwE
         8ylDGnJrKKpD8GCH9o2PXeL8xebERpTDZZUmmRqhTX46tTPhU/NtE1/fYQQemHZwcIDF
         DMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252351; x=1715857151;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IkOAXUx3tHgZcUiJ6wigE1dqY+HU5i/i31Ie65t5Yc=;
        b=VeEFMwmfrxLGOgWK4LUPOkMRKIGJuplRQ3vrbXY0YXpQMbIhlMLsBd0se5j5wqOvLx
         Y+9YC9Zc5LTp0q1qGIs0anXMjig6r77fsUFJosnpajPFaZtqyT1dr4GtAXIFxPLnGzYU
         8EznkkaZpUgcTpN+OprUZ46c8Io6drPZ9ENywscP4vCQAeV830RMyB8TVQdImOPFB245
         dr+EM3lBuHb8idXdk81HmgAAHyewwgcPMVOtw9j4t5oRDhGxivxeRFQtRnNA69bG6jkE
         A7Dt0zpM3gcN5A3RVkMd0DUU76KWGmIseW0M+qU8Xumc1HiBer6Y/n5HvrpjThPmKNTR
         1CUw==
X-Forwarded-Encrypted: i=1; AJvYcCXqxdFaO6UUNPihkLiogpFzBgb2TWCFl3S5Ip3CbSnjUPWPJ/eTTfjj/72EPB2i9NsHaq4HKpNQ51bNSFvLJkWeBxCH4Zkh
X-Gm-Message-State: AOJu0YzMaBOFDNhzMKENbKaHkzpclzKU+M8CbHl4G8vQ5TBBOXdGcaRi
	fO5f9NenN4dqA/k0DNhCz4EoWlIKmvafysxqR3Kggw8ih14GzfX+
X-Google-Smtp-Source: AGHT+IFGjU0KaUu6yzBpDlEPhdjZfCUvxVQawDIqzdFW6TDxb78qyrpfYeq3MH6u7iRbqXkr3HcNmQ==
X-Received: by 2002:a05:6359:4c21:b0:191:f9d:3468 with SMTP id e5c5f4694b2df-192d1b33d94mr547325155d.0.1715252351026;
        Thu, 09 May 2024 03:59:11 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b767ae3sm1054654a12.31.2024.05.09.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:59:10 -0700 (PDT)
Date: Thu, 09 May 2024 19:59:06 +0900 (JST)
Message-Id: <20240509.195906.2304840489846825725.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6388dcc8-2152-45bd-8e0f-2fb558c6fce9@gmx.net>
References: <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
	<71d4a673-73b6-4ebe-a669-de3ae6c9af5f@gmx.net>
	<6388dcc8-2152-45bd-8e0f-2fb558c6fce9@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 9 May 2024 11:52:46 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> A small addition here:
> digging through an old Tehuti linux river for the TN30xx (revision
> 7.33.5.1) I found revealing comments:
> in bdx_mdio_read:
> =A0=A0=A0=A0=A0=A0=A0 /* Write read command */
> =A0=A0=A0=A0=A0=A0=A0 writel(MDIO_CMD_STAT_VAL(1, device, port), regs=
 +
> regMDIO_CMD_STAT);
> in bdx_mdio_write:
> =A0=A0=A0=A0=A0=A0=A0 /* Write write command */
> =A0=A0=A0=A0=A0=A0=A0 writel(MDIO_CMD_STAT_VAL(0, device, port), regs=
 +
> regMDIO_CMD_STAT);
> =

> The CMD register has a different layout in the TN40xx, but the logic
> is
> similar.
> Therefore, I conclude now that the value (1 << 15)=A0 is in fact a re=
ad
> flag. Maybe it could be defined like:
> =

> #define TN40_MDIO_READ=A0=A0=A0 BIT(15)

Thanks a lot!

So worth adding MDIO_CMD_STAT_VAL macro and TN40_MDIO_CMD_READ
definition?


diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethe=
rnet/tehuti/tn40_mdio.c
index 64ef7f40f25d..d2e4b4d5ee9a 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -7,6 +7,10 @@
 =

 #include "tn40.h"
 =

+#define TN40_MDIO_CMD_STAT_VAL(device, port) \
+	(((device) & MDIO_PHY_ID_DEVAD) | (((port) << 5) & MDIO_PHY_ID_PRTAD)=
)
+#define TN40_MDIO_CMD_READ BIT(15)
+
 static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
 {
 	void __iomem *regs =3D priv->regs;
@@ -48,13 +52,13 @@ static int tn40_mdio_read(struct tn40_priv *priv, i=
nt port, int device,
 	if (tn40_mdio_get(priv, NULL))
 		return -EIO;
 =

-	i =3D ((device & 0x1F) | ((port & 0x1F) << 5));
+	i =3D TN40_MDIO_CMD_STAT_VAL(device, port);
 	writel(i, regs + TN40_REG_MDIO_CMD);
 	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
 	if (tn40_mdio_get(priv, NULL))
 		return -EIO;
 =

-	writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);
+	writel(TN40_MDIO_CMD_READ | i, regs + TN40_REG_MDIO_CMD);
 	/* read CMD_STAT until not busy */
 	if (tn40_mdio_get(priv, NULL))
 		return -EIO;
@@ -73,8 +77,7 @@ static int tn40_mdio_write(struct tn40_priv *priv, in=
t port, int device,
 	/* wait until MDIO is not busy */
 	if (tn40_mdio_get(priv, NULL))
 		return -EIO;
-	writel(((device & 0x1F) | ((port & 0x1F) << 5)),
-	       regs + TN40_REG_MDIO_CMD);
+	writel(TN40_MDIO_CMD_STAT_VAL(device, port), regs + TN40_REG_MDIO_CMD=
);
 	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
 	if (tn40_mdio_get(priv, NULL))
 		return -EIO;
-- =

2.34.1


