Return-Path: <netdev+bounces-110844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29B92E921
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3531F2321B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84015AAD3;
	Thu, 11 Jul 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKEgbC9Y"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5814A601
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703933; cv=none; b=O0JpbO/hAdO7T0JGjPQShXedDVaof4y8xst0D/tYL/kltiMj4H6JkZk7QUrdTowO1ikoDNqETqVGOnViKT47iMFyxl7ojL1yl7hoUGtLCZMGQlaBbQaKHZz12vGWEPsGbc7N014m9bPjjAu9DZEvKAwf3EcQpMyOx0cDEoR1PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703933; c=relaxed/simple;
	bh=bT3VHDsQRTb1ak0ThO8qg0IVMErf02GTkWZBQAjTOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7tr7Ts/c//EnpXhPmfJ95XmzHtek6V3zzCYDDe1N0W46F/kp0imqdrDOzb+qPheDeZsONYbswEZxNNlDBMrdKjR68sjVOJ7YE23sxOqedhbyGa8zcZAW5VjXVPbklv7R4Q3h97z/7IqZrNxSuBFgDcgpg8nUbYCTd+J4gDnlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKEgbC9Y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 804151140DFA;
	Thu, 11 Jul 2024 09:18:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 09:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720703930; x=
	1720790330; bh=NBKtKtydpdjQVe/+6Oi5w/AwibY1nYGlm7vTb6dxYJY=; b=H
	KEgbC9Y9lvHQfa8rf66ys9z0qv8zsL7zx9sDDaKu2I8EvfZMhogkocXqAF+2rcgX
	vucbbopp5v6tGLemiQ5rHfnw+YNRBDcNDJMUoU9dkGru1676unaOIWX0FtS29tIm
	dvr/wYRKhEvtUshJBWO9NP4J06EGll3EP9OWJbRWH1uiHySszspO54NkakX4mHoP
	VvWemfi1agWTChNijuYFNF5pn62g5bni261V14JR37TOaW62OxeAeHVW2kuKyp2f
	Y+VwNUkyZwyng9YUoudiMg/XkeQikbgw+8y6+Bw4gS7h791RYnoPEiWe9F7v7h/x
	4PXfUXUDhaEtzt1uwXq+Q==
X-ME-Sender: <xms:utuPZnLS8k7e2b6t6l8BZyKlDf1GhvM7oqZj7RKyLWIy6o7WFvx8YA>
    <xme:utuPZrIihOuHoceRAZMoct4oLZJ7gNbWdRxfpj8QLUyFTS9IBGxYiRGBqoGiUR3TJ
    7P_P-3U5Xlh4dI>
X-ME-Received: <xmr:utuPZvsJ501rEGA_dcxLNmeFrkjw_E7cbQrHGnfzXnn17yz09hKGJEsBwT0K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepgfdvkedugfegiedtfeefgeeuhedvieeffeefgfelvdetueffgedtjeelgedv
    ffeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:utuPZgYunuDLnoIWDehliuEo0zbSaZ3hCJtTD_S-6wEx2lxE5pzC1Q>
    <xmx:utuPZubAfp7BTosviu9y0KT1XrdWW-otiIBYilg3391AJzHdi-8jsQ>
    <xmx:utuPZkBiNSaEF-JL9B7NZ8hKCGxpOskcxQNj1jmI3wNBl3Horxl4Pw>
    <xmx:utuPZsbmncBuqemce-P5O10hzQobAN1AcXW7e0_bLFFKu_Pdd9sCdg>
    <xmx:utuPZtnELqBcYcBiQvoqth6qrZMAhyA3r_48AO5ntjnpqm5kA_TBA8-g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 09:18:49 -0400 (EDT)
Date: Thu, 11 Jul 2024 16:18:40 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jason Zhou <jasonzhou@x.com>
Cc: netdev@vger.kernel.org, Benjamin Mahler <bmahler@x.com>
Subject: Re: PROBLEM: Issue with setting veth MAC address being unreliable.
Message-ID: <Zo_bsLPrRHHiVMPd@shredder.mtl.com>
References: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>

On Wed, Jul 10, 2024 at 04:45:55PM -0400, Jason Zhou wrote:
> [1.] One line summary of the problem:
> 
> Issue with setting veth address being unreliable.
> 
> [2.] Full description of the problem/report:
> 
> Hello!
> 
> We have been investigating a strange behavior within Apache Mesos
> where after setting the MAC address on a veth device to the same
> address as our eth0 MAC address, the change is sometimes not reflected
> appropriately despite the ioctl call succeeding (~4% of the time in
> our testing). Note that we also tried using libnl to set the MAC
> address but the issue still persists.
> 
> Included below is the github link to the section where we set the veth
> address, to clarify what we were trying to do. We first create the
> veth pair [1] using a libnl function [2], then we set the veth device
> MAC addresses to that of our host public interface (eth0) [3] using a
> function called setMAC. Inside the setMAC [4] is where we are
> observing the aforementioned issue with unreliable setting of veth
> addresses..
> 
> This behavior was observed when re-fetching the MAC address on said
> veth device after we made the function call to set its MAC address. We
> have observed this issue on CentOS 9 only, but not on CentOS 7. We
> have tried Linux kernels 5.15.147, 5.15.160 & 5.15.161 for CentOS 9,
> CentOS 7 was using 5.10, but we also tried upgrading the Centos 7 host
> to 5.15.160 but could not reproduce the bug.

This suggests that the change in behavior is due to a change in user
space and an obvious suspect is systemd / udev. AFAICT, CentOS 7 is
using systemd 219 whereas CentOS 9 is using systemd 252. In version 242
systemd started setting a persistent MAC address on virtual interfaces.
See:

https://github.com/Mellanox/mlxsw/wiki/Persistent-Configuration#required-changes-to-macaddresspolicy

If that is the issue, then you can either change MACAddressPolicy or
modify your code to create the veth pair with the correct MAC address
from the start.

As I understand it, a possible explanation for the race is that your
program is racing with udev. Udev receives an event about a new device
and reads "addr_assign_type" from sysfs. If your program changed the MAC
address before udev read the file, then udev will read 3 (NET_ADDR_SET)
and will not try to change the MAC address. Otherwise, both your program
and udev will try to change the MAC address.

If it is not udev that is changing the MAC address, then you can run the
following bpftrace script in a different terminal and check which
processes try to change the address:

bpftrace -e 'k:dev_set_mac_address_user { @[comm] = count(); }'

It is only a theory. Actual issue might be entirely different.

> 
> We were re-fetching the addresses via the ioctl SIOCGIFHWADDR syscall
> as well as via getifaddr (which appears to use netlink under the
> covers), and, in problematic cases, both functions reported
> discrepancies from the target MAC address we were initially setting
> to. We also performed a fetch before we set the MAC addresses and
> found that there are instances where getifaddr and ioctl results do
> not match for our veth device *even before we perform any setting of
> the MAC address*. It's also worth noting that after setting the MAC
> address: there are no cases where ioctl or getifaddr come back with
> the same MAC address as before we set the address. So, the set
> operation always seems to have an effect.
> 
> Observed scenarios with incorrectly assigned MAC addresses:
> 
> (1) After setting the mac address: ioctl returns the correct MAC
> address, but the results from getifaddr, returns an incorrect MAC
> address (different from the original value before setting as well!)
> 
> (2) After setting the MAC address: both ioctl and getifaddr return the
> same MAC address, but are both wrong (and different from the original
> one!)
> 
> (3) There is a possibility that the MAC address we set ends up
> overwritten by a garbage value *after* we have already updated the MAC
> address, and checked that the MAC address was set correctly. Since
> this error happens after this function has finished, we cannot log nor
> detect it in the function where we set the MAC address because we have
> not yet studied at what point this late overwriting of MAC address
> occurs. It’s worth noting that this is the rarest scenario that we
> have encountered, and we were only able to reproduce it in our testing
> cluster machine, not in any of the production cluster machines.
> 
> [3.] Keywords:
> 
> networking, veth, kernel, MAC, netlink
> 
> [X.] Other notes, patches, fixes, workarounds:
> 
> Notes:
> 
> More specific kernel and environment information will be available on
> request for security reasons, please let us know if you are interested
> and we will be happy to provide you with the necessary information.
> 
> We have observed this behavior only on CentOS 9 systems at the moment,
> CentOS 7 systems under various kernels do not seem to have the issue
> (which is quite strange if this was purely a kernel bug).
> 
> We have tried kernels 5.15.147, 5.15.160, 5.15.161, all of these have
> this issue on CentOS 9.
> 
> We have also tried rewriting our function for setting MAC address to
> use libnl rather than ioctl to perform the MAC address setting, but it
> did not eliminate the issue.
> 
> To work around this bug, we checked that the MAC address is set
> correctly after the ioctl set call, and retry the address setting if
> necessary. In our testing, this workaround appears to remedy scenarios
> (1) and (2) above, but it does not address scenario (3).  You can see
> it here:
> 
> https://github.com/apache/mesos/commit/8b202bbebdc89429ad82c6983aa1c514eb1b8d95
> 
> We would greatly appreciate any insights or guidance on this matter.
> Please let me know if you need further information or if there are any
> specific tests we should run to assist in diagnosing the issue. Again,
> specific details for the production machines on which we encountered
> this error can be provided upon request, so please let us know if
> there is anything we can provide to help.
> 
> Thank you for your time and assistance.
> 
> Best regards,
> Jason Zhou
> Software Engineering Intern
> jasonzhou@x.com
> 
> embedded links:
> [1] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp#L3599
> [2] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0fbc7ff0/src/linux/routing/link/veth.cpp#L45
> [3] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp#L3628
> [4] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0fbc7ff0/src/linux/routing/link/link.cpp#L283
> 

