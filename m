Return-Path: <netdev+bounces-177967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62450A7341F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D47A189C2ED
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F64217F27;
	Thu, 27 Mar 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjGJ7ec1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B24214A98;
	Thu, 27 Mar 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084951; cv=none; b=o2h2za0L6yVnytL2qgoN7Z8PUeMAoC/BBjbArdxl9hBJo4fiYYDxb1zGaEo9PMtVEG6UunVhdz+PL3W9cXLLdSIDZq46j2SrtoX7ErtWdxgAZauhLWTHHiy7cIqsFgJ2A7Gvu0/jt9PvQmQfLJxKSJ4FkVWLQTzmhb5kg1fc5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084951; c=relaxed/simple;
	bh=M/9iLSgPAvBEvcRj/91c2/vxVJRa76X4X1+UONc6k7g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkFmekbhyEYqPmWY2xvyGC9hDWk0oFTLLw+rFDYHlQimF1OLRJL+KmrdX9kvQYyogOxtPSGmfU3N4zDHFi1w0QIcW0STcCOl/mXB9PRPY6hDNQhc9+CID5pY2mU0j98VmeD9H/X45zNm4ojnLAlE70yMh572cGXLOqcgjEhjvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjGJ7ec1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39149bccb69so890405f8f.2;
        Thu, 27 Mar 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743084948; x=1743689748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsPfvFNFiYpWeexMGdkrslH41pW1FMvcmq+GTlkBH+w=;
        b=IjGJ7ec1Bd6jvKPZoDNI0z8iixTInzQPjfLRUlSaQ8WIEkV9HP3aeKjVeJmRk2damj
         jLUGovlLGrm7KCk+MgKQu6V3Kb0bA0I8gelhuVf9YB2vEz2nLM+UW8EN+/3bbSfZUXXB
         qCzvVovmNWTHO6wzSON0LD8g4eb6oWqjl+MokQiUo6qGIP0JroPJQO5W8WbPUGZ/IbOV
         fHpJwYL/exEdN3ATid0XTapvaLLAxIpW8g+R3YIQZx4Y9/h9FnxlLk2YmKW1I3KeD1EG
         0U/IPpczx3LkLva9Ll30DhoL9TqUq7RjNShvu3HWZXLsBJr1exPlM0pbe42H2TIqs8I9
         /FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084948; x=1743689748;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsPfvFNFiYpWeexMGdkrslH41pW1FMvcmq+GTlkBH+w=;
        b=TyhKUPckJ+lHbDIhBRVjdOiTejXaH60qnqem6Ki2MEV2Z2ZBptDzxI5wf5POCetKpo
         ufbSIdfhuhtax2/dKDj7p2TdXVo1l582Z4A7rlBG3wt+EMkk8WvFGn1MzVWjs0AOylw9
         ocoS/GK0KBXweF7SER34XV1oP/n8u5kmBE7UgMNbqK7UvOp0nD087I18cFfjgv1v4G/s
         qo9faOgqG5FQOPjbiSlRORhbl2KKrKX+K3nD5eKM4fKGP9LqVAgHYf1ELpQtaxKIhTBR
         kDaIFrPQzjNWeZSyhapBFc2fVALwS+oqDdOSAYLFGNGungk+jtlvnyukOMceiydMoCU7
         D01w==
X-Forwarded-Encrypted: i=1; AJvYcCUhdZtq8o8G3YcbF2+HWHxzOnCeqisrHO0JDAc48ztfquNsLjp5pHDCRKJcSuGd+2SaaWh91eTkUbAB@vger.kernel.org, AJvYcCV3y62anG+Oy8TfnWrVltPU46M4Ke8DnJ/uErm0ZvHDrKinIAll4ns2gH9hbsotdMyxcRZBSciR+SfeBX/M@vger.kernel.org, AJvYcCWEL+QLTbXsZgErl+4fksctux8yKeKhF2NYB4a9/AF9RyOe1CVlXTg76Upbk7cIIfpxPPwCCGTX@vger.kernel.org
X-Gm-Message-State: AOJu0YzX076B3+/FH0+yo71wgKWC95JWIHmrSI1xdffGm+fBEVc48XH4
	IRNkkC6y1umBDxJSTJom+B5YocRwMCL0WvLGAH+FoddbL+2mTT3y
X-Gm-Gg: ASbGncvUS+bZKmde3aOjVDw17iG53MhkFkyLCiEZnKiXKmBVZD7/lLgIEmjSQjYkxMA
	qNE2BBMK+KqxfIEvZlBnebvHJbPzGl2PLWOGG+eTTNIBsgXrcLDPmrlbeHLuo65Z3SZJ4WDjru2
	cny/47n5r78VjYEPx4sjxqeI/N3FcyTRkvvknypSH6HuxtMh4KNbPOp0Udh+HpFGzgOqjqn9y5Z
	MCWb084ukCaLl3qUFGg5DLrUEXX0nueybieWy0by244jYdQjD/N3cV7rb37vFZQP07QQGheibX6
	QbFtG51itzRgBgfXwK8qU2uzj/TRD2jfyNyJcs7pI6X/sd3hlJhlxw2ve0ycxk4BMchfobhIMWJ
	8
X-Google-Smtp-Source: AGHT+IGXejG6SSWE1qsqlV2SDFl6w1YGt8KTotTLV2mFe3yEQtSfi86doGIB0kaHG0uCeBfkHHrEAw==
X-Received: by 2002:a05:6000:184b:b0:391:441b:baac with SMTP id ffacd0b85a97d-39ad1773e93mr2692945f8f.50.1743084947937;
        Thu, 27 Mar 2025 07:15:47 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e83620sm38992435e9.12.2025.03.27.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:15:46 -0700 (PDT)
Message-ID: <67e55d92.050a0220.2fa7e9.5d6b@mx.google.com>
X-Google-Original-Message-ID: <Z-VdkOhLT-4q4NQb@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 15:15:44 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: pass PHY driver to
 .match_phy_device OP
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-2-ansuelsmth@gmail.com>
 <Z-UxZMJR7-Hp_7d0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-UxZMJR7-Hp_7d0@shell.armlinux.org.uk>

On Thu, Mar 27, 2025 at 11:07:16AM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 27, 2025 at 12:35:01AM +0100, Christian Marangi wrote:
> > Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> > Having access to the PHY driver struct might be useful to check the
> > PHY ID of the driver is being matched for in case the PHY ID scanned in
> > the phydev is not consistent.
> > 
> > A scenario for this is a PHY that change PHY ID after a firmware is
> > loaded, in such case, the PHY ID stored in PHY device struct is not
> > valid anymore and PHY will manually scan the ID in the match_phy_device
> > function.
> > 
> > Having the PHY driver info is also useful for those PHY driver that
> > implement multiple simple .match_phy_device OP to match specific MMD PHY
> > ID. With this extra info if the parsing logic is the same, the matching
> > function can be generalized by using the phy_id in the PHY driver
> > instead of hardcoding.
> > 
> > Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Please also update the email address in the suggested-by to match the
> one in my reviewed-by for the next resend.
> 
> Thanks!
>

kernel test robot made me aware that this cause error with
nxp-c45-tja11xx. I was on an old net-next branch and didn't notice the
""recent"" changes to macsec support. I'm updating this and keeping the
reviewed-by tag, hope it's OK.

Also adding the simplify commit as suggested that recive the
match_phy_device.

-- 
	Ansuel

