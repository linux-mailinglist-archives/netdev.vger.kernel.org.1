Return-Path: <netdev+bounces-88346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF18A6CCE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575171C22143
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3212C53B;
	Tue, 16 Apr 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5QRW70W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435712C531
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275495; cv=none; b=DHCl2qf4yAOfayJYa+jO/UtLPdHhsHprN63OvhCl3vo8Mn4Y0lBi8RMyfZ9+u6owKGXI0DU/IHOMdYUVyjC5mp4Cudr5QVyGuZcPI625HfZ4fHxPAjWjhS6NmX3cHopjL2N2OQ4j4G/rNDU+Otl1hhR8sZK14d7gEC0G1M+3oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275495; c=relaxed/simple;
	bh=4otepq24ibU/BFgkCAGDDODzhJI1QplbGSgPPr0bnNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuXIqQGFyde6rKdE57zU/2/TQuMY1Uh+MZmLqd1yVH2V5Q5nhf/B8Em+DHoIUplVTV3RUwDLjTL4WLsT1fIaRyLTFTnf8OVP7CI/l9IbJmZwQQcD28wxeryeNVFIdTcrkXi/fypmuY2jB7onPjMHbBf7XE/wp8Np/4Gy72qkjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5QRW70W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB7C2BD10;
	Tue, 16 Apr 2024 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713275495;
	bh=4otepq24ibU/BFgkCAGDDODzhJI1QplbGSgPPr0bnNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5QRW70WEVB/gjlxQF34XfHI8FAXbbwHnSKkZJgaVQnUEtTNThMJb97o0PD9IaeNK
	 efdNoubBn/DS6cPrFYrxB8DbMRoNtUPBy1SS2cduKNPdK11oUwRyjbcmrX6PmL0Mev
	 KiJ36YAHFDoyUbYswGVn5Ykj5UuDf4IR3Rixacty6DfYfS+gVPVPRakyNlou3CJIFa
	 Rcbbj4ZdOeN7aCuwC6qntXqUuPZTBQxT54F58YyPYrR3H3nnkyFC7CUd5WL3PctA/R
	 D5zuGwWEucz1vQ059yTlnSlrfviH32XR0U869Gi8ZkvpZNC+ilcYzgA2bGnNUyfT+e
	 7kEDVHjToYhIA==
Date: Tue, 16 Apr 2024 14:51:29 +0100
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Lukas Wunner <lukas@wunner.de>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] igc: Fix deadlock on module removal
Message-ID: <20240416135129.GA3769813@kernel.org>
References: <20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de>

On Mon, Apr 15, 2024 at 12:59:37PM +0200, Kurt Kanzenbach wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> The removal of the igc module leads to a deadlock:
> 
> |[Mon Apr  8 17:38:55 2024]  __mutex_lock.constprop.0+0x3e5/0x7a0
> |[Mon Apr  8 17:38:55 2024]  ? preempt_count_add+0x85/0xd0
> |[Mon Apr  8 17:38:55 2024]  __mutex_lock_slowpath+0x13/0x20
> |[Mon Apr  8 17:38:55 2024]  mutex_lock+0x3b/0x50
> |[Mon Apr  8 17:38:55 2024]  rtnl_lock+0x19/0x20
> |[Mon Apr  8 17:38:55 2024]  unregister_netdevice_notifier+0x2a/0xc0
> |[Mon Apr  8 17:38:55 2024]  netdev_trig_deactivate+0x25/0x70
> |[Mon Apr  8 17:38:55 2024]  led_trigger_set+0xe2/0x2d0
> |[Mon Apr  8 17:38:55 2024]  led_classdev_unregister+0x4f/0x100
> |[Mon Apr  8 17:38:55 2024]  devm_led_classdev_release+0x15/0x20
> |[Mon Apr  8 17:38:55 2024]  release_nodes+0x47/0xc0
> |[Mon Apr  8 17:38:55 2024]  devres_release_all+0x9f/0xe0
> |[Mon Apr  8 17:38:55 2024]  device_del+0x272/0x3c0
> |[Mon Apr  8 17:38:55 2024]  netdev_unregister_kobject+0x8c/0xa0
> |[Mon Apr  8 17:38:55 2024]  unregister_netdevice_many_notify+0x530/0x7c0
> |[Mon Apr  8 17:38:55 2024]  unregister_netdevice_queue+0xad/0xf0
> |[Mon Apr  8 17:38:55 2024]  unregister_netdev+0x21/0x30
> |[Mon Apr  8 17:38:55 2024]  igc_remove+0xfb/0x1f0 [igc]
> |[Mon Apr  8 17:38:55 2024]  pci_device_remove+0x42/0xb0
> |[Mon Apr  8 17:38:55 2024]  device_remove+0x43/0x70
> 
> unregister_netdev() acquires the RNTL lock and releases the LEDs bound
> to that netdevice. However, netdev_trig_deactivate() and later
> unregister_netdevice_notifier() try to acquire the RTNL lock again.
> 
> Avoid this situation by not using the device-managed LED class
> functions.
> 
> Link: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> Link: https://lore.kernel.org/r/ZhRD3cOtz5i-61PB@mail-itl/
> Reported-by: Roman Lozko <lozko.roma@gmail.com>
> Reported-by: "Marek Marczykowski-Górecki" <marmarek@invisiblethingslab.com>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> [Kurt: Wrote commit message and tested on i225]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

I am aware that this patch seems to have also been submitted by Lucas
himself. I'd like to suggest that we focus on review of that submission.

https://lore.kernel.org/netdev/2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de/


