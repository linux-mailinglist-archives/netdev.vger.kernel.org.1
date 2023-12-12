Return-Path: <netdev+bounces-56419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65980ECB6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941761C209D1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B560EE3;
	Tue, 12 Dec 2023 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbrVF5Je"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4BA8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:01:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso576249266b.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386071; x=1702990871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhsqA/WEr7cNT5Nn38qo57OkX3gug5wr3eaF5XgiiRM=;
        b=ZbrVF5Je1dFQxgaO4lqxGFtdO80qZwmYcGig2uAju4cTP4j9xACczd8ocr/BG3P4IR
         XuIxvwJYs8S8M4r54i1ntQOsNf3SxRIOWrLdJJW58cGlMQrJpQnmNRnRDmeOHa0JSdcG
         kk6gnzwB6Ln6Aoh8OOcDyWLG9G9mrcYnUXCqtnFAcX9kxnPf72eW5aOIuD4KWzGhzgoA
         ymt54yWZF9E7Za9l8arR2R32GPBcMI96zTd+tierKBD52C0Mcdz8ePijI/UaI3QXGCX1
         qJ+tdEoeUWu+FWXykrWSxHRccIo4N+6ZJC47kqsNQWRXWQhe/KvPrJbIBsKIAW8QyssS
         Pl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386071; x=1702990871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhsqA/WEr7cNT5Nn38qo57OkX3gug5wr3eaF5XgiiRM=;
        b=BPN9Chr7uFu6y+7zI4Whh3wAxkm9fJ7Hyg6FkxtLrai8UsRCi0/fMn7FOR+QuunprW
         dzWYyD25z2J6teG6s5ykSQ9bblC0tBbylaTrICgU0idOTH9NZi2xSzVE3brsnjr+0uhh
         is41nd7x0VK0MepTB2o/D0X/8vYCSW2I0AfD8IguoWjKFPd9CecQmy/Ks5yiqSgdtIVZ
         ID8w9uNHfDAqOl/SZu93T5Xz4k+oMbnLj67dtduRo6vPPDL722pwlbxOQeuvyb/stFkf
         s+KY5r7Sm1CUXsdu7O0RZOsEnxaNE08wdQBWh/l+Nh36M3E8y8PvMs3kLI/ov0r7ImkH
         +wEw==
X-Gm-Message-State: AOJu0YyfwaA7fcMV5mwVDTgz2ZyvprS6h1rUcK5QYmbGt6jQIKtG5zOg
	2bwVLGQrwiwcGtO3sOHIA8Y=
X-Google-Smtp-Source: AGHT+IH5GFM0Q8RDrSuyjaoykZ1g2gbWB/1kKrD7pP4+ax6FsXoTSD35s1kLFJYg8hiYS/vur2sPFw==
X-Received: by 2002:a17:906:5354:b0:a1d:ac16:a842 with SMTP id j20-20020a170906535400b00a1dac16a842mr1447221ejo.132.1702386070668;
        Tue, 12 Dec 2023 05:01:10 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id se13-20020a170907a38d00b00a1fa6a70b92sm2574797ejc.111.2023.12.12.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:01:10 -0800 (PST)
Date: Tue, 12 Dec 2023 15:01:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Message-ID: <20231212130108.sogzte7ktmdu7vti@skbuf>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
 <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
 <20231211153054.vpgbx7oufazujtzf@skbuf>
 <CAJq09z7dTa3wB48aE0CkskvcE0vx5nM6VNzBtZzBGqTFxaV0CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7dTa3wB48aE0CkskvcE0vx5nM6VNzBtZzBGqTFxaV0CA@mail.gmail.com>

On Mon, Dec 11, 2023 at 06:07:56PM -0300, Luiz Angelo Daros de Luca wrote:
> /*
> * MTU change functionality. Switches can also adjust their MRU through
> * this method. By MTU, one understands the SDU (L2 payload) length.
> * If the switch needs to account for the DSA tag on the CPU port, this
> -* method needs to do so privately.
> +* method needs to do so privately. An MTU change will also be
> +* propagated to every CPU port when the largest MTU in the switch
> +* changes, either up or down. Switches with only a global MTU setting
> +* can adjust the MTU based only on these calls targeting CPU ports.
> */
> int (*port_change_mtu)(struct dsa_switch *ds, int port,
>    int new_mtu);

If only this comment were correct. In cascaded switch trees, we may have
switches which don't have a CPU port. Do as instructed here, and they
will not program the MTU to hardware.

> Do we really need to expand the API? A new ds_ops.set_global_mtu() is
> just giving the same but less specific info as
> ds_ops.port_change_mtu(). I prefer to work in an API with fewer
> functions than more optional functions for each specific HW design. It
> just makes writing a new driver more complex. The code in the DSA side
> will also be more complex with more code paths when only
> set_global_mtu is defined.

The alternative is distributing that complexity to individual drivers,
with more chances of getting it wrong. Let's be honest about it, that
has happened.

> If setting the MTU multiple times is a problem for a switch, the
> driver must keep track of the current global MTU value and do nothing
> when not needed. In the case of rtl8366rb, the MTU works in specific
> ranges. In many cases, changing the MTU inside a range would not have
> an effect on the switch (although the code is still writing the
> register with the same value).

It's not a practical problem except for the wasted time baked into the
design. Just worth mentioning. It's a slow path anyway, not a big deal.

> > If the chip uses set_max_frame_size() - which is not per port - then it
> > will accept any latest value, and not look just at the largest_mtu.
> 
> It might just work as the latest value will be the CPU port that is
> guaranteed to be the largest one. However, it might temporarily lower
> the global MTU between the user and the CPU MTU change. In order to
> fix that, it just needs to ignore user port changes.
> 
> > b53_change_mtu() also looks like it suffers from a similar problem, it
> > always programs the latest per-port value to a global register.
> 
> Latest will, in the end, just work because it is a CPU port and the
> MTU the largest one. Maybe the sequence could change in a
> multithreaded system but I didn't investigate that further. Anyway,
> focusing on the CPU port would just work.

The calling sequence in dsa_user_change_mtu() is single-threaded and
starts with dsa_port_mtu_change(), which is the cross-chip notifier
that programs all CPU and DSA ports, and ends with the direct
ds->ops->port_change_mtu() call which programs the user port.

So I hope you now understand why I'm saying they are buggy. No "might work".

> > So I guess there is ample opportunity to get this wrong, and maybe
> > making the global MTU "core functionality" is worth considering.
> > As "net-next" material - I think the bugs are sufficiently artificial,
> > and workarounds exist, to not bother the stable kernels with fixes over
> > the existing API.
> >
> > Would you volunteer to do that?
> 
> I don't believe we should expand the API but I will volunteer to
> update the port_change_mtu comment if accepted. I can also suggest
> changes to other drivers when needed but I prefer to not do that
> without a proper HW to test it.

With N drivers trying to save the same problem (working around the same
framework design), but in subtly different ways, the responsibility
moves to review to make sure they are all correct.

So the options for switches with global MTU are:

- keep an array of MTUs per port, calculate the maximum, program the
  maximum. This is what RTL8366RB does, you don't like that.

- reverse the calling order in dsa_user_change_mtu() between the
  ds->ops->port_change_mtu() on the user port and the dsa_port_mtu_change()
  cross-chip notifier, such that the order is accidentally fine for
  mv88e6xxx and b53. I don't think this qualifies as the "core
  functionality" you've been asking for, so let's move on.

- only act on MTU changes on the CPU port. A few drivers do this,
  obviously it works for them, and their reliance on the framework is
  reasonable. You're suggesting this as a workaround worth promoting
  to a recommendation in include/net/dsa.h, which won't be a good
  recommendation there as-is.

- ignore MTU changes on user ports, implicitly acting on all CPU and
  DSA (upstream and downstream) ports. Functionally ok as a general
  recommendation, but no driver follows it. You seem to be reluctant to
  make changes to drivers you can't test. The risk with both this and
  the previous option is that developers don't realize they need to
  perform the workaround.

- add a new ds->ops->change_global_mtu() which is called once per switch
  from dsa_switch_mtu(). This eliminates the back and forth between the
  driver and the framework. It would make the framework a bit more
  cumbersome, but the drivers generally simpler, except for mv88e6xxx
  which needs to implement both ds->ops->port_change_mtu() and
  ds->ops->change_global_mtu(). But even there, one needs to consider
  that the chip->info->ops->set_max_frame_size() call path needs fixing,
  and we'd end up having 2 call paths (one returning early for user
  ports) within the same mv88e6xxx_change_mtu() function.

- add a new ds->mtu_is_global bit, similar to ds->vlan_filtering_is_global.
  Document that when set, ds->port_change_mtu() will be called once per
  switch, with an invalid port argument which should be ignored. It has
  the same advantages as the ds->ops->change_global_mtu(), but the
  dsa_switch_ops API is a bit more quirky to save space for a different
  function pointer.

