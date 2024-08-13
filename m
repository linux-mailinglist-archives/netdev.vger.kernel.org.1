Return-Path: <netdev+bounces-117895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C494FB86
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6D41C220C7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5CC156;
	Tue, 13 Aug 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeQU0UF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1C14A82
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514334; cv=none; b=oQ58PLKSX+/mIBmyPYXPf2SN5YhVPrbjQIR/5X/b48MkBx7ejwxUd60rvsDWPoKjvgZbVnJfGi4Yj7B5ApxN3BcwNiW33RGY17v9fvuRDazPGrnnOfa6WXsdHRnTMFy1P+96XDRLpx4alytsCRGiNA9UBlIlPvt76u8Zk4XpRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514334; c=relaxed/simple;
	bh=BHWWaqT5IAXIKhwTKbpDfl06h51StkdnU/MRzOcRkGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEDFeNMlLmDp3i7bCAYkLK+73oYhWcXzwpkRHqoSJ8WfzGq3WZBm4Gj0+RWE8uJLbDbTzTcr6qiTJTiRJCA6Wp8eaNwPi7/aeBsXC1hN9lRRCDkgUAmqU3yQKADq70BszqKrOL9V0kLjVf9i6gIbS2unYvnhr7tLwl808HzM7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeQU0UF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E6FC4AF0D;
	Tue, 13 Aug 2024 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723514334;
	bh=BHWWaqT5IAXIKhwTKbpDfl06h51StkdnU/MRzOcRkGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MeQU0UF7p9y37w+sxLBUvuvLUWEm0VAxIs0081Bq2JVkvE/JxDRE5jocQQuJvP/h3
	 IkK3l3Afen+al+TGn3CQZnwcL/jbG7KUMv/WPO2Z5MZgqUORSgOBfWW+KYkQV9SLUS
	 80k8m2FhlHfFen6c6GR94+BPQ7ozNt0ZGl91G5tJDdGhz6v6oHJ64VMrClj1lj4Vcr
	 cb+IY5NCgWagro64s+VNfyxRWcbTvhOOK0Q4Ip4VBzckL7Bh1smM8X0CClwpKC3sC2
	 LEPOLL637bu7lxPeDnZMJ0g/kB8anjB8Y3XfwkOAcJ4oRezhrgpLLaBXcd/5xqBjmk
	 ags5DSh5FHLIw==
Date: Mon, 12 Aug 2024 18:58:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse,
 David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
 <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
 <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, Ron Beider <rbeider@amazon.com>, Igor
 Chauskin <igorch@amazon.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240812185852.46940666@kernel.org>
In-Reply-To: <20240811100711.12921-3-darinzon@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 13:07:11 +0300 David Arinzon wrote:
> +	ENA_ADMIN_BW_IN_ALLOWANCE_EXCEEDED         = 0,
> +	ENA_ADMIN_BW_OUT_ALLOWANCE_EXCEEDED        = 1,
> +	ENA_ADMIN_PPS_ALLOWANCE_EXCEEDED           = 2,
> +	ENA_ADMIN_CONNTRACK_ALLOWANCE_EXCEEDED     = 3,
> +	ENA_ADMIN_LINKLOCAL_ALLOWANCE_EXCEEDED     = 4,
> +	ENA_ADMIN_CONNTRACK_ALLOWANCE_AVAILABLE    = 5,

We have similar stats in the standard "queue-capable" stats:

https://docs.kernel.org/next/networking/netlink_spec/netdev.html#rx-hw-drop-ratelimits-uint
https://docs.kernel.org/next/networking/netlink_spec/netdev.html#tx-hw-drop-ratelimits-uint

they were added based on the virtio stats spec. They appear to map very
neatly to the first stats you have. Drivers must report the stats via
a common API if one exists.
-- 
pw-bot: cr

