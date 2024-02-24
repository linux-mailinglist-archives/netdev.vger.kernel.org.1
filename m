Return-Path: <netdev+bounces-74708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A612D862510
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E321F22351
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82621249F8;
	Sat, 24 Feb 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jCV2pOBp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA110A3C
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708778939; cv=none; b=klrEF8VN38Wj5iR4wsbVsnt1QVMzNt0+1U2+3otsPf5NbaYx7AfXwGm2obQ15iEYPITseTXzoXx3JuEX7wkOiSQbZY/BCmI8fwjWe23fM7qwtJ4IHkaqYhxmxDPJNxQ9KZvNS1LwEceI1pvQojLTyucTUOkAk28gv7iWD7EVxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708778939; c=relaxed/simple;
	bh=XAJuSDpYR+Drw8fH2nYQwEQ870V2Xf/OvZkWZXiT49s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLAecr3Aug1idFeofWkszgngr4RDKOrfR5uA1tY64QvLWEwtgU4yzw+bai43Cpi6fQZ2ZpvuTTlx+igQ8rG4+aPQZjkbPZsP9EBbq0SwDXDvTsBp/r3F6k15Z5rgc2LLtzyYeLxR5wAoxonz9swHsSIXgqkiqhP022D7z5dUFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jCV2pOBp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412985a51ecso6424205e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708778936; x=1709383736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp8SoobgRxaDY+uQRtQyavQk2+ctkN4l6AReeSoVED8=;
        b=jCV2pOBproCXsXJARZ5pdboOnUBrLd9+pZlNrtUqO5/wXI/f0OSj0B6uRFkeQ906Ky
         z9IVDC8r7xhU5ySyYfY31e80DcLDh44qIuy6YHJ6f+JG7f3gxa8TPgbxEGP4qtrImHgj
         sIhDxW+oZORj07Jl60wqvEXjSnZo6wGOEgxa5Jh6mbsPVOXo5uIjj8JXBGMGvA2Mf20L
         V8hE10wwBD57FQBOxwZJh1sodCo88igZ10V5t3TTR64JvRIo6V1hKR8VIpOaOBboXaFd
         NJ50dFsUANpk1TGZAH+i3hxkn3WvME9w2eLoJiuV5k4Tf70iK2PzOta1cMPeKrzpu11y
         nqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708778936; x=1709383736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp8SoobgRxaDY+uQRtQyavQk2+ctkN4l6AReeSoVED8=;
        b=JRnz/mmcfagP2e5VR3xlEKwbbLVPu6/yRZ9ZYjuUFcPAl9aB0E8Wu3i3ZL59zPllhc
         i+IQkEGEJhgHI7atTo8lw5mpaEmljNUh+i/wtovt+1V5V4UiDF/rfulZ6sC1i+Vsj/G0
         bW9khNChq5/ZW2wtaRS28+37RtqYYuecN0nXaUPlx8Ta32v+hEs9q+0JteyHpF7NzaM5
         imSJDzaB7o4OY3t4RWZ5UvtaAZETb77RWj1+2v2cleg8tdWbzBta7Sp+km1YqHGDutri
         UMrDgdSBDq3bs/VfjZD1kpd4g/N+kiR6lZiTv4YvcOCXnoCi+f5ryIYRjQq4G80Uhcs+
         1ztg==
X-Forwarded-Encrypted: i=1; AJvYcCVXPMqsPGe3NVjcTg+/r89B5aBufIE5XX2PZB1c4/9sNhD7OgLo3SWfS8GdYRs1QgtdWWdEiSwjVOqHU6seo7YAj/RYU7LZ
X-Gm-Message-State: AOJu0Yzz2zx5y+OAMEMhcvmJ6/O9/tLXstgBp6+lknNijDgtUHbO+OSe
	DcORB5+dHmilXu1a5GhXF9SodFgVXbHZfV8iALKK24fllpCP4/YATM+XT0cpjNU=
X-Google-Smtp-Source: AGHT+IEWEKR4LhybAH/6UyAi3XuYXeVhHHiws4zVGfKr/jRqRlZs0GptbmZktM1lqHFUX6P731OcTA==
X-Received: by 2002:a05:600c:5592:b0:412:6de0:69a9 with SMTP id jp18-20020a05600c559200b004126de069a9mr1531863wmb.39.1708778935620;
        Sat, 24 Feb 2024 04:48:55 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b0040fccf7e8easm5943504wmd.36.2024.02.24.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 04:48:50 -0800 (PST)
Date: Sat, 24 Feb 2024 13:48:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZdnlsMgqsyOPaeyC@nanopsycho>
References: <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
 <16217.1708653901@famine>
 <b7b89300-8065-4421-9935-3adf70ac47bc@intel.com>
 <ZdhoBOKc40DeVCfG@nanopsycho>
 <ef0270c5-3128-40d8-933e-f9dbeddf5961@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0270c5-3128-40d8-933e-f9dbeddf5961@intel.com>

Sat, Feb 24, 2024 at 12:56:52AM CET, sridhar.samudrala@intel.com wrote:
>
>
>On 2/23/2024 3:40 AM, Jiri Pirko wrote:
>> Fri, Feb 23, 2024 at 06:00:40AM CET, sridhar.samudrala@intel.com wrote:
>> > 
>> > 
>> > On 2/22/2024 8:05 PM, Jay Vosburgh wrote:
>> > > Samudrala, Sridhar <sridhar.samudrala@intel.com> wrote:
>> > > > On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>> > > > > On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>> > > > > > On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>> > > > > > > Greg, we have a feature here where a single device of class net has
>> > > > > > > multiple "bus parents". We used to have one attr under class net
>> > > > > > > (device) which is a link to the bus parent. Now we either need to add
>> > > > > > > more or not bother with the linking of the whole device. Is there any
>> > > > > > > precedent / preference for solving this from the device model
>> > > > > > > perspective?
>> > > > > > 
>> > > > > > How, logically, can a netdevice be controlled properly from 2 parent
>> > > > > > devices on two different busses?  How is that even possible from a
>> > > > > > physical point-of-view?  What exact bus types are involved here?
>> > > > > Two PCIe buses, two endpoints, two networking ports. It's one piece
>> > > > 
>> > > > Isn't it only 1 networking port with multiple PFs?
>> > > > 
>> > > > > of silicon, tho, so the "slices" can talk to each other internally.
>> > > > > The NVRAM configuration tells both endpoints that the user wants
>> > > > > them "bonded", when the PCI drivers probe they "find each other"
>> > > > > using some cookie or DSN or whatnot. And once they did, they spawn
>> > > > > a single netdev.
>> > > > > 
>> > > > > > This "shouldn't" be possible as in the end, it's usually a PCI device
>> > > > > > handling this all, right?
>> > > > > It's really a special type of bonding of two netdevs. Like you'd bond
>> > > > > two ports to get twice the bandwidth. With the twist that the balancing
>> > > > > is done on NUMA proximity, rather than traffic hash.
>> > > > > Well, plus, the major twist that it's all done magically "for you"
>> > > > > in the vendor driver, and the two "lower" devices are not visible.
>> > > > > You only see the resulting bond.
>> > > > > I personally think that the magic hides as many problems as it
>> > > > > introduces and we'd be better off creating two separate netdevs.
>> > > > > And then a new type of "device bond" on top. Small win that
>> > > > > the "new device bond on top" can be shared code across vendors.
>> > > > 
>> > > > Yes. We have been exploring a small extension to bonding driver to enable
>> > > > a single numa-aware multi-threaded application to efficiently utilize
>> > > > multiple NICs across numa nodes.
>> > > 
>> > > 	Is this referring to something like the multi-pf under
>> > > discussion, or just generically with two arbitrary network devices
>> > > installed one each per NUMA node?
>> > 
>> > Normal network devices one per NUMA node
>> > 
>> > > 
>> > > > Here is an early version of a patch we have been trying and seems to be
>> > > > working well.
>> > > > 
>> > > > =========================================================================
>> > > > bonding: select tx device based on rx device of a flow
>> > > > 
>> > > > If napi_id is cached in the sk associated with skb, use the
>> > > > device associated with napi_id as the transmit device.
>> > > > 
>> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> > > > 
>> > > > diff --git a/drivers/net/bonding/bond_main.c
>> > > > b/drivers/net/bonding/bond_main.c
>> > > > index 7a7d584f378a..77e3bf6c4502 100644
>> > > > --- a/drivers/net/bonding/bond_main.c
>> > > > +++ b/drivers/net/bonding/bond_main.c
>> > > > @@ -5146,6 +5146,30 @@ static struct slave
>> > > > *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>> > > >          unsigned int count;
>> > > >          u32 hash;
>> > > > 
>> > > > +       if (skb->sk) {
>> > > > +               int napi_id = skb->sk->sk_napi_id;
>> > > > +               struct net_device *dev;
>> > > > +               int idx;
>> > > > +
>> > > > +               rcu_read_lock();
>> > > > +               dev = dev_get_by_napi_id(napi_id);
>> > > > +               rcu_read_unlock();
>> > > > +
>> > > > +               if (!dev)
>> > > > +                       goto hash;
>> > > > +
>> > > > +               count = slaves ? READ_ONCE(slaves->count) : 0;
>> > > > +               if (unlikely(!count))
>> > > > +                       return NULL;
>> > > > +
>> > > > +               for (idx = 0; idx < count; idx++) {
>> > > > +                       slave = slaves->arr[idx];
>> > > > +                       if (slave->dev->ifindex == dev->ifindex)
>> > > > +                               return slave;
>> > > > +               }
>> > > > +       }
>> > > > +
>> > > > +hash:
>> > > >          hash = bond_xmit_hash(bond, skb);
>> > > >          count = slaves ? READ_ONCE(slaves->count) : 0;
>> > > >          if (unlikely(!count))
>> > > > =========================================================================
>> > > > 
>> > > > If we make this as a configurable bonding option, would this be an
>> > > > acceptable solution to accelerate numa-aware apps?
>> > > 
>> > > 	Assuming for the moment this is for "regular" network devices
>> > > installed one per NUMA node, why do this in bonding instead of at a
>> > > higher layer (multiple subnets or ECMP, for example)?
>> > > 
>> > > 	Is the intent here that the bond would aggregate its interfaces
>> > > via LACP with the peer being some kind of cross-chassis link aggregation
>> > > (MLAG, et al)?
>> 
>> No.
>> 
>> > 
>> > Yes. basic LACP bonding setup. There could be multiple peers connecting to
>> > the server via switch providing LACP based link aggregation. No cross-chassis
>> > MLAG.
>> 
>> LACP does not make any sense, when you have only a single physical port.
>> That applies to ECMP mentioned above too I believe.
>
>I meant for the 2 regular NICs on 2 numa node setup, not for multi-PF 1 port
>setup.

Okay, not sure how it is related to this thread then :)

