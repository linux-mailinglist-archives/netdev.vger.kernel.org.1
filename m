Return-Path: <netdev+bounces-75373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76E869A0D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377E4B2595D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796FA146003;
	Tue, 27 Feb 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DGS2czSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E6145B0C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046724; cv=none; b=Lfqkr37IPmzxAMu/IsgF2/5lrpwUKf5ftE+Q04T3CfBEuGPNA4ZU2goQiMYFGO4nlWoF2W86JJobK2tH2PUCvI2ww+NyaFRXtVYVt66UlBS2awO7HR+RXtTM9Mlt+suQmQIANc7Q+13y7KUNr17PC3Pr99aO7sl7C2ouELoZwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046724; c=relaxed/simple;
	bh=VwQb2wr5l+dQa4a/ezZtAJoIQZ69UbUqrEF/sIcCgU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnamys/Q+b4xh5NSESeTx6VddMcGnYqp67U/P69tc5vQF8PmiV1qyL5yCdsnaRy4HVByluXF+NSbXl/HjMK7YXPPd3ttobkC9c2CLwc36FlXQ4q2p31lNgk2KvTWyQrzXRZmqXTIIYBGSkX9CdWPQsj0pYI1EtQoCJevipWjPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DGS2czSZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so34975815e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046721; x=1709651521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cddeRWSkHsJ5aM6IXSQV8Lz3SVo39yOhC1FFX5E2qHs=;
        b=DGS2czSZk+4CJ7LHosp3dQDP4Kj6QiHTmSuqZCvI/ySca9cL7FynsbSiRAbpZv5ZKK
         lWKz/g/1Rv5iu2v1YZeKygmCdZMDZ2Mjk8dkRoyxSal0xB4jqPceyKB3UNf8jxtQ1JMK
         RpZBG2iumLWk4ysxZkE3UT609HJ1HWgItQZu3lxB63xZa0/uTrv1iV/XkUQW/Us9Xmdz
         dxvmAYQZBm1/ZxNcNY6RuwAB2oidgWPH5VwML37iwKvXpospEQRWtGxRsC9el7m9KCVp
         D61ybPenlk3fqK64xQbXLOLqySUn4kmGUlbI3MjngulIhxCWL3WURRB0U0QljgFT60Eh
         +Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046721; x=1709651521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cddeRWSkHsJ5aM6IXSQV8Lz3SVo39yOhC1FFX5E2qHs=;
        b=f3BxrDPpUdVxiCb1SXOfN+OpQs2ZRs8exvNajG3I7mRRyvoD4l2VB12Pu/+NaK9Cgt
         oHZnN9KSs6WJ0mTPr0nBiP8/7F6nYzRPeVFIz8huyHrKY1iEBc8Z+TOwFrtXACLJM4zu
         xPOXE4PsZl73G8cSrS1TIH+IX1OKUNtXOVjlzOzD9cobQixHxBoUO3qkcMJzj/w8ZfMU
         qik5LjvPP3u27LgHaVKglGOga8q9eNf3NEY5GPTi88fo+gFqPNT94Gb2j6wuLNewp0y1
         6chc19gkMhygaNckMT0OOj0HhLnXKfM7d9mUHottnEn/hqeGqWtNXauR+y1BfUKruXji
         VqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1q4VCx0jrLAxMJ7EUAHAPxXEo3yXzcnufH4dpsDkkvyNi27VgdGK2vmLT0scYxczicUI6KNBdLY4NLD2xsLT1exn7DL/s
X-Gm-Message-State: AOJu0YwV8OGjmt+CK1CHJptZ2oDzLWK0Ro4Nadl2Roj/Jj3TTKggchGL
	8JkSDgOWV7qz5mceZv5F4WIwHGIXFnnhR9T2B3wLC8gql1GX4uJVsw0zpaURdVE=
X-Google-Smtp-Source: AGHT+IF6PueeL1dmwQvp7sGfy97d29NO7S04AdntkKHe3lntm2e10f7SJr4z9Wx9HZ/Yxkerd/dQng==
X-Received: by 2002:a05:600c:4f95:b0:412:954c:801d with SMTP id n21-20020a05600c4f9500b00412954c801dmr8786100wmq.12.1709046721085;
        Tue, 27 Feb 2024 07:12:01 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jl20-20020a05600c6a9400b004126101915esm15288632wmb.4.2024.02.27.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:12:00 -0800 (PST)
Date: Tue, 27 Feb 2024 16:11:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] inet: do not use RTNL in
 inet_netconf_get_devconf() 
Message-ID: <Zd37vclUdivMpB4T@nanopsycho>
References: <20240227092411.2315725-1-edumazet@google.com>
 <20240227092411.2315725-3-edumazet@google.com>
 <Zd3cn-kct8PdrvGg@nanopsycho>
 <CANn89i+TfGnpBthoix4QmfC6hEsEH0HdYnAowMPeNz0z+4qUjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+TfGnpBthoix4QmfC6hEsEH0HdYnAowMPeNz0z+4qUjw@mail.gmail.com>

Tue, Feb 27, 2024 at 02:09:49PM CET, edumazet@google.com wrote:
>On Tue, Feb 27, 2024 at 1:59 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Feb 27, 2024 at 10:24:10AM CET, edumazet@google.com wrote:
>> >"ip -4 netconf show dev XXXX" no longer acquires RTNL.
>>
>> I was under impression that you refer to the current code, confused me a
>> bit :/
>>
>>
>> >
>> >Return -ENODEV instead of -EINVAL if no netdev or idev can be found.
>> >
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >---
>> > net/ipv4/devinet.c | 27 +++++++++++++++------------
>> > 1 file changed, 15 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>> >index ca75d0fff1d1ebd8c199fb74a6f0e2f51160635c..f045a34e90b974b17512a30c3b719bdfc3cba153 100644
>> >--- a/net/ipv4/devinet.c
>> >+++ b/net/ipv4/devinet.c
>> >@@ -2205,21 +2205,20 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
>> >                                   struct netlink_ext_ack *extack)
>> > {
>> >       struct net *net = sock_net(in_skb->sk);
>> >-      struct nlattr *tb[NETCONFA_MAX+1];
>> >+      struct nlattr *tb[NETCONFA_MAX + 1];
>> >+      const struct ipv4_devconf *devconf;
>> >+      struct in_device *in_dev = NULL;
>> >+      struct net_device *dev = NULL;
>> >       struct sk_buff *skb;
>> >-      struct ipv4_devconf *devconf;
>> >-      struct in_device *in_dev;
>> >-      struct net_device *dev;
>> >       int ifindex;
>> >       int err;
>> >
>> >       err = inet_netconf_valid_get_req(in_skb, nlh, tb, extack);
>> >       if (err)
>> >-              goto errout;
>> >+              return err;
>> >
>> >-      err = -EINVAL;
>> >       if (!tb[NETCONFA_IFINDEX])
>> >-              goto errout;
>> >+              return -EINVAL;
>> >
>> >       ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
>> >       switch (ifindex) {
>> >@@ -2230,10 +2229,10 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
>> >               devconf = net->ipv4.devconf_dflt;
>> >               break;
>> >       default:
>> >-              dev = __dev_get_by_index(net, ifindex);
>> >-              if (!dev)
>> >-                      goto errout;
>> >-              in_dev = __in_dev_get_rtnl(dev);
>> >+              err = -ENODEV;
>> >+              dev = dev_get_by_index(net, ifindex);
>>
>> Comment says:
>> /* Deprecated for new users, call netdev_get_by_index() instead */
>> struct net_device *dev_get_by_index(struct net *net, int ifindex)
>
>Only for long-standing allocations, where we are not sure if a leak
>could happen or not.
>We do not bother allocating a tracker otherwise.

Makes sense. Would it make sense to fix the "deprecated" comment then to
also reflect this usecase?


>Look at inet6_netconf_get_devconf() :
>We left there dev_get_by_index() and dev_put().
>
>I think I am aware of the tracking facility, I implemented it...

Yeah, I was just refering to the comment.


>
>
>>
>> Perhaps better to use:
>> netdev_get_by_index() and netdev_put()?
>>
>>
>> >+              if (dev)
>> >+                      in_dev = in_dev_get(dev);
>>
>> The original flow:
>>                 err = -ENODEV;
>>                 dev = dev_get_by_index(net, ifindex);
>>                 if (!dev)
>>                         goto errout;
>>                 in_dev = in_dev_get(dev);
>>                 if (!in_dev)
>>                         goto errout;
>
>A single goto looks nicer to me.

:)

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>
>> Reads a bit nicer to me. Not sure why you changed it. Yeah, it's a nit.
>>

