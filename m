Return-Path: <netdev+bounces-130530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9098ABA7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B61F21E7F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651741990BB;
	Mon, 30 Sep 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbIQQmTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DE192D7F;
	Mon, 30 Sep 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719679; cv=none; b=S15qyLlQuiZDU9goRS8BAllnFgACuzr6nz8LLCQmG+RIGnW3S6ngX7CmIib6YPJplOxikb9anWOBgNf1hjk/Ri6VuoZ6pfxJ+W31QtUch7GE8n4yezXlX9B7qxDCSW8S0ttmybJJwt6ngSSvViJI+YafnTVrWpZQV02B6Xvzdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719679; c=relaxed/simple;
	bh=2yfjV0n2fQvSlVYlX7wNns3lLhJSYJ3XV83Nw0ib6YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti/tq+bg3I6tapCLt+8zCjGRiX3ZSrT8chKLUTTYQdD0emeJj6GPyJa+dhCyQ11SxyhJgpUG8fl+fk87Iiv34+5+T0VUFwFyYJVh7Wdh6ZLLiHR830gavemzFyjAwfMTjp2sYfEn3YgMy6eZGB8VEmlzCb1o5Rtf3Mc0eyx7uFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbIQQmTB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5094e0c0d71so490466e0c.2;
        Mon, 30 Sep 2024 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719676; x=1728324476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wFYcYi1x+ZrQ9uMGVi8n5XM09/Rz/A0sPv6fdkzgVU=;
        b=AbIQQmTB28EQPewHDGrcccqgJ3qwJAwEo0PEDVPI7u1kaGt10hCvcn+cTAs10FOhmt
         +AxOSaXsXV2Y1bcT416NjaVkOaHnYtDofs+6O/C0p7MAO/UiZ4/tz7mnvQENv5qw/q2B
         WAAng6VWdVQPoDaQKE17fNQkPzR/8VYkpRaWXagvAQ73T2IucznpF2npHY/cxznwGNDb
         cN+rOhNAptBbKBldvc5h88mGLJ2QlgSCVvFbtcGM6esIOQAe6LaqgPytlKcBXal73zij
         +puMyI0vGL/llj3lx3aLItJFUaJKNEED6x4gIGu5uif0UGk5hAZrO4jn+IjrHdbliArK
         4Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719676; x=1728324476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wFYcYi1x+ZrQ9uMGVi8n5XM09/Rz/A0sPv6fdkzgVU=;
        b=M78hsBG8dptVUGKbxfKUrxxS7sUtLSbtmPITXxz2viqQIPsDsQ92dZS/uWlSa7sWKl
         jWeNOpyiyKM5ds722/IgjgRA/qAc1GFxl7270b4fw08zuJxoZmJHYH0pT/OHR+Aeszz4
         idUjkisLiQhekXGT8pXJ7GU4xv0T0957c0NhaRYncEBaBoSwHY+NvaDgyBkH7+wxGdmQ
         /OhPr/WCHt0yttdlxMttCMn593hLus4AqojVCy1N7XcTaL2Q3XSH0+0wMbmTWAOOcWqh
         U3v1EEauUlqOMgqNx+R1NxNs15ZtekgDlgLsRPt/8X88T46Sl6WpZi56NKEM267w6k/J
         27rA==
X-Forwarded-Encrypted: i=1; AJvYcCUPL1YyLhmxx+of1ZR4a+c8W8Q2dF5Ol9TDSJyikkA49oAAPawku67OXytXak1Jp5h2qFBK06Y2@vger.kernel.org, AJvYcCXYpXJLPkEBDS9A1lgeZ+wxjdT1rccEiiLvxiRs8lO2Xgbe6agYhprn8Bu6jOOQee1Q5Chqi6LDmpzjDQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs9HaXbvUdBoXBlj4wNZNb8i4FsyfJpMsTn4UkWK5wCwBUvns
	3IPyCkpBps9Pf1wbaV7CJFdsaQhORKgsDkDTnjs3c+t9guxCDnq3pR7ah/b4BbSeOciXi/sib4M
	6GES4QHnRIfpHoGq5Sg9d7cXWrTA=
X-Google-Smtp-Source: AGHT+IGid9mFu2KKC1Y3XaIGaQYrgeekYnr4QMQgDTkuCFH3p3bUX9Q6HEMdA8MtCZWqYP3vGUcd4DX3z+BnDPsymK4=
X-Received: by 2002:a05:6122:251d:b0:50a:76c9:1bb with SMTP id
 71dfb90a1353d-50a76d84964mr3076382e0c.11.1727719676533; Mon, 30 Sep 2024
 11:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926160513.7252-1-kdipendra88@gmail.com> <20240927110236.GK4029621@kernel.org>
 <20240927112958.46unqo3adnxin2in@skbuf> <20240927120037.ji2wlqeagwohlb5d@skbuf>
In-Reply-To: <20240927120037.ji2wlqeagwohlb5d@skbuf>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 30 Sep 2024 23:52:45 +0545
Message-ID: <CAEKBCKP2pGoy=CWpzn+NGq8r4biu=XVnszXQ=7Ruuan8rfxM1Q@mail.gmail.com>
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Simon Horman <horms@kernel.org>, florian.fainelli@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Fri, 27 Sept 2024 at 17:45, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Fri, Sep 27, 2024 at 02:29:58PM +0300, Vladimir Oltean wrote:
> > > > + dp = dsa_port_from_netdev(slave_dev);
> > > > + if (IS_ERR(dp))
> > > > +         return PTR_ERR(dp);
> >
> > I don't see an explanation anywhere as for why dsa_port_from_netdev()
> > could ever return a pointer-encoded error here? hmm? Did you follow the
> > call path and found a problem?
>

Yeah, you are right. I ran smatch to find this and saw there is no
validation. I did not see any problem as you said. I thought it would
be better to include this change. If you say there is no point for
this change, then that's also fine for me. I got the chance to learn
new things.

> To make my point even clearer. As the code goes:
>
> bool dsa_user_dev_check(const struct net_device *dev)
> {
>         // This dereferences "dev" without a NULL pointer check.
>         // If the kernel did not crash, it means that "dev" is not null.
>         return dev->netdev_ops == &dsa_user_netdev_ops;
> }
>
> static int bcm_sysport_netdevice_event(struct notifier_block *nb,
>                                        unsigned long event, void *ptr)
> {
>         ...
>         switch (event) {
>         case NETDEV_CHANGEUPPER:
>                 ...
>                 if (!dsa_user_dev_check(info->upper_dev))
>                         return NOTIFY_DONE;
>
>                 // we know here that dsa_user_dev_check() is true, and
>                 // no one changes dev->netdev_ops at runtime, to suspect
>                 // it could become false after it just returned true.
>                 // Even if it did, we are under rtnl_lock(), and whoever
>                 // did that better also acquired rtnl_lock(). Thus,
>                 // there is enough guarantee that this also remains true
>                 // below.
>                 if (info->linking)
>                         ret = bcm_sysport_map_queues(dev, info->upper_dev);
>                 else
>                         ret = bcm_sysport_unmap_queues(dev, info->upper_dev);
>         }
>         ...
> }
>
> struct dsa_port *dsa_port_from_netdev(struct net_device *netdev)
> {
>         if (!netdev || !dsa_user_dev_check(netdev))
>                 return ERR_PTR(-ENODEV);
>
>         return dsa_user_to_port(netdev);
> }
>
> static int bcm_sysport_map_queues(struct net_device *dev,
>                                   struct net_device *slave_dev)
> {
>         struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
>         ...
> }
>
> So, if both conditions for dsa_port_from_netdev() to return ERR_PTR(-ENODEV)
> can only be false, why would we add an error check? Is it to appease a
> static analysis tool which doesn't analyze things very far? Or is there
> an actual problem?
>
> And why does this have a Fixes: tag and the expectation to be included
> as a bug fix to stable kernels?
>
> And why is the author of the blamed patch even CCed only at v5?!

Sorry to know this, I ran the script and there I did not find your name.

./scripts/get_maintainer.pl drivers/net/ethernet/broadcom/bcmsysport.c
Florian Fainelli <florian.fainelli@broadcom.com> (supporter:BROADCOM
SYSTEMPORT ETHERNET DRIVER)
Broadcom internal kernel review list
<bcm-kernel-feedback-list@broadcom.com> (reviewer:BROADCOM SYSTEMPORT
ETHERNET DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:BROADCOM SYSTEMPORT ETHERNET DRIVER)
linux-kernel@vger.kernel.org (open list)

Thank you so much for your time and effort , special thanks to Simon
for everything ,thanks Vladimir for the way you explained. and thanks
Florian for your help.

Best regards,
Dipendra Khadka

