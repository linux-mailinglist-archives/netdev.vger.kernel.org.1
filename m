Return-Path: <netdev+bounces-134407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316159993B3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FE31F231C3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAF1CBEAB;
	Thu, 10 Oct 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwVrSsJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE319D064
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592288; cv=none; b=jHjzoKgU0yTfzVbbWEeMGXVrMhub7tiLH5Qkh46rkcs0ksm0xAuYGzRaMBSzAKiCzuSL+NAZnIryqVXTwjqLF5qrD2nCPEfdfBzONfMywjA/DZbFZRjdYEXkfVgc1PA6IWOYDyYFgJW5DRSuzNcPDT2iSB5U/y3I366RoRS81wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592288; c=relaxed/simple;
	bh=Ki232wUFcvOlwGHjlwA3DQLGm72SvsI0YLACOtetnZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4pPEUXie6bODLpMRKl42tlFMIxQ2VxGAV5eD9lqGy4sjWgbIriw5lORwIyyk0FfutZPuNg8uVg+TZ2lywb9ZJ5z0ggQf5VRp0/1k7j0qNhaH2Pe8TJ9Hq2V3xam8QWqIBXQfDe7+2K1xSrlTJeNqH2dxhl0B+E9SuhWwqBAeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwVrSsJ4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac60ab585so13392601fa.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728592284; x=1729197084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3k2MWb0seFKuo7cYNb8ZHsjG7JTps9V/jxdBLKOq6XY=;
        b=mwVrSsJ4qRVsKuHQdrBeiYj+cwi6j2W/DuQzNHmovbssZwzRj1PPwUr6qoymbf0fFT
         afr7cnD4vKtoky6jPOBKHOPPBrp43ZAUVGvjSvza+ClbsFeELNTgzPQkOav/8yKfbYUx
         RF0sQP+IEpyoi9xYn28+tPYJzqSHMokBBNuV+Mhsy50eDjNks8Nh02Tkvfiw91mD7Jxk
         N9wYSalAi1X+hucY4pjwGpV6Yr4KR0lR8kWsAuLtNz4psPhg1lWiP7N1s8w2miKmmBLi
         eEGZ+Mu2SbxqHgagshJsw0TGsADoLK6May+kxADmmj8vaaBq+CFw/JYb63PnzJz/3zlC
         rLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592284; x=1729197084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k2MWb0seFKuo7cYNb8ZHsjG7JTps9V/jxdBLKOq6XY=;
        b=ojk8A0g38gFax+woeoEfKdw/8O+NTICqgemGEDeq8cOjgms0WXmJommHCBSHwFyxAw
         x2SHYvszUJX6v6vdGf0UeZjQNc966IkZ7h0TE1CQA2mMp31ybg1sTMYddnadUXu+wHNd
         BPw9PGSXRijZIKY0fMGYQrmBNpyq6lA98HfiieYwuvOxlZG+isRAdNoGrZp2bkzIACD1
         /zk/s2+DuTGOEnPlGNDfWtwEna0X+gH4NIlE4rBqkdDvLP9bsdnKd1ym4126ZbEvI46y
         Zhlf+dFCVcXW4odnejaUhRQZ/vubq1A3I+rTkjdq/i4uXzPf0V+P67vv3ij+XT1mPDy5
         U94g==
X-Forwarded-Encrypted: i=1; AJvYcCVsdK/Fi1qX/24BhSylQvF6H9NsubpIp0TtxgOnLrcDqCRp1vDRRep33CQtrW8xYs5OIMLLd0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FyxjrTXDsxIfpa5Cey7Gsr5FnWmZfZMJ51tErjFKHwlAXoGC
	CZWr1CwJVtA+Xgq95iMMr/n8l/keY4AzF5uYbsvHrMSOdVAGwUaS
X-Google-Smtp-Source: AGHT+IFICGzObqMtyDecknzLwhoDgga4CQl0AhOmnVkzq/uPaeTdp0l6NSqKfI/08veuxhT9YaiAJQ==
X-Received: by 2002:a2e:b894:0:b0:2fa:c014:4b6b with SMTP id 38308e7fff4ca-2fb32b014b6mr155571fa.41.1728592284063;
        Thu, 10 Oct 2024 13:31:24 -0700 (PDT)
Received: from mobilestation ([85.249.18.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2457983fsm3088341fa.27.2024.10.10.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:31:22 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:31:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <6x6ysomjef4khxhaflggtyzqca3rwxh2f4wifmbddm3pjasbbz@fc3wingdcoeh>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
 <vjmounqvfxzqpdsvzs5tzlqv7dfb4z2nect3vmuaohtfm6cn3t@qynqp6zqcd3s>
 <rxv7tlvbl57yq62obsqtgr7r4llnb2ejjlaeausfxpdkxgxpyo@kqrgq2hdodts>
 <ZwZMglQLdg-5XPwm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZMglQLdg-5XPwm@shell.armlinux.org.uk>

On Wed, Oct 09, 2024 at 10:27:30AM GMT, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 03:02:46AM +0300, Serge Semin wrote:
> > On Sat, Oct 05, 2024 at 02:40:42AM GMT, Serge Semin wrote:
> > > Hi
> > > 
> > > On Fri, Oct 04, 2024 at 11:19:57AM GMT, Russell King (Oracle) wrote:
> > > > This is the second cleanup series for XPCS.
> > > > 
> > > > ...
> > > 
> > > If you don't mind I'll test the series out on Monday or Tuesday on the
> > > next week after my local-tree changes concerning the DW XPCS driver
> > > are rebased onto it.
> > 
> > As promised just finished rebasing the series onto the kernel 6.12-rc2
> > and testing it out on the next HW setup:
> > 
> > DW XGMAC <-(XGMII)-> DW XPCS <-(10Gbase-R)-> Marvell 88x2222
> > <-(10gbase-r)->
> > SFP+ DAC SFP+
> > <-(10gbase-r)->
> > Marvell 88x2222 <-(10gbase-r)-> DW XPCS <-(XGMII)-> DW XGMAC
> > 
> > No problem has been spotted.
> > 
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> 

> Thanks. However, it looks like patchwork hasn't picked up your
> tested-by. Maybe it needs to be sent in reply to the cover message
> and not in a sub-thread?
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=895512
> 
> Maybe netdev folk can add it?

Yeah, the tb-tag hasn't been added to the commits either:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=bb0b8aeca636373a9136a7a5b7594031c7587c5e
Likely you are right and the patchwork just doesn't detect the
sub-replies tags. In the meantime the b4-tool does pick them up. I've
just tested it.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

