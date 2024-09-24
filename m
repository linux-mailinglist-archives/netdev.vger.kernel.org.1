Return-Path: <netdev+bounces-129599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F028A984B57
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA31C22CAD
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C71ABED2;
	Tue, 24 Sep 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1md87S/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F11A7AED
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203857; cv=none; b=JM056gr4MMBEXHJaGndlFE76xj6uVAJE5D2jYqg5iSz7329B/nE66V4wdTv20eBwijzGwObwj4tfR/+8P0jSaGR77ywEVtX6mj7lfPSUqFxrCZIbFRt1Kp0xRmUMP39yNX0e6uDJ25orMtKFU+JFK2eZfOPqQpSkhCAnBQEQ7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203857; c=relaxed/simple;
	bh=TEVEY4txE8aUBWXpcwW3ORxg542NuBLLZeOnlJ8MrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceMYjKv+V1Q6xpkk/qSyxgXP9jxXv6iS3i75jcfXXBuQtF5uAcRH22lvchRp0iURynvJ5TXthy+TdNDU+laiC60FibFJWWXKYCJFXbNkvVD9j+QSOQ4oNszyj3OW+Gg5bd+LPpPGpzuTDYQ43u453xsUAenFvsWV3cC2B+O8/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1md87S/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365aa568ceso7001121e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727203853; x=1727808653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8yljJUo8NRBugHKOFT0PM95Jmsv0H5pGe3vrsP2GKA=;
        b=W1md87S/i2UN41S32xqENyQuHaZZRWWSS9LKAxCTU8yZFgdEOG95gvu0qliNbgai1K
         TXPeGvF1gYZixSGdLM+weyRy/ZHaAzzCmAru6jLxDcjqrcykHbhv8tiHTLkGkX6yyj0Y
         QVRrg76stZ6Bp/2LvOLuQITsJwWBGfxt9Y/atqzXTrm9A0AbfPbao7T4ZHFiRc28ixCT
         L5fPtlcattPsvGmGD0aqL10NR30UpOeCOhTKEXIgfgVPVEDsfwh3oYH/MxfXldxg5RLS
         XJ1tZJ2iXDZQvDC1K4nC+DmK+AE/eY9xuX0nYRw//CfbFZJWYVqT0UFEtwBhFvvXrP1L
         HIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203853; x=1727808653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8yljJUo8NRBugHKOFT0PM95Jmsv0H5pGe3vrsP2GKA=;
        b=r8B7Yc+enWGiD719yCmkkQqWnYEjAw5mrkSlrT4EHfVsBDFtz4siq/6HdO4JKTQVP6
         u1xQoPgipbmXgBjMw1ykMOqGA9Egn1Nk62/J1l2EEOHib+fEZw7YfwXCPAb4YEZ21O8q
         OUYVQ+HDywoSSTKeCKGLhce8TJmFK59uPsd3phifiMO5Hn+PT9z/k6m4ISqlwZrmjkzC
         RTqsozz4BuOwBrakxgM6cxtDecsn59PaxIaGMAig29uM9ZAcVdvB0RouMi0fv3I4T4b+
         Q8U4P6mkkOGHFWDklpJz/hqTVGlY/v0GIPBs2NQkP1DPiWHHN5llWNnrIYWEmR59rfJ2
         EcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCULLpgIo5ufm9oAC2FK4KO6THjI0td4OL0ci3arxEHAks9NrXdfN0IwBwgs0JVwybpU2tkvG5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FQZ0cul0H7nDYIgnzZ7eWRJT751AzeUTUOr3cydP98xtJgs5
	KO0SVW70NXjh6q0Jo4UVwvQbsSpsmJd+2G+GQ4C/ByCf7udQX12Y
X-Google-Smtp-Source: AGHT+IHRriG35uTpaSEGDgrKzigcN/tN63RMLWMH004l8eZgH73DZXtYF7VLiK+XTKsI8w4Tw3a6Ew==
X-Received: by 2002:a05:6512:118d:b0:533:324a:9df6 with SMTP id 2adb3069b0e04-53877530f3fmr60553e87.29.1727203852433;
        Tue, 24 Sep 2024 11:50:52 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864081fsm297694e87.161.2024.09.24.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 11:50:51 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:50:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"horms@kernel.org" <horms@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Ong Boon Leong <boon.leong.ong@intel.com>, 
	Wong Vee Khee <vee.khee.wong@intel.com>, Chuah Kim Tatt <kim.tatt.chuah@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <6nikxeiovzdrlxq5alpvhvgpkeky2gkevk6mczivfxsar3hoof@n2gxyrrten6m>
References: <20240923202602.506066-1-shenwei.wang@nxp.com>
 <fcu77iilcqssvcondsiwww3e2hlyfwq4ngodb4nomtqglptfwj@mphfr7hpcjsx>
 <PAXPR04MB918588AD97031D9548D24A9B89682@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB918588AD97031D9548D24A9B89682@PAXPR04MB9185.eurprd04.prod.outlook.com>

On Tue, Sep 24, 2024 at 06:13:27PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Tuesday, September 24, 2024 2:30 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> > horms@kernel.org; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> > Abreu <joabreu@synopsys.com>; Ong Boon Leong <boon.leong.ong@intel.com>;
> > Wong Vee Khee <vee.khee.wong@intel.com>; Chuah Kim Tatt
> > <kim.tatt.chuah@intel.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> > mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> > <andrew@lunn.ch>
> > Subject: [EXT] Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for
> > VLAN Tag register busy bit check
> > >
> > > Overnight testing revealed that when EEE is active, the busy bit can
> > > remain set for up to approximately 300ms. The new 500ms timeout
> > > provides a safety margin.
> > >
> > > Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> > > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > Please note, you can't add the R-b tag without explicitly getting one from the
> > reviewer/maintainer/etc. Please read the chapter "When to use Acked-by:, Cc:,
> > and Co-developed-by:" in Documentation/process/submitting-patches.rst
> > 
> 

> I apologize, Serge. 
> I made an error in how I utilized the r-b function here. My intention was to explicitly 
> include you in the next version of the patch.

No problem. Just remember you can't add the formal
Reviewed-by/Acked-by/etc tags to the patch until you _explicitly_ get
one from the reviewers. It means you must wait until the reviewers
send you an email message with the tag typed in the text. Thus you
must drop my tag from your v4 patch.

Here is an excerpt from the kernel doc regarding this:

"Be careful in the addition of tags to your patches, as only Cc: is appropriate
for addition without the explicit permission of the person named; using
Reported-by: is fine most of the time as well, but ask for permission if
the bug was reported in private."

(see Documentation/process/5.Posting.rst for details)

-Serge(y)

> 
> Thanks,
> Shenwei
> 
> > > ---
> > > Changes in V3:
> > >  - re-org the error-check flow per Serge's review.
> > >
> > > Changes in v2:
> > >  - replace the udelay with readl_poll_timeout per Simon's review.
> > >
> > > ---
> > >  .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18
> > > +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > > index a1858f083eef..0d27dd71b43e 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/ethtool.h>
> > >  #include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > >  #include "stmmac.h"
> > >  #include "stmmac_pcs.h"
> > >  #include "dwmac4.h"
> > > @@ -471,7 +472,7 @@ static int dwmac4_write_vlan_filter(struct net_device
> > *dev,
> > >                                   u8 index, u32 data)  {
> > >       void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> > > -     int i, timeout = 10;
> > > +     int ret;
> > >       u32 val;
> > >
> > >       if (index >= hw->num_vlan)
> > > @@ -487,16 +488,15 @@ static int dwmac4_write_vlan_filter(struct
> > > net_device *dev,
> > >
> > >       writel(val, ioaddr + GMAC_VLAN_TAG);
> > >
> > > -     for (i = 0; i < timeout; i++) {
> > > -             val = readl(ioaddr + GMAC_VLAN_TAG);
> > > -             if (!(val & GMAC_VLAN_TAG_CTRL_OB))
> > > -                     return 0;
> > > -             udelay(1);
> > 
> > > +     ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
> > > +                              !(val & GMAC_VLAN_TAG_CTRL_OB),
> > > +                              1000, 500000); //Timeout 500ms
> > 
> > Please drop the comment at the end of the statement. First of all the
> > C++-style comments are discouraged to be used in the kernel code except
> > when in the block of the SPDX licence identifier, or when documenting structs in
> > headers. Secondly the tail-comments are discouraged either (see
> > Documentation/process/maintainer-tip.rst - yes, it's for tip-tree, but the rule see
> > informally applicable for the entire kernel). Thirdly the comment is pointless here
> > since the literal
> > 500000 means exactly that.
> > 
> > -Serge(y)
> > 
> > > +     if (ret) {
> > > +             netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> > > +             return -EBUSY;
> > >       }
> > >
> > > -     netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> > > -
> > > -     return -EBUSY;
> > > +     return 0;
> > >  }
> > >
> > >  static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
> > > --
> > > 2.34.1
> > >

