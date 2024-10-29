Return-Path: <netdev+bounces-139916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E79B4990
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD5C1F237AC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA4205E24;
	Tue, 29 Oct 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dkEhVsL1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C938BEA
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204519; cv=none; b=GWpvPyNCAuVBKeyEQf6tmSz/kcfn75Y61CvrolyiXfOhYP8FPueubJzYgVlgfZt1joOzUIOoovjZMeZSvXgfBBW5eLvZJgd/R8OPj173jvOwyY5+2d6LBbrK6qIt/ipCTgr+IT0UhvBvn/PSrY+MFqjfLWPX5ZvHsnutmoA9P30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204519; c=relaxed/simple;
	bh=gYzIoqdSwekIU6bdXNiROsHGwypLK3Enyq4cn6vyFWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxdcQRYLjW7fRFC9X1I/kL2H8obpxdS//cC1atsupkp5ASiz9GytjVlZieNk7xbUIpRsSy+ivhb+uNTJqBd4R+tZ1jKrB5qp6ZZY+WmWv9UgUWcPzaBZ2o7CBa4WRX5cnLaIYCHkwxUVLnxzCnYKdaUPRh+6Pqrm2EnUOMI0Dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dkEhVsL1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HzQ1z+1DbL3z/C63wYQzQP0dbfy7JZgtq9MdE3mHlNE=; b=dkEhVsL11GHDyrM4q0hZSyx9It
	BTQ1HfXOYJfMWembK79uWDiCL/tthrJjOwVais9X4v6t5aShPtVsOMjZNtBoandjIhtV3A2A06g/8
	HlXHNUue9Kl1m/DGDOkmSYPpCv8emFat115E7pBNCuAr9Ijsi/K8uJVPVRoaBLh3pNkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5lEE-00BZXE-LH; Tue, 29 Oct 2024 13:21:42 +0100
Date: Tue, 29 Oct 2024 13:21:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
Message-ID: <30b946f2-bfb8-4938-8f12-1b10bf81972a@lunn.ch>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
 <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
 <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
 <e6863bfb99c50314d83e2b8a3ab8f1fabe05e912.camel@codeconstruct.com.au>
 <4f56a2d0-eb1b-4952-a845-92610515082a@lunn.ch>
 <f3d0cafe11000fe1cad7b4ad13865b3bcfd2ad27.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d0cafe11000fe1cad7b4ad13865b3bcfd2ad27.camel@codeconstruct.com.au>

On Tue, Oct 29, 2024 at 12:06:58PM +0800, Jeremy Kerr wrote:
> Hi Andrew,
> 
> > > However, regardless of what the spec says, we still don't want the
> > > strlen() in nla_put_string() to continue into arbitrary memory in
> > > the
> > > case there was no nul in the fw_name reported by the device.
> > 
> > I agree with that, but i was thinking that if it was not allowed, we
> > should be printing a warning telling the user to upgrade their buggy
> > firmware.
> 
> Gotchya. All fine there.
> 
> > Are there any other strings which will need similar treatment?
> 
> This is the only nla_put_string() in the ncsi code, and there are no
> other string-adjacent components of data represented in the spec (that
> I have come across, at least).

It is worth mentioning all this in the commit message. It answers
questions from reviewers before they ask the questions...

	Andrew

