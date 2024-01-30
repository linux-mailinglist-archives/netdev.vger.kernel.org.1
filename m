Return-Path: <netdev+bounces-67281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45A8428EE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0576CB269DB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439E86ADE;
	Tue, 30 Jan 2024 16:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397486AD7
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631314; cv=none; b=F98a2y80Qv1gX8sXvWjyN2F5K509cwKXJ2MKbmqrzd2qaC8Q+U/Kd4FcPr8lT0atMvjHeGQ+g40+q7rjB8EHYk/XMeYY5NQ27nvjN24qHpU5C4KjJ9SWKguD78dxW2pa4remnYvkNYnVC6gf80QoiyhxjIkpprxDvjFdjmlA71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631314; c=relaxed/simple;
	bh=fzXJS4DweGCSI6aBj0vKMbw+Ersps+rvvCvxsQ4JjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovHIY+atgSp7ybMMNAUd5AQUYPjNbrRqMkOYv7AlwjZCTGFqnedP2Tyc51HveMKbi9R+FjROnglNs0mEmPKPaiNaPnBVp+sNn4rgWqWgqjwiNeiXYnsMSRN8Wy1mPxTgbR71K/5FoQKVMRfXKn96LSc2I/0lavShJqv6BT4ZN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75AC661E5FE01;
	Tue, 30 Jan 2024 17:14:24 +0100 (CET)
Message-ID: <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>
Date: Tue, 30 Jan 2024 17:14:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] i40e XDP program stops transmitting after link
 down/up
Content-Language: en-US
To: Seth Forshee <sforshee@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Seth,


Thank you for bring this up.

Am 30.01.24 um 15:17 schrieb Seth Forshee:
> I got a inquiry from a colleague about a behavior he's seeing with i40e
> but not with other NICs. The interfaces are bonded with a XDP
> load-balancer program attached to them. After 'ip link set ethX down; ip
> link set ethX up' on one of the interfaces the XDP program on that
> interface is no longer transmitting packets. He found that tx starts
> again after running 'sudo ethtool -t ethX'.
> 
> There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
> timeout' message in dmesg when disabling the interface. I've included
> the relevant portions from dmesg below.
> 
> This was first observed with a 6.1 kernel, but we've confirmed that the
> behavior is the same in 6.7. I realize the firmware is pretty old, so
> far our attempts to update the NVM have failed.

Does that mean, the problem didn’t happen before Linux 6.1? If so, if 
you have the reproducer and the time, bisecting the issue is normally 
the fastest way to solve the issue.


Kind regards,

Paul


> [    0.000000] Linux version 6.7.0 (root@616a530b3729) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #2 SMP Thu Jan 25 10:37:21 EST 2024
> ...
> [    9.038171] i40e: Intel(R) Ethernet Connection XL710 Network Driver
> [    9.044447] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> ...
> [    9.064833] i40e 0000:d8:00.0: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
> ...
> [    9.320886] i40e 0000:d8:00.0: MAC address: xx:xx:xx:xx:xx:xx
> [    9.327030] i40e 0000:d8:00.0: FW LLDP is enabled
> [    9.344331] i40e 0000:d8:00.0 eth0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [    9.355552] i40e 0000:d8:00.0: PCI-Express: Speed 8.0GT/s Width x8
> [    9.374074] i40e 0000:d8:00.0: Features: PF-id[0] VFs: 64 VSIs: 66 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
> ...
> [    9.401522] i40e 0000:d8:00.1: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
> ...
> [    9.652066] i40e 0000:d8:00.1: MAC address: xx:xx:xx:xx:xx:xx
> [    9.658040] i40e 0000:d8:00.1: FW LLDP is enabled
> [    9.688622] i40e 0000:d8:00.1 eth1: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [    9.699822] i40e 0000:d8:00.1: PCI-Express: Speed 8.0GT/s Width x8
> [    9.719259] i40e 0000:d8:00.1: Features: PF-id[1] VFs: 64 VSIs: 66 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
> [    9.401522] i40e 0000:d8:00.1: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
> ...
> [   13.948968] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
> [   13.956753] i40e 0000:d8:00.0: SW DCB initialization succeeded.
> [   13.970005] i40e 0000:d8:00.0: FW LLDP is disabled
> ...
> [   14.113004] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
> [   14.120800] i40e 0000:d8:00.1: SW DCB initialization succeeded.
> [   14.133940] i40e 0000:d8:00.1: FW LLDP is disabled
> ...
> [   14.267874] bonding: bond0 is being created...
> [   14.979070] i40e 0000:d8:00.1 eth1: set new mac address xx:xx:xx:xx:xx:xx
> [   14.994445] bond0: (slave eth1): Enslaving as a backup interface with an up link
> [   14.994681] i40e 0000:d8:00.0 eth0: set new mac address xx:xx:xx:xx:xx:xx
> [   15.010359] bond0: (slave eth0): Enslaving as a backup interface with an up link
> [   15.912874] i40e 0000:d8:00.0: Stop LLDP AQ command failed =0x1
> [   15.944842] i40e 0000:d8:00.1: Stop LLDP AQ command failed =0x1
> [   41.262871] 8021q: 802.1Q VLAN Support v1.8
> [   41.262890] 8021q: adding VLAN 0 to HW filter on device eth0
> [   41.262902] 8021q: adding VLAN 0 to HW filter on device eth1
> [   41.262914] 8021q: adding VLAN 0 to HW filter on device bond0
> [   48.272456] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
> [   48.280233] i40e 0000:d8:00.0: SW DCB initialization succeeded.
> [   48.307415] i40e 0000:d8:00.0: User requested queue count/HW max RSS count:  12/32
> [   48.440266] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
> [   48.448025] i40e 0000:d8:00.1: SW DCB initialization succeeded.
> [   48.475051] i40e 0000:d8:00.1: User requested queue count/HW max RSS count:  12/32
> [   58.935900] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
> [   58.945123] i40e 0000:d8:00.0: SW DCB initialization succeeded.
> [   59.131772] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
> [   59.139560] i40e 0000:d8:00.1: SW DCB initialization succeeded.
> [  336.363825] i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable timeout
> [  336.603619] bond0: (slave eth1): link status definitely down, disabling slave
> [  345.464976] 8021q: adding VLAN 0 to HW filter on device eth1
> [  345.547358] bond0: (slave eth1): link status definitely up, 40000 Mbps full duplex
> [  345.547379] bond0: active interface up!

