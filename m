Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7DD7413E3
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF1Ofq (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 10:35:46 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40150 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbjF1Ofn (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 10:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=lUkU2FtlrmI884MIX+8Ov37gsp+qdDfIHByA05Xth/Y=; b=QxVQpJx6qn+f5oGrAkHLxJMYIf
        Qy+iqBzTXhk7XI5t7mLx4fvmIcki1IHhegCo5eQ+qlHkTkEeBooESMuLLWmckkIDT3w+HqIvf1D23
        +uqbVkJnP6nPG5o4wmJoKc6WLqOV19TF2lcx+uMhagS8UlvDPKYMl45a53elqfOxo3S8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEWGj-0007pD-Dk; Wed, 28 Jun 2023 16:35:41 +0200
Date:   Wed, 28 Jun 2023 16:35:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <0e82eff0-16ba-49b0-933d-26f49515d434@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
 <87ilb8ba1d.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilb8ba1d.fsf@nvidia.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

> >> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> >> index 77219cdcd683..6e4d5456a885 100644
> >> --- a/drivers/ptp/ptp_sysfs.c
> >> +++ b/drivers/ptp/ptp_sysfs.c
> >> @@ -358,6 +358,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
> >>  		   attr == &dev_attr_max_vclocks.attr) {
> >>  		if (ptp->is_virtual_clock)
> >>  			mode = 0;
> >> +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> >> +		if (!info->adjphase || !info->getmaxphase)
> >> +			mode = 0;
> >
> > Maybe it is time to turn this into a switch statement?
> 
> I agree. However, I do not want to conflate two separate things being a
> bugfix and a cleanup. I think we can do one of two options.
> 
>   1. We can take this patch as is, but I submit a subsequent cleanup patch for
>   this.

Fine by me.

> > I also wounder if this really is something for net. How do you think
> > this patch matches against the stable rules?
> 
> Apologize in advance but not sure I am following along. The commit for
> the patch the introduces the problematic logic has made its way to net
> and this patch is a fix. Therefore, isn't net the right tree to target?

Humm. So c3b60ab7a4df is in net-next, and the tag net-next-6.5. So it
was passed to Linus yesterday for merging. You would like this fix
merged either before -rc1, or just after -rc1.

We are in the grey area where it is less clear which tree it should be
against. So it is good to explain after the --- what your intention
is, so the Maintainers get a heads up and understand what you are
trying to achieve.

I actually thought you were trying to fix an older issue, something in
6.4 or older, which is what net is mostly used for. Under those
conditions, the stable rules apply. Things like, is this fixing an
issue which really effects users....

       Andrew

