Return-Path: <netdev+bounces-169379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D0A439FB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B34188778C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903726138E;
	Tue, 25 Feb 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOIslc/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFB25A2CD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476339; cv=none; b=SYw7wn7p9FDFSlf8cI6jbTddeOLE0kTF8UXCOSFRakOKow1VxzT0Ip3mZZzDbCIHQIpYz1R7mDkAfZQdJVQiHfZzPYMqkReR4rSLoUVr2hKN2XkGx/Ag0nV2Wbfli0++ZK4YhOouuJXbq2xUH7ToLAOl4SzDfx1+2eUxpePteTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476339; c=relaxed/simple;
	bh=Mpo0m6idNqGle/F9l+0n7I4xcC28MOswyoNwASQmucA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg8MAd1WLYeNwZa2VqrrDFO6E2bW8U3PgZ0RkNo9vhyCzbZwPCRQFko74D6kq9PLkoZa/Bg23fsDuzPJ1LZpWXEj2yAGldptXP0g3mvLg4ueeqjK4tUC9Lkgl/tCcwHAgZ03F3QzBwYBdlsWBlz9jFhtN1VDociGRw/Zans84Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOIslc/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08A3C4CEDD;
	Tue, 25 Feb 2025 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740476338;
	bh=Mpo0m6idNqGle/F9l+0n7I4xcC28MOswyoNwASQmucA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOIslc/vsGocaRlnnUFIID+FlY9KAiveCPU4AAYrDG6HHUNEPtiSqImvCump0OvLV
	 weWJ+YRssQWo+GlI1XU6fvV9ix4wTjKLF+w2FYgI+GLsHZIwAtrwyPvRXeW9+kv4Pi
	 JtgORv/XqoHzHJ3V+SMYA/1wIqyHYd17gXRvwjw90SJGLH0O8ltZOBVPQP3gmHWUuO
	 KjZI1lA+J5Qo+J47v9+nl1H92ByRayHFj+JvnPApdORrSmHTY7lwmL3J77hg8lYDdZ
	 aAa35n2zKZAmS+Jr+xiCfnL7O+z6zQMZfqFE7zLZwdYSWve3ts37VzMISp7dQNizem
	 9J+TD30infOyw==
Date: Tue, 25 Feb 2025 09:38:51 +0000
From: Simon Horman <horms@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250225093851.GJ1615191@kernel.org>
References: <20250218183948.757-1-darinzon@amazon.com>
 <20250218183948.757-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218183948.757-5-darinzon@amazon.com>

On Tue, Feb 18, 2025 at 08:39:47PM +0200, David Arinzon wrote:
> The patch allows retrieving PHC statistics
> through sysfs.
> In case the feature is not enabled (through `phc_enable`
> sysfs entry), no output will be written.
> 
> Signed-off-by: David Arinzon <darinzon@amazon.com>

...

> diff --git a/drivers/net/ethernet/amazon/ena/ena_sysfs.c b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> index d0ded92d..10993594 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_sysfs.c
> @@ -65,6 +65,52 @@ static ssize_t ena_phc_enable_get(struct device *dev,
>  static DEVICE_ATTR(phc_enable, S_IRUGO | S_IWUSR, ena_phc_enable_get,
>  		   ena_phc_enable_set);
>  
> +#define ENA_STAT_ENA_COM_PHC_ENTRY(stat) { \
> +	.name = #stat, \
> +	.stat_offset = offsetof(struct ena_com_stats_phc, stat) / sizeof(u64) \
> +}
> +
> +const struct ena_stats ena_stats_ena_com_phc_strings[] = {
> +	ENA_STAT_ENA_COM_PHC_ENTRY(phc_cnt),
> +	ENA_STAT_ENA_COM_PHC_ENTRY(phc_exp),
> +	ENA_STAT_ENA_COM_PHC_ENTRY(phc_skp),
> +	ENA_STAT_ENA_COM_PHC_ENTRY(phc_err),
> +};

Hi David,

Some very minor nits from my side:

Is seems that ena_stats_ena_com_phc_strings is only used in this file and
thus should be static.

> +
> +u16 ena_stats_array_ena_com_phc_size = ARRAY_SIZE(ena_stats_ena_com_phc_strings);

Likewise for ena_stats_array_ena_com_phc_size.

...

