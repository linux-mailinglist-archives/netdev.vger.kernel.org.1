Return-Path: <netdev+bounces-175328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA5A652A5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32FA16AFF3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBF199E8D;
	Mon, 17 Mar 2025 14:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5840156236;
	Mon, 17 Mar 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221049; cv=none; b=k91LPyS7CKua8EeUUGKGw1isfpuwVc2eAKoC2IYB276JwuIObbJtnu0mwTzFTTMc2xc7q8fWBK4UkKOpxZXiWWSKVyCuawX7XL5hDdLzZg5lgY9zUtButzDDwMyHL302cPUJ7QJcOT1q8Ez+kw925vDaVfnWqiKRm4c6lDjjnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221049; c=relaxed/simple;
	bh=ZrCUyyoaCtGtFB4feGbsXOOJ2TmB82Yr07aXXd2sG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlvZTpjUcrCWJfzMEaQwzq0ev8hEVW4U2V35CXDt3gO7wRfStEfvdAmk2qc0fqW+zOmYYwy26h7mKjIsMxSe/jzLkwm79VF70BiyRW1TtclqCSuHY8ut+8ev2v28GAIs3Ujj74wv/7y7Gx9+Vry8M6exAjXR5foSLY09PgYMUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2796613D5;
	Mon, 17 Mar 2025 07:17:36 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3CE3F63F;
	Mon, 17 Mar 2025 07:17:25 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:17:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] net: phy: fixed_phy: transition to the faux device
 interface
Message-ID: <Z9gu86r9pdFPGxrb@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com>
 <ea159cab-e09f-4afc-b0da-807d22d272c8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea159cab-e09f-4afc-b0da-807d22d272c8@lunn.ch>

On Mon, Mar 17, 2025 at 01:29:31PM +0100, Andrew Lunn wrote:
> On Mon, Mar 17, 2025 at 10:13:19AM +0000, Sudeep Holla wrote:
> > The net fixed phy driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> > 
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/net/phy/fixed_phy.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> 8 insertions, 8 deletions. How does this reduce its footprint?
>

I meant the use of struct faux_device vs struct platform_device. Yes
it is not a big deal.

> Seems like pointless churn to me. Unless there is a real advantage to
> faux bus you are not enumerating in your commit message.
> 

Greg has answered that, so will skip.

-- 
Regards,
Sudeep

