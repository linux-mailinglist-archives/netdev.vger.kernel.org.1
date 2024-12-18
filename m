Return-Path: <netdev+bounces-153105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E99F6CAD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ABD164338
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE81F7072;
	Wed, 18 Dec 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVM2C8Oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109661A256E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544320; cv=none; b=WRda/PYfvrH/8WaimmwfRngYqw2iWX178pIF2aydeNMDG8RIKyRd4rrxPkqGKgRBbnFtjeMU2fFSYT4gjC7VxEx/6i7TrGWf/2lMYvdshFW32A3r+K0cB8JEGPmDVK1oFlyBmua0wUtvYJG7Fgu+BKL67YJXT1yh5j8PGNK/wnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544320; c=relaxed/simple;
	bh=2So0nul1mz0/2K4Ol25NHSdvjvCJf1yUkrkJLZzp1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD/NR42nIuI6mwuRIUmWmoNaiLeVYtrWjJWAo0OIaa27qpdgwLofQlzpQjj5q+ZlAsh1BAFuENQ2xVzJSgGLL+qMUY7RKWhgyAusBWJgPX/EIVZ3fRnQSL6Upr4r8XKIFLmPIFSdRRo5pGwFqjOtzZk7Y2UP7Pn28WzlkNhgTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eVM2C8Oe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso8974102a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734544317; x=1735149117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuTI8JBt/EZ+l8PFms5uxro4CHQ/QT9ZzGcBaY71A3k=;
        b=eVM2C8OeHoEjet1QRZ2YNkAD/OewghUWzeX+AWuzumsyaBz+5Xvvn3/KfTbiBVWxin
         6vzP6NXiX4taQC1GFnLKb/982MWXadCAyerVBa0MdkMKN5NeiUTOdlWk6lzJtzl0800K
         gZwfFNH71MAGSwFVWXWyVamphZW+RcUVY+bPlGPJDwlnc/D65286cJ+TvcqJMIOv5699
         IL7AbPJWew/kUrnC/W1hVt9k/xg3MGySrdKqX5lxXB3ywI9nWn77NWaBmKBO6/+r5o0b
         oeTfRhH4zlYqJ/tvi3TR+4/AFrz8sFUaD9CJW7n9i680u2VQaVG6jRM1w2tk/bsIjReZ
         PCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544317; x=1735149117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuTI8JBt/EZ+l8PFms5uxro4CHQ/QT9ZzGcBaY71A3k=;
        b=NXRpfG7AttuA85v9dUEnmUxgjJKTluV4N70yDhEuJFEqejySP5nMlsugctkWE2fJuO
         Sqj1FyoKcwR7YxKWwxsqBu3jRX7ysguVG9V9zbfLXJNRwWRFPViAussSywRYCAtenk8w
         AEsy7SKGRtuMy90aEGmded2zmPoK60CZFFDz8g37WU7Ki6vnFL7vCZ5RUak1IyAc5VXC
         BIklqHR7n6p+mrUPAGo5c2F74/kPWWG12sj1d9yfcIjOM+XkeVLWtzDx2c9uM55cB5p7
         g/BwyhEDq6jRZYj+WDKakavEIX51vqRXVSB6j621+jDQ7cJlRp441xBRUt7A4joruQQA
         ye+Q==
X-Forwarded-Encrypted: i=1; AJvYcCViVXsbRXO1/BKLVaBCwTaajO+PIG4MbyeEqDABuavmE//U8oiNICYDAZ5jP0e87rgShFOwJfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz847wZwzl9dN+LjnJy68synsVon9dft09CTrN4bebXV2ZBmoX1
	yG0zg9djqWtdcjiXSCNkRdjpNVmOybB88ck9t8W20ra1t6kz+evdMsCJhT1IzyY=
X-Gm-Gg: ASbGncsI64KLmzXr46n5c5jG6yqYlpuFle7I1bdDQde3jt6RCuD9D7NAzF8tq81y0uE
	+7bg0akU6siDcvSZ+17j43dgKYrk33H3JldhjtCJ/dr9CC3U8DsPwj7+oX7dAwVDUUynRYa2oWX
	As5bS44hlqfKAyE0V/L6OYbriG5aRpbg24URF8TjFZRssnpWzThis9dHIeoRacmFmUjVydw5uGK
	ZQtAS2LBNiEEjz0vvKhGK82B2S+ukfMHephpA0geVqo2MdoQ/BzoRoeGNksSg==
X-Google-Smtp-Source: AGHT+IH1c0SiqJ9S0vW3GjpTrilhfirwlgVe7LxPXAmcmvdcFWW1srbLC4xqZpvUu0l/1LZk2/U+3g==
X-Received: by 2002:a05:6402:3581:b0:5d7:ea25:c72f with SMTP id 4fb4d7f45d1cf-5d7ee3ff3acmr4017187a12.25.1734544317452;
        Wed, 18 Dec 2024 09:51:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad1b31sm5553348a12.33.2024.12.18.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:51:57 -0800 (PST)
Date: Wed, 18 Dec 2024 20:51:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
Message-ID: <116fc5cb-cc46-4e0f-9990-499ae7ef90ee@stanley.mountain>
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
 <8d54b21b-7ca9-4126-ba13-bbd333d6ba0c@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d54b21b-7ca9-4126-ba13-bbd333d6ba0c@web.de>

On Wed, Dec 18, 2024 at 06:38:25PM +0100, Markus Elfring wrote:
> > When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
> > incomplete iteration before going to "exit:" label.
> 
> 
> …
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > @@ -680,8 +680,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> >  		ndev->features |= ndev->hw_features;
> >  		eth_hw_addr_random(ndev);
> >  		err = rvu_rep_devlink_port_register(rep);
> > -		if (err)
> > +		if (err) {
> > +			free_netdev(ndev);
> >  			goto exit;
> > +		}
> >
> >  		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
> …
> 
> I suggest to add another jump target instead so that a bit of exception handling
> can be better reused at the end of this function implementation.
> 

When you're cleaning up from inside a loop, then the best practices is
to clean up partial iterations before the goto and then clean up whole
iterations in the unwind ladder.  So this patch is better the way that
Harshit his written it.

regards,
dan carpenter



