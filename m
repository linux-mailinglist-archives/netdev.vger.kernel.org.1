Return-Path: <netdev+bounces-300072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tguEIN5bMmomzAUAu9opvQ
	(envelope-from <netdev+bounces-300072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:33:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7669793A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=K95+fDAB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24DCE30322C2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CF38F95A;
	Wed, 17 Jun 2026 08:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C83BED76;
	Wed, 17 Jun 2026 08:32:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685165; cv=none; b=FZi+9vyRibs6lDW58m5iPiMcrvivbq9towXFSWZJILzKzIaiSLkhR58qOfDokjt/gwKjHYcRTSIsbriddc6kREhDx+ogxfdpOPmwS6ogRvKxo33rDn1Q1aIc6SiLCnNCTKxP2rn9Nh4V3/92dVQsIm8AL56gT+ldqMNbVWqTUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685165; c=relaxed/simple;
	bh=kf0PmLbyKQ/2blQwIF/Rjt3LWgLL2BsA0cxPmPPS0R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4NT66iUdyiCulmz77pxdZvPVAhOyznnH+AYR9AasdoEs2aG3jHfz4xlzZoKv9wMQYF131Il+u/fmjyLCiR+I1kPXDnt4MXTKCXXjBoht8cv4wfNle5bYUnlPD8ls7KDVsm3DC0zDucZNw34gIeTaQ+gICXOwcixM0jDKm796sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K95+fDAB; arc=none smtp.client-ip=188.68.63.162
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4ggHCr24H6z43BL;
	Wed, 17 Jun 2026 10:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1781685144;
	bh=kf0PmLbyKQ/2blQwIF/Rjt3LWgLL2BsA0cxPmPPS0R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K95+fDABLkOFcRSwnw7IYzQO5KxOWdsSwnx/3+YDwJsB9LuYzIDBPWn1ufZVIwmUT
	 +SDIhHI86cneq2fquMx/R96153VpKIDl35Hpvu8ubOM4LCaSq4UIXaL0b0JpxSkRAv
	 7nB9VoaSPZLiN7zKKeAMTGKyWEab5hZHT9LS0xzya2pRw9Xx3ObCUE+64iJLzssA9F
	 91NPhDMby6/e2+Q0S72gIgbvD21ajhzPSZxdFRW9dg9LkOXEx64V+i3FC7emFqjlgS
	 EExFdEMgW1Dz2ssnoh6nNHda1R9awye0KLbEBlWAff2eJCizqRu6d/GomeM8t504ty
	 QTI4M2i5VUJtg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4ggHCr1J5rz3tLF;
	Wed, 17 Jun 2026 10:32:24 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4ggHCq3pr2z8sZP;
	Wed, 17 Jun 2026 10:32:23 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id AB7595FBFB;
	Wed, 17 Jun 2026 10:32:22 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e8acc151-19f3-4823-83a1-e0906dd9f0f0@leemhuis.info>
Date: Wed, 17 Jun 2026 10:32:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_6=2E16=5D_r8169_RTL8168h/8111h_fails_?=
 =?UTF-8?Q?to_probe_=E2=80=94_=22Unable_to_change_power_state_from_D3cold_to?=
 =?UTF-8?Q?_D0=22_=E2=80=94_bisected_to_4d4c10f763d7?=
To: Josh Perry <josh@6bit.com>, mario.limonciello@amd.com, bhelgaas@google.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 regressions@lists.linux.dev
References: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178168514307.1060164.16093719345392338025@mxe9fb.netcup.net>
X-NC-CID: EU+0w11D1L2EjVOiB5djiD1sGtVkwq3AXnplGM6FJ6HIeoK/8fI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-300072-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:josh@6bit.com,m:mario.limonciello@amd.com,m:bhelgaas@google.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:rafael@kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,leemhuis.info:dkim,leemhuis.info:mid,leemhuis.info:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DMARC_NA(0.00)[leemhuis.info];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53F7669793A

On 6/12/26 03:07, Josh Perry wrote:
> #regzbot introduced: 4d4c10f763d7
> 
> Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fails
> to probe on boot; the device drops to D3cold and the driver can't bring
> it back:

FWIW, that commit is 4d4c10f763d780 ("PCI: Explicitly put devices into
D0 when initializing") [v6.16-rc1] from Mario, who is already CCed, but
looks like might be on holiday or something due to inactivity on the
lists in the recent days. So it might take a few days before this moves on.

Josh, this is not my area of expertise, but there are two things I guess
might be helpful:

* retry with 7.1
* upload "dmesg" and "sudo lspci -vvv" output from working and broken
kernels somewhere (like bugzilla.kernel.org).

Ciao, Thorsten

>   r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID 541,
> IRQ 137
>   r8169 0000:04:00.0: Unable to change power state from D3cold to D0,
> device inaccessible
>   r8169 0000:04:00.0: Mem-Wr-Inval unavailable
>   r8169 0000:04:00.0: error -EIO: PCI read failed
>   r8169 0000:04:00.0: probe with driver r8169 failed with error -5
> 
> The board has two identical RTL8168h NICs (both XID 541): 0000:02:00.0
> and 0000:04:00.0. Only 04:00.0 fails — its sibling 02:00.0, on a
> different root port, probes and works normally on the very same kernel
> and boot. The failing NIC then does not appear (no enp4s0), taking the
> machine's WAN offline. This strongly suggests the problem is port/
> topology-specific rather than device- or driver-specific: the upstream
> port behind 04:00.0 is placed in D3cold and the endpoint cannot be
> resumed to D0.
> 
> Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
> Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A
> (2026-03-25, latest available). Firmware is current, so this is not a
> platform-firmware issue.
> 
> Bisection: v6.15 good, v6.16 bad (verified by booting both). I then
> reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: Set up
> runtime PM even for devices without PCI PM") on top of 6.16.7: the NIC
> probes and links at 1Gbps/Full normally, with no workaround:
> 
>   r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID 541,
> IRQ 138
>   r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=off
> also restores the NIC, which is consistent with the upstream port being
> placed in D3cold and the device failing to resume to D0 after the
> explicit-D0 init change.
> 
> The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 is
> still affected (retested today on current firmware).
> 
> Happy to test patches or provide full dmesg / lspci.
> 


