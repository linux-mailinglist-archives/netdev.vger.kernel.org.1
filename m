Return-Path: <netdev+bounces-147485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6D9D9C9A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419C816773A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370F1DAC92;
	Tue, 26 Nov 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lX2HTkd0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF11D63C4;
	Tue, 26 Nov 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642369; cv=none; b=fdnfPyY4XfK6YdP+xs2+7R2ED0DwsWabGvKzLPTm05LkNPw5VQ/+m6a/E5cfshcxOMvKwfNqMyTI82kjTEO3N/plGGfmgBz+GfJt6v2VS8JxzFBhXlabGs4w9keTsFc/8Lgem4SdntsbyAZ78t7u0O8RofDK/iyyzSWVp7HXigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642369; c=relaxed/simple;
	bh=H17MHCfd24VPEldcnn5wdiGocPT+zmtDZfyEF8Mym3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UinkD7PjTc4Ua81Cx52zJsbAwpIngDLB5d54dVHh1tpg8gLkXsWntbPPfPR/VnhdzocCXzUymc7QnZRU783hoKSI4e2YlSbK02a6i9nH+DAzCl90Q5UY74XBzX2NMNb4P2llQAjYIZK4pfbf6Y3th+/5kHYJxZbU51UPs6sijCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lX2HTkd0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Us51DEsfUuxfpmv7rXsN3ADrJLcG5L8FQbD+ZR2E+ps=; b=lX2HTkd0Yss2rlJmqzV8ZArRTS
	CjjM3ticImcRzuIvMQz1oGCx0etV4a/4bpO1dotmha6JihdZfu85408KAJR1nh7J3hmq6DCGD2tlE
	Nu2HQ5t3s6Rv2raZUnNy4ofdolBcBB29iwDE+s2h8yQz3mHSHMUQqAxwiJfvVkIkGX9k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFzQV-00EXlC-LI; Tue, 26 Nov 2024 18:32:39 +0100
Date: Tue, 26 Nov 2024 18:32:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Message-ID: <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
References: <20241122224829.457786-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122224829.457786-1-asmaa@nvidia.com>

On Fri, Nov 22, 2024 at 10:48:27PM +0000, Asmaa Mnebhi wrote:
> From: asmaa <asmaa@nvidia.com>
> 
> Once the BlueField-3 MDIO clock is enabled by software, it is expected
> and intended for it to keep toggling. BlueField-3 has a hardware GPIO bug
> where constant toggling at "high frequencies" will lead to GPIO
> degradation.
> 
> The workaround suggested by the hardware team is to lower down the clock
> frequency. That will increase the "life expectation" of the GPIO.
> The lowest possible frequency we can achieve is 1.09Mhz by setting
> mdio_period = 0xFF.

802.3 says:

  22.2.2.13 MDC (management data clock)

  MDC is sourced by the station management entity to the PHY as the
  timing reference for transfer of information on the MDIO signal. MDC
  is an aperiodic signal that has no maximum high or low times. The
  minimum high and low times for MDC shall be 160 ns each, and the
  minimum period for MDC shall be 400 ns, regardless of the nominal
  period of TX_CLK and RX_CLK.

My reading of this is that you can stop the clock when it is not
needed. Maybe tie into the Linux runtime power management
framework. It can keep track of how long a device has been idle, and
if a timer is exceeded, make a callback to power it down.

If you have an MDIO bus with one PHY on it, the access pattern is
likely to be a small bunch of reads followed by about one second of
idle time. I would of thought that stopping the clock increases the
life expectancy of you hardware more than just slowing it down.

	Andrew

