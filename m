Return-Path: <netdev+bounces-88347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBE8A6CCF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFF1C221EE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09212C544;
	Tue, 16 Apr 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0cqfBIL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430E129A72
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275495; cv=none; b=Vl0AogWH41VW9MlKEWO8WSR5mtVIH3/6CzlsabAtFtOH56dmCcUjNbBnl/RPhXc8CnRG4yuk3ZjbO1YYFczxWlohZKRyFipe29FzmHaImQq4E3bw5GTx+ow5FTu1kawdSdS0zaMRRvH3kQShMsYz9oCpXTGwGV+ieJgg1gPly5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275495; c=relaxed/simple;
	bh=yzjOk/XT1m/fqB5jnXhoNIDg6Ef7jDbuSx6EqGNgTWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms0sJ3u5jZYqGBl5rqyhK7+yI8LAecLOauwQ70CLVhgC7YsKISKkxU6O2PvftspV0Clif9L/9NXYNJ1RQQdVaEEU/QcrmSMw4/umDkVcEvEygFgxnHXeJ7s+jAMHQFhQjBlwucfPtxknTX7EvGZJtVFgHD9wLa1JbsQeviyfhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0cqfBIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FD2C113CE;
	Tue, 16 Apr 2024 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713275494;
	bh=yzjOk/XT1m/fqB5jnXhoNIDg6Ef7jDbuSx6EqGNgTWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0cqfBILIohuyYCKz1tkeVq/k4ktRDgW5CURsD1BRriJqR+l7N2ohQpxBU9O4Y6B7
	 2iYEAeMYyv4RkEcbPCZLsMFy/ZY4r8N26rigKuaGkv3iaw520Df8hujfgYrIAn/GQL
	 /wJDwLxUsk2Yue7uP840qBTRg3axkji5mNfKj8CtHh3hsi5vs0Hwmn6+W+EBIBMQ5u
	 S/hOYqwfr6RccLtSsZKLP2B/lLHBVSp4SpcbrnDzXhiHrHm32N4mKz+y1kS4T6XX59
	 cLw2jcrVScJAAU+uiih5OCi97s5/2s4hWz6JH4f8LBkAMnCGxETtqgfNCEnnDjn9wV
	 wpy0vicjMPcPA==
Date: Tue, 16 Apr 2024 14:51:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Roman Lozko <lozko.roma@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Message-ID: <20240416135129.GM2320920@kernel.org>
References: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>

On Mon, Apr 15, 2024 at 03:48:48PM +0200, Lukas Wunner wrote:
> Roman reports a deadlock on unplug of a Thunderbolt docking station
> containing an Intel I225 Ethernet adapter.
> 
> The root cause is that led_classdev's for LEDs on the adapter are
> registered such that they're device-managed by the netdev.  That
> results in recursive acquisition of the rtnl_lock() mutex on unplug:
> 
> When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> then frees the device-managed resources.  Upon unregistering the LEDs,
> netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> which tries to acquire rtnl_lock() again.
> 
> Avoid by using non-device-managed LED registration.
> 
> Stack trace for posterity:
> 
>   schedule+0x6e/0xf0
>   schedule_preempt_disabled+0x15/0x20
>   __mutex_lock+0x2a0/0x750
>   unregister_netdevice_notifier+0x40/0x150
>   netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev]
>   led_trigger_set+0x102/0x330
>   led_classdev_unregister+0x4b/0x110
>   release_nodes+0x3d/0xb0
>   devres_release_all+0x8b/0xc0
>   device_del+0x34f/0x3c0
>   unregister_netdevice_many_notify+0x80b/0xaf0
>   unregister_netdev+0x7c/0xd0
>   igc_remove+0xd8/0x1e0 [igc]
>   pci_device_remove+0x3f/0xb0
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Reported-by: Roman Lozko <lozko.roma@gmail.com>
> Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>

I am aware that Kurt has submitted what appears to be the same patch [1,2],
which I'm inclined to put down to miscommunication (email based workflows
are like that sometimes).

FWIIW, it is my understanding is that the patch originated from
Lukas[3], and thus it seems most appropriate to take his submission.

As for the patch itself, I agree that it addresses the problem at hand.
For the record, I have not tested it.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] [PATCH iwl-net] igc: Fix deadlock on module removal
    https://lore.kernel.org/netdev/20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de/
[2] [PATCH iwl-net v2] igc: Fix deadlock on module removal
    https://lore.kernel.org/netdev/20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de/
[3] Re: Deadlock in pciehp on dock disconnect
    https://lore.kernel.org/all/ZhBN9p1yOyciXkzw@wunner.de/


