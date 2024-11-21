Return-Path: <netdev+bounces-146633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEC9D4B83
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F048B264EA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F81D2793;
	Thu, 21 Nov 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LEkZlkKS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590959474;
	Thu, 21 Nov 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188110; cv=none; b=Omgk8rKMActwmARDWlcXRQaO53tCCFemnWSAxozwtyQn43WIbaAiXMExOM3kJcw/8XAU316+Reu9qFuXa0quaNuNFxKXCWM1M99Iahv83XdfPbQxxrw99KfZq4htPvVi8n4HI9PQap5fChv9UvK++YHFU/0prw98J74nu1i8yYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188110; c=relaxed/simple;
	bh=+09UqF3DA48MJ036al7ktyOHyfA0HnCqeJz6/VYnoiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjCzNCpfBUmHKNQvQsTCT+t6iLhYKzGhxaE/RX4PdZs51XM7jXn7iAtBLA4X3VOGnhtHTBLI1BjIagArm8ul0aI6mnTeC4jQLfT0a8RDXJCpuN5CS4gSi7O9PoatcAOXdwtEvr/mg1MsrUA1PIb9MR3/M/8GU+I2T4zfId/9C3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LEkZlkKS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qgG0e7UzN8+WUp6AqXCjxSqcwayn6e6nDB+hkU2JcJo=; b=LEkZlkKSgLA6iUvi5ydHat8rBq
	e8E/zLkDsZUujh0K6PcR6YKmgqzKDMl2VKiilQu7Zd+7bYsT+Qe+BOQrwTYWPvviS1WUIZ4eS6ggP
	rbU7fgl6LY/zZtD4tECcbzJ1E/ZD7JvVD40nsC1VNN4SrhFieptGEOgp7tyH4E+oRbovtHNt/uHAi
	5a/cN7p4SZVz2OYCuIuUf+XNwH01Xgyqb7mJ6hYeFT9KggG9WF1MOBcqK6ezSxNAJdV31yQrj3F+V
	rZLESO7vxTJptBdYIwalye9P3bBOKsHBNgrxnS2TbR5Sqo7nTnxDKs/SSdafCU0kGtyghSLA774Ut
	NdU9v2VQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tE5Fj-00076D-0V;
	Thu, 21 Nov 2024 11:21:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tE5Fd-00080P-2R;
	Thu, 21 Nov 2024 11:21:33 +0000
Date: Thu, 21 Nov 2024 11:21:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121105044.rbjp2deo5orce3me@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 21, 2024 at 12:50:44PM +0200, Vladimir Oltean wrote:
> On Wed, Nov 20, 2024 at 05:46:14PM +0800, Cong Yi wrote:
> > Hi, Russell King:
> > 
> > Thank you for your reply!
> > Yes, as you say, there is no problem with the definitions themselves
> > being named. When I just read from Linux-5.4 to 6.6, I thought
> > that PCS_STATE_ and PHYLINK_DISABLE- were associated in some way.
> > After reading the code carefully, I found that there was no correlation。
> > In order to avoid similar confusion, I sent this patch.
> 
> For the record, I agree that tying together unrelated constants inside
> the same anonymous enum and resetting the counter is a confusing coding
> pattern, to which I don't see the benefit. Separating them and giving
> names to the enums also gives the opportunity for stronger typing, which
> was done here. I think the patch (or at least its idea) is ok.

See include/linux/ata.h, and include/linux/libata.h.

We also have many enums that either don't use the enum counter, or set
the counter to a specific value.

The typing argument is nonsense. This is a common misconception by C
programmers. You don't get any extra typechecking with enums. If you
define two enums, say fruit and colour, this produces no warning,
even with -Wall -pedantic:

enum fruit { APPLE, ORANGE };
enum colour { BLACK, WHITE };
enum fruit get_fruit(void);
enum colour test(void)
{
	return get_fruit();
}

What one gets is more compiler specific variability in the type -
some compiler architectures may use storage sufficient to store the
range of values defined in the enum (e.g. it may select char vs int
vs long) which makes laying out structs with no holes harder.

Another thing one gets is checking in switch() statmeents that all
values in the enumerated type have a "case" or "default". That's
fine where we need to ensure that all values of an enum are checked,
but if that's unnecessary, it becomes an unnecessary burden to
remember to add a - sometimes - useless default case to each switch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

