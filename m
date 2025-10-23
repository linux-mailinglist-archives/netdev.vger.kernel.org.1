Return-Path: <netdev+bounces-232141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA10C01C14
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1FE3B6F0E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170A329C54;
	Thu, 23 Oct 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGfwFRN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40931E0ED
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229087; cv=none; b=neYOSs8KItf9EtqVSRnDZowo0qtTRB+7fUWyVcjuucw9/U+xNEpU1zV3o9hq3KRHSH4mZXEaoI0HGRTCwm6RM7vvJ/VKe+xgQtES87C05fKVw1OHXziP1ovzEn/15J/jaolg7NaaTJCYDX5YXavIVND0FIqf/fNy6Yo8C8jVA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229087; c=relaxed/simple;
	bh=EHM7fQOHNeLsoiL3vC36Dccd2CyB8XS5TMseHrscFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDA6AYXKDYLrGMiFBF/MDgAXLbJJdRYnLMh+EckX+bGOYcRPXdWsc8SpleEOVeCZqTg0UXAnpX8CYy8KbrJ6ThlVD8kGdWlU/pqxOKc2P5s1ClCfRzxb1b3TNpqyXD05KeRiXlfb/T41b9uz1dJvkNwj5wfeigwhuqowrAydkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGfwFRN4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ec291a325so705407a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761229084; x=1761833884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lowMFcjGtC50avJO9ESsGiMhY7bgLV5uttBpBtCygM=;
        b=AGfwFRN42/OJU/I/xtsfheKf7jmV/nFNWIGdjB9UXxFHoepSPPlWFyUcAEIuaTI4Jp
         ncHAP4zSG9HnVOZbNV5uIdwiBJFTO+jrcGaAmqtEomh+Vk3ieBo3Vl2EV0cihpz/kUW8
         ss6lSWyXplNhhS+3dvLHXEPoNjRd02GjNHyJRYp4fWgT7DowBbOVBlBy/RR2Dr7/QD+8
         z0PKT7hxTHmfj3zqhFAzizpLYYvaYcSs+ZVkS9fPl/ZD1wcC+zeJK8fU/3ivmZqYtFCq
         BytVhmU39//HpQoo5UEHKIl4DdrBBchGTtceCSSlqHvxuq+AxM7HP36CnjeG/WJzHzdK
         fvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229084; x=1761833884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lowMFcjGtC50avJO9ESsGiMhY7bgLV5uttBpBtCygM=;
        b=p13Ej1l2kZA2y+bQCl5JEyqaQChH64BCEl2onyJjrQY/uLevkN8hMD/jzA/m3Uguwz
         2dUcOWVcVGAYJ+neNGW95Sqt/qkTqFIabpOUm9Xv6ZK3IC4htMdtq2j3+x+3a1j8Ca3h
         mftS1VEAxDOc0WBBPghitXtQImywmstwwF6rAsR1BbQBG/76X5r2rhio5IKRyRQ6/Ml7
         ErZ+t1FcbiPt3Pc+mkF9K2zR2Fsn4AGVXTL9JtaoouGTq5IRkc1y8qcFQj4bqt2d0lbq
         LOl4R+or3GpovA+bVayhHlwWVVh7dD1gpxhNeTJ2zWZXsohuZNN3AbjfbegFHSq1pDrS
         khVQ==
X-Gm-Message-State: AOJu0YzdmsEmXHNNp9SC0BOzp5xx16zI0wLJb6IO5Y3UmJC7JKjMI0HS
	0zZ0xAvGQpc0HgxnGt3Jjqqgu0/Cz8ye3oMt5q1lHLoB6JyBxPBjSv/U
X-Gm-Gg: ASbGncsNHS3LFu4cwHhjuH76LMgb7J/XWqFxpNJLFRdxGYobJAZR6uI5hLG0cyqthMw
	8GVJcjv6w3VW8JElCg/lfstkEwQdpoZuTyrDb0+DAQla8d8JLKL47+lld3v0Vz9PZ354X7GC4fR
	fIjXj4J4e0aQ75i24Uo7pSq9iBXkPwSoRb72Vjs1Mu6FceNUH8gYrsXxW7kD5dFqpJTgclY2gK2
	O142tRlr75u8cA5oy/2pk/HYjf2WgX6euaVt+DPNnvP+ZIVEXMb3a5Ix8h7+IYEeiXxmgDb6HS/
	sk3o56RXcR9od/rF+5rRCwNtXhD4e7CoXeNAsdBGYhzpDvJiyjm8BoZlLdV4BrUXS20NzjnqLfL
	oOSqozS2b4dRQ/9udmSN0OWXjTveVbnuCcH35MxkTnntgu2U0LTAAEcO3+K8sAE9s6e0YIOY6w4
	Zhepb8
X-Google-Smtp-Source: AGHT+IGDK0WHAgOUIbAsdqHX3U++zNVrDR2oq29rKFa2lE4dndEP53CQaWke7F3n+Iyv7vfKnFvSyA==
X-Received: by 2002:a17:90b:4a50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-33bcf90e727mr36477602a91.33.1761229084168;
        Thu, 23 Oct 2025 07:18:04 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb0196831sm2604687a91.20.2025.10.23.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:18:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:17:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Oscar Maes <oscmaes92@gmail.com>
Subject: Re: [PATCH net] net: vlan: sync VLAN features with lower device
Message-ID: <aPo5FCLqkJc86ixe@fedora>
References: <20251021095658.86478-1-liuhangbin@gmail.com>
 <38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>

On Thu, Oct 23, 2025 at 03:39:07PM +0200, Paolo Abeni wrote:
> On 10/21/25 11:56 AM, Hangbin Liu wrote:
> > After registering a VLAN device and setting its feature flags, we need to
> > synchronize the VLAN features with the lower device. For example, the VLAN
> > device does not have the NETIF_F_LRO flag, it should be synchronized with
> > the lower device based on the NETIF_F_UPPER_DISABLES definition.
> > 
> > As the dev->vlan_features has changed, we need to call
> > netdev_change_features(). The caller must run after netdev_upper_dev_link()
> > links the lower devices, so this patch adds the netdev_change_features()
> > call in register_vlan_dev().
> 
> 
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > 
> > I’m not sure what the proper Fixes tag should be, so I’ve left it blank for
> > now. If anyone has a clue, please let me know.
> 
> Apparently the issue is there since fd867d51f889aec11cca235ebb008578780d052d

Thanks, I thought it's a VLAN issue. Didn't expect it's from here.

> 
> > 
> > ---
> >  net/8021q/vlan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> > index fda3a80e9340..4857fb0ee11d 100644
> > --- a/net/8021q/vlan.c
> > +++ b/net/8021q/vlan.c
> > @@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
> >  	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
> >  	grp->nr_vlan_devs++;
> >  
> > +	netdev_change_features(dev);
> 
> Is this just for NETIF_F_LRO? it feels a bit overkill for single flag.

Not only LRO, the vlan set all the dev features in vlan_dev_init() but doesn't
call the netdev_change_features(). I think it need to compute the dev features
once.

> Also, why netdev_change_features() (vs netdev_update_features())?> +

Hmm, I might made a mistake. I thought any_dev->vlan_features changes need
to call netdev_change_features(). But actually only the lower_dev->vlan_features
changes need to call netdev_change_features(). I will fix it.

Thanks
Hangbin

