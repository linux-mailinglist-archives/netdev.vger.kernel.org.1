Return-Path: <netdev+bounces-69828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6F84CC0D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CEC1F242A2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548107764E;
	Wed,  7 Feb 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfthRUtv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563877644
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313947; cv=none; b=Rx74p3EG/TFkgWeMqgFE2ACNBFlRo3c62ezplAcWfLJBwmjkLeGQju01gYMw4Qbhske6JREY96vcMRAL819Z10mSHGL06hVDd+ULbPt6swceHdDBvpHm5gquEJOQrHCP+vveeiThzWs/Zg4aJW4RHFPX2Pz8UDzZVM4t8SOPBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313947; c=relaxed/simple;
	bh=1eKopmu4+bTxR4F2IimfNnd2d2cE1OrcWFzC1/9Xm+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIyDEP26QWqOkv1mFbTDHZQttjL47vDomrEtYI+hyS+BiFaPNIVmI60xg/AZyRPPFH8xuEWsuR+n8xhWfKdqiK/JmBJxC5B4hfLytjfnpkC2ZwrWqYgSMEaNrnx88sdhCLzC+MaYozfsQ0NWn7DhV+CLrFONxmRsI1zVB10CR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfthRUtv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so743415a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707313943; x=1707918743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssucjkApVHBsZVPy7RMVbGWlOv8R81OtHKLkTIxL75E=;
        b=GfthRUtvBexp6lUIe7GU+nCgTjMJ6uYl+4owgrQKms/9u7a6rPawwyy+rvL6hoc+gr
         ityiN/Ycm0/BkeOhg+G0jcYd5tkmOA+dgBLJiVx7ynJjthuAc4ooPMruXSeh6Zkf1o5e
         SsCvXZ1JRWEdlE+C8L3pjX4m0hU2uA4R1Kg4014DKSbqNqpHSg06VqBf2nL+6nFqNs5T
         Uqcc1ExMEmEaDgcSLAsDQH1PnI8b62f/XUkBGTckaQkbl+qkCbV/BCLrkGq21BerBJav
         PP8Suc3NcKq1euQO0wGKy9RBwAjUQE+FbozGdauFu/Z8DIH4gG8QgUh3T0kSsNJcHVlH
         x0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707313943; x=1707918743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssucjkApVHBsZVPy7RMVbGWlOv8R81OtHKLkTIxL75E=;
        b=A+QCX/1itnG+vpUzIrsszIvXhg5rdlMe7bId6yxB7bZHuavKhL8W2PWBd5mNb6tlvY
         IzI2VFUm2BoDS3pp4XPaVgMNtceC0oekexOxTf5qVdYAN41VudXDbVY1ro2FTYEmKSpm
         XD9s7TTndYwfZ+TGDWIfzVUopoH1K3wW7jNNIfRI8cVY0lqQYR7/0PdaWz5bnSE3hDb7
         epK8TXg79WGN/OsH26F2DvSJ+lFy5TOZusVdxtLw1A/azGTSeS6KFPDI4UvcKhTj/JqL
         q+FlMJf84elOd1tXnA981h9NIu7/mKMIDLeg4XUJXi1mbJsI95yJ8tvD9hQhFGNi0vx1
         i3AQ==
X-Gm-Message-State: AOJu0Yx94JAZOctz41U1JXqIpsO8VG9vM+43T0Q9qQQE6CQ4Ca3tOp/o
	ixhHGHvNuiU3UE4LMqF7T2Vhqz4mP05oYJ6QTCursTjpQkIT9Ale
X-Google-Smtp-Source: AGHT+IENDHIhbR7wteWQbXtL2mevl2caQhgOmSZZBbuKlHearZm4BYxKy1Kk0y3Hkngo2TMyudHymQ==
X-Received: by 2002:a05:6402:1b0b:b0:560:c888:9cf4 with SMTP id by11-20020a0564021b0b00b00560c8889cf4mr1856528edb.28.1707313942560;
        Wed, 07 Feb 2024 05:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXi1rfmfbaYmAUzLd6Nkj/pUMld79kgFYZjdrRWY/at3fU7YbH/8fju/1n2729UouFwNWBQbDsEFVdXiGSE+FgZncZ9ioCshkawR7c1Po7aKMgk+y7tZGK887rKNw0rtKcUFAefRTGdXUPQaLFWujuzEPXMLh4RzM1V9OoTt933V62CGj8UgQ8LACqks53aUTrsaWH16//w8VErcsf8U3KensmRKmkYb84nq2+zP2O5oX7YAKkYT72iLELf3i4k2hfkBMeew0y52CtlTP44lhgji5hAtvvKm0RJEzAC1qdJjTPFDDGpD/HKWlQRgobeXVIViTxrR7pj4V47az0xBwBdsOnY0wv06IOUOY/tI/Nc0Eugf0iKN8rAPiZbOMiDrsBixTIHTXVXroh5G6RITtUvD77vIgKc1CHegNRsPD0Ounda/JjTN5UMZj4W44Vpvo9cTuZJxPf4OFTb0azG9dUMTIgmcMTmro29H9O0nomlQ7tasrXz+WRtlYSB0NCIxNoEeyPpycbXwCTqJrCF52e/pTtt6C+BE+cjIp86A4L+UJNklTi862r5IEolwJZwqklN8SDlBz+rxBCBTx7nmdQ2lJ5u6Jl8VW/LIfXdODOm3PFVozVb60knGgwJf+1l+q7Frkhv2K2Fxdpr4QkTHEORhNGbBvQhCfQqEnZle798Gne47wylrnO5s6Z+u4O6jGCIecHbo/LTInSDj5Xo6mmoRqnn6V2OYWslv31cIWxEw8meBg==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id fi25-20020a056402551900b00558a1937dddsm686175edb.63.2024.02.07.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:52:22 -0800 (PST)
Date: Wed, 7 Feb 2024 15:52:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <20240207135219.7wr4hctzjuanotxv@skbuf>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
 <20240206112024.3jxtcru3dupeirnj@skbuf>
 <ZcIwQcn3qlk0UjS4@shell.armlinux.org.uk>
 <20240206132923.eypnqvqwe3cga5tp@skbuf>
 <57406055-ff3c-4788-bbf7-8476f63f90db@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57406055-ff3c-4788-bbf7-8476f63f90db@gmail.com>

On Tue, Feb 06, 2024 at 08:25:17PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/6/2024 5:29 AM, Vladimir Oltean wrote:
> > On Tue, Feb 06, 2024 at 01:12:33PM +0000, Russell King (Oracle) wrote:
> > > > I know next to nothing about EEE and especially the implementation on
> > > > Broadcom switches. But is the information brought by B53_EEE_LPI_INDICATE
> > > > completely redundant? Is it actually in the system's best interest to
> > > > ignore it?
> > > 
> > > That's a review comment that should have been made when the original
> > > change to phylib was done, because it's already ignored in kernels
> > > today since the commit changing phylib that I've referenced in this
> > > series - since e->eee_enabled and e->eee_active will be overwritten by
> > > phylib.
> > 
> > That's fair, but commit d1420bb99515 ("net: phy: improve generic EEE
> > ethtool functions") is dated November 2018, and my involvement with the
> > kernel started in March 2019. So it would have been a bit difficult for
> > me to make this observation back then.
> > 
> > > If we need B53_EEE_LPI_INDICATE to do something, then we need to have
> > > a discussion about it, and decide how that fits in with the EEE
> > > interface, and how to work around phylib's implementation.
> > 
> > Hopefully Florian or Doug can quickly clarify whether this is the case
> > or not.
> 
> Russell's replacement is actually a better one because it will return a
> stable state. B53_EEE_LPI_INDICATE would indicate when the switch port's
> built-in PHY asserts the LPI signal to its MAC, which could be transient
> AFAICT.
> -- 
> Florian

Thanks, Florian.

