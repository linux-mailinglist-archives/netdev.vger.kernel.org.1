Return-Path: <netdev+bounces-101291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6788FE0A6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021AAB24883
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAB13C3F7;
	Thu,  6 Jun 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnL5dfpo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962713B28A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661388; cv=none; b=q+YTNvjp6ehfilu3UwF54btzRDqASFierIONKLjMH5p7F4DjkrLIef9rCP/r2RAfqeXgNHGvRDYNFp8lM+LgxhE3yVi9mXt/MUVVK/n/+JpLp1QlZkjTiTLZvp2mqnBYdGBae1QMc+6+41iP2NJsEt4FffmpgNJy1QdKqjBA6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661388; c=relaxed/simple;
	bh=WO93m4a4i6r9Hp1ZPlW5j5STenQ54mlwMzKp4P9xuuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PixbRmiuPG9HncvQ6agGVCWLxMS45gKfXPCOCnRHLKZ35R8bkjj6CkKibYvDi3o2xaM+dnEC5u7LIrpmQhR2YgW0jfgFdHBvZ8G3md0srd04eK1fJ0g3EHH7ewVU2WBbfKQvYvMQIjdSj6YgjmqE6tqUjgYYTH1Z3s8OnR7zWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnL5dfpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717661386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5H7ujta7XRo68/DK/ynDK/bJkTwu1S/t77wJbenzWM=;
	b=cnL5dfpo3fDJLz2uxgZ7EV0taUqSwtEc0V+6uE9p/dKXFaCxrw7dSpENtIehnFav3JQyPb
	5VL81TQQJIZ0y6HJ1oP8ip728FNbs+hNhDqj8acGNvQZOsCHcXdg6vX0nFLoLSrgdW/xqq
	Yjm7+maVeMlnPIt6nD+MS1XGpjyZ4uc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128--ZV02-P3PJCJDswq3jMISA-1; Thu, 06 Jun 2024 04:09:44 -0400
X-MC-Unique: -ZV02-P3PJCJDswq3jMISA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421179fd82bso6060925e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717661383; x=1718266183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5H7ujta7XRo68/DK/ynDK/bJkTwu1S/t77wJbenzWM=;
        b=YQhmesZc0YO4TDTRFchvmSYPH/lcXBQIooomQ3okCMpOuXfaeNrP4lFXn50wceeBvV
         GvLf8FcfzZxjl7ckcsq+vYx/xZUyyV6D8qM4PxhvdcIBpCBbDP7TrvfWE/zwQnSp9vkj
         coNCWoYPuQwI7GgTE71IbRd0pWp6C3nGKu3z9xBrBrFK3C/+rVHoKww2I9HT4f2FchMI
         PD7BiCLVSNR01ROMSApC7Z0+CHz/6dDGpKHfk0euzz9Adf6kQYjkPdP1+h7mFMUPuBA8
         tsrqpXuFoe8+WuKmzpiXWN/4AVG5z6OHTvZrwWW1Qlo8/GDLAY5jnlJmqLldxd6O6i+s
         5SxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVG6BHgF3tp6NRR2LoNQjZm5tvnw8tOUoKcbtrG/GPD1iJjzS8BdipmInoIsgnACRcuHGh9041krk9OT9AM5WXGX6zDMec
X-Gm-Message-State: AOJu0Yz6uxOHMt5K2Hl0ZiY+F7Qop9d3myX42SaiKOY7PSh7rtnqqZG4
	WsoZ2+jZWpId4k4Sszx5xyVpB77u65+ieR4/hSIipQGYHCeKrGe7SNJ0kdSdaiEH5AI1yVBTeAE
	nktO/hpdzEyDn0+MrzLdprVYx+NFx4fAuJy05hK6EKnaiOZq+tpKKPA==
X-Received: by 2002:a05:600c:2151:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-421562e9570mr40021885e9.17.1717661383042;
        Thu, 06 Jun 2024 01:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUXvwXbtyAYmcLaPl8UVL4+OpyRQk+Ext5qWltCqc6giMGANd9CTsuzn4rWPFepzxdAm7nHA==
X-Received: by 2002:a05:600c:2151:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-421562e9570mr40021705e9.17.1717661382507;
        Thu, 06 Jun 2024 01:09:42 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d13esm45312375e9.24.2024.06.06.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:09:41 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:09:40 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	lucien.xin@gmail.com, marcelo.leitner@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	echaudro@redhat.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
Message-ID: <ZmFuxElwZiYJzBkh@dcaratti.users.ipa.redhat.com>
References: <cover.1717088241.git.dcaratti@redhat.com>
 <bc5449dc17cfebe90849c9daba8a078065f5ddf8.1717088241.git.dcaratti@redhat.com>
 <d1e494b5-c537-4faa-8226-892718b736aa@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1e494b5-c537-4faa-8226-892718b736aa@fiberby.net>

hello Asbjørn, thanks for looking at this!

On Wed, Jun 05, 2024 at 07:37:13AM +0000, Asbjørn Sloth Tønnesen wrote:
> Hi Davide and Ilva,

[...] 
 
> Sorry, that I am late to the party, I have been away camping at
> Electromagnetic Field in the UK.

guess you had fun :) 

> Why not use the already existing key->enc_control.flags with dissector
> key FLOW_DISSECTOR_KEY_ENC_CONTROL for storing the flags?
> 
> Currently key->enc_control.flags are unused.

I looked at the struct, it currently stores information about
IPv4 / IPv6 fragmentation of the inner/outer packet plus
FLOW_DIS_ENCAPSULATION - that IIRC is true in case the packet has
an inner IP header (key->enc_control.addr_type selects the address family).
these 3 bits are usually set when FLOW_DISSECTOR_KEY_CONTROL is
requested.

> I haven't fixed the drivers to validate that field yet, so currently
> only sfc does so.

I see:

[1] https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/net/ethernet/sfc/tc.c#L276

(for FLOW_DISSECTOR_KEY_CONTROL)

[2] https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/net/ethernet/sfc/tc.c#L390

(for FLOW_DISSECTOR_KEY_ENC_CONTROL)

> Look at include/uapi/linux/pkt_cls.h for netlink flags:
> 
> enum {
>         TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>         TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> };
> 
> and at include/net/flow_dissector.h for the dissector flags:
> 
> #define FLOW_DIS_IS_FRAGMENT    BIT(0)
> #define FLOW_DIS_FIRST_FRAG     BIT(1)
> #define FLOW_DIS_ENCAPSULATION  BIT(2)
> 
> I would like to keep FLOW_DIS_ENCAPSULATION as the last flag, in order to
> keep parity with the netlink flags, since the dissector flags field is
> exposed to user space when some flags are not supported.

to fully understand this, I need some more info on how you think
IP_TUNNEL_<blah> bit should be written on the dissected data, since
FLOW_DIS_IS_FRAGMENT has the same value as BIT(IP_TUNNEL_CSUM_BIT).
So, in a way or another parity with netlink can't be guaranteed.

The main reason why I added a new dissector bit is: avoiding breaking
functionality of drivers, because I don't really know what the hardware
does. If we want to use FLOW_DISSECTOR_KEY_ENC_CONTROL, then all drivers
supporting the offload of this bit need to return -EOPNOTSUPP if
key->enc_control.flags contains IP_TUNNEL_<blah> bits (like done in [2] for
FLOW_DIS_*FRAG*).
Moreover, if a driver supports offload of one of these bits (e.g. TUNNEL_OAM),
we need to understand if it's possible for hardware to match when 'addr_type'
is not specified, e.g. a geneve packet carrying a non-IP packet.

> I realize that since this series is now merged, then fixing this up will
> have to go in another series, are you up for that?

I'm not against: if there's something to improve, this is the right
moment _ later it will be more difficult; but we should clarify:

- how / if we want to handle overlap of 'flags'. I guess, pass the
  current tunnel flags to the arguments of
  skb_flow_dissect_set_enc_addr_type(), and write "something" in
  ctrl->flags.
- what to do with with flower netlink API. If these bits are in the
  same struct, we don't need TCA_FLOWER_KEY_ENC_FLAGS anymore? should
  we extend TCA_FLOWER_KEY_FLAGS instead?

thanks,
-- 
davide


