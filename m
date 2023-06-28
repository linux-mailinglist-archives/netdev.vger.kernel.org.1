Return-Path: <netdev+bounces-14453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F757419D9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 22:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5EA280D8D
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429EF1096C;
	Wed, 28 Jun 2023 20:46:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A46107A9
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:46:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77391FF6
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+y1JusCGLuOzWsZPtC769VYTFYhrXWGIXGBzKkpmVLM=; b=fqCQ32/ziNsLhj2D9dSSUtxmcc
	uW1B0MFkhS4OimnmdN5FN6UbHFBa53JSWBxmSRaFN/KRYBa2218ix5EZix1fp4LJAjvDmwa+shjXW
	nokF3ufHshpUwcrrfM2tmTNs7ETBbN4E8ZxxFJdp/aptamGVror/wQRp9B5FSoOQVd6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qEc3c-000BG8-7G; Wed, 28 Jun 2023 22:46:32 +0200
Date: Wed, 28 Jun 2023 22:46:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
	Nathan Chancellor <nathan@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <06f5c065-2c6d-4cd2-9699-89f05443f137@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
 <20230628133850.0d01d503@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628133850.0d01d503@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 01:38:50PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Jun 2023 03:16:43 +0200 Andrew Lunn wrote:
> > > +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> > > +		if (!info->adjphase || !info->getmaxphase)
> > > +			mode = 0;  
> > 
> > Maybe it is time to turn this into a switch statement?
> 
> I don't think we can switch on pointers in C.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L749

Works for temperature sensors, voltage sensors, current sensors, and
power sensors. Maybe hwmon is different to what is going on here, but
both a sysfs files.

> The patch is good as is, right?

Yes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

