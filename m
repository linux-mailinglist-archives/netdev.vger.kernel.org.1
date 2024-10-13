Return-Path: <netdev+bounces-134948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1B99BA83
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7AB214D7
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502114600D;
	Sun, 13 Oct 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mg7lFcl5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DA231CB3
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728839930; cv=none; b=OTy+ZOuPdeU8fXlKJV9pPxgW+3Uow5pAq1eDpMg7cL77clJN5WxjKf02Zv02sHOwcA+gDE2kh8HNRTC9V6hbnoTv8IHGtDJ9Xq5UIUtnAHUSTbpR56cx6e6h75EjobDLD5FLiRlz+ACatc7ibDALvmtag9ia+nPnu0P6zqLgtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728839930; c=relaxed/simple;
	bh=zU6r7WQCLlgzksPUdZ062rKKSl7c+BK7PZyJW9b6dqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV8IbgDEdRK1p3Ge0dJfLv+3FpIhO4AYV6waa7u/v9MljItWOXjI+Dz41j23LtgLw1zMd28tejfKLgGPW34ZpXREDa63htFVH2j7LIC50eWlhKLkLlUDwoBpLOBMIynuOLZiG4ipqjDopJDTjZdfj/orkh4uPIS4x5GkzwGZAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mg7lFcl5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l64+Kseta+3Wn1wFZTUZ91fvBaqXNypD7O0yDnX1sC8=; b=Mg7lFcl58nUuXmfp7MkDSbP0Qs
	JY7URSm+9avn24WFVlH5t/VTsLTs7qZ7d47lbNdAtk7VKh8Q8znEl9HWlOY/QMpapKKFOpRLrdLus
	Ahcy8QGFGHugJyHWJedY+g59R2wIvYbT4S0s0acMJm7RtAx/KG0VjlXua1AlQvT+NzD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t01yQ-009r9q-8f; Sun, 13 Oct 2024 19:01:42 +0200
Date: Sun, 13 Oct 2024 19:01:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net v2 2/3] net: dsa: mv88e6xxx: read cycle counter
 period from hardware
Message-ID: <f33e48fd-b8fe-4c7f-9180-fe6d23c1e48a@lunn.ch>
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-3-me@shenghaoyang.info>
 <9b1fe702-39b2-4492-b107-f1b3e7f3c2a9@lunn.ch>
 <1c768936-9306-4bb9-8a2f-1e21e09e4b56@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c768936-9306-4bb9-8a2f-1e21e09e4b56@shenghaoyang.info>

On Sun, Oct 13, 2024 at 01:26:53PM +0800, Shenghao Yang wrote:
> 
> >> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> >>  struct mv88e6xxx_ptp_ops;
> >>  struct mv88e6xxx_pcs_ops;
> >> +struct mv88e6xxx_cc_coeffs;
> >>  
> >> -struct mv88e6xxx_cc_coeffs;
> >> -
> > 
> > It is better to put it in the correct place with the first patch,
> > rather than move it in the second patch.
> 
> Hi Andrew,
> 
> Thanks! Happy to spin a v3 if preferred.
>  
> >>  	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
> >>  	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
> >>  	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
> >> -	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
> >> -	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
> >> +	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
> >> +	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
> > 
> > Once these patches are merged, it would be nice to remove
> > chip->tstamp_cc.mult and chip->tstamp_cc.shift and use
> > chip->cc_coeffs->cc_mult and chip->cc_coeffs->cc_shift. We don't need
> > the same values in two places.
> 
> I've looked around a bit and this doesn't seem possible - the common
> timecounter code in time/timecounter.c and linux/timecounter.h has a
> dependency on the cc_mult and cc_shift fields within the cyclecounter
> tstamp_cc.

Ah, sorry. I did not see that tstamp_cc was a timecounter structure.

Maybe have 3 const struct cyclecounter similar to you having 3 const
mv88e6xxx_cc_coeffs. Assign the appropriate one to chip. mult and
shift can then be dropped from mv88ex6xxx_cc_coeffs?

	Andrew

