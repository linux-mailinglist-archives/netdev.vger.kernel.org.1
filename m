Return-Path: <netdev+bounces-245002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA871CC4DC8
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944F03046FB3
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C33491F5;
	Tue, 16 Dec 2025 18:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35883491F2;
	Tue, 16 Dec 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908508; cv=none; b=gOndt5uYsIS2XVluBS1UeK4/m6wq8/302YCJavADnEQzKZtJVtnnY6ojsTK1sDNm54SnnDcfVHVb14dE52LlD6a0oMGKNKyNuIvNA70/CoOl3r6LG8RlNdpRXQtO2//MZXAPhtGQJoiVduUwQIZdF2KYwKVXXdyaI7QOEY+mcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908508; c=relaxed/simple;
	bh=p9Av8xpkdl0yLY1QD0a0+CAizlE1pNUfSR48cS5kRQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLGhKDxpE6oSNcGhmutKb9haIMYo7auG68DDE4FwSrvL4F7uPlmDzWl3rhU7/fIJg3OwlHLF35ZwbSDfI2AuxS6JceUx2+FL0oeEwAIpctK3lks7YZzsce7EHufAXOFunLtTHSjeRUB0RGbszG4MdJfXlg/PbXiZQAtMfn+Kb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vVZSz-000000004Sq-2s9q;
	Tue, 16 Dec 2025 18:08:09 +0000
Date: Tue, 16 Dec 2025 18:08:06 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v4 0/4] net: dsa: lantiq: a bunch of fixes
Message-ID: <aUGgBj8YZHQnaIsv@makrotopia.org>
References: <cover.1765241054.git.daniel@makrotopia.org>
 <20251210161633.ncj2lheqpwltb436@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210161633.ncj2lheqpwltb436@skbuf>

On Wed, Dec 10, 2025 at 06:16:33PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 09, 2025 at 01:27:42AM +0000, Daniel Golle wrote:
> > This series is the continuation and result of comments received for a fix
> > for the SGMII restart-an bit not actually being self-clearing, which was
> > reported by by Rasmus Villemoes.
> > 
> > A closer investigation and testing the .remove and the .shutdown paths
> > of the mxl-gsw1xx.c and lantiq_gswip.c drivers has revealed a couple of
> > existing problems, which are also addressed in this series.
> > 
> > Daniel Golle (4):
> >   net: dsa: lantiq_gswip: fix order in .remove operation
> >   net: dsa: mxl-gsw1xx: fix order in .remove operation
> >   net: dsa: mxl-gsw1xx: fix .shutdown driver operation
> >   net: dsa: mxl-gsw1xx: manually clear RANEG bit
> > 
> >  drivers/net/dsa/lantiq/lantiq_gswip.c        |  3 --
> >  drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 --
> >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 19 +++++-----
> >  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 38 +++++++++++++++++---
> >  4 files changed, 44 insertions(+), 18 deletions(-)
> > 
> > -- 
> > 2.52.0
> 
> From a DSA API perspective this seems fine.
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 

In case you are reluctant to accept patch 4/4 ("net: dsa: mxl-gsw1xx:
manually clear RANEG bit") it'd be nice to have at least patch 1, 2 and
3 merged as-is, and I'll resend 4/4 as a single patch being a simple
msleep(10) instead of the delayed_work approach, if that's the reason
for the series not being accepted.

