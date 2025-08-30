Return-Path: <netdev+bounces-218452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE421B3C77F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAC11C8120F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF1258ED1;
	Sat, 30 Aug 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQHbLrOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B15257458;
	Sat, 30 Aug 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522011; cv=none; b=CSZsRHKNVL30F5rpmCiN3iDTF7HvREuehsF3Uy0APdpkdpf4Jd06yQzY+BQUWxpsbqIqmDe0Y5utoHPdV+QDwaHehwkvBtid6l+6ijdOkHVH4w7gddZFmJwu0FC9GfTpOJJYPAD82C8Q1BLOttwRFiqZy/GzZtvm5g3NzCf5zIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522011; c=relaxed/simple;
	bh=M/4QkicDvYUqGmWDBiVXc+5oIZpBQ1ITpap2f+VH8+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3vCZ/5eKg+yKkmCJWkD1gq+rT0lak/jtzdGQeySvsOXkL+5Brf9kaatuNoJFtwYfwo86GUHq8O4nAkEhztlkjKRYF614EEAiVyWSVM3eU9uxdlKHETCncjKe2yE9M1a8KCso7EoScx1RL6h9LwJDfh82nFQ3ZpanpAuxwLYoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQHbLrOL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f42e4c3ebso2660678e87.3;
        Fri, 29 Aug 2025 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756522008; x=1757126808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmYm/w/0U9x80KlznmQYQsTzQxSzfKQGnP1/RZ25NJ8=;
        b=jQHbLrOLyDctTJL4svP/asvkZPkhtUnQvefgM7q0dZoFahE8cXvEWe1SNy0NV0ONAC
         BjxGv2kk7C84z3urJ260OM/fmZYtNXvt/eZ/sZNrCVqcoXLrwqRL7qTgEAjgy9odiafR
         MXBNhcZp5nv/LSU9yyjdiy+eX6QNJScAyaVAUwtW+fcukdbcPnghjY/+HaPeK57y63HM
         3u/g5QWJ3aN1Ub9JzSVIuo+DeJrB2nHK3/Iji+ODzdx7RtXKIxu0G0T+dHjI2plD8DYj
         kD2niQtrygodMSqK9wG5udx90aUNemOReQMgjG298iYPPD40+1w6L08U3ftqV5VtnIcY
         T9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756522008; x=1757126808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmYm/w/0U9x80KlznmQYQsTzQxSzfKQGnP1/RZ25NJ8=;
        b=lDaQevIQ0OPjZn05HrcxZH25fTCUK2wXU7ZyXNRuVQ3oqOF0idTqp2XJzhyIom6Yqe
         TCY5ROwkmeftMW3MfXRGMAok6vcJutfy0F52TdbH76QMPPbi1C1VaZq2q5Zer2PAu95M
         b+zaShjvaIPeBZqyir+SL8xRH14Qz8cqMW+H5QOLzyu/1+Br5zO824bm+1oR1FlpxS47
         CTmFDif5ksG2z7GgEFz3Nh+n62AQ2Eh7aPQEeROBV1Ak1WK6E7XuvXjawtAnCtdL/iYd
         /2y2M7r5mETav+hC0e/TIwZcC5N8221hN4jL3rwCr6vty67jVadpZ14IZrL9QJg62but
         JWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWYl+Iq0op3gmKHFqGjhXDXVD0pblzhDW2bWh3AwTHlWpG6dz++F9Z1xwi0pyfkEQ9Hj4mRY9+M@vger.kernel.org, AJvYcCX+gMcI+2nKtunxrgylmyiPhVwk3dR9+b53XwOsv3IeY+3unCJLM1lohZeN9ZeNy0nuVt0SE8Aw2vZYavw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhE6FkoC1jYzZe3r8MMolWW3FmdqXfnMNzRr/Iuu7VU+l20WRt
	h3gZPeTEa4ezbG7v27DZLa/NUICMf5SoSg3TCEr6IYjp8GnQPQpasUwh
X-Gm-Gg: ASbGncvkJYgFY94bPymggT7kZyMnAOJebqnlTnihxWmWBvHDKJzGSO3z+UYWCb396wc
	RkE4YyFJvWbs00KeQ2UWWyPHqp2AVnISbN9/SwaPYQtfWdhAXeqLaAFVfYD/7iS1xadvj0R9rv7
	lOEL/Nl8PnSb/f20Y+2tqCUnw3CpzykMBAiOlbDchSh/Qqu4pFKjvs/R1r0rznPttti2KEEWYCI
	DHQP577Kgh6veqydviPVzW20aioTUaRq6RFm7R1sGHa/PLxsf5IB2V546uiWBvstfFRM44KY4mR
	mhcKI2Ec82PQ7cAhar1+aMPShFlnAtcg0fE/yBHXMi/zMHGN65IbzJxMbUXdULjQoO1/3bSHjxv
	Fmwb6ryqOuGIp8SGL0gAIuLrNUpzu
X-Google-Smtp-Source: AGHT+IF7Bd3fOlKc+4Unr2H9zCn176zOAJFKTSA5Ek59ur+391TFMRcuvi5wSkVXt9jLGMIoN48gEw==
X-Received: by 2002:a05:6512:3ca4:b0:55f:47a9:af43 with SMTP id 2adb3069b0e04-55f709bda67mr172719e87.57.1756522007876;
        Fri, 29 Aug 2025 19:46:47 -0700 (PDT)
Received: from mobilestation ([5.227.41.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678450f5sm1067153e87.73.2025.08.29.19.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 19:46:46 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:46:43 +0300
From: Joseph Steel <recv.jo@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com, sebastian.basierski@intel.com
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
Message-ID: <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>

On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
> 
> 
> On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
> > This series adds four new patches which introduce features such as ARP
> > Offload support, VLAN protocol detection and TC flower filter support.
> > 
> > Patchset has been created as a result of discussion at [1].
> > 
> > [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
> > 
> > v1 -> v2:
> > - add missing SoB lines
> > - place ifa_list under RCU protection
> > 
> > Karol Jurczenia (3):
> >   net: stmmac: enable ARP Offload on mac_link_up()
> >   net: stmmac: set TE/RE bits for ARP Offload when interface down
> >   net: stmmac: add TC flower filter support for IP EtherType
> > 
> > Piotr Warpechowski (1):
> >   net: stmmac: enhance VLAN protocol detection for GRO
> > 
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++---
> >  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
> >  include/linux/stmmac.h                        |  1 +
> >  4 files changed, 50 insertions(+), 6 deletions(-)
> > 
> 
> The series looks good to me.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Not a single comment? Really? Three Rb and three Sb tags from Intel
staff and nobody found even a tiny problem? Sigh...

Let's start with an easiest one. What about introducing an unused
platform flag for ARP-offload?

Next is more serious one. What about considering a case that
IP-address can be changed or removed while MAC link is being up?

Why does Intel want to have ARP requests being silently handled even
when a link is completely set down by the host, when PHY-link is
stopped and PHY is disconnected, after net_device::ndo_stop() is
called? 

Finally did anyone test out the functionality of the patches 1 and
2? What does arping show for instance for just three ARP requests?
Nothing strange?

So to speak at this stage I'd give NAK at least for the patches 1 and
2.

BTW I've been working with the driver for quite some time and AFAICS
Intel contributed if not half but at least quarter of it' mess.

Joseph

