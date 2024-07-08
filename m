Return-Path: <netdev+bounces-109908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FE92A3EB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308B4B22323
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3713BC04;
	Mon,  8 Jul 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS/RinjD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6ED1386BF;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446214; cv=none; b=B56RReGJ9eOeJXsn3NNcCna7OwqJXo3PKRc0nz9snTWYhl5hM0vdYxXBfXRXgmPNBRCsq81TdbupZKB8SGMGJf2uff46o6eFW8njjZ0CST98hYQ8zQXbZVS8BpvSBjm+ifUG7LpJ3gBnO8vOTX9zjP+1rri2aTOfACKf1dCi6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446214; c=relaxed/simple;
	bh=wxw4f8Ohz34hP/KIG3Mwx+JS06fgGytbZfPDRVqxS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3pKCCLjXaoEzaCt+uDTmSoTXXYU/3StUHLGFNHUBiB8wS+QOyb/bM5oUPLaG2D/WSlpsqpv2/nAv/h7usmsG9VTlxuKvsv2agSHHl/ICoDfJLhQMhYeIyOcKWDmGLb9FVOsQB/LYdiVeC66/ByylYWh5qPXW9wYFMMOkUkNqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS/RinjD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso15621635e9.3;
        Mon, 08 Jul 2024 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720446211; x=1721051011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/H78dV2CQyOKZtgy53vprQZIn/cmX0k21n4Wz6mxpk=;
        b=YS/RinjDPf6xszfVf72dmgOQ5PFYMqy/75sqeT2FvCP7dor8IgsONUEXrVs+VWa6Ru
         IwdgkH+yTsexQQqE/hB2iSs9E7QDUZcP1VObEN5wptBclg22eVm//8sFD2iy5uLC9Y+c
         PM+zI+y2/nK8tjZaOtOaGjHPdmxAo70Pmb2o1JUsqtAr8DZnk2X1rGeKZghlebJCrPoQ
         Abi13fUpJd7A+eMUBU1WWPrRHQkiJ6Sk8jfjpULd9YWwwdanq+sAjzlB3JNOwiJHLQNa
         are4VOEdR7kagV/aBzLY4EXxRxTBt24yD4Zw/mZw4lobT0XDhTwrQRVSTV9ka/QwoxS6
         7Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720446211; x=1721051011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/H78dV2CQyOKZtgy53vprQZIn/cmX0k21n4Wz6mxpk=;
        b=EWk/8JlP92rilb8Y7VlRzQguQnwZS0RdN8A65Ag0M7R20coccC7WBzaGbZGt/rY8T3
         o/DUEzXVCM9iFQsYugfB8UDlhloPPZCSf2H8CqGUOOc+b9EPufU8D+3/mSG0aPEAYMq7
         A4AZwT82X6iJ7vn0HK97hYjqw84ultVrdK+k28AWwW1qUcDf58MMOQSSS8IEvUPIm2JY
         DVlamby6ETOIUOuwr5hsz4PF2gGdiRqG7VpjEDACN2q0p5fjeWVL0oxS78j6HGgjCPME
         TAbb2gLh5CMIZdU6kvmna8Qs0LS0urIWusDXx5T65Z87MOrqSg5t/l7b+aNf9NdfOZjX
         nqWg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVc3Mr4n2XuMBYKfS7fksMY23eEud63ulKChREHV18iXsR7kjyIC5gPRZ2IlCblWdq299kcldv+FLb/U/jZ+IFDj0OUbD1bA7ch2m1pO1zQRFAqjVPj/qh6qJG1/Lkk3XKvJe
X-Gm-Message-State: AOJu0YzsZ6fl2BZjKwuCHekHNU2ZoYurpyAyd7GUmptWbWM/q+4faBbA
	xmmYVbmikXyglkVDm3O6Sr2sIqnTWmZMf22ahS5GMdVMLMpl2fUX
X-Google-Smtp-Source: AGHT+IGYrebj0t6Sz6CR6eFUr5wmQS1bM2olcs7f1zh32jh5ZLmrYMWuQY6AoOum12kv8PhheSWyNg==
X-Received: by 2002:adf:f8cd:0:b0:367:9224:9623 with SMTP id ffacd0b85a97d-3679dd0d323mr6925452f8f.7.1720446211105;
        Mon, 08 Jul 2024 06:43:31 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367963fa692sm13084965f8f.85.2024.07.08.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:43:30 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:43:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <20240708134328.hgwthqwcif5pjaig@skbuf>
References: <f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org>
 <20240708133359.rylvvmpcwlsxtrs5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708133359.rylvvmpcwlsxtrs5@skbuf>

On Mon, Jul 08, 2024 at 04:33:59PM +0300, Vladimir Oltean wrote:
> On Fri, Jul 05, 2024 at 11:48:40AM +0100, Daniel Golle wrote:
> > The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> > using bootstrap pins. However, there are only 4 possible options for the
> > switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
> > switch is wrongly stated in the device tree as 0 (while in reality it is
> > 31), warn the user about such broken device tree and make a good guess
> > what was actually intended.
> > 
> > This is necessary to not break compatibility with existing Device Trees
> > wrongly declaring the switch to be present at address 0 or 1, as with
> > commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch
> > from device tree") the address in device tree will be taken into
> > account, while before it was hard-coded in the driver to 0x1f
> > independently of the value in Device Tree.
> > 
> > Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > ---
> 
> Despite having commented on v3, I am not going to leave a review tag on
> this patch. Its contents has nothing to do with DSA, so I have no
> technical objections of my own, plus little authority for an ack.
> It basically boils down to whether the phylib maintainers are okay with
> this use of mdio_device_remove() API from mdio_device drivers
> themselves.
> 
> I did have a technical concern in v3 about a race between the finishing
> of probe() and the call to mdio_device_remove(), which Daniel did not
> respond to, but I suspect that __device_driver_lock() from
> drivers/base/dd.c will serialize those.

Having that said, I noticed that this particular patch revision is not
entirely under their attention, so this is a heads up for them.
https://lore.kernel.org/netdev/f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org/

