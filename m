Return-Path: <netdev+bounces-248289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A6BD06874
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41DE5301AE07
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084AD2EBDEB;
	Thu,  8 Jan 2026 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Lbe7Hp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF233987
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914426; cv=none; b=i0NbHFqgdSVQYR3fmGHfatB7j3rrn6wQidnS7QTo6tNGCHQiKwoxbicD1Rbi595Kkyb8hl4Cst4Iw6rxop9ysdw+JVxKfTUynGC3a5AlP3zUd4uItHZnD+WfDOiyW2Cc7IjL1yP/HxmOnqx6m6+QGABSS7AHr8r0q7uxhCOtngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914426; c=relaxed/simple;
	bh=7bwQ+XZ+abLywU7PoTafW4uAbblLEvi0WeRRKdGZLhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KypPWC+xv4DAMb/CcPZx8vtTRDkC01cf94ktEwi9YKgvAu5F6F+Gc6B0cKn09YG3njdHl/7mZ4o9qMkKmuF94anR2tTvhxbAG+yA8AKO0UZgJzOuf3MlLoRtOq/CklP+Zk5BYubOlyruz8mkVDzEvnR+Osw5FFeGEAP9e3xfWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4Lbe7Hp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso24313005e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767914424; x=1768519224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAPZAV/DI69pvvmVAjFT6poIAMoV1R1xs7ZH4qHwqr4=;
        b=L4Lbe7HpUf556KQA33EsuUaZtXIpv63I9O6VknZmiq+vAyhNKfIOaB3UMUKZI7Jf/3
         IB7/tBjEYva+5I4xe0+DZMi4mcg0Cm3Q8diK5w0adZBsN8R7v8/zQn3QIRfg21NSyXz/
         5S1FHBonEsf9QvXGBZZI8CyN268eIVd4IbaiUPLNegnxJyBX/V3YBve/d4muV5AGR7SB
         ygycuRPJ7Sk74e+YymObgE4LjjGqZd2TogRxwQJIXZ17uXBfKAJEQb5//C150GSNug+x
         ph5LA0hXFCFErQeM3uvdv9KlCDCDS86kXssNKcCNc9oGTYUqiwGNT7yeIn4yawIDSDf7
         DvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914424; x=1768519224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAPZAV/DI69pvvmVAjFT6poIAMoV1R1xs7ZH4qHwqr4=;
        b=Tv155i7w8GQOyDbrZYYxSiWJe0waST11HA7PSYL43lmPDwyic2nirOTZNHjC5yZAJQ
         9rhXs8f5c5kRvQ60KsFEICxZJyG7C57hbONWJ0xPZR7S86ecmgc3MOFkHQ10WsO5Tl5D
         WXNOqSfdLE1SYsisXDJjDcvLyEHs0r6VVvUYY6JUAKuch/RygmMJpzXC8P9WR09xopTZ
         xd8sMuOLeiJFx3E24SUfCfLiyNcZ98/ondnznPHLiNgw2v+veVyMoWYqUWKltajKqz0m
         BRLSSFraNcA64EyzwW53elJ3/bNTSsLduFHtP8Dfa4M6yMdPKJHnF9es2gI3bjNxQEEs
         5XUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0t/BX5++sYCvMQ6iNUdrpiiAwYZTnRGSigNorSwuGzSzgJB+zSnsrz6KZn/mS86EfB0lsv2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEll0yV4MWWyfhwX2Ncbvqqw91ds2lkXTnKwTEKELwQL9kIAOk
	CPure/CTmn15o5c9rA9W07g/QRZHJ2BNbyS6yjGLEzzz7fUuq3hKzxhM
X-Gm-Gg: AY/fxX4oov0VJMn6aEGNuqs3EQRM/ezSPPWbJuBw8EyEYercVmsJAM28FvZPrTiNxn7
	kc51FTKEiGGrSg5Fk53GwEO6zl/27y0yc5VA29VFGYm4lKMXjTtGrtubybxkOpHvfvgqpsNBKTO
	ws7IUVteoknWMvFLUZUQ6HPIRbmGGtg3fIazKS7ca/OtEcY5ejXz9DxpD5DvmbaFsVntRWa2FT2
	5zq9eT5Xu+opi7nO5yWWRUquQAz5OO68H1wQYmCQO3b+5UPaI1fot+YRmE2HR8H0OlcaGrhE4aW
	oziQ7KamYRpCW0UY91vX4jH08rppFxP7q6tfhYblEysrzrW5Lg7mauz6ZZ/emlnhIYGJ2vL8K4A
	BwPCeqhpzKsrmNHiz+hx9bjYKtPLSjJ7uLEvai4SeF51n1wqXeDKPWjNySmmq6FVk5BsdnnjW8u
	AGQ43PzIgvEEOju10=
X-Google-Smtp-Source: AGHT+IH0wkNf0HJBh0WfU29N6zAqcqxpV4tj2ho3jeagdAn2EOdOlSEs8Bt3XH76R+EuTmqAwz/kqA==
X-Received: by 2002:a05:600c:46cc:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47d84b41034mr94045105e9.31.1767914423528;
        Thu, 08 Jan 2026 15:20:23 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8678cad8sm51826055e9.3.2026.01.08.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:20:23 -0800 (PST)
Date: Thu, 8 Jan 2026 23:20:21 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <aWA7tSjnH7Kr1GCk@google.com>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <aWA2DswjBcFWi8eA@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWA2DswjBcFWi8eA@makrotopia.org>

On Thu, Jan 08, 2026 at 10:56:14PM +0000, Daniel Golle wrote:
> > +static int rtlgen_sfp_read_status(struct phy_device *phydev)
> > +{
> > +	int val, err;
> > +
> > +	err = genphy_update_link(phydev);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!phydev->link)
> > +		return 0;
> > +
> > +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
> 
> This should be the same as
> phy_read(phydev, MII_RESV2); /* on page 0 */
> Please try.

Tried it on my setup, the two calls do indeed seem to return the same
value.

