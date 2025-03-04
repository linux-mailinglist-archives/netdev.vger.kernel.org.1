Return-Path: <netdev+bounces-171834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5CA4EF27
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 22:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB3C3AA20A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B94251788;
	Tue,  4 Mar 2025 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qn/inAdF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264A260A3E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122468; cv=none; b=d0amtFQopXneU33GjJUdSf/MUYV0TGt2r8IlTEIZjcGmlPEOOIDNwriDUI197PmFbvUgmam7qTS48tlNZn1aaW/hPPyTcoxj5gZuFR8PuCYVnvPcHsl7XN06nzUHVbgf8NlX52sp4S1ApjlVwI7HpvcUoCC1mIFGV06kBVj7v+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122468; c=relaxed/simple;
	bh=wIi+Azfqnm9yYsopqy23jlP5FcItAkJ5ANceQdN3QRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksZGGxpeN3adLwJjd3id+vZmAectXquV+fr2IUEE1WFEWoVJ405uZCqBH6pwIO66DqplCVN2dHMxJnlXIOgaf87qKEH41rolnjxtYc6qvZGAkZCSKGodbS0zaHInz6TYqtUJvjCQXldcUcSW2S4jsB1yfLUsZzQdaqmwmB9vZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qn/inAdF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AJ7Y6bhh15PBAyVnM/LSU4zoL/AY4eryKRqi/ttettE=; b=Qn/inAdFx/DgWYJFzTzCwkfV8j
	sju5DpXK15CNE8UUdiMuXKuX2/vuxa2DeK8t/s+AqYxkTg0uMTF6vE9oEksYOg3T/+1mg8OfoVNfT
	LLjGa5HnYPs1T/XaiFjWTt2wPyZHp4m0K0HpCYEOxYUIrx+aBu6d3I4BJF9N/CsSzVSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpZUJ-002GdQ-P2; Tue, 04 Mar 2025 22:07:39 +0100
Date: Tue, 4 Mar 2025 22:07:39 +0100
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
Subject: Re: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190504.3743-5-darinzon@amazon.com>

> +static ssize_t ena_phc_exp_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct ena_adapter *adapter = dev_get_drvdata(dev);
> +
> +	if (!ena_phc_is_active(adapter))
> +		return 0;
> +
> +	return snprintf(buf, ENA_PHC_STAT_MAX_LEN, "%llu\n",
> +			adapter->ena_dev->phc.stats.phc_exp);

I've not been following previous versions of this patch, so i could be
repeating questions already asked....

ena_adapter represents a netdev?

/* adapter specific private data structure */
struct ena_adapter {
	struct ena_com_dev *ena_dev;
	/* OS defined structs */
	struct net_device *netdev;

So why are you not using the usual statistics interface for a netdev?

	Andrew

