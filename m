Return-Path: <netdev+bounces-177836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED406A7200E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D185168A13
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEC2192E2;
	Wed, 26 Mar 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuB7ipH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF0137930
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021482; cv=none; b=nxaGcaHsBC1wU8Q++XbVlXpebj1LhiXElj3E8K89bfmw8LBBL+6lHoDCXQrMYrWko73Z0Z4Rwj6Q0+LvWcz/L7C60JW7jeCUw8A9mbjRvU3zSdxYSN5He0BiuecNpoZz9rzLqXmFgy8JF7+hMsb2MX5NSfSt2V/+xlMiuyt3jAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021482; c=relaxed/simple;
	bh=bsv80saC4YRtAruQYOL7i3btQ31Y628tKi1leEfteJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxPTijmlSd7EK4eWf1JIIcoLCWO8XdMEOrwH2B6/pYA0D4b3j4LPcHlVEMjRnaohjQ3yGEvIVeajsZ7WU01P6Goj4svzP6ZGsb3uatYkBFCmGr/Pjq4MkEIlRvVPQU11KLok0us6xv3am6scNM4p3uPDJRpZMXtUI7GiVXjU1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuB7ipH4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301302a328bso388157a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743021480; x=1743626280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wZDOziDl+wlAYrzasrZTDtE0ds1SMnWLX8kiyFoieWc=;
        b=LuB7ipH45Vo14ESRiVN9okiyg86KaPdU4wvUq4TSKSIh23VBx6PPVC37vKgHvB2lm/
         HuzRC72x5Q8jYFYLikwe2ozseHNNwi0uUiCHSvqmdoesgbCiIgqEMEo0dSdUCTjX4VSk
         44Jx+b2lvZt4ssY9N1xArIUr/3tM3k1Jo5Xx5g1hIntN8AmDZhaAPh03sJbH5RAD7Xl5
         +9o3snbB/XG7tLGB/E2ZqOQgArWWiHT/uZF7o9CKHP9GR+Is/7OpOFqsvlhV/791LL1M
         hGPbYQUjYPvnxX2ackZucf+iZG3vkxKPDaUz/tfXHGs+crRz3lJeI1AQPyx3uX8Vvhlh
         kSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021480; x=1743626280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZDOziDl+wlAYrzasrZTDtE0ds1SMnWLX8kiyFoieWc=;
        b=BxiiSGX5ytrJmpT96iEJs+iBYtXpRRgq0tj3Fu1gvR6LpyUHJAExnpez+r6vr9JoEr
         isKGfeLBw0d2e5iICtjeABhVGL6r8/lP/p0IKvsigfOBHr8GKA90Ekg7wqr0dx4YbgtK
         vmVS0Xl3PCuCe5XGnroGxzUL0/k6FTL6PDmHLDM4cKCRq8rRx7DmW2WGSf7qxO0d1X2C
         SIIE2yfqU+vUgnVrixKokjnn6liqmhadP4Hqa/A0q4gIyu+4w5fko58chCPlHO+OEy+f
         VLaD/H1nnJAooWxahmlsUokC+74wOjh2l35uHU/QE7UoCTQqBHaIizs+vPZKMFpDaGzu
         vQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9dWIDEySdm1ZtNpW7U3DRKMxQ3XoYIWgzK6j8st9FpvafkDQ9p5GqsqixHe3YPMPUB+5MXbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsDAQPK5pEEsDzxoxUzjYdsA/3Vl9pCPxI4rtSmbJDs3WZcS0
	7NVudXSH3/bYqQXZT+li90/H+o/eQKDbLM/pm+LCYZ0BlgbJgZ0=
X-Gm-Gg: ASbGncs+uVKh+W50MhxdzVFFuDXRtqJ1hsLrYCmCQvMR9iQZdOUd/DtWD3+F6zSyfwJ
	vP3fUgzBdxEILVY+xTM1lwl9II76kOaadLBlF/9yY8NOt563omVRA1O3POCTA4ro0E7PE7gdEFV
	sXmZbkn4GZ0iU8Yx7mRGmJs18kuaY/XE2SnFDWlNPYX8raGtYKpQhLdsApyp6dNF2eS0Ea5p3MB
	/zP8OGb/gw3e6/itd6TATCTIxPF5r4NHdRvDqU3no0M3I70Hz4Cfr8astjJ310BBD8fynZtk0c/
	KjPg+eBPUcZ21jwwTGzBb/9OW2QIOtYxl0OxTCnjw7l4saJZfu2qPmI=
X-Google-Smtp-Source: AGHT+IGVrwfUKXLvqL9nLVebtnA/S9KIAHVbnTjjG3MpMoLgH+wT+veTulYE1OoiS5NSNd0x7zYkTg==
X-Received: by 2002:a17:90b:5243:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-303a906c163mr1701009a91.28.1743021480164;
        Wed, 26 Mar 2025 13:38:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e10baa2sm755481a91.24.2025.03.26.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:37:59 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:37:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <Z-Rlpgp3vb-zsgSM@mini-arch>
References: <20250325213056.332902-1-sdf@fomichev.me>
 <20250325213056.332902-3-sdf@fomichev.me>
 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
 <Z-QcD5BXD5mY3BA_@mini-arch>
 <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
 <Z-Q-QYvFvQG2usfv@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-Q-QYvFvQG2usfv@mini-arch>

On 03/26, Stanislav Fomichev wrote:
> On 03/26, Cosmin Ratiu wrote:
> > On Wed, 2025-03-26 at 08:23 -0700, Stanislav Fomichev wrote:
> > > @@ -2028,7 +2028,7 @@ int unregister_netdevice_notifier(struct
> > > notifier_block *nb)
> > >  
> > >  	for_each_net(net) {
> > >  		__rtnl_net_lock(net);
> > > -		call_netdevice_unregister_net_notifiers(nb, net,
> > > true);
> > > +		call_netdevice_unregister_net_notifiers(nb, net,
> > > NULL);
> > >  		__rtnl_net_unlock(net);
> > >  	}
> > 
> > I tested. The deadlock is back now, because dev != NULL and if the lock
> > is held (like in the below stack), the mutex_lock will be attempted
> > again:
> 
> I think I'm missing something. In this case I'm not sure why the original
> "fix" worked.
> 
> You, presumably, use mlx5? And you just move this single device into
> a new netns? Or there is a couple of other mlx5 devices still hanging in
> the root netns?
> 
> I'll try to take a look more at register_netdevice_notifier_net under
> mlx5..

I have a feeling that it's a spurious warning, the lock addresses
are different:

ip/1766 is trying to acquire lock:
ffff888110e18c80 (&dev->lock){+.+.}-{4:4}, at:
call_netdevice_unregister_notifiers+0x7d/0x140

but task is already holding lock:
ffff888130ae0c80 (&dev->lock){+.+.}-{4:4}, at:
do_setlink.isra.0+0x5b/0x1220

Can you try to apply the following on top of previous patch? At least
to confirm whether it matches my understanding.. We might also stick
with that unless we find a better option.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3506024c2453..e3d8d6c9bf03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -5454,6 +5455,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
+	netdev_lockdep_set_classes(netdev);
 
 	mlx5e_dcbnl_build_netdev(netdev);
 



