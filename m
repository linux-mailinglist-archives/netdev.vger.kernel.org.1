Return-Path: <netdev+bounces-102356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FB902A63
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08921C21D91
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7EE339A8;
	Mon, 10 Jun 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqbjWoSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41514277
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053388; cv=none; b=WNlUxBc8dyFXgc+nuN0qCbOJnclYUxosXZQvpg9kV36nPaV06KN9k5fHOHj6/6jOvBK4s3cDGv+lTXccfFnpRSzJixdXHfJtdPGGo+g733xyvG1n+pC7G0UGU/h21wK/DtFNC5FWRQL/5+8vGIkv46WLs3U6bGqCF7V7TTofdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053388; c=relaxed/simple;
	bh=1cLtwdMBZFSg89wyY//Oj+qqfVlHuxQ/btuEGi/hjVA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TunqGG1K7+zpO7ocI4hvTeIsx4RQ2SFL2mOUK2x06UtdMivqNusJUlBqTJdjy+6m5JzYxOIb5KdLcE6mXc+y85eIXyvGfGw/DbTNg1ShRVhpSlt/Qy8dFmHIj/AhpSyNGy+s8jU316OSJrqQPL0fnaSXR2OsQpkvdW54WNGyKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqbjWoSa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f715fd5e60so1034165ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718053386; x=1718658186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gt76kbECtkqXffMb/WgSFzKI7LUsI6+wKhqblnLUxSc=;
        b=gqbjWoSald7/2BkNboBbv8sdl7SPYxq7yDMhIsv0TG/6+DSsxVTtRKy/YJVwffQbnW
         KWXRBwwsaOChU/KAVMo4dLhTistyxQ1JVBgFbMnYGhlTeJa6PtUU/ksLPn95m0HFiq+a
         Dapv870AfzoW6K/YPDktVZEjvohq3/vL9otAOTiyM2yI9/2djJanSzo6pEGpewDh4PCr
         hyM+QThU8Wu3CV27T4vW/z/6s6EUk+ho6zzIzQgEzzybD2D1M7b2GFpuWu241BVcQddT
         sCCwkWY2s8VAgLsW0doUgo8AEdlogGAOC0ezlSQLmeOPDDfpQQDVehjSot03oFEa57H0
         +A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053386; x=1718658186;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gt76kbECtkqXffMb/WgSFzKI7LUsI6+wKhqblnLUxSc=;
        b=KsGufrdc7T63tehBd+kjMHBA5uB+8Q/O+hJyiewDAKJ7oVDn8P26cGxOB2IWJCgOIc
         J2z0veAOseBhHeIYhU5LZXn8x8w+ONdBDgZQ2iEsDKk55G+C7QbEEgDTJJNZb1ImhLNd
         OOn9DhRP2j0JVHN97+wDMkuETO+RKCQUNS1fYYoIY3srpVeH+XPsJy8DQpNP2aatm6gu
         I4+eNG+VNMYr2ubf/D9wzd3lxm5Rwji+5qYuQV3sWVuy8EvS8S183+2FBdYMEQLDTxDv
         bGWI0ywwL0k8GFshCC1l1moGOCrMOSLUdPW329gugxMac1pj2WdMXfy+zed7QrmNYrTe
         416w==
X-Forwarded-Encrypted: i=1; AJvYcCX5k10Bg9rInRBbmP4W4pZdgeAbTTHODZlFFi1OHJcrz0hx3TSqU+mGCDKSoTKvAdG8oAOvCgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktgzQ+UNAyurtqKseSIJT+Usef8qLhwq1HvNxMrUGEiXoBt3/
	AdsSnu0FUaJLUgu76ir8LS8x5V9TGqSf/pJldm0lPR9AgMCFgAhE
X-Google-Smtp-Source: AGHT+IGGkCTmhYIVzyysVKgnFFspNot0W1msOidAg+oBrNdJ1Aeg1n4okkBD6OpG/VR6BqCmFEaFOw==
X-Received: by 2002:a17:902:f541:b0:1f7:3ed:e7b2 with SMTP id d9443c01a7336-1f703edee2cmr56099295ad.0.1718053386012;
        Mon, 10 Jun 2024 14:03:06 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71a9beb9asm18303905ad.121.2024.06.10.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 14:03:05 -0700 (PDT)
Date: Tue, 11 Jun 2024 06:02:50 +0900 (JST)
Message-Id: <20240611.060250.2237029167355751325.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net, fujita.tomonori@gmail.com
Cc: andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240610.154850.1916370094900982618.fujita.tomonori@gmail.com>
References: <20240605232608.65471-4-fujita.tomonori@gmail.com>
	<78ecc7a9-bb33-4c2d-a797-87f782b6a382@gmx.net>
	<20240610.154850.1916370094900982618.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 15:48:50 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Sun, 9 Jun 2024 13:41:20 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
> 
>>> +static int tn40_priv_init(struct tn40_priv *priv)
>>> +{
>>> +	int ret;
>>> +
>>> +	tn40_set_link_speed(priv, 0);
>>> +
>>> +	ret = tn40_hw_reset(priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Set GPIO[9:0] to output 0 */
>>> + tn40_write_reg(priv, 0x51E0, 0x30010006); /* GPIO_OE_ WR CMD */
>>> +	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
>>> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);
>> 
>> the last tn40_write_reg (to TN40_REG_MDIO_CMD_STAT) is in fact the
>> same as:
>> 
>> tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
> 
> This means that as the original driver does, this driver sets bus
> speed to 6MHZ for QT2025 PHY, however after that, this driver sets
> it to 1MHZ again?

This overwriting doesn't make sense and seems that the NIC works well
without the above line. I'll drop it in v10.

