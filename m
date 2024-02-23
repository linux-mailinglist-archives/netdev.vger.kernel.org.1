Return-Path: <netdev+bounces-74319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E5860E52
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6FE1C237A4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53A5C615;
	Fri, 23 Feb 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="thVrdZ13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC35C916
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681226; cv=none; b=H2djhH2CPWCp5c67UxMWP3abYiHqbnJE71qVdf0enKksPOr/BSgkgyvBSZqLi8gzZyIuDE0MjkniUKIN2Owyhejz6ax93P0kpcJR2zmqzyc+q8TZNngQpTLObHCXYmskhiQPMAbZTnHtYFm+p3Q5TjaL9Yp1wN5CwOR+Z7R2GwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681226; c=relaxed/simple;
	bh=ZIdemWZQs0ju9CDIGiNdn3iFt9CIaN1PVSnpE8KvLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCQJxaQh+zy/A88pbyHyHZaiowmJYgHbJ35P2ntXDDyRcVtxDQqmiSd+C2SbHGMBRjCnOtZT3QPFMAS8cUWwQ6YVxkm2EGAzVJhOUdCl1ZkGRI+gect9Wu5zGEedUrNbNB9LV1AOG36LSVawaXEP0FfL48lXVrPoKE57blqlE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=thVrdZ13; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41275855dc4so5086975e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708681222; x=1709286022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D47/aOWTcfRmsXRuq16KXWcUFzSqLdEdVQ7JNoDbQ7A=;
        b=thVrdZ13jKvb/XjWoiETxeXDQl5+xgffSQBc90xbvShYco9FvgKg+5jTCJ5b7Ss9gd
         Nhao2v4sMhB4lRfw5JShHOr2IETTaIaBoLTTKxwK6RyBA1By62ZXS3DMPZW7aToZLzU5
         8UYHU+tmpcIh5ujkbQMkcT0rdwGORJnsXVxNL1gKTuMD1cRyPUgBALXA3jhSore+ESHz
         QCiDJGboKSrL84tzvf+bt7aZwb9A3AIrMlSiFu2FC38pn9Boo6CW/ZgUCz9y5rC7h2bP
         sK3Ey799OK/sUbSo4KtYFmamgEFwxlQUDIPecMY/LBDuI9ZH9SMvQ627san/cGljZ2KK
         bCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681222; x=1709286022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D47/aOWTcfRmsXRuq16KXWcUFzSqLdEdVQ7JNoDbQ7A=;
        b=kZtaQT26zHdd4zLZYOmr5Yrk09ymunQtY0yGRFlAj0JSI3RHfW4rnNpsbV2HoWRczd
         GxM0aatSccSwM+qynxKGW6QlwY92yn1aaXi3fU/THQPuHzdm7UnZ8lhBwD7fSyDyaS2L
         Pc/8k7pKGveYf+nyOLHtnNU/JWMyzz/4V7Js5ALsQXvh0/HOUDUotroFexc3PNBbetp9
         +++tBQkNhOmiMf5XhDLZ0Mi1NvXm6vdH6Hl8lOJBOkFkw6O/3WqTtonM/kKeLwPouS8x
         ywgWs4otQA+sx44cN8bqbRzTXTcA/7tIGwT3tTLW7SNzdbAJIOZ3kXTsVwz2JHI1mXxh
         7R0g==
X-Forwarded-Encrypted: i=1; AJvYcCUL5EtN3hDrYlaVxK6loHK9kKDTJG7Hlg6Uk8T1U6hALtrPUFKePklMpSKtuHZ9pWBR6eMa2PLWNE54mCKSGRFNjFsGQFd0
X-Gm-Message-State: AOJu0Yx/lbnxhVlSgp96gt/+hRBmiEPC+7d+0A4+MSo7uz6cB+ca8kZt
	w6r6dJSOJS0mGb3iCVJmpHzM1ISeIMSHl0vHd/7zMPehmm8WyBBNxxCt3xjalLs=
X-Google-Smtp-Source: AGHT+IE7qxWdtnRnoq0NO7g4u+YuOZKfxecn6qC9LTTpCJim7Yb2Txg3d1+3gnlNneYBkf/ojlRWsQ==
X-Received: by 2002:a05:600c:511f:b0:412:903b:12a5 with SMTP id o31-20020a05600c511f00b00412903b12a5mr743127wms.19.1708681222065;
        Fri, 23 Feb 2024 01:40:22 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b00411d0b58056sm1744925wms.5.2024.02.23.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:40:21 -0800 (PST)
Date: Fri, 23 Feb 2024 10:40:20 +0100
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
Message-ID: <ZdhoBOKc40DeVCfG@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
 <16217.1708653901@famine>
 <b7b89300-8065-4421-9935-3adf70ac47bc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b89300-8065-4421-9935-3adf70ac47bc@intel.com>

Fri, Feb 23, 2024 at 06:00:40AM CET, sridhar.samudrala@intel.com wrote:
>
>
>On 2/22/2024 8:05 PM, Jay Vosburgh wrote:
>> Samudrala, Sridhar <sridhar.samudrala@intel.com> wrote:
>> > On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>> > > On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>> > > > On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>> > > > > Greg, we have a feature here where a single device of class net has
>> > > > > multiple "bus parents". We used to have one attr under class net
>> > > > > (device) which is a link to the bus parent. Now we either need to add
>> > > > > more or not bother with the linking of the whole device. Is there any
>> > > > > precedent / preference for solving this from the device model
>> > > > > perspective?
>> > > > 
>> > > > How, logically, can a netdevice be controlled properly from 2 parent
>> > > > devices on two different busses?  How is that even possible from a
>> > > > physical point-of-view?  What exact bus types are involved here?
>> > > Two PCIe buses, two endpoints, two networking ports. It's one piece
>> > 
>> > Isn't it only 1 networking port with multiple PFs?
>> > 
>> > > of silicon, tho, so the "slices" can talk to each other internally.
>> > > The NVRAM configuration tells both endpoints that the user wants
>> > > them "bonded", when the PCI drivers probe they "find each other"
>> > > using some cookie or DSN or whatnot. And once they did, they spawn
>> > > a single netdev.
>> > > 
>> > > > This "shouldn't" be possible as in the end, it's usually a PCI device
>> > > > handling this all, right?
>> > > It's really a special type of bonding of two netdevs. Like you'd bond
>> > > two ports to get twice the bandwidth. With the twist that the balancing
>> > > is done on NUMA proximity, rather than traffic hash.
>> > > Well, plus, the major twist that it's all done magically "for you"
>> > > in the vendor driver, and the two "lower" devices are not visible.
>> > > You only see the resulting bond.
>> > > I personally think that the magic hides as many problems as it
>> > > introduces and we'd be better off creating two separate netdevs.
>> > > And then a new type of "device bond" on top. Small win that
>> > > the "new device bond on top" can be shared code across vendors.
>> > 
>> > Yes. We have been exploring a small extension to bonding driver to enable
>> > a single numa-aware multi-threaded application to efficiently utilize
>> > multiple NICs across numa nodes.
>> 
>> 	Is this referring to something like the multi-pf under
>> discussion, or just generically with two arbitrary network devices
>> installed one each per NUMA node?
>
>Normal network devices one per NUMA node
>
>> 
>> > Here is an early version of a patch we have been trying and seems to be
>> > working well.
>> > 
>> > =========================================================================
>> > bonding: select tx device based on rx device of a flow
>> > 
>> > If napi_id is cached in the sk associated with skb, use the
>> > device associated with napi_id as the transmit device.
>> > 
>> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> > 
>> > diff --git a/drivers/net/bonding/bond_main.c
>> > b/drivers/net/bonding/bond_main.c
>> > index 7a7d584f378a..77e3bf6c4502 100644
>> > --- a/drivers/net/bonding/bond_main.c
>> > +++ b/drivers/net/bonding/bond_main.c
>> > @@ -5146,6 +5146,30 @@ static struct slave
>> > *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>> >         unsigned int count;
>> >         u32 hash;
>> > 
>> > +       if (skb->sk) {
>> > +               int napi_id = skb->sk->sk_napi_id;
>> > +               struct net_device *dev;
>> > +               int idx;
>> > +
>> > +               rcu_read_lock();
>> > +               dev = dev_get_by_napi_id(napi_id);
>> > +               rcu_read_unlock();
>> > +
>> > +               if (!dev)
>> > +                       goto hash;
>> > +
>> > +               count = slaves ? READ_ONCE(slaves->count) : 0;
>> > +               if (unlikely(!count))
>> > +                       return NULL;
>> > +
>> > +               for (idx = 0; idx < count; idx++) {
>> > +                       slave = slaves->arr[idx];
>> > +                       if (slave->dev->ifindex == dev->ifindex)
>> > +                               return slave;
>> > +               }
>> > +       }
>> > +
>> > +hash:
>> >         hash = bond_xmit_hash(bond, skb);
>> >         count = slaves ? READ_ONCE(slaves->count) : 0;
>> >         if (unlikely(!count))
>> > =========================================================================
>> > 
>> > If we make this as a configurable bonding option, would this be an
>> > acceptable solution to accelerate numa-aware apps?
>> 
>> 	Assuming for the moment this is for "regular" network devices
>> installed one per NUMA node, why do this in bonding instead of at a
>> higher layer (multiple subnets or ECMP, for example)?
>> 
>> 	Is the intent here that the bond would aggregate its interfaces
>> via LACP with the peer being some kind of cross-chassis link aggregation
>> (MLAG, et al)?

No.

>
>Yes. basic LACP bonding setup. There could be multiple peers connecting to
>the server via switch providing LACP based link aggregation. No cross-chassis
>MLAG.

LACP does not make any sense, when you have only a single physical port.
That applies to ECMP mentioned above too I believe.



