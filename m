Return-Path: <netdev+bounces-102449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D91902FB6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791401C2276B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5116F90C;
	Tue, 11 Jun 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YASbS5eM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864314290
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081688; cv=none; b=oSOLpLukSgaZRqYSjIkbFshnRH2jcCILkczeRJU2HHqJ2QrlB4r9OTFpwvUnFqhiWL8nW5GA+VGVDOUF0LhCT7jwlzF+aYfPTBv8TaQD/ZAzsCxfAajeTX0gCxP7rbSzjNOQD4NFVjsGKvyrmAZiUSpmQj8OuDqOY36j68qqnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081688; c=relaxed/simple;
	bh=3kJactzqV+/HWX+Whc+gfJwULdSHj/mXBWYx1C9Vn94=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=URCO/nAKqnX09A+XagqPjTRmImNbDMnjUiZfHXF87d8G2Y/F9r7P7YnteHF0JEdbyyNYVRUFJiPc5lUZzBLKijN+jQGyHZWveLBgWi5vl5fnz1skwaNDSfPh/ZUM2JFlwB5PIXu6UtmisbxRilOCe1JqlJCME3+E/8vKYXgo71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YASbS5eM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c2edc2611bso253647a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718081687; x=1718686487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgMT18t7rPBAclEtXVJ/0g0gS/SkzBSOXNapkKxBc2c=;
        b=YASbS5eMIuyMZ/HSXk3lm9GJLllNU/MHiNuO1UjT3RZAPjmz97gzdWwqGia4sKNqsh
         nGYOScFoCu8/7YxcNrFD8N+Bm/YkGwmh4nF84z56nxGTDdupKv4CPEwSqIypGvGX9ROQ
         4DiF21Hlu2Wx+xsrp4RqHzvg17l6CMKeqHs4mshIhS4dxdej/qCHWYc/G61PZQRKNiLH
         kN6WtSmhDVDY8IvufW+mSXpksSPQ2HdWpevPM7VJ4Tq7QUUoGZVGm/naOMAu1cPPWYiQ
         FChsHEi2aWpaTMnthTL6K1RqHSXjhSic2fUgf9NzcijSym3t8oLa7FVpQiGwtXZ6ObRJ
         TqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081687; x=1718686487;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mgMT18t7rPBAclEtXVJ/0g0gS/SkzBSOXNapkKxBc2c=;
        b=ASPcD720KjmGNA3PpwmiBvKPJQOt3WlrKQHM8gfeVa/jV0bCujcV9rYJnMfq4/YQXE
         KBihcvKCDMBH8SkyazSUVJqFmLPuY8aGYBtup3ZzuBioLRCIijgsuw+rBYfIn6kZ84UN
         shi0v/LqytKc3LM6V4/TFNvbLB/2YiOz9oWX7Ae49q3b9d3A29pNkhWa3c7JcSbAMotQ
         eD2huAud6p0GS3oiRiTqLU2aG+HdkpfIhLzxeY+NseXJrQykWGggOmaxWD8e6dcSs9m6
         yRSVJ25qEdwkR/cjHu/5JV1uR2Vn9dO+wpxMK0JjeC5yCCt2JOapI6PZQ5QrJ8k/kOMc
         zMBw==
X-Forwarded-Encrypted: i=1; AJvYcCW1WM2wfJltBXBRfb975WAlz14lqea1p7McIVA0D9GEPehBfFx3SoaA3ance/K8ZfEWFHXYE0bzScV7+KjEkIpDGLvvUWHT
X-Gm-Message-State: AOJu0Yz8FaFo7LiqbcTIi6YEJ2sjBBoew+U19tEIYL7g+hG5UrkYvrs3
	8EZx5+2heOr2HD3Q7+nVvN1xEKq8yglAwIcX/zt2oUEW/YTlgv/bBf3ZOVgY
X-Google-Smtp-Source: AGHT+IG8Cdx/wFeSBnzb0FHRgfBWNe4cGg/NjeBFB+D/CP1bMAbBI/8LvDanro0CbhjXpcdcYQXs+Q==
X-Received: by 2002:a17:902:ec8b:b0:1f7:414:d673 with SMTP id d9443c01a7336-1f70414dcbamr65692515ad.4.1718081686962;
        Mon, 10 Jun 2024 21:54:46 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f336d172sm51581285ad.247.2024.06.10.21.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:54:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:54:42 +0900 (JST)
Message-Id: <20240611.135442.1008031498769485601.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 9 Jun 2024 11:10:54 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

>> FUJITA Tomonori (6):
>>    net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>>    net: tn40xx: add register defines
>>    net: tn40xx: add basic Tx handling
>>    net: tn40xx: add basic Rx handling
>>    net: tn40xx: add mdio bus support
>>    net: tn40xx: add phylink support
>>
>>   MAINTAINERS                             |    8 +-
>>   drivers/net/ethernet/tehuti/Kconfig     |   15 +
>>   drivers/net/ethernet/tehuti/Makefile    |    3 +
>>   drivers/net/ethernet/tehuti/tn40.c      | 1771 +++++++++++++++++++++++
>>   drivers/net/ethernet/tehuti/tn40.h      |  233 +++
>>   drivers/net/ethernet/tehuti/tn40_mdio.c |  143 ++
>>   drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
>>   drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
>>   8 files changed, 2493 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40.h
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h
>>
>>
>> base-commit: c790275b5edf5d8280ae520bda7c1f37da460c00
> 
> Hi Tomonori,
> 
> feel free to add my
> 
> Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>

I added your Reviewed-by except for patches that you've
reviewed. Please have look at the remaining patches in v10.

I'll add PHY specific data for initialization to the PCI id_table
after merged.

