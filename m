Return-Path: <netdev+bounces-237395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A68C4A72C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B3418934F7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0433E362;
	Tue, 11 Nov 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXa1jQBc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D7248883;
	Tue, 11 Nov 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823438; cv=none; b=fXYb2dmbwQH7IBahDWgCeUWo5rHJS7WyPU6n7acGwwJMiZUGwo5XPb4Qdq0kA+Yxlk1wtdBDPnC1EGVcDiRXlf1kAiwqrm1ULJ3itTi1PuXwGRBj4RXtIgPetjXdHzoNTkWckFXzRLFNIu0hF+iyOTlFGNy4krS6aPqZBh0EXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823438; c=relaxed/simple;
	bh=XQVEmKUskABpebnnp2AiiV4QBBv9Qw26XAnM1za6FD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjrHed1gpLPGzNA1vbLAVPO1s0Na/tbLLzIO1GhNoJlsBmaE3OrAuR4nWjRCGtrByT1quD4/T44r8pPFnyv0DNi+YyLPSulAWGAkYT1WewybLMlFazL6wmV7gCrRcwprK9bMkzGeEacHCcvT3yS1oKsxbqJPeS0yYtIrPwbLfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXa1jQBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938FFC4CEFB;
	Tue, 11 Nov 2025 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762823438;
	bh=XQVEmKUskABpebnnp2AiiV4QBBv9Qw26XAnM1za6FD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FXa1jQBcMYwJDQpsOVlEpQACYDBebi38yyv3QPdgkHmL39Yeq2mBlZqo9o33zmJKK
	 RLfbnfUsKYUxdkY/s4QCMcA23fyR0/APn8MtDYbF4ATiwCtfMDlMglPVtL7FOVvwap
	 FcKt2ZEu4R1NclkgemATZ6+Cz49fY8djRWTsgevUqPwQTcwT9DQKL8h3uHrpgxA21o
	 V2WeEKAoysCNzQpqVbmh+b3U3TOIEWOMyGq1x4z20VfxMctEYCvoBYZkIbHd2vKmjG
	 fHYkKqnt/zB8nIcnK2zvOvQJOV0CjxWvT45KbwdE/aYzG1GPK46N8CKTr3SVr5rs94
	 DU9JcwSo9df5w==
Date: Mon, 10 Nov 2025 17:10:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Antoine
 Tenart <atenart@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Yajun
 Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v3 1/2] net: ethernet: Allow disabling pause on
 panic
Message-ID: <20251110171036.733aa203@kernel.org>
In-Reply-To: <20251107002510.1678369-2-florian.fainelli@broadcom.com>
References: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
	<20251107002510.1678369-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 16:25:09 -0800 Florian Fainelli wrote:
> Development devices on a lab network might be subject to kernel panics
> and if they have pause frame generation enabled, once the kernel panics,
> the Ethernet controller stops being serviced. This can create a flood of
> pause frames that certain switches are unable to handle resulting a
> completle paralysis of the network because they broadcast to other
> stations on that same network segment.
> 
> To accomodate for such situation introduce a
> /sys/class/net/<device>/disable_pause_on_panic knob which will disable
> Ethernet pause frame generation upon kernel panic.
> 
> Note that device driver wishing to make use of that feature need to
> implement ethtool_ops::set_pauseparam_panic to specifically deal with
> that atomic context.

Some basic review comments below (no promises if addressing those will
make me for one feel any warmer towards the concept).

>  Documentation/ABI/testing/sysfs-class-net | 16 +++++
>  include/linux/ethtool.h                   |  3 +
>  include/linux/netdevice.h                 |  1 +
>  net/core/net-sysfs.c                      | 39 +++++++++++
>  net/ethernet/Makefile                     |  3 +-
>  net/ethernet/pause_panic.c                | 79 +++++++++++++++++++++++

panic.c or shutdown.c is probably a slightly better name,
more likely we'd add more code in that.

>  6 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethernet/pause_panic.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
> index ebf21beba846..da0e4e862aca 100644
> --- a/Documentation/ABI/testing/sysfs-class-net
> +++ b/Documentation/ABI/testing/sysfs-class-net
> @@ -352,3 +352,19 @@ Description:
>  		0  threaded mode disabled for this dev
>  		1  threaded mode enabled for this dev
>  		== ==================================
> +
> +What:		/sys/class/net/<iface>/disable_pause_on_panic
> +Date:		Nov 2025
> +KernelVersion:	6.20
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		Boolean value to control whether to disable pause frame
> +		generation on panic. This is helpful in environments where
> +		the link partner may incorrect respond to pause frames (e.g.:
> +		improperly configured Ethernet switches)
> +
> +		Possible values:
> +		== =====================================================
> +		0  do not disable pause frame generation on kernel panic
> +		1  disable pause frame generation on kernel panic
> +		== =====================================================

please no sysfs for something as niche as this feature

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e808071dbb7d..2d4b07693745 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2441,6 +2441,7 @@ struct net_device {
>  	bool			proto_down;
>  	bool			irq_affinity_auto;
>  	bool			rx_cpu_rmap_auto;
> +	bool			disable_pause_on_panic;

Warning: include/linux/netdevice.h:2567 struct member
'disable_pause_on_panic' not described in 'net_device'

>  	/* priv_flags_slow, ungrouped to save space */
>  	unsigned long		see_all_hwtstamp_requests:1;

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/netdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/notifier.h>
> +#include <linux/if_ether.h>
> +#include <net/net_namespace.h>

Alphabetical sort, please.

> +/*
> + * Disable pause/flow control on a single Ethernet device.
> + */
> +static void disable_pause_on_device(struct net_device *dev)
> +{
> +	const struct ethtool_ops *ops;
> +
> +	/* Only proceed if this device has the flag enabled */
> +	if (!READ_ONCE(dev->disable_pause_on_panic))
> +		return;
> +
> +	ops = dev->ethtool_ops;
> +	if (!ops || !ops->set_pauseparam_panic)
> +		return;
> +
> +	/*
> +	 * In panic context, we're in atomic context and cannot sleep.
> +	 */

single-line comment would do?

> +	ops->set_pauseparam_panic(dev);
> +}
-- 
pw-bot: cr

