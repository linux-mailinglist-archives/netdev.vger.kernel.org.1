Return-Path: <netdev+bounces-187698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20071AA8F3A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8929816E1E4
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FD383A2;
	Mon,  5 May 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+zp0Cve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBB2DC789;
	Mon,  5 May 2025 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436681; cv=none; b=BupmeF1FlmeOZHB0UX2oo01yM3QMVC5AIzki/HYWdRFpn8ryqrD/NFbxSRWrbqYVfzU6cOGJaKg0+0xfifYfT0zW8y7E/xSgfXGArKmqNQ2OYLFVYihfjevUJ9dtXSVqe6BfkegvuOeAraI+M6hFYBTf1wHte3iYwzy8P7YTv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436681; c=relaxed/simple;
	bh=n9DSrRhvj6S5JgtzQkpkDqezZ/xHBdRJ5jQgPsYXCLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA3br3cTP/c/pusdyv3TupupLN1FjVRgJk/IMX3UTF5oQx382OBjlWMW3MgrkKKwZ+zVhItiAryGbsho49iiTVWqxi0Jf9Q6+N0H9VZGKwlS7pudndIxbvI7vu6zEKWa45yewGRpzoh5DVFsEhE5IpnZN8dTNDblnWS5aAXw2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+zp0Cve; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so14989715e9.1;
        Mon, 05 May 2025 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436678; x=1747041478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PF2CyQx2MPaV+rJ68g+o7uLVAoJbG7ga5+6WFdjiP3A=;
        b=H+zp0CvexGqSz+Q1ujaj960/UDH/tSzSj+BEhj8BZ7zKK6HM1To1N5cOTncNGrX2Td
         WlP2gJWfCv7j5xO33cVKNLuF2E3i4+h4vaNp9k4atPn96gKXMwHTrsKnrkdwST+43jyh
         RQcawGvkSMgxaamve6f92fksEjURFNC5eptI78aNFPze7G052P4VgsUqhzSGsJzg7EFf
         MlShdAZ3F2/yz1N1FQYbEm0qn6MxXit7uyv5+SnFK6mzyclZsNFk1aBYXMg2WBhCGI6C
         akA65Do1knZSAYxp9CENUrfaXPhe8ur2MfMpdJqRkDe66BZT59ofPMex2jsliEuBvtwK
         8Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436678; x=1747041478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF2CyQx2MPaV+rJ68g+o7uLVAoJbG7ga5+6WFdjiP3A=;
        b=M3g1+GOgO7Gv0vm245Vmd0XU/lOvpfXwv0mxqYv3vU09Pv+FGNEFHvBaPLBnlxmmPR
         gysTVY6K0isAMF1ji0PnofhF6Oyhm84gQU11GU4kYZ9lb69/cFPm8U8whAgzn73xmu45
         g5LNwT+NgVB4D6Vo52ej9qL8ZxnLnAO24+cfuHpnWT+GEPWJUISM+8hLSDCQx9tzyYQv
         LDvXfDFiHBz8ncCeHS18W5L7CgB8lGY7KsFkKSD6Qf1pUVak7DQVCI7agyUEv7EWZuJ8
         FzBZeZjd0amhsxIr4fanzDve0wwC4Vv+cLZcI0un0k4YCUiPjdYwjFq+RAgT3/hcskHU
         3/ww==
X-Forwarded-Encrypted: i=1; AJvYcCVb1vflr6dEqvWc/om3x/6XNWJU2+/1RDAU6hRVjrORP5ql/za+CfJS2oR+AwhNRfA/2zIGu1PR5BMU5JU=@vger.kernel.org, AJvYcCXcZzvzBrB5axU9Lg22KMadSpG5F9OvyHOvV1NXVN5aQKDBN8/18+nuMqjtq0vRio8Q8jPYWDkb@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMqyO4tS8sOzskZm9W6mSMAGppi9GG2RZw/HyG8aa0J1/zb8U
	4HBCf6RIlMIhEmzBVAVif/glwA4L9x3bpZAOzIHor3bbgd8mtr62
X-Gm-Gg: ASbGnctcojsXOfldn4f7pTgqdaI4Nazor6gVEPM1OJrwHqRtuPpomaZ3hHXXCyECb3+
	pbOsyKFwrFsYlU7eWUaykJivf5/6XeYxuJ6JxhQSzJgPu2r3oaPgt04VDDu01RL0VWf2YIbDepE
	o7MMuqrrWkJlfnGlB9X4Fk+zd8gOMhZwO9Vgl9qE3AyHG62OoT+2tHTN4VjjFLIoMQYXNwkuQOE
	RQsev4GivzJ0HPjmLkmKCZ/HL3AR5X85JyIG/0ZCmeVk425O/hMSxXj2v2RCNOJlxweaOooWUAz
	xSLq+BuqqIPRWgNgbiTojxyACkn9GjdaNuT6rg==
X-Google-Smtp-Source: AGHT+IFIqdr/tc0ob8HjmKsgvnPZEZu7wfgqrfLNWKbQpPSOjxgUG71cRtZVlqchJSK9RCEg2GbJXw==
X-Received: by 2002:a05:600c:8012:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-441c48b069emr54300605e9.5.1746436678067;
        Mon, 05 May 2025 02:17:58 -0700 (PDT)
Received: from debian ([2a00:79c0:608:9e00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc469sm128392865e9.6.2025.05.05.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:17:57 -0700 (PDT)
Date: Mon, 5 May 2025 11:17:56 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v3] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Message-ID: <20250505091756.GA9785@debian>
References: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>
 <20250429200306.GE1969140@ragnatech.se>
 <4e68ca40-85b8-4766-9040-edf677afd0f7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e68ca40-85b8-4766-9040-edf677afd0f7@redhat.com>

Hi Paolo,

On Fri, May 02, 2025 at 12:51:47PM +0200, Paolo Abeni wrote:
> On 4/29/25 10:03 PM, Niklas Söderlund wrote:
> >> @@ -765,6 +768,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> >>  	struct mv88q2xxx_priv *priv = phydev->priv;
> >>  	struct device *dev = &phydev->mdio.dev;
> >>  	struct device *hwmon;
> >> +	int ret;
> >> +
> >> +	/* Enable temperature sense */
> >> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> >> +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> >> +	if (ret < 0)
> >> +		return ret;
> > 
> > nit: I wonder if it make sens to create a helper function to enable the 
> > sensor? My worry being this procedure growing in the future and only 
> > being fixed in one location and not the other. It would also reduce code 
> > duplication and could be stubbed to be compiled out with the existing 
> > IS_ENABLED(CONFIG_HWMON) guard for other hwmon functions.
> > 
> > That being said I tested this with mv88q211x and the temp sensor and PHY 
> > keeps working as expected.
> > 
> > Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Since this is net-next material +1 for the helper.
>
Agreed.

> Also AFAICS this is fixing a net-next regression, so it needs a fixes
> tag, too.
> 
We discussed it here:
https://lore.kernel.org/netdev/48c4cd14-be56-438e-9561-c85b0245178c@lunn.ch/

Andrews opinion was the change is rather archtitecture then a fix.

Best regards,
Dimitri Fedrau

