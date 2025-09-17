Return-Path: <netdev+bounces-224060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B80BB80536
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245B67BB1FF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892333B48F;
	Wed, 17 Sep 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iyOk5hTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC133B486
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121049; cv=none; b=CUIQ3OrbiIRB2mfCVKzUMO3jJr3wFfvGdo7eadSmVJ3pzg9QgOSO77VaWoHEy3lkv6pi23B1joA52T84NIESffxo+/QlycqypZ3qK2W2GwT79HwBdomIMThEnJME5ht1YqvW+8muda29dD/E3nCjm1SH62DFMwQqkmo2zhanUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121049; c=relaxed/simple;
	bh=9OJQZq6bHCOGv02hQ9NPzIP7qKBnKi5yAR5CrQuWy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRVB9PY6jcEdmAeeP3HAHYARwpfm9sjTUOLPnNyLtUGnu17GC3cqaRpDsqXR4+u2/6mMruyoRldqz6A/Pzd8UWId7GaliU3SPvUsbSJtGT1Rv3giP/rGPkmqm2oTu8jxCU71+SQnW3G7FzOinVFmxPBwOv6NpWp6pD5n9iKw2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iyOk5hTd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-816ac9f9507so109100285a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758121046; x=1758725846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=iyOk5hTd0RGR9IJYHKGcrhnycmh/4ftPLUaqp3uwYYz6uA9kAqIbgGODrL6+WBffg0
         ASlqAudM790xLRDtuWWVwGyscKIBeOCecYaxuipegTHgeE3O2ZwrmDYwfAcZmOhtrYQs
         gfKdsmskHqq3krQtsNfAaxiEd3Hyp41ZR6lsxwJBmigCoKmRuSdQChvKcyJjfMq4K4WV
         hK30HKK/+ZfvEEt4CWApkQQB5nEMOCD3uJYt57jUsnemEI1SeaoBf8fSVBslYFyb4zJ/
         qKaDohT80/SXOdXnCUU+ZFDXbAaoyRjUz6d3wNqDRh7pDiGVCollGDl+dZzXX1RK185h
         9o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121046; x=1758725846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=YS5b2F61BRmq0OIFUALzrUmGW9G+0fsq84A7nvWEwj44sfZN34f84LkHMg53zTqVPU
         r8NMi2I7diLNl0O+OjUjKocfqU2yn9+lVH1w3D1rx9BZE1ydXAgtv1+0weS0nRMr775T
         XBRkT8qL0vwls/+N+lDassQu2cxOJyKyZ4C+uFEqWZm7uRVxDSAd9Xb/40DBckbymafl
         2nH1LoE2cxsVikHayVM2yu1oXx/QFY0Iv0cmHVa5NjYefIl0aMEFBviNgVYWJ8AaGqRY
         55IzzCN1KilFq2EPNwzyImqqantmSxajDL9QF4QgVOKmJ3NgdK2A7u6bQ4bLYbdvWgZN
         XNuw==
X-Forwarded-Encrypted: i=1; AJvYcCWIM/0V+K9ZU2VL+8enmuXp5T4nAFhe2JLR+4LiSVTJx8Cs97hXIcNnSpitU0TjPBi5xrqqTRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAUhWNsqHZ+WYi3OmZE3Fmqzm5jTISqiW1AkdYU+x9UnbYSTB
	9vjUV+llpCUbGnwugs2b9Hji10lsD4oWBEKBpnnqSQOoVXjUnQ8zGXnZBDUXu0hESQ==
X-Gm-Gg: ASbGncspHJoZpNRDebYIxbZ+EBTaWY5YEsAZ01YZVZHQMTlM2fkrD4H9ImJHuFUo+0D
	RXRb2KUNB4qCrPr8hxMFxdzqrVUpVSpC0XrteuHotQ0z7p3qjLA0DORZgVPD/Dcaj+8fwKxfopp
	LLtmJWqRHEZgUZYPJjWwhlpSJvsSVhD6rXMwiSlihegZqrg3/3/+hnBI0q2sEEjcHtZdFMDYHVH
	c8UZVfuKiH+gNBodo4j0Z1ruZcOHuF8Qfjh7Ggk6q4VmM6tedjP8wJXVgoVZ78rFkuDPBGkvas/
	eCuRh5cpEr4s+5jN9DvX5xe+T4VwJ1O09o56nThJLb2lGEijIsULYPe1UNTFs+bLLguNl7NZArz
	n9Q96Nv8IfZmPOpH4taogv3Cxpv7PSLDhP/Dy8U28ANap9W3qF7fHlSZ8TnEa02uK6Foxuv1dDL
	XJ0pLJBQM0Hpuk65LKE5TR
X-Google-Smtp-Source: AGHT+IHSha0l2uy8bY+NcvRiDKKxmDF7lfi4/yLSRxZTDI+PO2c2F0E2cv/USSjdeL4NWU7Va2vk2w==
X-Received: by 2002:a05:620a:4713:b0:828:b2ab:a50e with SMTP id af79cd13be357-82b9e38f41bmr799576585a.31.1758121045894;
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974dbbbsm1145829885a.21.2025.09.17.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:57:23 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <ccfd7d48-401b-4f25-ac8e-aa6aa9654956@rowland.harvard.edu>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
 <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>

On Wed, Sep 17, 2025 at 04:31:40PM +0200, Hubert Wiśniewski wrote:
> On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> > Are you aware that the action of pm_runtime_forbid() can be reversed by 
> > the user (by writing "auto" to the .../power/control sysfs file)?
> 
> I have tested this. With this patch, it seems that writing "auto" to
> power/control has no effect -- power/runtime_status remains "active" and
> the device does not get suspended. But maybe there is a way to force the
> suspension anyway?

I don't know exactly what's going on in your particular case.  However, 
if you read the source code for control_store() in 
drivers/base/power/sysfs.c, you'll see that writing "auto" to the 
attribute file causes the function to call pm_runtime_allow().

If you turn on CONFIG_PM_ADVANCED_DEBUG there will be extra files in the 
.../power/ directory, showing some of the other runtime PM values.  
Perhaps they will help you to figure out what's happening.

Alan Stern

