Return-Path: <netdev+bounces-13476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C524073BBD6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DC2817C4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B6C2F5;
	Fri, 23 Jun 2023 15:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C4D2E9
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:38:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D22126;
	Fri, 23 Jun 2023 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eaai/2aq87jv39+4nAJAoxKbCvsMFKJK4WRa82NziSY=; b=xTJ+PaaHmLU0TXGAu3Lh10OkQS
	PQbBNyqDwbxlG3M5FODc72rEZf1AEvVGVkDdwXzKAlGtemmmisAobREPgMuAobacj5+3ihfqAXDEO
	IpwIhdRXhH4VZ8sCAexv/l037yG7Ku7ioNZj2cMPHq9iDBd7yPpT++8QpNc51o4Fq1Lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCirq-00HN9f-Td; Fri, 23 Jun 2023 17:38:34 +0200
Date: Fri, 23 Jun 2023 17:38:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	claudiu.beznea@microchip.com
Subject: Re: net: macb: sparse warning fixes
Message-ID: <fe335672-6b8d-4fb0-81ce-34f029891d39@lunn.ch>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 03:16:23PM +0200, Nicolas Ferre wrote:
> Hi Ben,
> 
> On 22/06/2023 at 15:05, Ben Dooks wrote:
> > These are 3 hopefully easy patches for fixing sparse errors due to
> > endian-ness warnings. There are still some left, but there are not
> > as easy as they mix host and network fields together.
> > 
> > For example, gem_prog_cmp_regs() has two u32 variables that it does
> > bitfield manipulation on for the tcp ports and these are __be16 into
> > u32, so not sure how these are meant to be changed. I've also no hardware
> > to test on, so even if these did get changed then I can't check if it is
> > working pre/post change.
> 
> Do you know if there could be any impact on performance (even if limited)?

Hi Nicolas

This is inside a netdev_dbg(). So 99% of the time it is compiled
out. The other 1% of the time, your 115200 baud serial port is
probably the bottleneck, not an endianness swap.

	 Andrew

