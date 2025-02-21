Return-Path: <netdev+bounces-168364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871FFA3EA8F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898C719C33C2
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EA1CD1E1;
	Fri, 21 Feb 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kao0ylXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA61C8FB5
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103695; cv=none; b=gC7/zg0pbmDtL/OswRLnl//wcwQh9qDyeBtPZQKBa9MmMAmGqilT7ZqWAM/JSp/PQb5i7A0EWMlGnNT0I9sApMectCj5cuR2u7c2p7vMhU7Ds4WosLHglFlqqexs4NTf7EMGU24hkNvA08jR8GXxmoz3stnPWNegzziYfT5tgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103695; c=relaxed/simple;
	bh=XzfrksWFNtnGSgiQPWyBEZtgDEPQ8LSFOaY8vmQgURE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WipZ3Q0tOveVfwiSQyiaUPP5mMKxfW1NyN6OhYQf1zLd0rTVnU1cfQfItgIS4oIlEHTFA7NoRF3LPjJ3topEgSqbUTrg6UQrL4yBh514P4fcK/f/6lS8rsDybg5cpdQ/hrifjCu07c1YAoEJOE5Rh9ju8VDlvLnJgYakp6PIg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kao0ylXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D20C4CED1;
	Fri, 21 Feb 2025 02:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103694;
	bh=XzfrksWFNtnGSgiQPWyBEZtgDEPQ8LSFOaY8vmQgURE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kao0ylXEf4oq+aosBBarGTG78IZ+TJjr16CO7wcxI7yEY8ZSSZpLI6y8vBrQnIMjr
	 hq5PYAAJv/QBX0+T2kpp7dUlFpvt4KGKNTnxpoFy9MW8kN7MdrD0/D34TA8mHZuASU
	 ZwuG0d9rL1+rqwj5icKylpIRdMxn1K0Dk3FPlk3hodZCVW3INovryeL6E0bdpgty7t
	 wf9mBZJ78aM5eUspM4YMswd+3GnU3v5KFPJSA3sAOw7EshKozx8+FSC0IJ4pUXdvYu
	 CoY7l+BPw3cn57F7+bdWgt+g76AJm5Ko5cRsnryip7PO82c1Eieu/LIO4ixDTB1L9x
	 WMh5lqC6TZHjw==
Date: Thu, 20 Feb 2025 18:08:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v7 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250220180812.10b6de7e@kernel.org>
In-Reply-To: <20250218183948.757-5-darinzon@amazon.com>
References: <20250218183948.757-1-darinzon@amazon.com>
	<20250218183948.757-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 20:39:47 +0200 David Arinzon wrote:
> +static ssize_t ena_phc_stats_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct ena_adapter *adapter = dev_get_drvdata(dev);
> +	int i, rc, chars_written = 0;
> +
> +	if (!ena_phc_is_active(adapter))
> +		return 0;
> +
> +	for (i = 0; i < ena_stats_array_ena_com_phc_size; i++) {
> +		const struct ena_stats *ena_stats;
> +		u64 *ptr;
> +
> +		ena_stats = &ena_stats_ena_com_phc_strings[i];
> +		ptr = (u64 *)&adapter->ena_dev->phc.stats +
> +		      ena_stats->stat_offset;
> +		rc = snprintf(buf,
> +			      ETH_GSTRING_LEN + sizeof(u64),
> +			      "%s: %llu\n",
> +			      ena_stats->name,
> +			      *ptr);
> +
> +		buf += rc;
> +		chars_written += rc;
> +	}
> +
> +	return chars_written;
> +}
> +
> +static DEVICE_ATTR(phc_stats, S_IRUGO, ena_phc_stats_show, NULL);

In sysfs I'm afraid the rule is one value per file.
So the stats have to have individual files.
-- 
pw-bot: cr

