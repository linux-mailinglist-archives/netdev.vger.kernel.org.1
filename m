Return-Path: <netdev+bounces-171835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD4A4EF2C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 22:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D01697B8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA9260384;
	Tue,  4 Mar 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zNhIUS5k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E41C84DB
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122610; cv=none; b=Jnu7g6ftcfEXy4mLQ5WyPH/TE/F89RM6x0UANpZnQ9dSd9r3wiTP2QKvlVWzXHtIJQx6H2/bGYANnBsjv2bDpDwK3fgo7MdvOZIwv1x6JFk5/h2LWzLgHt8rOwmCUUhCjPA+8a1he8tjQQn9SDpqyFfqhiXMtnGFalNizQKrkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122610; c=relaxed/simple;
	bh=LOe6YN/ICgwOkhX7oZRIibsNIwZTPRTqVfQk7HlSDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujeRUR82gKsckimTqx11kOHTWVWLTGrvbCwZuLZPKeBr+oB6yys/iCXRB/mQRWGpjoZgGIzXDmbBaABQ2kmdbvFOZs13Uqja4btBhaji4YdU2aa83hI7J3MQx3bVWPXq0tfJhpEL7mByeS1MMJD6ErHd9fkcmJgKu5eCdHbo9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zNhIUS5k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C7AcgVH2dgLSukAc/yiRNsvC4mW8nP1lzJAKxR2RSyw=; b=zNhIUS5kRSdckAH2eHJQjp7GKM
	Lnkquw1hMlTZZ19smZUg2zcdp8XxomtzbYDDhcYEe7LxWqYpXjb/BZ9RceJ9aV2QmOs7i29xrbod3
	Vt71hW5y6sOu0NDKaqUx93LwG7AcJtL2XY5HOXm6nH/NtsJCSCHGnzLv6shr5SM9fY2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpZWg-002Gg5-UZ; Tue, 04 Mar 2025 22:10:06 +0100
Date: Tue, 4 Mar 2025 22:10:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190504.3743-6-darinzon@amazon.com>

> +The feature is turned off by default, in order to turn the feature on,
> +please use the following:
> +
> +- sysfs (during runtime):
> +
> +.. code-block:: shell
> +
> +  echo 1 > /sys/bus/pci/devices/<domain:bus:slot.function>/phc_enable
> +
> +All available PTP clock sources can be tracked here:
> +
> +.. code-block:: shell
> +
> +  ls /sys/class/ptp
> +
> +PHC support and capabilities can be verified using ethtool:
> +
> +.. code-block:: shell
> +
> +  ethtool -T <interface>
> +
> +**PHC timestamp**
> +
> +To retrieve PHC timestamp, use `ptp-userspace-api`_, usage example using `testptp`_:
> +
> +.. code-block:: shell
> +
> +  testptp -d /dev/ptp$(ethtool -T <interface> | awk '/PTP Hardware Clock:/ {print $NF}') -k 1

Why is not opening /dev/ptpX sufficient to enable the PHC?

    Andrew

