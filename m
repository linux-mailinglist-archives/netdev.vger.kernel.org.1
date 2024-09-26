Return-Path: <netdev+bounces-129889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A8986DD2
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CACD1F22745
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1418C357;
	Thu, 26 Sep 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XACVNiUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556917BEA0;
	Thu, 26 Sep 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336293; cv=none; b=S3ciCIec9gkpYz/v66UgeFoeiQNZoZevQUhdNg9thwFxFI44EqJgo1ocHbnispB4aXYFbyP6yGMWRKplyWrgpCWUK5PGDPdEr6Ow6F+7Bk7nia8VqGozjWCTYefwAFv3NGlA09q970G+YwKLuLw8PTRGuKWZfuGG8H5uGf/Dwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336293; c=relaxed/simple;
	bh=Dp84neu+vynjrTHf4i2W8jzAHHaFlisszl3hFMQ+ZCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hubvWkI7Eebr4804YBNcfBbmre0ENitCZoLPM9s65Kvp+urcFd0GVSalImckDaiKcRu+o+6XT1uctAeCpNOj3whDCAOGQbEJob9b3elEJFiJuHjOdLO7VyU1S/Sw2hgqNs/Hw4hieHjPiDPM0A5JYBNR7Yeda3CUJR9eJ27sdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XACVNiUn; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-502b405abb1so209689e0c.1;
        Thu, 26 Sep 2024 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727336290; x=1727941090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sjsal3XJocRUMBEqC7eulF6D2Ki2TAvQnVssNUiGcw=;
        b=XACVNiUn1whigOkUBEi4SjQuu4pHLAdIm6Bq8M/My7muR1h3j53BNqlUY6/uS6XiMh
         oNSPrzJnVz5HTvRvPREQQXLTftbZn8WEUkNzDyXF+Vu4oymHHcE8ziyiRy4V8VjPP+v3
         pdLZH3jwDj6zAp8yMs+3T/U+13kYu6lkP3DVuIml8VpLmAq8Y/n7vv5mDEcCW+WR0hk0
         U3z4MsULkgGIJq6mUXWln8WAs2hG7hDnUwS9APPsGWmH1hTsJE/UcJ2vX8NUVY0hXM4p
         WrHeD0x912+jXgMPr8BOqjwKquM1FYc/h2gn0qCgbOlw3/rDjud44fzIFgkewbYTD/3U
         augA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336290; x=1727941090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Sjsal3XJocRUMBEqC7eulF6D2Ki2TAvQnVssNUiGcw=;
        b=uyBsB2t+0i3C387QitbozQHsRom2OHI6AabhQ1EaZ79CGb01400fcSZyLCpinXoAqG
         uLDDgVQTxoMSly+TnFzvPaLF2UAAXCW6+snnF3Yxaz+V7yclDLkoYLGkPapQyc+jJPTF
         T+zcl43f+D17EVYfPNdS2Z4h9kSCDxjTfgoudj1yvxxq3PBhyUqELAwbb7PTb7bB5k10
         j2eVaWBhDW+KChBjlHYpxjWBbJ04IJK1tefwD3aDWcNb3rhhKDBMwzVJxFjMLkD2MnuC
         5x0orwMCzWsZTzAxTf3cUvwasVMM+CqdZI4F9JYntY7e1km8GMzcE7jP3RAH9EYm2kQn
         /Syg==
X-Forwarded-Encrypted: i=1; AJvYcCVdNc+JM+6a4t6sw9Lme3GgolCWRO6MKWaxiXn0elsKHCwmmFa6KXBJd7uV2LroX8bslP/8OaAtV9zS7vg=@vger.kernel.org, AJvYcCVyLo5bDLpHMkltHJz0NpEuFshUJKuy6rq1aC3xKCMQ3RAxYuzuBfdHNuxr7gNskHtolG+hX628@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtg+J2kycVkkZ+iyS39JRFmI9pQCcgb1aEQTyXY+x5RjhSxiQA
	xmGAzESmmySU6ScExXgk3oZ053msT5cPpWAjSMEWfCr8NBfOKiO0nD2sarkqD7kACkJ5d6L/kkG
	ZzPfyqYAcdG88awJIiStwSfTwOiE=
X-Google-Smtp-Source: AGHT+IFj2qGMlB0QH3Dqyg4frcCkP6Mef6gndDSEa0u4i1FL0L4exkBq3DgOBe9Ju/ytkZ8G65IMhPNdYUkIInlXxsY=
X-Received: by 2002:a05:6122:920:b0:503:9cbc:1c9e with SMTP id
 71dfb90a1353d-505c19b3481mr4733943e0c.0.1727336290249; Thu, 26 Sep 2024
 00:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925152927.4579-1-kdipendra88@gmail.com> <202409261447.R2kfrGVq-lkp@intel.com>
In-Reply-To: <202409261447.R2kfrGVq-lkp@intel.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Thu, 26 Sep 2024 13:22:57 +0545
Message-ID: <CAEKBCKOmtF8QFnpC_9rf-uKyLa6We_oR9UfuN4C-y99GLswciA@mail.gmail.com>
Subject: Re: [PATCH net v4] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
To: kernel test robot <lkp@intel.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	maxime.chevallier@bootlin.com, horms@kernel.org, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I will fix this and will send v5.

On Thu, 26 Sept 2024 at 13:06, kernel test robot <lkp@intel.com> wrote:
>
> Hi Dipendra,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/net-systemport-Add-error-pointer-checks-in-bcm_sysport_map_queues-and-bcm_sysport_unmap_queues/20240925-233508
> base:   net/main
> patch link:    https://lore.kernel.org/r/20240925152927.4579-1-kdipendra88%40gmail.com
> patch subject: [PATCH net v4] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409261447.R2kfrGVq-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261447.R2kfrGVq-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409261447.R2kfrGVq-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/net/ethernet/broadcom/bcmsysport.c: In function 'bcm_sysport_unmap_queues':
> >> drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: error: expected ';' before ')' token
>     2401 |                 return PTR_ERR(dp));
>          |                                   ^
>          |                                   ;
> >> drivers/net/ethernet/broadcom/bcmsysport.c:2400:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>     2400 |         if (IS_ERR(dp))
>          |         ^~
>    drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
>     2401 |                 return PTR_ERR(dp));
>          |                                   ^
> >> drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: error: expected statement before ')' token
>
>
> vim +2401 drivers/net/ethernet/broadcom/bcmsysport.c
>
>   2389
>   2390  static int bcm_sysport_unmap_queues(struct net_device *dev,
>   2391                                      struct net_device *slave_dev)
>   2392  {
>   2393          struct bcm_sysport_priv *priv = netdev_priv(dev);
>   2394          struct bcm_sysport_tx_ring *ring;
>   2395          unsigned int num_tx_queues;
>   2396          unsigned int q, qp, port;
>   2397          struct dsa_port *dp;
>   2398
>   2399          dp = dsa_port_from_netdev(slave_dev);
> > 2400          if (IS_ERR(dp))
> > 2401                  return PTR_ERR(dp));
>   2402
>   2403          port = dp->index;
>   2404
>   2405          num_tx_queues = slave_dev->real_num_tx_queues;
>   2406
>   2407          for (q = 0; q < dev->num_tx_queues; q++) {
>   2408                  ring = &priv->tx_rings[q];
>   2409
>   2410                  if (ring->switch_port != port)
>   2411                          continue;
>   2412
>   2413                  if (!ring->inspect)
>   2414                          continue;
>   2415
>   2416                  ring->inspect = false;
>   2417                  qp = ring->switch_queue;
>   2418                  priv->ring_map[qp + port * num_tx_queues] = NULL;
>   2419          }
>   2420
>   2421          return 0;
>   2422  }
>   2423
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Best Regards,
Dipendra

