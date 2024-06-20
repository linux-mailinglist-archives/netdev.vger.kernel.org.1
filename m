Return-Path: <netdev+bounces-105179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5390FFF5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D58B26641
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE517CA1B;
	Thu, 20 Jun 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhqY7oNN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39A19AD9E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874537; cv=none; b=TjrgMEK000938biSuouBw5/aquQuN+sgvI+FR6jBq3aj+LLnlu0V8wf2A4Q84eEBM0x6jPH+jQCI1NJqj5R3mWmTtxWv95jhV4rX9zlqF0wClvn5h8z8x9ge92+XMwYe5dO2TWZoRCUZstOiZpLibjQnRuuyi5SMHjaJDFR0FyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874537; c=relaxed/simple;
	bh=cwaOPvQO2c30Z5Ix9gC7PbMmJqdNz/ZnsKJ1wwZeHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1E2NH7iwa7HU2iKVQq9MlYgAQDU3o8WU3VHutmaHtxAFU+OhAmobKpN/COxao8mIh/A1uU+BO7yPqZGLVpxBtYrVn5M3wB6RgBgUrvgotbIC8+nfqeWxMRXpVeoTKCT+Y1x3mnZ+tpbHNv9xn3mNi5Z0h4dZ8K5EWY+wYzfO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhqY7oNN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25cb994dbfeso265995fac.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718874535; x=1719479335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6HQFHkw2SlKPud0RedsY3aO4LxuICENBnB9Qp8Ea5E=;
        b=dhqY7oNNFBtKVcCqCaTzO90a5wMCBzVIg7PFUogQVQlmTxXihGoMdVCz7Z6SoePz6c
         shhNSNNAFMohWDMOGljXL1AKWsE6Zzaz9BMDx80+cVTyAUOO/BBYdtpLdLcoMNSwjeBO
         QYO5denWwOL5Ugmb8mFVqcTc+LduIb5cc6TWKaGrGYC2F2UiE/13EMGZcQpzo3ttbULY
         Jb0k68O3+pkKUlTlQDgWnzQbXqdnC9CbBcSXNNoMTW552W5cYt1mgdf31HLUNzQcmvAo
         07iN/QzCI8v9Xdtkh7E7muTQO7Qa5umq71vvt+Rn6+MybMqnZpYq7UieAgWJRP3xDVJa
         Arig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874535; x=1719479335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6HQFHkw2SlKPud0RedsY3aO4LxuICENBnB9Qp8Ea5E=;
        b=hZZ5YKiCMfsGqFK9JkTJwZB4M7co6PBv8mSP55H4GBMfSef+yjKT/zM8rqAfj7WgnF
         6IqBvZRsKozF2X3gyZioEWQg3k67dAjq776CLNghNbyseJ/3xkVeymWGgTfUCd+UVM67
         D9l0ltAjesnbTtnsipWkCitlH1nffqTOmxZYkmpzYmV4BuoUOaz78jkhqKjefQz2Vsf/
         jFg87lN2vcpJAc5Qnzx9uh0PDZucWgIcXd2jHD6m9PoQ3LM+bSKLfH2xAJXWsn7xVDca
         oaWlh8FuDpn3WAw57PNZompi467wwM3pth7usJKI5CoIVUpMltZvreFze7SClDTWqiz5
         PClw==
X-Gm-Message-State: AOJu0YxzHn2K8PawKRSAQVR7O8PjLYj1/1fE8d5FP88BLJ/hyTUk8K1S
	YBuU5UuouLnEBqimA+8u/YwloVaxlJQ1ZWuoCCeLntNqfqKgv1yj
X-Google-Smtp-Source: AGHT+IHBiBwVXPX/JD4Aushu3jSZPb/Kgv8ptMNYW0vd1Gc5+0+2AB/UqMRDbo0nyq208WXAA47gXg==
X-Received: by 2002:a05:6870:a711:b0:25c:483d:b90d with SMTP id 586e51a60fabf-25c94d08934mr4938569fac.43.1718874534696;
        Thu, 20 Jun 2024 02:08:54 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96aee8sm11925646b3a.73.2024.06.20.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:08:54 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:08:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCH net-next] bonding: 3ad: send rtnl ifinfo notify when mux
 state changed
Message-ID: <ZnPxoFXHKQ5dAq5K@Laptop-X1>
References: <20240620061053.1116077-1-liuhangbin@gmail.com>
 <1b9fd871-e34a-4a7d-b1d3-4f3fd8858fa3@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9fd871-e34a-4a7d-b1d3-4f3fd8858fa3@blackwall.org>

Hi Nikolay,
On Thu, Jun 20, 2024 at 11:47:46AM +0300, Nikolay Aleksandrov wrote:
> On 6/20/24 09:10, Hangbin Liu wrote:
> > Currently, administrators need to retrieve LACP mux state changes from
> > the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> > this process, let's send the ifinfo notification whenever the mux state
> > changes. This will enable users to directly access and monitor this
> > information using the ip monitor command.
> > 
> > To achieve this, add a new enum NETDEV_LACP_STATE_CHANGE in netdev_cmd.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  drivers/net/bonding/bond_3ad.c | 2 ++
> >  include/linux/netdevice.h      | 1 +
> >  net/core/dev.c                 | 2 +-
> >  net/core/rtnetlink.c           | 1 +
> >  4 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> > index c6807e473ab7..bcd8b16173f2 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> >  		default:
> >  			break;
> >  		}
> > +
> > +		call_netdevice_notifiers(NETDEV_LACP_STATE_CHANGE, port->slave->dev);
> >  	}
> 
> This will cause sleeping while atomic because
> ad_mux_machine() is called in atomic context (both rcu and bond mode
> spinlock held with bh disabled) in bond_3ad_state_machine_handler().

Ah, that's why we call the bond_slave_state_notify() after spin_unlock_bh()?
Where can I check if call_netdevice_notifiers() would sleep? So I can avoid
this error next time.

> Minor (and rather more personal pref) I'd split the addition of the new
> event and adding its first user (bond) for separate review.

Hmm, with out using call_netdevice_notifiers(). How about just call
rtmsg_ifinfo() or rtmsg_ifinfo_event() directly?

Thanks
Hangbin

