Return-Path: <netdev+bounces-67230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F68426BE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E9A2828D6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4C6D1C3;
	Tue, 30 Jan 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZD66PQl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D26D1BA
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624238; cv=none; b=FTEDQzDhX6pQ9ejYIQ4z9GcEHU+0jvJHv1smsg0gc5NwJlYcBCaWaTip/PuwmaBFRbgo6ONU9SHpi6WclCmMdmjoeVgB1s1p2LfkIl7MSMISbxJwUjJ8xn+rEWqzvMvCygM291DZrtSg0+El2DtqV61lbCUKpWcCXiJpq6LSbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624238; c=relaxed/simple;
	bh=1xBIl8GZkB7K5VFi0QysmWLfiKb/D7WCdMvy9HJqmSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZptZG5B4ml8xG9gxG6eYio7G7XI2ZrJ5beYhD/0hTSd6oj25kwSiP9dlbJG3ZKkjIThF7FEIE6G4ibgH8TFSDhqIodkAuCz9Az0keLmZoRz8l5PMA2ArvP1VVUV5ZLFBPb2YPsKFftg2Qjwk3JU7ZumkeD2YI7zw8qj6cwShtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZD66PQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04CC43390;
	Tue, 30 Jan 2024 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706624237;
	bh=1xBIl8GZkB7K5VFi0QysmWLfiKb/D7WCdMvy9HJqmSs=;
	h=Date:From:To:Cc:Subject:From;
	b=FZD66PQlE/M/vlHNkJRe+O2oygcLs56dtHrmvozy2L8c3obi8xEGJsqfM8qAfdusi
	 JLUVIMQBvFdF6ZBTPhlSS8nW2YgAMgyxnFNfWKp2ZI0COeb/yGDbNpKs1rkjZx4p+f
	 XWBmeoTN0sTR5d7VkwCxbdtS+pdy5jxg88kGhgCyp0c47INV/wjMMTfdVrLmMFqpqe
	 6DTXdctO5Loc4VwysTyiL1/zzZlS+VhFrobs20b5+3h7PP8kBrMplqec3FwU1ObOim
	 nB3UPJsXiFabFAMrOVadozDHbd/dgZ4LXehvbR2l/7i2xdvKuRuAkWL+rtGawe0fii
	 4iH8Qq2H9JUPA==
Date: Tue, 30 Jan 2024 08:17:16 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: i40e XDP program stops transmitting after link down/up
Message-ID: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I got a inquiry from a colleague about a behavior he's seeing with i40e
but not with other NICs. The interfaces are bonded with a XDP
load-balancer program attached to them. After 'ip link set ethX down; ip
link set ethX up' on one of the interfaces the XDP program on that
interface is no longer transmitting packets. He found that tx starts
again after running 'sudo ethtool -t ethX'.

There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
timeout' message in dmesg when disabling the interface. I've included
the relevant portions from dmesg below.

This was first observed with a 6.1 kernel, but we've confirmed that the
behavior is the same in 6.7. I realize the firmware is pretty old, so
far our attempts to update the NVM have failed.

Thanks,
Seth

[    0.000000] Linux version 6.7.0 (root@616a530b3729) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #2 SMP Thu Jan 25 10:37:21 EST 2024
...
[    9.038171] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    9.044447] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
...
[    9.064833] i40e 0000:d8:00.0: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
...
[    9.320886] i40e 0000:d8:00.0: MAC address: xx:xx:xx:xx:xx:xx
[    9.327030] i40e 0000:d8:00.0: FW LLDP is enabled
[    9.344331] i40e 0000:d8:00.0 eth0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[    9.355552] i40e 0000:d8:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    9.374074] i40e 0000:d8:00.0: Features: PF-id[0] VFs: 64 VSIs: 66 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
...
[    9.401522] i40e 0000:d8:00.1: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
...
[    9.652066] i40e 0000:d8:00.1: MAC address: xx:xx:xx:xx:xx:xx
[    9.658040] i40e 0000:d8:00.1: FW LLDP is enabled
[    9.688622] i40e 0000:d8:00.1 eth1: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[    9.699822] i40e 0000:d8:00.1: PCI-Express: Speed 8.0GT/s Width x8
[    9.719259] i40e 0000:d8:00.1: Features: PF-id[1] VFs: 64 VSIs: 66 QP: 32 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[    9.401522] i40e 0000:d8:00.1: fw 7.0.50775 api 1.8 nvm 7.00 0x80004c97 1.2154.0 [8086:1583] [8086:0002]
...
[   13.948968] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
[   13.956753] i40e 0000:d8:00.0: SW DCB initialization succeeded.
[   13.970005] i40e 0000:d8:00.0: FW LLDP is disabled
...
[   14.113004] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
[   14.120800] i40e 0000:d8:00.1: SW DCB initialization succeeded.
[   14.133940] i40e 0000:d8:00.1: FW LLDP is disabled
...
[   14.267874] bonding: bond0 is being created...
[   14.979070] i40e 0000:d8:00.1 eth1: set new mac address xx:xx:xx:xx:xx:xx
[   14.994445] bond0: (slave eth1): Enslaving as a backup interface with an up link
[   14.994681] i40e 0000:d8:00.0 eth0: set new mac address xx:xx:xx:xx:xx:xx
[   15.010359] bond0: (slave eth0): Enslaving as a backup interface with an up link
[   15.912874] i40e 0000:d8:00.0: Stop LLDP AQ command failed =0x1
[   15.944842] i40e 0000:d8:00.1: Stop LLDP AQ command failed =0x1
[   41.262871] 8021q: 802.1Q VLAN Support v1.8
[   41.262890] 8021q: adding VLAN 0 to HW filter on device eth0
[   41.262902] 8021q: adding VLAN 0 to HW filter on device eth1
[   41.262914] 8021q: adding VLAN 0 to HW filter on device bond0
[   48.272456] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
[   48.280233] i40e 0000:d8:00.0: SW DCB initialization succeeded.
[   48.307415] i40e 0000:d8:00.0: User requested queue count/HW max RSS count:  12/32
[   48.440266] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
[   48.448025] i40e 0000:d8:00.1: SW DCB initialization succeeded.
[   48.475051] i40e 0000:d8:00.1: User requested queue count/HW max RSS count:  12/32
[   58.935900] i40e 0000:d8:00.0: FW LLDP is disabled, attempting SW DCB
[   58.945123] i40e 0000:d8:00.0: SW DCB initialization succeeded.
[   59.131772] i40e 0000:d8:00.1: FW LLDP is disabled, attempting SW DCB
[   59.139560] i40e 0000:d8:00.1: SW DCB initialization succeeded.
[  336.363825] i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable timeout
[  336.603619] bond0: (slave eth1): link status definitely down, disabling slave
[  345.464976] 8021q: adding VLAN 0 to HW filter on device eth1
[  345.547358] bond0: (slave eth1): link status definitely up, 40000 Mbps full duplex
[  345.547379] bond0: active interface up!

