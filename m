Return-Path: <netdev+bounces-38172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E47B9A05
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 04:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 81109281D92
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41401106;
	Thu,  5 Oct 2023 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VD9VMX3Y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06817E;
	Thu,  5 Oct 2023 02:44:07 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D3C0;
	Wed,  4 Oct 2023 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0NQ/g4PmP3KmQk0o9HxrWTK9sWaymND2wvzIv9n7au0=; b=VD9VMX3YpO4p8fBX8lciuydeA6
	WyT4s8XUgioC6EOCKNETFxjIG9C5ZcUGuN3RqKzqIYq/AFI8xGJrr66v3/Gcgp3gvshBwFj4sTrGS
	sJwR/zVWIlcIltPUmUwRafp50nLbHGGtSVXvPQAcR7hKJepgX6aUat7loXwwgaRT4pq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qoEL9-008ICm-Od; Thu, 05 Oct 2023 04:43:51 +0200
Date: Thu, 5 Oct 2023 04:43:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <56227e76-f01f-4b90-b325-1cd9ecb8d5a3@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
 <20231004162831.0cf1f6a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004162831.0cf1f6a8@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 04:28:31PM -0700, Jakub Kicinski wrote:
> On Sat, 30 Sep 2023 12:39:44 +0200 Robert Marko wrote:
> > +	ret = of_property_read_string(dev->of_node, "firmware-name",
> > +				      &fw_name);
> 
> Perhaps a well established weirdness of the embedded world but why read
> the fw name from OF?! You can identify what PHY it is and decide the
> file name based on that. And also put that fw name in MODULE_FIRMWARE()
> so that initramfs can be built with appropriate file in place :S

The Aquantia PHY and its `firmware` is just weird. It is more than
just firmware, it also contains what i think they call provisioning.
That is basically the reset defaults for registers. And not everything
is documented, and i think parts of that provision contains SERDES eye
configuration. So i think you end up with a custom firmware per board?
And you can never trust the firmware in one device will do the same
thing as a different firmware in another device, because the reset
defaults are a bit fuzzy. The PHY driver is somewhat built on sand,
since you cannot really trust any register to have any specific reset
value.

So i can understand putting the board specific firmware name in DT,
and that the firmware will never be in linux-firmware because it would
not scale, and there never being one firmware usable for all
boards. And this odd way of doing things means the usual mechanisms
for getting the firmware in initramfs does not work.

I suppose the question is, do we want to say this is all too ugly for
Linux, solve it in the bootloader, or spend the extra $0.50 for a
flash chip and put the firmware in at the factory. As a kernel
developer i would want the boot loader to solve this, so i can TFTP
boot the kernel. I would also like having a rescue mechanism for when
i brick Linux on the box and need to boot a Debian install image to
recover it.

    Andrew

