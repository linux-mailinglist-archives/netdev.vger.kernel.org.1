Return-Path: <netdev+bounces-66278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED21F83E398
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D421B2116A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCB23750;
	Fri, 26 Jan 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6h06wAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23701CA9C
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303090; cv=none; b=uTRUQHnIzIN0OK9nSjwiDpiFFZYbHpCoWx3Jlu2p+gZMMvnGnVI44Zi1ymjjJCrgagSLcoZpaEgPdsw1sgdjTvmbJ7IYm0+LAeH7uzU7tZP1jDF7xpqkgFPXiDPZcwxLhQu59SykHbZt4s+Ve6tckgTAw0n4QQxPIo5kHZkRCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303090; c=relaxed/simple;
	bh=GjD4yN4643QoSyvGkTebC4jtRi5QMPkswyp4I0O6Obo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzuvZgGwFmAkZFVqp76Y8QPYd0ldo4FZw7lJM67q4Wmga110j4venaGHvr3NnhP/LTPZPfLZcjBf9dyUglaD1ZxXHP0J31d28Qg1VUddg7fIeio0M6bKuQ7UcQ0WFjaJ9+2i5bk3otZSwJ1sV13r4qxCQeRL/klvGDnx76IcZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6h06wAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E00FC433C7;
	Fri, 26 Jan 2024 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706303090;
	bh=GjD4yN4643QoSyvGkTebC4jtRi5QMPkswyp4I0O6Obo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6h06wAjx/d2rnn6/H5GbIOWV6ZSc9uq/6GQcqLDSeeMLmDhIdjAXuvmzSKIx660l
	 N9pLUkEYGeABCgdPJ5fwlx0eUz88lSMCz2nVT2m8wUomw6AlIuwPkiyRazu7io9SCp
	 VveGIQx2eFvF5tSjNjbPZU/SmROfLCG8gQVJFchy5+xUVSTbWqjd2BH5gYC0wFsMxI
	 SDwvo4bh500rtVs6cV7wg32h4VrAVIKbf9zF0u07/A/zsVl2M9hMDMIoqkBOhnZ1ZH
	 x2dqHbnOQANWINbnp1CNGavHES1xQGJYJ3SSQyLfCuRBeGH6rxKQyRtVdZIEbNBE69
	 EX//FFxIoAWpw==
Date: Fri, 26 Jan 2024 21:04:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 2/2] net: txgbe: use irq_domain for interrupt
 controller
Message-ID: <20240126210445.GE401354@kernel.org>
References: <20240124024525.26652-1-jiawenwu@trustnetic.com>
 <20240124024525.26652-3-jiawenwu@trustnetic.com>
 <20240124103438.GX254773@kernel.org>
 <02e301da4f35$3ae8d790$b0ba86b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02e301da4f35$3ae8d790$b0ba86b0$@trustnetic.com>

On Thu, Jan 25, 2024 at 10:21:40AM +0800, Jiawen Wu wrote:
> On Wednesday, January 24, 2024 6:35 PM, Simon Horman wrote:
> > On Wed, Jan 24, 2024 at 10:45:25AM +0800, Jiawen Wu wrote:
> > 
> > ...
> > 
> > > +static int txgbe_misc_irq_domain_map(struct irq_domain *d,
> > > +				     unsigned int irq,
> > > +				     irq_hw_number_t hwirq)
> > > +{
> > > +	struct txgbe *txgbe = d->host_data;
> > > +
> > > +	irq_set_chip_data(irq, txgbe);
> > > +	irq_set_chip(irq, &txgbe->misc.chip);
> > > +	irq_set_nested_thread(irq, TRUE);
> > 
> > Hi Jiawen Wu,
> > 
> > 'TRUE' seems undefined, causing a build failure.
> > Should this be 'true' instead?
> 
> Oops. I built it with 'true' but sent the patch with 'TRUE'. ☹

It happens.

Please send a v2 with this fixed.
And please include Andrew's Reviewed-by tag unless
you make material changes to the patch.

