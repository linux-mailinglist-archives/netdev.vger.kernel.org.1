Return-Path: <netdev+bounces-193003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C1AC21C6
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8200217E90E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4922AE41;
	Fri, 23 May 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8ijAVjh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE022A4F0
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998470; cv=none; b=ccFl1+klSVWJiiQZ3JSUlBIjX86JF0xCj5+NLtV3VBeOszGDxT2eRC3wToyz0EpecHghLE8RExW6KCOobDM/+ZQT1Oq9VgU0tKYMte87iyvJf1FjiEnMIP9vu9lJCzlXQobAH2N7A4fQ03A1nQ4fRgwlIdfnsXc2ZTglz+ukjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998470; c=relaxed/simple;
	bh=tiqxC3eZym9ExZwgJUcvLNkmS2z31m2Y/nzQP0S4o8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5MfTZHiL2DhzPZZa5lBKenTn0Swa4mX4E0p0FIV1T9QGnGuxsj/OcUoESrxDDlN/C2/5g4NEOUYtk8Qscbui9Orm6tr2colY2EJbOkdAgCA14IPNucgfKR3eKrxIodIWqn3PhMEiRkJnF4D9D+Dc5xd9dSHwUwa4fJooxmxKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8ijAVjh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747998468; x=1779534468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tiqxC3eZym9ExZwgJUcvLNkmS2z31m2Y/nzQP0S4o8Q=;
  b=N8ijAVjh8nT5u5DEfmrTv0k6wdlXvhJQTeUplDjNJ7326JPkIIJZxv5X
   Er7TTzpE4ib97l9yG44X2OoTFENrXBN6B3xyocrGFsA8eMe9Z/AEFHqlR
   6XFvZgPK36uElSaiT4RmtpCkCkCx8wgxaImtfHBefOS/3DFcDmnUU+4xj
   FkaBZ9ba3Tw/S2IpRK3ODX15zcksMEDfv/TIhc6dOuCduuQ828oNosq6Q
   VzPrITIibgfh5QzF79IRxulz8dVFJ6Yvdf08PYNpCOsfoH8Bxz6UABo1q
   SJThIbAru0vtAm4rs4IrPP3dfAOyfBxjdxCoTK33i3e3teEs7seQRQJ/C
   A==;
X-CSE-ConnectionGUID: HsovjmS/QnK0k8bx7NJ3xw==
X-CSE-MsgGUID: 6T1s9nLLTJ+Qlx9Q83uuUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="72579134"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="72579134"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 04:07:47 -0700
X-CSE-ConnectionGUID: QGllusLeTEm/jhLR1hJ+Yw==
X-CSE-MsgGUID: gFDBOn5QSJmLGv0Cuxj1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141597498"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 23 May 2025 04:07:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id ADD511F6; Fri, 23 May 2025 14:07:43 +0300 (EEST)
Date: Fri, 23 May 2025 14:07:43 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250523110743.GK88033@black.fi.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>

Hi,

On Thu, May 22, 2025 at 07:19:52PM +0200, Ricard Bejarano wrote:
> Hi all,
> 
> Please excuse me if this is not the right place or way to report this, in which case I'd appreciate a pointer to the proper forum. I've CC'd every one who showed up in get_maintainer.pl.
> 
> I'm investigating a performance issue in the bridging of traffic coming in via a Thunderbolt 3/4 (thunderbolt-net driver) network interface. I don't think this is tracked from what I could find online.

Probably nobody tried this before you ;-)

> Summary:
> When a thunderbolt-net interface is slave to a bridge, traffic in the "other slave interfaces -> bridge -> thunderbolt-net interface" direction approximates maximum line bandwidth (~9Gbps in Thunderbolt 3, ~16Gbps in Thunderbolt 4); but traffic in the opposite "thunderbolt -> bridge -> other" direction drops to ~5Mbps (in my testing). More details below.

What is the performance without bridging?

I have to admit, I don't know much about how bridging works in Linux
networks stack so it is entirely possible that the thunderbolt-net driver
misses some important thing.

Anyways it would be good to concentrate on the link with poorest throughput
and start looking at that setup. After the non-bridged throughput
measumerement, can you send me full dmesg of both systems with
"thunderbolt.dyndbg=+p" in the kernel command line, once you have connected
them?

> I need some pointers on how to proceed.
> 
> Thanks,
> RB
> 
> -- 
> 
> ## 1. Setup
> 
> Three hosts:
> - `red`:
>   - Board: Intel NUC8i5BEH2
>   - CPU: 1x 4-core x86-64 (Intel Core i5-8259U)
>   - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
>   - Disk: 1x 120GB SATA SSD (Crucial BX500)
>   - Relevant interfaces:
>     - `br0` (`bridge` driver, `10.0.0.1/24` address)
>     - `tb0` (`thunderbolt-net` driver): maps to the board's Thunderbolt port, slave of `br0`
> - `blue`:
>   - Board: Intel NUC8i5BEH2
>   - CPU: 1x 4-core x86-64 (Intel Core i5-8259U)
>   - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
>   - Disk: 1x 120GB SATA SSD (Crucial BX500)
>   - Relevant interfaces:
>     - `br0` (`bridge` driver, `10.0.0.2/24` address)
>     - `tb0` (`thunderbolt-net` driver): maps to the board's Thunderbolt port, slave of `br0`
>     - `eno1` (`e1000e` driver): maps to the board's Ethernet port, slave of `br0`
> - `purple`:
>   - Board: Intel NUC8i5BEHS
>   - CPU: 1x 4-core x86-64 (Intel Core i5-8260U)
>   - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
>   - Disk: 1x 240GB M.2 SATA SSD (WD Green)
>   - Relevant interfaces:
>     - `br0` (`bridge` driver, `10.0.0.3/24` address)
>     - `eno1` (`e1000e` driver): maps to the board's Ethernet port, slave of `br0`
> 
> Connected with two cables:
> - Amazon Basics Thunderbolt 3 & 4 cable, connecting `red` (`tb0`) to `blue` (`tb0`).
> - Monoprice SlimRun Cat6A Ethernet cable, connecting `blue` (`eno1`) to `purple` (`eno1`).
> 
> All three running Linux 6.14.7 (built from source) on Ubuntu Server 24.04.2 LTS, running iperf 2.1.9 servers.
> See "4. References" section for details.
> 
> ## 2. The problem
> 
> As seen in [4.6.3b], traffic going in the `purple:br0 -> purple:eno1 -> blue:eno1 -> blue:br0 -> blue:tb0 -> red:tb0 -> red:br0` direction approaches line speed (~1Gbps).
> However, per [4.6.3a], traffic going in the opposite `red:br0 -> red:tb0 -> blue:tb0 -> blue:br0 -> blue:eno1 -> purple:eno1 -> purple:br0` direction is several orders of magnitude slower (~5Mbps).
> 
> This is abnormal, given [4.6.1] sets the bidirectional Thunderbolt line speed at ~9Gbps and [4.6.2] sets the bidirectional Ethernet line speed at ~1Gbps.
> 
> Per the above, we can safely assume that the problem is localized at `blue`, specifically in how `blue` bridges traffic out of `tb0` and into `eno1`.
> 
> From prior undocumented anecdata, we know this also happens in Thunderbolt-to-Thunderbolt bridged traffic, which hints at a problem in how traffic goes out of `tb0` and into `br0`, not with how traffic goes out of `br0` and into `eno1`.
> This is further consolidated by the fact that Ethernet-to-Ethernet bridging is known to approach line speed in both directions (or otherwise the Internet would be way slower, I suppose).
> 
> And finally, hosts are only assuming an IP address at their respective `br0` interfaces, and [4.6.1] shows line speed performance in the `red:br0 -> red:tb0 -> blue:tb0 -> blue:br0` direction (and reverse).
> Meaning, we can reduce the scope further to how traffic goes out of `tb0` and into some other slave of `br0`, but not `br0` itself.
> 
> ## 3. The solution
> 
>     ¯\_(;.;)_/¯
> 
> ## 4. References
> 
> ### 4.1. `uname -a`
> #### 4.1.1. `red`
> ```shell
> # red
> $ uname -a
> Linux red 6.14.7 #1 SMP PREEMPT_DYNAMIC Mon May 19 13:38:28 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> ```
> #### 4.1.2. `blue`
> ```shell
> # blue
> $ uname -a
> Linux blue 6.14.7 #1 SMP PREEMPT_DYNAMIC Mon May 19 15:01:20 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> ```
> #### 4.1.3. `purple`
> ```shell
> # purple
> $ uname -a
> Linux purple 6.14.7 #1 SMP PREEMPT_DYNAMIC Tue May 20 09:04:42 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> ```
> 
> ### 4.2. `ip a`
> #### 4.2.1. `red`
> ```shell
> # red
> $ ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host noprefixroute
>        valid_lft forever preferred_lft forever
> 2: eno1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>     link/ether 94:c6:91:a3:f5:1a brd ff:ff:ff:ff:ff:ff
>     altname enp0s31f6
> 3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 04:d3:b0:0f:e6:cd brd ff:ff:ff:ff:ff:ff
>     inet 192.168.10.201/23 metric 600 brd 192.168.11.255 scope global dynamic wlp0s20f3
>        valid_lft 163sec preferred_lft 163sec
>     inet6 fd9f:7271:415f:d845:6d3:b0ff:fe0f:e6cd/64 scope global dynamic mngtmpaddr noprefixroute
>        valid_lft 1724sec preferred_lft 1724sec
>     inet6 fe80::6d3:b0ff:fe0f:e6cd/64 scope link
>        valid_lft forever preferred_lft forever
> 6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether ce:42:52:00:a0:5b brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.1/24 brd 10.0.0.255 scope global br0
>        valid_lft forever preferred_lft forever
> 7: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP group default qlen 1000
>     link/ether 02:5f:d6:57:71:93 brd ff:ff:ff:ff:ff:ff
> ```
> #### 4.2.2. `blue`
> ```shell
> # blue
> $ ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host noprefixroute
>        valid_lft forever preferred_lft forever
> 2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP group default qlen 1000
>     link/ether 1c:69:7a:00:22:99 brd ff:ff:ff:ff:ff:ff
>     altname enp0s31f6
> 5: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether d0:c6:37:09:01:5a brd ff:ff:ff:ff:ff:ff
>     inet 192.168.10.200/23 metric 600 brd 192.168.11.255 scope global dynamic wlp0s20f3
>        valid_lft 247sec preferred_lft 247sec
>     inet6 fd9f:7271:415f:d845:d2c6:37ff:fe09:15a/64 scope global dynamic mngtmpaddr noprefixroute
>        valid_lft 1651sec preferred_lft 1651sec
>     inet6 fe80::d2c6:37ff:fe09:15a/64 scope link
>        valid_lft forever preferred_lft forever
> 6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 3a:4d:83:e0:ab:3b brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.2/24 brd 10.0.0.255 scope global br0
>        valid_lft forever preferred_lft forever
> 7: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP group default qlen 1000
>     link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
> ```
> #### 4.2.3. `purple`
> ```shell
> # purple
> $ ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host noprefixroute
>        valid_lft forever preferred_lft forever
> 2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UP group default qlen 1000
>     link/ether 1c:69:7a:60:d8:69 brd ff:ff:ff:ff:ff:ff
>     altname enp0s31f6
> 3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 94:e6:f7:7c:2d:fb brd ff:ff:ff:ff:ff:ff
>     inet 192.168.10.199/23 metric 600 brd 192.168.11.255 scope global dynamic wlp0s20f3
>        valid_lft 165sec preferred_lft 165sec
>     inet6 fd9f:7271:415f:d845:96e6:f7ff:fe7c:2dfb/64 scope global dynamic mngtmpaddr noprefixroute
>        valid_lft 1640sec preferred_lft 1640sec
>     inet6 fe80::96e6:f7ff:fe7c:2dfb/64 scope link
>        valid_lft forever preferred_lft forever
> 4: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 1a:45:1d:c0:46:02 brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.3/24 brd 10.0.0.255 scope global br0
>        valid_lft forever preferred_lft forever
> ```
> 
> ### 4.3. `ethtool -i br0`
> #### 4.3.1. `red`
> ```shell
> # red
> $ ethtool -i br0
> driver: bridge
> version: 2.3
> firmware-version: N/A
> expansion-rom-version:
> bus-info: N/A
> supports-statistics: no
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> ```
> #### 4.3.2. `blue`
> ```shell
> # blue
> $ ethtool -i br0
> driver: bridge
> version: 2.3
> firmware-version: N/A
> expansion-rom-version:
> bus-info: N/A
> supports-statistics: no
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> ```
> #### 4.3.3. `purple`
> ```shell
> # purple
> $ ethtool -i br0
> driver: bridge
> version: 2.3
> firmware-version: N/A
> expansion-rom-version:
> bus-info: N/A
> supports-statistics: no
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> ```
> 
> ### 4.4. `ethtool -i tb0`
> #### 4.4.1. `red`
> ```shell
> # red
> $ ethtool -i tb0
> driver: thunderbolt-net
> version: 6.14.7
> firmware-version:
> expansion-rom-version:
> bus-info: 0-1.0
> supports-statistics: no
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> ```
> #### 4.4.2. `blue`
> ```shell
> # blue
> $ ethtool -i tb0
> driver: thunderbolt-net
> version: 6.14.7
> firmware-version:
> expansion-rom-version:
> bus-info: 0-1.0
> supports-statistics: no
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> ```
> 
> ### 4.5. `ethtool -i eno1`
> #### 4.4.1. `blue`
> ```shell
> # blue
> $ ethtool -i eno1
> driver: e1000e
> version: 6.14.7
> firmware-version: 0.4-4
> expansion-rom-version:
> bus-info: 0000:00:1f.6
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
> ```
> #### 4.4.2. `purple`
> ```shell
> # purple
> $ ethtool -i eno1
> driver: e1000e
> version: 6.14.7
> firmware-version: 0.4-4
> expansion-rom-version:
> bus-info: 0000:00:1f.6
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
> ```
> 
> ### 4.6. `iperf` tests
> #### 4.6.1a. `red` to `blue`
> ```shell
> # red
> $ iperf -c 10.0.0.2
> ------------------------------------------------------------
> Client connecting to 10.0.0.2, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.1 port 38902 connected with 10.0.0.2 port 5001 (icwnd/mss/irtt=14/1448/538)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.0076 sec  11.0 GBytes  9.40 Gbits/sec
> ```
> #### 4.6.1b. `blue` to `red`
> ```shell
> # blue
> $ iperf -c 10.0.0.1
> ------------------------------------------------------------
> Client connecting to 10.0.0.1, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.2 port 49660 connected with 10.0.0.1 port 5001 (icwnd/mss/irtt=14/1448/464)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.0079 sec  10.8 GBytes  9.26 Gbits/sec
> ```
> #### 4.6.2a. `purple` to `blue`
> ```shell
> # purple
> $ iperf -c 10.0.0.2
> ------------------------------------------------------------
> Client connecting to 10.0.0.2, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.3 port 56150 connected with 10.0.0.2 port 5001 (icwnd/mss/irtt=14/1448/580)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.0358 sec  1.09 GBytes   933 Mbits/sec
> ```
> #### 4.6.2b. `blue` to `purple`
> ```shell
> # blue
> $ iperf -c 10.0.0.3
> ------------------------------------------------------------
> Client connecting to 10.0.0.3, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.2 port 37106 connected with 10.0.0.3 port 5001 (icwnd/mss/irtt=14/1448/958)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.0239 sec  1.09 GBytes   934 Mbits/sec
> ```
> #### 4.6.3a. `red` to `purple`
> ```shell
> # red
> $ iperf -c 10.0.0.3
> ------------------------------------------------------------
> Client connecting to 10.0.0.3, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.1 port 38260 connected with 10.0.0.3 port 5001 (icwnd/mss/irtt=14/1448/1578)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.2234 sec  5.88 MBytes  4.82 Mbits/sec
> ```
> #### 4.6.3b. `purple` to `red`
> ```shell
> # purple
> $ iperf -c 10.0.0.1
> ------------------------------------------------------------
> Client connecting to 10.0.0.1, TCP port 5001
> TCP window size: 16.0 KByte (default)
> ------------------------------------------------------------
> [  1] local 10.0.0.3 port 48392 connected with 10.0.0.1 port 5001 (icwnd/mss/irtt=14/1448/1243)
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-10.0233 sec  1.09 GBytes   932 Mbits/sec
> ```

