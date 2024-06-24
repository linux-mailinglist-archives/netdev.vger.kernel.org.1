Return-Path: <netdev+bounces-106135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4C914EEC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A1B28303D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB513A86A;
	Mon, 24 Jun 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8PrDb2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DE13D8B2
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236457; cv=none; b=i0997O26Q4kJekMnQTeyjN5cb9Jdnf4EtU3zDx1CkZsa2e/6BaT6HAxdW5pyK/CSszOGGZ2BM13j3yHCrgJUvV/sxenuZi2tgdyXY0Q290GvQWQAYSXTqLUh2LvyXV8mZX+BEdEVqCrA2cU/EB1+CEF22Y8D7h75t+MR7Ug59Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236457; c=relaxed/simple;
	bh=txGy3gCSjIbyRRaKtiE7F1hm5L1fe+S4+LA9f8xguOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aClCpoc1HkF3qYOVC0tFzXBgIVrBlCkrHWCStbpjWONYYGL897oUq0v3k28m1sdvU/i/CoMisLkEGRHJdb4BoP9fvYMmcksmWLnDJoII183FeFrfxb/QhMhf/cJUv4ETzlYpVradyvxFMyLsNt/bJU+/aTHEslF2VUx+Uy0AkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8PrDb2P; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso854294e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236454; x=1719841254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoBxgHYr9hPN4v84jRXzL+PKOC6QxUGVIN3I0v8h3zk=;
        b=S8PrDb2PpbjGVY967xrCjJ2ZJIBnDWG0AL4ac3gXHkQIos41+V0RjagEkRUKAt8jJP
         58oDgljgTIWt+bK4rLICWhZKQS6TJjGmNDxKCPT2lC51nPA6/eA44dgn5HOJSy/w6+un
         zuU4i5mUQJ2Ivk1XFaF+hBIIty+v1HpjMzsHfNO7+g2ol0+KoPhINr5Dgbf8f0yRbJa7
         oy9nxeeS9Avjqe3ftpneaehE6oHCPa2h+3S9O/pXTcBbfDIWPQRz9u7fWSQ604H57haz
         kATIcgVlK9x5LoJMmSWmgkAILuUseFxl98NSDYwF5NQMwNmBg96LxYQ0kf1KMBZo0+8G
         AFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236454; x=1719841254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoBxgHYr9hPN4v84jRXzL+PKOC6QxUGVIN3I0v8h3zk=;
        b=Q4gxHBfjuUlfERH7kKteIxj0wWE4jObtkgWQ4YINGEHBlBtjjsIxTYBp1gy0uCjHZg
         jO8V+8UKM2YE0KUapgiqYwWFvk0GZ1FxX9FejlQAnXUihZY27lDpZIXzLajH4lcgMiv/
         IsSziIwwdpGrzmSy33RRJ8W21e1dRG5RuY83I1yX1fh+RM0mv4pbFXHet/zrLJ+apo67
         koB9wR9gLLntm7bASfRr7JbCQqmUdbjCyP62GZaBwbm1M7VU2xWhsZrLS/0TG0eDja7s
         eoAXk0IXfbHhjiP4JymvOlXuSLtQacEtZyZCzKvlLjm650B9UoLRoNOEm+5Hx2ULlqUj
         I+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVCksV/EDXz8wcfcQEWrqL1ZttUvwNEbzCXyB0KA7J9jVPzMI/QgARgqOF7AtVFPq+IeEJtkEzJX5Fm3DJUL2BblrqdU+/D
X-Gm-Message-State: AOJu0Yw+SKh1J44Fo6MiChAs8odGXkZc8fUB3bw6w0rPL7yedRhHOaOF
	Y+kw2urXy1QLyzFh+IE6n5CC2FkShntUg3bmC+FtjLW5l8XSEskk
X-Google-Smtp-Source: AGHT+IEdFIuVzHJx5tXMOcS83RsKvbg4yJlnEnxjqXwl6RkKT2rP50LyfzeGnwSYYNBY8IgX1ijYTw==
X-Received: by 2002:ac2:47e1:0:b0:52c:df8e:a367 with SMTP id 2adb3069b0e04-52ce18526e1mr3454710e87.53.1719236453753;
        Mon, 24 Jun 2024 06:40:53 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cea4b432dsm135604e87.130.2024.06.24.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:40:53 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:40:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <kyvqil6vcpyew3he37uy6tdseqtcvutmd5h4chltwy37ddnnvz@lsvjhfynq5pw>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
 <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
 <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>
 <doeizqmec22tqez5zwhysppmm2vg2rhzp2siy5ogdncitbtx5b@mycxnahybvlp>
 <v5apa7efqvhh4yu5jnfkgtgp2ozhqyafhm7nddvdtls5toduas@7bynm2cts2ec>
 <d527jazwnhsflzqilxf2rpe363jty3srrad2b6j3imadq2xmq3@w2nk4zogxwsb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d527jazwnhsflzqilxf2rpe363jty3srrad2b6j3imadq2xmq3@w2nk4zogxwsb>

Hi Russel

On Mon, Jun 24, 2024 at 04:32:53AM +0300, Serge Semin wrote:
> Hi Russell
> 
> On Tue, Jun 18, 2024 at 01:26:52PM +0300, Serge Semin wrote:
> > On Fri, Jun 14, 2024 at 12:14:21AM +0300, Serge Semin wrote:
> > > On Wed, Jun 12, 2024 at 11:04:11PM +0100, Russell King (Oracle) wrote:
> > > > On Tue, Jun 11, 2024 at 03:25:14PM +0300, Serge Semin wrote:
> > > > > Hi Russell, Andrew
> > > > >
> > > > > Should we have a DW IP-core-specific getter like
> > > > > stmmac_ops::pcs_get_config_reg() which would return the
> > > > > tx_config_reg[15:0] field then we could have cleared the IRQ by just
> > > > > calling it, we could have had the fields generically
> > > > > parsed in the dwmac_pcs_isr() handler and in the
> > > > > phylink_pcs_ops::pcs_get_state().
> > > > 
> > > 
> > > [...]
> > > 
> > > > 
> > > > There's a good reason for this - dealing with latched-low link failed
> > > > indications, it's necessary that pcs_get_state() reports that the link
> > > > failed if _sometime_ between the last time it was called and the next
> > > > time the link has failed.
> > > > 
> > > > So, I'm afraid your idea of simplifying it doesn't sound to me like a
> > > > good idea.
> > > 
> > > No caching or latched link state indications. Both the GMAC_RGSMIIIS
> > > and GMAC_PHYIF_CONTROL_STATUS registers contain the actual link state
> > > retrieved the PHY. stmmac_pcs_get_config_reg() will just return the
> > > current link state.
> > > 
> > > Perhaps my suggestion might haven't been well described. Providing the
> > > patches with the respective changes shall better describe what was
> > > meant. So in a few days I'll submit an incremental patch(es) with the
> > > proposed modifications for your series
> > 
> 
> > The incremental patchset is ready. I need to give it some more
> > tests, then rebase onto the kernel 6.10. It'll be done in one-two
> > days.
> 
> It turned out I has created my series on top of your v1 series. I just
> finished rebasing it onto v2. The only thing left is to test it out.
> I'll do that today and then submit the series in-reply to your v2
> email thread. Sorry for making you wait once again.

Finally I've done that.
https://lore.kernel.org/netdev/20240624132802.14238-1-fancer.lancer@gmail.com

The update has turned to be a bit more bulky than I intended, but the
resultant code looks neat and small consolidated in the
stmmac_pcs.c/stmmac_pcs.h files with just three DW *MAC HW-abstraction
callbacks defined in the DW GMAC and DW QoS Eth core modules.

I did my best to provide the changes in the incremental manner with no
driver breakage. Hopefully I didn't fail that.) As before you can
re-shuffle the patches and the change they content whatever you think
would be better in the final series.

-Serge(y)

