Return-Path: <netdev+bounces-73780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCD85E5D1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA7A285E86
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC38563A;
	Wed, 21 Feb 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EkwVhY9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E68562D
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539765; cv=none; b=U7v7WDn6TYwx1upvkaOC/RRBFsF3Kxibp/x/ywHubcBldPuAGqASoc66AnCANqbBT9L5hRrBfD/gnILV9+X/XhvbCcJMt6IUXL7hxtFtBA37vMz8p4oOHRsdSdcc5Cwg1JbgBCLwFBIjKQRaAbGjUbqx+sh7GsrRaO9roz3Rnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539765; c=relaxed/simple;
	bh=EriAXYtWwS8Hk4l8xRlROSDp2wDGrhlyMRyCErH6xfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnti/PhL2qF6WXy/y47D02Gr0tZCnC2iB7bLBIo5++Z8K/fxOtXGN0tNXANZ42BYADIwaDJGXwoXuf6uhBF6qDeKr4H2aNC4ImxNTYvojksNTL7t3pIOHfhh3O2xofLMPUCVjanHPj18kiC3vdsA68jFclP54qRE8n5auBkY19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EkwVhY9G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41275f1b45aso6881265e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708539761; x=1709144561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sxza/sj4eN2dhcXgIfKmMLV43QJtvnpBq1Dsu79/oM8=;
        b=EkwVhY9G5eiWD17UkJ5aiXy6xxg5W2P9AvHVGEgA5S93YEwNMNazdGhKMFd+tIaVab
         /ac1OPAJDxYUD1EeU38gWiN6otVVJkAoq3JmDfQQyU6HFdV2iHsVRGtFO+Kh2QbnvB8c
         jSi26wsehTYK3beS1Mqk79yxuaOgWddDMrFGDXicJf6v6uaZ3iGXzo5gLj8pL5EpAZQE
         curJL6Kd2UZBynQIFlcXcrko1g2x73u86Z31CcMn3wlCNZk7A3INrrvY2YJz9IoUqwxw
         BwCWBZpKfZHDvpMMVSftRfJx/s8w1UyOlTjvCXsa3qVSQ9/doDly4CbkGdjWDvdPr4TH
         RjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539761; x=1709144561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxza/sj4eN2dhcXgIfKmMLV43QJtvnpBq1Dsu79/oM8=;
        b=mbArlfwiosHDoJXJQ2K6WcRsu2pg0bAmP9kjEaP9PWNNU5h3q4FaWQWLj0IgZm6MK1
         /rOTBaONaHljEmjwVYeiMQZ6J0ucSPElqj5MMiYOS6u7r5iAzdnVq8bYNCtZVH8PPjaf
         1rSk10sHrt7io95jxN7yq8EHBj+Sdoap5ZbXhRj2lc3Ja6VwbqQDeWKp79qAgqXtuP20
         6LoZVdkHNFTA80XBOcw9y+BAMSXZu962DIQCQ2P+zXU6QYkQOjFBzkmryMkT7Lx9HQCu
         TNXkTt6m/XJWEu8sfmj/sgUfxDLLAqXho9fFL0tcw5Yc2IaHxhUSDPHNfY8eF1xdqNHZ
         KH+w==
X-Forwarded-Encrypted: i=1; AJvYcCXx01H9n4VyItA2VpZ8zZt4b68K4xEyW3n7sw8neoZoxnbe2wLGP+v0LS2A02oYZUrWP5gXVTlEWy+59AmOBprQ0TLvBBFs
X-Gm-Message-State: AOJu0Yx6XIlKhOKi8LliC/A3zg6BBrg59QgJGd7BKiP9SOZhgqzLyWGt
	mSGNGD39i2JZkXyfWMLTCGooxulX96MjFX9rnBY3FHRwCu0UnLj+fEFLRLiX4xs=
X-Google-Smtp-Source: AGHT+IF7ZT0YuYYtLVSNjTpUwDdZ+nR47AWk+WxYU52Fr+mbZaT8NcjZPuvSRACpD9gkBzBB0MaWqA==
X-Received: by 2002:a05:600c:19cd:b0:411:d273:90e2 with SMTP id u13-20020a05600c19cd00b00411d27390e2mr16855758wmq.3.1708539760834;
        Wed, 21 Feb 2024 10:22:40 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b00410dd253008sm3297807wmr.42.2024.02.21.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:22:40 -0800 (PST)
Date: Wed, 21 Feb 2024 19:22:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 12/13] rtnetlink: make rtnl_fill_link_ifmap()
 RCU ready
Message-ID: <ZdY_bci2rMpjKusw@nanopsycho>
References: <20240221105915.829140-1-edumazet@google.com>
 <20240221105915.829140-13-edumazet@google.com>
 <ZdYes3iPqzf0FCTf@nanopsycho>
 <CANn89i+CvOVkaiXuO5vgggHdzVP17Yzw1WaiH93-fjf2cqnN_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+CvOVkaiXuO5vgggHdzVP17Yzw1WaiH93-fjf2cqnN_A@mail.gmail.com>

Wed, Feb 21, 2024 at 06:15:11PM CET, edumazet@google.com wrote:
>On Wed, Feb 21, 2024 at 5:03 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Feb 21, 2024 at 11:59:14AM CET, edumazet@google.com wrote:
>> >Use READ_ONCE() to read the following device fields:
>> >
>> >       dev->mem_start
>> >       dev->mem_end
>> >       dev->base_addr
>> >       dev->irq
>> >       dev->dma
>> >       dev->if_port
>> >
>> >Provide IFLA_MAP attribute only if at least one of these fields
>> >is not zero. This saves some space in the output skb for most devices.
>> >
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >---
>> > net/core/rtnetlink.c | 26 ++++++++++++++------------
>> > 1 file changed, 14 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> >index 1b26dfa5668d22fb2e30ceefbf143e98df13ae29..b91ec216c593aaebf97ea69aa0d2d265ab61c098 100644
>> >--- a/net/core/rtnetlink.c
>> >+++ b/net/core/rtnetlink.c
>> >@@ -1455,19 +1455,21 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
>> >       return 0;
>> > }
>> >
>> >-static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device *dev)
>> >+static int rtnl_fill_link_ifmap(struct sk_buff *skb,
>> >+                              const struct net_device *dev)
>> > {
>> >       struct rtnl_link_ifmap map;
>> >
>> >       memset(&map, 0, sizeof(map));
>> >-      map.mem_start   = dev->mem_start;
>> >-      map.mem_end     = dev->mem_end;
>> >-      map.base_addr   = dev->base_addr;
>> >-      map.irq         = dev->irq;
>> >-      map.dma         = dev->dma;
>> >-      map.port        = dev->if_port;
>> >-
>> >-      if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
>> >+      map.mem_start = READ_ONCE(dev->mem_start);
>> >+      map.mem_end   = READ_ONCE(dev->mem_end);
>> >+      map.base_addr = READ_ONCE(dev->base_addr);
>> >+      map.irq       = READ_ONCE(dev->irq);
>> >+      map.dma       = READ_ONCE(dev->dma);
>> >+      map.port      = READ_ONCE(dev->if_port);
>> >+      /* Only report non zero information. */
>> >+      if (memchr_inv(&map, 0, sizeof(map)) &&
>>
>> This check(optimization) is unrelated to the rest of the patch, correct?
>> If yes, could it be a separate patch?
>
>Sure thing. BTW, do you know which tool is using this ?
>
>I could not find IFLA_MAP being used in iproute2 or ethtool.

No clue. Never spotted it.

