Return-Path: <netdev+bounces-114736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BE9439BF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007CB1C21B3D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC3189529;
	Wed, 31 Jul 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="imwGluif"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B2188018;
	Wed, 31 Jul 2024 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470182; cv=none; b=bN+7T9e6ek+jC7bw4HLgKjg/FADeqR5+nFryG+VxiPQBuwMXvGN+hW/uTjyM9jU34hWawQKCFSul9g6go6453YDEJneImGnyEd+iZIOFQJhxa3QMaJ4O7XPR2dRTgWv/jyGP/N3CRs1FZu3cO2po48mVAqkNUtqh56ECXFxpYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470182; c=relaxed/simple;
	bh=gvD+1bqY+1jC/x6qln8gRn20fHZAE+bwnEeKjft/WbE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXZzaAIP6pxMy16KyllQ19AGwxkuV0/vgY4gXeg2dUc33czsOOZg0DN8kazAtCDmYrt83yZWEFUWT3eesO4DjF4nodt1c3x5IVpU4KXJ429uB5MlIZQN11Big2CzkdvS0B+CR9oT8Sx4RX9M7Z4j4yjNunutc5/7BPvd5XcKaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=imwGluif; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Mrsl7+zgXcrBDvUgvoeETiYKzsBtiwZXMEqgkWx8Gs=; b=imwGluifeo/MyIHWJWQRfdiqJf
	PuGYO0n7lCZOUKNlQeQIkq50qePh79USlNDxFh25B3XR+fH3efpP+Oe3+ChGS02z4DnMgqGCnwosA
	VbcT+8UpvY4c2m+ibLowdjZJ3xim15y0eTrgIGYVBn08gaMeuLA0W4Iv9QY+ACaClV34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZJAu-003im5-KP; Thu, 01 Aug 2024 01:56:08 +0200
Date: Thu, 1 Aug 2024 01:56:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Damato <jdamato@fastly.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Wang <xiaoning.wang@nxp.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 net-next resent] net: fec: Enable SOC specific
 rx-usecs coalescence default setting
Message-ID: <ada2c1b3-08b7-498f-91d5-3d5c1c88e042@lunn.ch>
References: <20240729193527.376077-1-shenwei.wang@nxp.com>
 <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>

On Tue, Jul 30, 2024 at 11:17:05AM +0100, Joe Damato wrote:
> On Mon, Jul 29, 2024 at 02:35:27PM -0500, Shenwei Wang wrote:
> > The current FEC driver uses a single default rx-usecs coalescence setting
> > across all SoCs. This approach leads to suboptimal latency on newer, high
> > performance SoCs such as i.MX8QM and i.MX8M.
> > 
> > For example, the following are the ping result on a i.MX8QXP board:
> > 
> > $ ping 192.168.0.195
> > PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> > 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
> > 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
> > 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
> > 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms
> > 
> > The current default rx-usecs value of 1000us was originally optimized for
> > CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
> > generations, CPU performance is no longer a limiting factor. Consequently,
> > the rx-usecs value should be reduced to enhance receive latency.
> > 
> > The following are the ping result with the 100us setting:
> > 
> > $ ping 192.168.0.195
> > PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> > 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
> > 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
> > 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
> > 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms
> > 
> > Performance testing using iperf revealed no noticeable impact on
> > network throughput or CPU utilization.
> 
> I'm not sure this short paragraph addresses Andrew's comment:
> 
>   Have you benchmarked CPU usage with this patch, for a range of traffic
>   bandwidths and burst patterns. How does it differ?
> 
> Maybe you could provide more details of the iperf tests you ran? It
> seems odd that CPU usage is unchanged.
> 
> If the system is more reactive (due to lower coalesce settings and
> IRQs firing more often), you'd expect CPU usage to increase,
> wouldn't you?

Hi Joe

It is not as simple as that.

Consider a VoIP system, a CISCO or Snom phone. It will be receiving a
packet about every 2ms. This change in interrupt coalescing will have
no effect on CPU load, there will still be an interrupt per
packet. What this change does however do is reduce the latency, as can
be seen by the ping. However, anybody building a phone knows about

ethtool -C|--coalesce

and will either configure the value lower, or turn it off
altogether. Also, CCITT recommends 50ms end to end delay for a
national call, so going from 1.5 to 0.4ms is in the noise.

Now consider bulk transfer at line rate. The receive buffer is going
to fill with multiple packets, NAPI is going to get its budget of 64
packets, and the interrupt will be left disabled. NAPI will then poll
the device every so often, receiving packets. Since interrupts are
off, the coalesce time makes no difference.

Now consider packets arriving at about 0.5ms intervals. That is way
too slow for NAPI to go into polled mode. It does however mean 2
packets would typically be received in each coalescence
period. However with the proposed change, an interrupt would be
triggered for each packet, doubling the interrupt load.

But think about a packet every 0.5ms. That is 2000 packets per
second. Even the older CPUs should be able to handle that.

What i would really like to know is the real use case this change is
for. For my, ping is not a use case.

     Andrew

