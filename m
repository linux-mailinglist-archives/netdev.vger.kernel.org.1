Return-Path: <netdev+bounces-118336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533419514D3
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734061C25049
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00077F11;
	Wed, 14 Aug 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="TcI8WF2K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562C13AA27
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618448; cv=none; b=FC4uZdYNKWeFGJCIDAEfjd9db9tqNiAbJrUMFQETzt2MLMz873vr6et0BTyhtummorh3Z3bGBBHnIpr6elq6WRyou3w/cOwDGZlSXfAgJ6+iZkyY5YKQOVG0xi/LScC5v5NbxTP3KzyH2pePOqF2b87O88sPUqRzS9RkClX7Wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618448; c=relaxed/simple;
	bh=+vfRSpI18Yf1ZfrKU05BRJmRw6VwEV9+GjEgW1YVXtY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjN6nqfnOy9WAeAI9hKSQycsWAxQ0fuTQjxBAs2REI4Xsb6hJ+PSDT9KUVKPJLAaDktKpgzzTn8t6ExUec1H6oo4+eKZVs6CvfnvJ8tVMJZlpjB8BbByf8fTU2aASJTfDefC+AOdcByi2c+xkvY1G1uNiE4ZAjlAY7Wc4gpN1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=TcI8WF2K; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso65213511fa.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1723618444; x=1724223244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEaPJY1jV0tPNyOEVQIOq2rulCYzJWHwSjLzgFRg7mg=;
        b=TcI8WF2KVcg6W62zlCAxvr0zgcSKOnHH273Al68p55nM6SM0aQnO+uCdkVk7KgKcDk
         6wTwrYA66lTo222RYjhq6cmkNXmSaX+E1AqTPX+wmd1MX0OkxSSpwpxx3maBRykqWVdW
         52gW2y2LhColDUt/AdOlwXsTaQPcipI/MmgfMsBNAsAbf1UeQDB5IxJDlMiCbBk80Zo7
         FGfjfehgO1clkfwOX4NXbiSgt1KlGKl156vntXqm9QaQeP4otjelqIwS9YKbT1U2MsJ4
         ArIZHir1k2gZ/5cUlunCZTIekveoWrxo6v/SNWO6P91jVHerac4BMV1GacoJroioR7Cn
         Y9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618444; x=1724223244;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EEaPJY1jV0tPNyOEVQIOq2rulCYzJWHwSjLzgFRg7mg=;
        b=UCJNHIo3ABoWlBYuuemVEmFDWXe/VxMmRzAjvwwgcNMSK6NT7LzGlKuLQJMazhZD+w
         ydMdCkj2APxb3tmTsjk6VmNz04/WX0G/6Q5j+ffOyhhaSc/VRs9gvZknVyvya4Zi60tx
         bf36wgLFxY0gJ6wUJWJcOzi3MtFxp0MFYZO/tt2L+FaVi1oWq1Umz8cx/58pkqad4M4/
         PeHGV9Gn4P6dbHc7BE8MZu8sqJnjnQaF0hBu+uAoBNgSL/hpEnJWy8vIo8qXxhqK0JCL
         CsVYq+5rPOA0Rybp1ErOf6lYKyAZOLC3PtJ5fgwPBWiweHbIF8bSdpSR7Idh58kub/rU
         NdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIgmyWzubihrvNAMQHJLvvT1v6bKr9Bk4etErktnwETolP57c6qpX5hVQWAZQ1U8HIj6Oibv6zP7BjEijiAAGj7SgDmiMo
X-Gm-Message-State: AOJu0YxGg/dgm9wTP8/udluAeW+Fe0PgCHIP3H8SrnbOYIo7/E7GYhyf
	R39wfii4EyFF8QNlgOx8hLD8I6oyk8T4+lR6htrORizvnaXntYew9U9P79gytim3NkzM4136k0p
	P
X-Google-Smtp-Source: AGHT+IGIOyvDUYOA+jjpuEil/HvBtTHumduIcp7JiWn5PRn2D/MkXL6pPrK+bnKNArxMKLMVEiF7lQ==
X-Received: by 2002:a2e:4a11:0:b0:2f1:a509:ce66 with SMTP id 38308e7fff4ca-2f3aa1a574emr9694761fa.5.1723618443940;
        Tue, 13 Aug 2024 23:54:03 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f29203ced4sm13156131fa.86.2024.08.13.23.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:54:03 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, netdev
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: understanding switchdev notifications
In-Reply-To: <d5c526af-5062-42ed-9d92-f7fc97a5d4bd@alliedtelesis.co.nz>
References: <d5c526af-5062-42ed-9d92-f7fc97a5d4bd@alliedtelesis.co.nz>
Date: Wed, 14 Aug 2024 08:54:02 +0200
Message-ID: <87jzgjfvcl.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On tor, aug 08, 2024 at 12:48, Chris Packham <chris.packham@alliedtelesis.c=
o.nz> wrote:
> Hi,
>
> I'm trying to get to grips with how the switchdev notifications are=20
> supposed to be used when developing a switchdev driver.
>
> I have been reading through=20
> https://www.kernel.org/doc/html/latest/networking/switchdev.html which=20
> covers a few things but doesn't go into detail around the notifiers that=
=20
> one needs to implement for a new switchdev driver (which is probably=20
> very dependent on what the hardware is capable of).
>
> Specifically right now I'm looking at having a switch port join a vlan=20
> aware bridge. I have a configuration something like this
>
>  =C2=A0=C2=A0=C2=A0 ip link add br0 type bridge vlan_filtering 1
>  =C2=A0=C2=A0=C2=A0 ip link set sw1p5 master br0
>  =C2=A0=C2=A0=C2=A0 ip link set sw1p1 master br0
>  =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev br0 self
>  =C2=A0=C2=A0=C2=A0 ip link add link br0 br0.2 type vlan id 2
>  =C2=A0=C2=A0=C2=A0 ip addr add dev br0.2 192.168.2.1/24
>  =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan5 pvid untagged
>  =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan1
>  =C2=A0=C2=A0=C2=A0 ip link set sw1p5 up
>  =C2=A0=C2=A0=C2=A0 ip link set sw1p1 up
>  =C2=A0=C2=A0=C2=A0 ip link set br0 up
>  =C2=A0=C2=A0=C2=A0 ip link set br0.2 up
>
> Then I'm testing by sending a ping to a nonexistent host on the=20
> 192.168.2.0/24 subnet and looking at the traffic with tcpdump on another=
=20
> device connected to sw1p5.
>
> I'm a bit confused about how I should be calling=20
> switchdev_bridge_port_offload(). It takes two netdevs (brport_dev and=20
> dev) but as far as I've been able to see all the callers end up passing=20
> the same netdev for both of these (some create a driver specific brport=20
> but this still ends up with brport->dev and dev being the same object).

In the simple case when a switchport is directly attached to a bridge,
brport_dev and dev will be the same. If the attachment is indirect, via
a bond for example, they will differ:

       br0
       /
    bond0
   /    \
sw1p1  sw1p5

In the setup above, the bridge has no reference to any sw*p* interfaces,
all generated notifications will reference "bond0". By including the
switchdev port in the message back to the bridge, it can perform
validation on the setup; e.g. that bond0 is not made up of interfaces
from different hardware domains.

> I've figured out that I need to set tx_fwd_offload=3Dtrue so that the=20
> bridge software only sends one packet to the hardware. That makes sense=20
> as a way of saying the my hardware can take care of sending the packet=20
> out the right ports.
>
> I do have a problem that what I get from the bridge has a vlan tag=20
> inserted (which makes sense in sw when the packet goes from br0.2 to=20
> br0). But I don't actually need it as the hardware will insert a tag for=
=20
> me if the port is setup for egress tagging. I can shuffle the Ethernet=20
> header up but I was wondering if there was a way of telling the bridge=20
> not to insert the tag?

Signaling tx_fwd_offload=3Dtrue means assuming responsibility for
delivering each packet to all ports that the bridge would otherwise have
sent individual skbs for.

Let's expand your setup slightly, and see why you need the tag:

   br0.2 br0.3
       \ /
       br0
      / |  \
     /  |   \
sw1p1 sw1p3  sw1p5
(2U)  (3U)  (2T,3T)

sw1p5 is now a trunk. We can trigger an ARP broadcast to be sent out
either via br0.2 or br0.3, depending on the subnet we choose to target.

Your driver will receive a single skb to transmit, and skb->dev can be
set to any of sw1p{1,3,5} depending on config order, FDB entries
(i.e. the order of previously received packets) etc., and is thus
nondeterministic.

So presumably, even though you might need to remove the 802.1Q tag from
the frame, you need some way of tagging the packet with the correct VID
in order for the hardware to do the right thing; possibly via a field in
the vendor's hardware specific tag.

> Finally I'm confused about the atomic_nb/atomic_nb parameters. Some=20
> drivers just pass NULL and others pass the same notifier blocks that=20
> they've already registered with=20
> register_switchdev_notifier()/register_switchdev_notifier(). If=20
> notifiers are registered why does switchdev_bridge_port_offload() take=20
> them as parameters?

Because when you add a port to the bridge, lots of stuff that you want
to offload might already have been configured. E.g., imagine that you
were to add vlan 2 to br0 before adding the switchports; then you
probably need those events to be replayed to the new ports in order to
add your CPU-facing switchport to vlan 2. However, we do not want to
bother existing bridge members with duplicated events (and risk messing
up any reference counters they might maintain for these
objects). Therefore we bypass the standard notifier calls and "unicast"
the replay events only to the driver for the port being added.

> Thanks,
> Chris

