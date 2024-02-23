Return-Path: <netdev+bounces-74225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838878608AE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BBC1C2123F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26640B67A;
	Fri, 23 Feb 2024 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GtT+zFoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C6B653
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653913; cv=none; b=nO0C64dx8Oeoc55DtySTgj6QGED6MLR5Tcsl79u620Ey+XMN2xdlQMZ+Gq0qucaDJa6twkZXXR9IwgKDOqpahUkT1OLZMqjmKzQj6ua+cZXjYQr6G1qgg6QfDOOa4l4uqemU909ICGmk5nrvN9m/DFK2yNRF9VW83go6n1eh5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653913; c=relaxed/simple;
	bh=wdso368jPSf8CFYB2IoiNm8DxZJJveNJvO5nJPxuwKw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Dp1YKgWR/+i2QcMXjro+8SebHp6V4waw6lxXjSuXb8Qrm+jk6TZDz+D7KWXzgCUXEu5Wucwor6iIn1BLQ0fbcf3nIilqi3wMTH7CHmtfduI/l0Bd2zTJhMei526X1yyXmQbhLYSHQo0cN3hFQwDJYsdMA/lPTMrSAO4i8KxpHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GtT+zFoa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4DC2B40C99
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708653905;
	bh=u25/PDWH2R1C/OfvmY98ZzjTVUaSo/GXZmXMgks0biU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=GtT+zFoa5CIf6Esimzs8NSD3KnDYS3NzGFNTn95tyjLBta1UZT2Q10JjeiPeEKqsa
	 Pe4kaMnahkKcDy/kcv8T83aH0xRAdsFLE8Pih21fWgl56V6tYBkr0aeJbUp+CJeH8t
	 d08mrleVA8xFw5N/kfWVsZzEM/XurlMoQsyJSxEtIKbvnFsxXjJDM8vKpPZrI16CSj
	 Lx/hEbtpUy3iavfofk9nEUxiXIsNtwm/AAwzHGg+BUGyzmDZ5tB8qgA+KF8uq5EckL
	 xlDtVpwO7/Sj+TzIJMUWrmRsSzZpEBJxudht84mqBMXwey5XENjxSiFMJNvXwP3zXo
	 bxkDs8tQtANoQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so295695a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 18:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708653903; x=1709258703;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u25/PDWH2R1C/OfvmY98ZzjTVUaSo/GXZmXMgks0biU=;
        b=s+OZoRMnOXC1hJOdfG1eq/T9SqNoLwCzQVrdnzKZSsDdDVJWV1txv6hV3q89FmqDoq
         yHbNrpKRKiojmKae6iSJ00YqL+iYUzzEf6fjIppybE1SYPltvC6PvZQoQQhlOVxv63KK
         ngV8Io5nC83KL8H0ZfAZ1nwFcpF7m1WYPCMccT7H0DrL2fFlOHUCbSYHGSCMRfMbSMQJ
         5TNPoFR3u1UfHx8fKpw51YfOU3/3u6k4MCJJC2jVFLLg+c4A2xkYR6FgigzrYC1RnhgL
         /1fMGg4jcNggfOlcs+w8BcLwCVsm61GoS/oxcwIKFo8p5eq9wK3mmXxT1pnH8bbdPz0V
         lZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiWlGItSI/Nw15QLyk92HRhDG088BsLa7y1JgG+0qq6/KpC7lsXB/0sdif8m3ZYcKdZafAlBb0CH9PyjTtsv3p9M+RQbAW
X-Gm-Message-State: AOJu0YyQIK5hWx91wRxLlifrXHxMgKk8K+mQn6+5MI0I8jspteXZG0qL
	t3gTaVBAPSEkySMOuM78Fl66VUqaTa0TrluZtum+jrK/QfonIaR1g+WviSaIoOqnehN84HDt2Ad
	28rVT9lttvM/3P/c7DnvX8It5juWVr42HBdCFMsg3ci2VrjBEJsqEHv77gGCgwgxQTayrpA==
X-Received: by 2002:a05:6a21:350d:b0:19e:a448:71cf with SMTP id zc13-20020a056a21350d00b0019ea44871cfmr772693pzb.24.1708653902996;
        Thu, 22 Feb 2024 18:05:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPL8kxtT7ho4QbYaiktWQxmQPj2CU61K1sElhnm7ZJLy8Evt6atcLx89D6NVqjv++R0xgw8g==
X-Received: by 2002:a05:6a21:350d:b0:19e:a448:71cf with SMTP id zc13-20020a056a21350d00b0019ea44871cfmr772672pzb.24.1708653902591;
        Thu, 22 Feb 2024 18:05:02 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id ne12-20020a17090b374c00b002996bfea625sm181773pjb.21.2024.02.22.18.05.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2024 18:05:02 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B431E5FF14; Thu, 22 Feb 2024 18:05:01 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id AC8DC9FAAA;
	Thu, 22 Feb 2024 18:05:01 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
cc: Jakub Kicinski <kuba@kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Tariq Toukan <ttoukan.linux@gmail.com>,
    Saeed Mahameed <saeed@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
    Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
    Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
    Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description for multi-pf netdev
In-reply-to: <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
References: <20240215030814.451812-1-saeed@kernel.org> <20240215030814.451812-16-saeed@kernel.org> <20240215212353.3d6d17c4@kernel.org> <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com> <20240220173309.4abef5af@kernel.org> <2024022214-alkalize-magnetize-dbbc@gregkh> <20240222150030.68879f04@kernel.org> <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
Comments: In-reply-to "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
   message dated "Thu, 22 Feb 2024 19:23:32 -0600."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16216.1708653901.1@famine>
Date: Thu, 22 Feb 2024 18:05:01 -0800
Message-ID: <16217.1708653901@famine>

Samudrala, Sridhar <sridhar.samudrala@intel.com> wrote:
>On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>> On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>>> On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>>>> Greg, we have a feature here where a single device of class net has
>>>> multiple "bus parents". We used to have one attr under class net
>>>> (device) which is a link to the bus parent. Now we either need to add
>>>> more or not bother with the linking of the whole device. Is there any
>>>> precedent / preference for solving this from the device model
>>>> perspective?
>>>
>>> How, logically, can a netdevice be controlled properly from 2 parent
>>> devices on two different busses?  How is that even possible from a
>>> physical point-of-view?  What exact bus types are involved here?
>> Two PCIe buses, two endpoints, two networking ports. It's one piece
>
>Isn't it only 1 networking port with multiple PFs?
>
>> of silicon, tho, so the "slices" can talk to each other internally.
>> The NVRAM configuration tells both endpoints that the user wants
>> them "bonded", when the PCI drivers probe they "find each other"
>> using some cookie or DSN or whatnot. And once they did, they spawn
>> a single netdev.
>> 
>>> This "shouldn't" be possible as in the end, it's usually a PCI device
>>> handling this all, right?
>> It's really a special type of bonding of two netdevs. Like you'd bond
>> two ports to get twice the bandwidth. With the twist that the balancing
>> is done on NUMA proximity, rather than traffic hash.
>> Well, plus, the major twist that it's all done magically "for you"
>> in the vendor driver, and the two "lower" devices are not visible.
>> You only see the resulting bond.
>> I personally think that the magic hides as many problems as it
>> introduces and we'd be better off creating two separate netdevs.
>> And then a new type of "device bond" on top. Small win that
>> the "new device bond on top" can be shared code across vendors.
>
>Yes. We have been exploring a small extension to bonding driver to enable
>a single numa-aware multi-threaded application to efficiently utilize
>multiple NICs across numa nodes.

	Is this referring to something like the multi-pf under
discussion, or just generically with two arbitrary network devices
installed one each per NUMA node?

>Here is an early version of a patch we have been trying and seems to be
>working well.
>
>=========================================================================
>bonding: select tx device based on rx device of a flow
>
>If napi_id is cached in the sk associated with skb, use the
>device associated with napi_id as the transmit device.
>
>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>
>diff --git a/drivers/net/bonding/bond_main.c
>b/drivers/net/bonding/bond_main.c
>index 7a7d584f378a..77e3bf6c4502 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5146,6 +5146,30 @@ static struct slave
>*bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>        unsigned int count;
>        u32 hash;
>
>+       if (skb->sk) {
>+               int napi_id = skb->sk->sk_napi_id;
>+               struct net_device *dev;
>+               int idx;
>+
>+               rcu_read_lock();
>+               dev = dev_get_by_napi_id(napi_id);
>+               rcu_read_unlock();
>+
>+               if (!dev)
>+                       goto hash;
>+
>+               count = slaves ? READ_ONCE(slaves->count) : 0;
>+               if (unlikely(!count))
>+                       return NULL;
>+
>+               for (idx = 0; idx < count; idx++) {
>+                       slave = slaves->arr[idx];
>+                       if (slave->dev->ifindex == dev->ifindex)
>+                               return slave;
>+               }
>+       }
>+
>+hash:
>        hash = bond_xmit_hash(bond, skb);
>        count = slaves ? READ_ONCE(slaves->count) : 0;
>        if (unlikely(!count))
>=========================================================================
>
>If we make this as a configurable bonding option, would this be an
>acceptable solution to accelerate numa-aware apps?

	Assuming for the moment this is for "regular" network devices
installed one per NUMA node, why do this in bonding instead of at a
higher layer (multiple subnets or ECMP, for example)?

	Is the intent here that the bond would aggregate its interfaces
via LACP with the peer being some kind of cross-chassis link aggregation
(MLAG, et al)?

	Given that sk_napi_id seems to be associated with
CONFIG_NET_RX_BUSY_POLL, am I correct in presuming the target
applications are DPDK-style busy poll packet processors?

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

