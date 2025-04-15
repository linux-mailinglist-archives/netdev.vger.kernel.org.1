Return-Path: <netdev+bounces-182803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8CA89EEC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9CF7A2D03
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790762973D2;
	Tue, 15 Apr 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8InTvPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB32DFA4C;
	Tue, 15 Apr 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722267; cv=none; b=q/5R09GyyJfdWCE4zo+Lk2CGaTJ27uLtPRAOxH3oa6BycSUR8zY+E4nnwI24KVw7lnQ/j6ZkPg+2+LNbh7cI/JMjpXznq+TL0+gWCXKZwNds5/wZDY3Y4fiKu/q5l74CDod7tU2sPsex3M3UyrBDcbkndn4sEwsbLylm48gaLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722267; c=relaxed/simple;
	bh=sa7Skd2aaXb0VF8USJsNqb1mTJyQs3A826CyqUahHUs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brmb+I/lbJR6ibHrC9cVJWLS1TSM17HWfmU4RSLldFPhtea3O5N0+sU/d83d/g0EnrjWzLow0CjGN2Iud4+/n6F/xvoEgFkDAy4w3Pmesq/At2l9tuZcrtrjItTakh/WmLuHUbygi3m3fM9iI1yf1wvNCypRlA5MrExuKjq/Fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8InTvPc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso28157835e9.0;
        Tue, 15 Apr 2025 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744722264; x=1745327064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+PNNMorDjrK3jPX7Cg5O+Ib6RnAEFHMPsiH2T1ynei0=;
        b=H8InTvPcsb9ERWkwZlzWxp6Yx4ZpsiOGCqyvfi5SwOVmeHBQUCVxf2dHRdxglf6wUF
         ifiaFcpXerxzI3HoeXlCl0GilG5LApxQkS4Z49wuNAFchs+77CyWGJegEpJ5WRlsF4Bk
         IcjKL8wKGObODfVo8+gZex6gaxKbkCkeJAUb5aNLg223yy7AEDnCPnwGDS/AEHbuBwja
         dIlyD6uUmlKoUEQngr142OMq+areqPTKhnoUkxwN75VlPFKqtqyu/1TcWvdYcdgOC7lz
         sxUF8nLr92BQW7V5EYAoF8iNdimxEYjSh6Pj53izhhWVhkOFpjVwOjeII1W401Amz31h
         CvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722264; x=1745327064;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PNNMorDjrK3jPX7Cg5O+Ib6RnAEFHMPsiH2T1ynei0=;
        b=YnylgSg10XrPi1oA3e+EbdGmednuncjDuH4h1IGpECIM04ERKz9DvVvPcjTVorU804
         VnkwAp90QcKroyuUeI05gSz8RAXFlv1wFbpzSI/BYIG8G9+HKIDabzuAuOtfkrqtjkQ/
         dTxkf3epzdlCplkAF/ZRQ3d+vLLbrvLee10vYa3KN/YwQvb8njafnsh64G7zopFCOHBx
         FJRCidLQRy2GtgvjB2LfEKF9TK6er7b8rk1wstShOPoB+upA4INAifBGHnAH4dFsjtUy
         dm4JMl+OG1Y9OQ7G1nXpEESOZzEACr7lSNbKuYMTrkCRGEmxRRf88QZlgnqWiAGzLDui
         BgRg==
X-Forwarded-Encrypted: i=1; AJvYcCXe+qxMAu4vvIXo1FOZ6+EUukP8nJytFS78I4cLoDfJ0V9HsrLEAqoiUWaw8UZ1TcCrCK1tigvd@vger.kernel.org, AJvYcCXjrFwJeo6Wa1m3qQhEzXeWp+TicytHI65VH+EVmw5wttXEfmmN/40iswfd+YP+ku5Gn7KI3JDgGM49@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAERN4jo58Q3ohEJ3HGjGfC1rCt8UvonBmdcUe4xfRS1eQh5E
	fs9thCNlXOqroTLMI1NRGaRi4smThA8j8jK41quMdfR7s4c1fmC2
X-Gm-Gg: ASbGncsyqf6SnNeFWGy5ufRBcnhGGIzMPqz2Tl6HfpP6AtIiEl2Rf6ZsKBkD0mNwg2V
	N9HOA1X9URZ83/Tdha4xwmiMpaBmVRGgYLSGJWPsge/v5Zr/v3I1ZKVg2v5Qgblhvbmv00N8gYy
	j8ciPkLwKLAgupYIpEi5G+3vsyL7X8Yh+YRYFc9KtJMEAa1MWOTPsOeDuOndcirCL4LTo0Ue6rj
	P3S/OUOOP1t+E5hlpkrSTn/nmJgzCR8nb+wSooz+Lo5LXHmXGRkPFa9FWqoeQEO7S4nlvVofey9
	ENDnGvQgPPXXFUztqKzSC6rK0+DetQyoUyHsiwEsGc7AGbd5xWqeNyuwCrfYmGv+rlliMahuPca
	+VKOwCTzA/LVZ
X-Google-Smtp-Source: AGHT+IFjvOvuLlb3DPkaAYoMi6rOX66PTgUOC+2ABZ7NcqxMs9iL57C5P8JCwArGpmNJpCbge+P5Cg==
X-Received: by 2002:a05:600c:1e09:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43f3a959790mr155195855e9.15.1744722263377;
        Tue, 15 Apr 2025 06:04:23 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-95-100.retail.telecomitalia.it. [95.249.95.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm216575095e9.32.2025.04.15.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:04:22 -0700 (PDT)
Message-ID: <67fe5956.050a0220.347569.4476@mx.google.com>
X-Google-Original-Message-ID: <Z_5ZUZuRBn0Um1rd@Ansuel-XPS.>
Date: Tue, 15 Apr 2025 15:04:17 +0200
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
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
 <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>
 <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>
 <Z_5XQZvgdW6Wfo06@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_5XQZvgdW6Wfo06@shell.armlinux.org.uk>

On Tue, Apr 15, 2025 at 01:55:29PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 15, 2025 at 01:24:16PM +0200, Christian Marangi wrote:
> > On Tue, Apr 15, 2025 at 10:37:49AM +0100, Russell King (Oracle) wrote:
> > > > +static int aeon_ipcs_wait_cmd(struct phy_device *phydev, bool parity_status)
> > > > +{
> > > > +	u16 val;
> > > > +
> > > > +	/* Exit condition logic:
> > > > +	 * - Wait for parity bit equal
> > > > +	 * - Wait for status success, error OR ready
> > > > +	 */
> > > > +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> > > > +					 FIELD_GET(AEON_IPC_STS_PARITY, val) == parity_status &&
> > > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_RCVD &&
> > > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_PROCESS &&
> > > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_BUSY,
> > > > +					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);
> > > 
> > > Hmm. I'm wondering whether:
> > > 
> > > static bool aeon_ipc_ready(u16 val, bool parity_status)
> > > {
> > > 	u16 status;
> > > 
> > > 	if (FIELD_GET(AEON_IPC_STS_PARITY, val) != parity_status)
> > > 		return false;
> > > 
> > > 	status = val & AEON_IPC_STS_STATUS;
> > > 
> > > 	return status != AEON_IPC_STS_STATUS_RCVD &&
> > > 	       status != AEON_IPC_STS_STATUS_PROCESS &&
> > > 	       status != AEON_IPC_STS_STATUS_BUSY;
> > > }
> > > 
> > > would be better, and then maybe you can fit the code into less than 80
> > > columns. I'm not a fan of FIELD_PREP_CONST() when it causes differing
> > > usage patterns like the above (FIELD_GET(AEON_IPC_STS_STATUS, val)
> > > would match the coding style, and probably makes no difference to the
> > > code emitted.)
> > > 
> > 
> > You are suggesting to use a generic readx function or use a while +
> > sleep to use the suggested _ready function?
> 
> To write the other part of it (I thought this would be obvious!):
> 
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> +					 aeon_ipc_ready(val, parity_status),
> +					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);
>

Eh I never considered that I could totally pass entire function in the
condition part. 

> > Mhhh I think I will have to create __ function for locked and non-locked
> > variant. I think I woulkd just handle the lock in the function using
> > send and rcv and maybe add some smatch tag to make sure the lock is
> > taken when entering those functions.
> 
> If you don't need the receive part, then pass NULL in for the receive
> data pointer, and use that to conditionalise that part?
> 

Ok yes that can also work.

-- 
	Ansuel

