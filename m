Return-Path: <netdev+bounces-138513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B699ADF72
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD21C217D6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78E1AE001;
	Thu, 24 Oct 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI9QUpc+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E83189F4B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759658; cv=none; b=m8wP4yIhrUP6sjWxm8jUdWT9QcQ18vsyQoFKAhldRED0mqSiIQxMfA1YY4Y4vePS4s+iBBf5poMv0L/SHrg/Z2DkPWeyR8ULAZRIBX1XXQKXOEjO6qN3n82h9gQPW/FsE7UK7LTM38jAWnB+iPvFQ6bAMuI5AsiO+5jUIBnxPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759658; c=relaxed/simple;
	bh=XShdbifM8rPpMICCTPs3OkzOAyfBxFO3evEa2zTnfd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmrXxvlOrwvYg9JLuQU2c6VhJpBAF9mh6frT7VVmOr7k1z8tY+vC2N1Tmo3aPl938EQ+nHsCasxwhBuscC914jR58vnX6Wqrm0/PO7f4Mp7CfcakqnTLg2xtuHw0b3nuhaQrDjI6vypWVo8OX7F3Nuya06z/SACIc6bVzEIvpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI9QUpc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AD9C4CEC7;
	Thu, 24 Oct 2024 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729759658;
	bh=XShdbifM8rPpMICCTPs3OkzOAyfBxFO3evEa2zTnfd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI9QUpc+aC6nDAu3KMLELxzjvO4Xw4pKDllMTBcvoeh7rUEO5k3MRCrHpdhnQsTS7
	 +7GUVsmVViMRSoWTYasrBxmVxJq4aTM3HmMHCAzFD7MpveNn9lstqXjZupxXHsAObI
	 8qdVXzGIR+atlOuuBjdM5DYuepDAlthqTuAGowPuUuKrPlyRNHJUu9D79yBy1ZTipG
	 ofE+E5RejvpCfF3s/d/+IH1WTEtbidzm+r0fHs8fbdqwf7GYST2xHO08fBDfy35JcR
	 A1fnwWlppH9xIR60mAmyo1JOCJG3YaVkf26CXqHpJIbRYXBLMpFM257Q6X4hZhBlBr
	 u6zfZDfUJTIbA==
Date: Thu, 24 Oct 2024 09:47:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Wander Lairson Costa <wander@redhat.com>,
	Yuying Ma <yuma@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net 1/3] igb: Disable threaded IRQ for igb_msix_other
Message-ID: <20241024084732.GE402847@kernel.org>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
 <20241021-iwl-2024-10-21-iwl-net-fixes-v1-1-a50cb3059f55@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-1-a50cb3059f55@intel.com>

On Mon, Oct 21, 2024 at 04:26:24PM -0700, Jacob Keller wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> During testing of SR-IOV, Red Hat QE encountered an issue where the
> ip link up command intermittently fails for the igbvf interfaces when
> using the PREEMPT_RT variant. Investigation revealed that
> e1000_write_posted_mbx returns an error due to the lack of an ACK
> from e1000_poll_for_ack.
> 
> The underlying issue arises from the fact that IRQs are threaded by
> default under PREEMPT_RT. While the exact hardware details are not
> available, it appears that the IRQ handled by igb_msix_other must
> be processed before e1000_poll_for_ack times out. However,
> e1000_write_posted_mbx is called with preemption disabled, leading
> to a scenario where the IRQ is serviced only after the failure of
> e1000_write_posted_mbx.
> 
> To resolve this, we set IRQF_NO_THREAD for the affected interrupt,
> ensuring that the kernel handles it immediately, thereby preventing
> the aforementioned error.
> 
> Reproducer:
> 
>     #!/bin/bash
> 
>     # echo 2 > /sys/class/net/ens14f0/device/sriov_numvfs
>     ipaddr_vlan=3
>     nic_test=ens14f0
>     vf=${nic_test}v0
> 
>     while true; do
> 	    ip link set ${nic_test} mtu 1500
> 	    ip link set ${vf} mtu 1500
> 	    ip link set $vf up
> 	    ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
> 	    ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
> 	    ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
> 	    if ! ip link show $vf | grep 'state UP'; then
> 		    echo 'Error found'
> 		    break
> 	    fi
> 	    ip link set $vf down
>     done
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Reported-by: Yuying Ma <yuma@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


