Return-Path: <netdev+bounces-115447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2D946633
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D0AB217B4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDE13A895;
	Fri,  2 Aug 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jZo+zAY/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347713A403;
	Fri,  2 Aug 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641715; cv=none; b=qdacXva67Aavv/BMhhz3d8akBM64+ZsxVJ3dUmb8a1BtGkbOrDfxqkqDsprhoGgTPGsVakoY97UwxDWCEIfqVa3iP1P5NblX7Jnsp6Tx3QC3kV2opp9sBOj6ru3RcbSKqeJFxurBdsDLoGhN6tsPX5e1GFNF8RdfC/UJ7eysfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641715; c=relaxed/simple;
	bh=G3ktvJyNjBf8TnIZVT0ANzoVJfwL/K+ywRnJK/gxEDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7pO5ZtKQI6L2nI9QO+Vlp/7IqFgRIREpD4rlYgT9YT72lTHYCQ3sZtLNxKPjlrCJT1WR+Q/UQiWqiU3U5NKxXqEHcetQsbgsANs/pVD0AgjDjbMyV08dModyPD+/fAjoJB30+6ph6EBm85fAI0OaDcMDbzI+geP8Cnd8roTzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jZo+zAY/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5DkwMmT+724knaZ9VDO6NBUm878zP+f3Gj+JqRDoYb4=; b=jZ
	o+zAY/E26z8SYJlaY1NdcXN5ZdsteGlXOGVVEl58ck7he3bl8dwKSzkqxM2JxBzZufNDpBxdqAjKx
	YsUO8TffUKTyo9JFLvmJ0qNABkbbu0/AEvdqsd/PvBoiko1eOqoxLx6gzPrdVO0SK+8AYhZyw0fmR
	Zl1UvrZZp9emjUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sa1nW-003tsy-KS; Sat, 03 Aug 2024 01:34:58 +0200
Date: Sat, 3 Aug 2024 01:34:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roy Lee <roy_lee@accton.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3: Add param `short_preamble` to enable MDIO traffic
 to external PHYs
Message-ID: <d254d820-399d-4ac7-b9b0-e4b3668bbed3@lunn.ch>
References: <20240802100448.10745-1-pmenzel@molgen.mpg.de>
 <CACKFLikjqVZUXtWY5YBJPT56OqW0z00DxkaENzG74M64Rrr81w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikjqVZUXtWY5YBJPT56OqW0z00DxkaENzG74M64Rrr81w@mail.gmail.com>

On Fri, Aug 02, 2024 at 12:51:15PM -0700, Michael Chan wrote:
> On Fri, Aug 2, 2024 at 3:05 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
> > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > index 0ec5f01551f9..9b4ab201fd9a 100644
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -233,6 +233,10 @@ static int tg3_debug = -1; /* -1 == use TG3_DEF_MSG_ENABLE as value */
> >  module_param(tg3_debug, int, 0);
> >  MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
> >
> > +static int short_preamble = 0;
> > +module_param(short_preamble, int, 0);
> > +MODULE_PARM_DESC(short_preamble, "Enable short preamble.");
> > +
> 
> Module parameters are generally not accepted.  If this is something
> other devices can potentially use, it's better to use a more common
> interface.

+1

Most systems supporting suppressed preamble do this using the DT
property 'suppress-preamble'. See:

Documentation/devicetree/bindings/net/mdio.yaml

You could add an ACPI parameter for x86. You could also consider
implementing clock-frequency if the MDIO bus master and all the
devices on the bus support faster than 2.5MHz.

	Andrew


