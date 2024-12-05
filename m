Return-Path: <netdev+bounces-149459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8499E5B85
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F07D1638A4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D321D5AC;
	Thu,  5 Dec 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="rCPZEs6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318814A8B;
	Thu,  5 Dec 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416460; cv=none; b=d2ss6JgGlmWgf8dj+Jxj2KvjSImzT4wk7uttKXLX3F7D7dxqDnnwq8htyo+psdEVKwlIrElv20sWngO2qgPdnEmkC40AAD9QaRbhXXyzA0gnl7f4HHcW/b0Pv2RO8w3AliWbvoIHtVjpBr98CFYoulR5mZgO6sT9lIkS/h7EDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416460; c=relaxed/simple;
	bh=0lswcrrrf/epOFGJdVWca3PuFg+KtbXYaCM3HgesehQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boWgPS10TUunQfWK+96QvyjWRlTwLY3Ez2pvgMm70UHiOb4v9vEZ2BBYXOVVMk+vnz/uBWi3lyhsNoBe05aL05PTxZR2McacA0R/fqJuiPoiHbLnxaagPl+IE/kmlq/4yyDrM61lV/s33oLhn7eeaIq+6qQ9bnagSQiABHXQL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=rCPZEs6y; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id AE94E240E27;
	Thu,  5 Dec 2024 17:28:57 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id D58022403E9;
	Thu,  5 Dec 2024 17:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1733416135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wbYhcwj77z2TOLb2TYf0vGG0ElaCD4syUYO4qjcAdU=;
	b=rCPZEs6y1TtoeQUjUIlXzARZlVvsqqv76nJY8JGLTxcU59QtEo/Xs15n7/NwT9EaDQM/pC
	RnVsKWkIRN0+X3JbZHVoiXBZfq2UNB0NrsENqUVIgM6D74bG0KVNr1egu11sM56MNxyIN5
	TZpR/rL1XR8PPRmr2WFD4UKxkSM0jhAt4QZ24Zik5MNDR6yADzf2wxeAoSTJFPVkiAVp/x
	bxEWxEhl1ayHirGsJDHM8NSwBSN9NpRY5LBypXwGtPYOClSBXYVqqIoI1JVj7sU9El1nY7
	MozX5msAirwNMHjb/u6fcP0ySpx+R2N7ZMqCMbSfMZmUaAg+SiQoVV946aI+FA==
Received: from [10.10.34.132] (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 4DDE32405C5;
	Thu,  5 Dec 2024 17:28:54 +0100 (CET)
Message-ID: <665459ff-9e99-4d22-9aeb-69c34be3db6b@tk154.de>
Date: Thu, 5 Dec 2024 17:28:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: sysfs: also pass network device driver
 to uevent
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, idosch@nvidia.com, petrm@nvidia.com
References: <20241115140621.45c39269@kernel.org>
 <20241116163206.7585-1-mail@tk154.de> <20241116163206.7585-2-mail@tk154.de>
 <20241118175543.1fbcab44@kernel.org>
Content-Language: en-US, de-DE
From: Til Kaiser <mail@tk154.de>
In-Reply-To: <20241118175543.1fbcab44@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: e2e151
X-Rspamd-UID: 9a904b

On 19.11.24 02:55, Jakub Kicinski wrote:
> On Sat, 16 Nov 2024 17:30:30 +0100 Til Kaiser wrote:
>> Currently, for uevent, the interface name and
>> index are passed via shell variables.
>>
>> This commit also passes the network device
>> driver as a shell variable to uevent.
>>
>> One way to retrieve a network interface's driver
>> name is to resolve its sysfs device/driver symlink
>> and then substitute leading directory components.
>>
>> You could implement this yourself (e.g., like udev from
>> systemd does) or with Linux tools by using a combination
>> of readlink and shell substitution or basename.
>>
>> The advantages of passing the driver directly through uevent are:
>>   - Linux distributions don't need to implement additional code
>>     to retrieve the driver when, e.g., interface events happen.
>>   - There is no need to create additional process forks in shell
>>     scripts for readlink or basename.
>>   - If a user wants to check his network interface's driver on the
>>     command line, he can directly read it from the sysfs uevent file.
> 
> Thanks for the info, since you're working on an open source project
> - I assume your exact use case is not secret, could you spell it
> out directly? What device naming are you trying to achieve based on
> what device drivers? In my naive view we have 200+ Ethernet drivers
> so listing Ethernet is not scalable. I'm curious what you're matching,
> how many drivers you need to list, and whether we could instead add a
> more general attribute...
> 
> Those questions aside, I'd like to get an ack from core driver experts
> like GregKH on this. IDK what (if any) rules there are on uevents.
> The merge window has started so we are very unlikely to hear from them
> now, all maintainers will be very busy. Please repost v3 in >=two weeks
> and CC Greg (and whoever else is reviewing driver core and/or uevent
> changes according to git logs).

We have some Mellanox Spectrum Switches here whose network interface 
names don't match their faceplate. They are called eth... and their 
numbering is also out of order, so we would like to rename them 
accordingly. They are using the mlxsw_spectrum driver.

Generally, you could do that once at boot time, but those Spectrum 
Switches also support port splitting. That means you can attach a 
breakout cable to one of its ports and then use the devlink tool to 
split the network interface into multiple ones in Linux. But the split 
network interfaces are then called eth... again:

root@SN2100:~# ip l | tail -n2
26: swp1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
     link/ether 50:6b:4b:9f:04:59 brd ff:ff:ff:ff:ff:ff
root@SN2100:~# devlink port split swp1 count 4
root@SN2100:~# ip l | tail -n8
27: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
     link/ether 50:6b:4b:9f:04:59 brd ff:ff:ff:ff:ff:ff
28: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
     link/ether 50:6b:4b:9f:04:5a brd ff:ff:ff:ff:ff:ff
29: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
     link/ether 50:6b:4b:9f:04:5b brd ff:ff:ff:ff:ff:ff
30: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
     link/ether 50:6b:4b:9f:04:5c brd ff:ff:ff:ff:ff:ff

In their GitHub wiki [1], Mellanox recommends using a udev rule for 
renaming. udev has its implementation for retrieving the driver of a 
network interface, whereas OpenWrt's hotplug doesn't have such an 
implementation. With this patch, the driver name would be already 
available inside such hotplug scripts.

[1] 
https://github.com/Mellanox/mlxsw/wiki/Switch-Port-Configuration#using-udev-rules

