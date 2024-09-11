Return-Path: <netdev+bounces-127506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3543975992
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2051F235B2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D11B4C35;
	Wed, 11 Sep 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="scgVzA4j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2281B3728;
	Wed, 11 Sep 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076309; cv=none; b=tzWHhJmNe8t5Pl2Xc8AvGI8Ld4c8POY9xK9EKXATAhIiUjOvjnBPiUzfohs96tlOjof6EuRp3XDgxh0I9QVSDhVZDYZmdI2ZlkgqfKm9Ue1UI9RdfioZjuPRNSf9oHCoPFrNrm384vCV+oOxwpksQh+r0aDTAXVt6QeiL+13MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076309; c=relaxed/simple;
	bh=BilNsUvJfRZ0GdxlYYKIIPGj12hj2YnO3i7QFGfJO+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B33369qskUARfPZnSyzAwLhMZLZbSf+lX53qqV0OwaKYpWcPPxkSSrtJrhwHtpGyYdGkP+NfsNlkAgafZoOr6ag6yQ/zzdedAjC1HZMunsjoLmEYu/81cdRkjb3cQDE1gy+AfXZtJB5wbhMXX5S60Ijvt1mDU3D2kGlaFEnW8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=scgVzA4j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pmQK4YmD0F9VOqXDapzYiQ6/zLcJ+MuI1M7o/Ocw+q0=; b=sc
	gVzA4jV5GDYK4pWVF+DbLlZDJsqnf+AafEjWVOUKghHkXhlchmQ30xu0g87FrthH9ufzoVEvkFWJP
	RDoQdtBlTvVweqD2zFvxCvpeq/ikkSX+nS4OqPL7ewAbYjpSjVb+eDZxVvVZZB43IbEh7wp82RhJT
	xAWChL0G0BS93+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soRII-007Esq-PH; Wed, 11 Sep 2024 19:38:18 +0200
Date: Wed, 11 Sep 2024 19:38:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Message-ID: <76d49fe4-e2b4-43c4-83f9-07796f47ae1d@lunn.ch>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-3-danieller@nvidia.com>
 <20240911073234.GJ572255@kernel.org>
 <cb9d0196-5b91-486b-932e-e73a391fa609@lunn.ch>
 <DM6PR12MB4516864A308D5BDFF0021129D89B2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR12MB4516864A308D5BDFF0021129D89B2@DM6PR12MB4516.namprd12.prod.outlook.com>

> Hi Andrew,
> 
> In both cases we transfer the same size of data, which corresponds to the size of the firmware image, to the module.
> Moreover, in both cases the same size of data is passing on the wire, which depends on the wire obligations.
> 
> But, instead of running #n "0103h: Write FW Block LPL" commands (see section 9.7.4 in CMIS 5.2) with up to 128 bytes, we are running #n/16 "0104h: Write FW Block EPL" commands (see section 9.7.5 in CMIS 5.2) with up to 2048 bytes.
> That means that instead of processing #n commands and sending back to the core the status for each one, we do it for only #n/16.

O.K, thanks.

> The standard does not say anything about the I2C layer, but the
> speedup doesn’t lie in that.

What does your hardware do? Can it do 2048 byte I2C bus transfers? Or
is it getting chopped up into smaller chunks?

Thanks
	Andrew

