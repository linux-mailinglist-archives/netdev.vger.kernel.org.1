Return-Path: <netdev+bounces-116638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998794B458
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B04E1F233A4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F7010E9;
	Thu,  8 Aug 2024 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DSfjdoce"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC144A1E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078525; cv=none; b=ezFmGqgouDYmCM+t8O4ffw6rI+MFW858eYQ4mwbQWvdVGmbSP8Epp0UGXuHZlz7v9Th6afuBAbeS7EU3KSQB/yvQHnlNQvXA9Vy3yAVOPRLK3dcYVJzSdWyUvyZJz6uOWaOneppT9HX97sauFj9U9P6UPZHMgyhLqpDiQXyBhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078525; c=relaxed/simple;
	bh=9oc+hcUt/FX/qxtebA4LB9ziVi4PozR6VE6uGf6V9Zk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N+XMXKDrFY/xfYVAFHqq3v2EVTo0k0hP39CFM20Gtfu711pN83rW7XXKQxWoNBViBTIB1g5DvuVImdzSg8gc+hxYHlMh91tA6ZHoM/viEqpo036QhQkv4gE4o+Ycct0j7u0bhmzua0kkimG4iFXl+No+S6WMk1ySYnLtW53PfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DSfjdoce; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 11B182C0301;
	Thu,  8 Aug 2024 12:48:18 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1723078098;
	bh=9oc+hcUt/FX/qxtebA4LB9ziVi4PozR6VE6uGf6V9Zk=;
	h=Date:To:From:Subject:From;
	b=DSfjdocekjsZ/kk5cZv78IjUpLX9y2GZcKrljin+C56tmzkT4TX+Hzof6mSjEHMbz
	 EoLDPyLE1g9KzuA+jB1OdR4ptD+em8UhYJmTpofjRGiyW9j0lP0IZVPlcn+ZQaaw50
	 pP6SLto6Y2/2MGlOv7WXsKxGcUpb+Vk/txVzDMwCb2HdyypcNvJ2myLEtdQoLXd1GN
	 9SSfTKBt31sxBK0GyBSdIaBH+8Mnpw9ImleCcdoBDUY08UqWn7x5z2LYbvjDFFThic
	 DZifTa4okqa2062k2zmcOwbZUM+26TB9BD++XJtFe80Sybd6X3O0pG0cPPf4QMCbdq
	 0gBWMwIyJqAhA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66b415d10000>; Thu, 08 Aug 2024 12:48:17 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id DC84113EE41;
	Thu,  8 Aug 2024 12:48:17 +1200 (NZST)
Message-ID: <d5c526af-5062-42ed-9d92-f7fc97a5d4bd@alliedtelesis.co.nz>
Date: Thu, 8 Aug 2024 12:48:17 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: understanding switchdev notifications
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=66b415d1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=rzgwEc8jZHYV5HFceJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=aOckU8jMy-YA:10 a=pAl8zCnWZt0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi,

I'm trying to get to grips with how the switchdev notifications are=20
supposed to be used when developing a switchdev driver.

I have been reading through=20
https://www.kernel.org/doc/html/latest/networking/switchdev.html which=20
covers a few things but doesn't go into detail around the notifiers that=20
one needs to implement for a new switchdev driver (which is probably=20
very dependent on what the hardware is capable of).

Specifically right now I'm looking at having a switch port join a vlan=20
aware bridge. I have a configuration something like this

 =C2=A0=C2=A0=C2=A0 ip link add br0 type bridge vlan_filtering 1
 =C2=A0=C2=A0=C2=A0 ip link set sw1p5 master br0
 =C2=A0=C2=A0=C2=A0 ip link set sw1p1 master br0
 =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev br0 self
 =C2=A0=C2=A0=C2=A0 ip link add link br0 br0.2 type vlan id 2
 =C2=A0=C2=A0=C2=A0 ip addr add dev br0.2 192.168.2.1/24
 =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan5 pvid untagged
 =C2=A0=C2=A0=C2=A0 bridge vlan add vid 2 dev lan1
 =C2=A0=C2=A0=C2=A0 ip link set sw1p5 up
 =C2=A0=C2=A0=C2=A0 ip link set sw1p1 up
 =C2=A0=C2=A0=C2=A0 ip link set br0 up
 =C2=A0=C2=A0=C2=A0 ip link set br0.2 up

Then I'm testing by sending a ping to a nonexistent host on the=20
192.168.2.0/24 subnet and looking at the traffic with tcpdump on another=20
device connected to sw1p5.

I'm a bit confused about how I should be calling=20
switchdev_bridge_port_offload(). It takes two netdevs (brport_dev and=20
dev) but as far as I've been able to see all the callers end up passing=20
the same netdev for both of these (some create a driver specific brport=20
but this still ends up with brport->dev and dev being the same object).

I've figured out that I need to set tx_fwd_offload=3Dtrue so that the=20
bridge software only sends one packet to the hardware. That makes sense=20
as a way of saying the my hardware can take care of sending the packet=20
out the right ports.

I do have a problem that what I get from the bridge has a vlan tag=20
inserted (which makes sense in sw when the packet goes from br0.2 to=20
br0). But I don't actually need it as the hardware will insert a tag for=20
me if the port is setup for egress tagging. I can shuffle the Ethernet=20
header up but I was wondering if there was a way of telling the bridge=20
not to insert the tag?

Finally I'm confused about the atomic_nb/atomic_nb parameters. Some=20
drivers just pass NULL and others pass the same notifier blocks that=20
they've already registered with=20
register_switchdev_notifier()/register_switchdev_notifier(). If=20
notifiers are registered why does switchdev_bridge_port_offload() take=20
them as parameters?

Thanks,
Chris



