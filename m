Return-Path: <netdev+bounces-225753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62084B97F83
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261162E43CC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010A1F2B8D;
	Wed, 24 Sep 2025 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcQb/foT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63091EB5D6;
	Wed, 24 Sep 2025 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676138; cv=none; b=PLf68zpicJm1iflicbYeN5TXqnjJhkCjIUgkq8uRR60AR6GLA4cLc1okLg+CpCYZ3z2rzeO5ImmoWj+VV6L2tWPuTirfrDG8ouGbojH2aLu3aBL/Ims+348M+jYMobu9Lrq0MRnKwFOvKLtz4PEBzzcuPMRhVWpwwQYxnVmqHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676138; c=relaxed/simple;
	bh=wFeZ3JD6xZwZ0rVyUYmNQlQV4kdMRClxy4beWMxNXaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTOV9gnXbUmK/kvmDqVArVlkQqXDP2mYlVxcnHSNS3trgWIB4ixXbNdheTYsFoj0nZgvKigWcasoke0Af9xnz/Q+LA5asYuVO/vHE5vRHk2YeJmm9y6+y48ph8p/YxXHUNK7Kt5LUYsP+PtU1Os4t4X5RypBuUs9fc43ADkUP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcQb/foT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A1AC4CEF5;
	Wed, 24 Sep 2025 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676137;
	bh=wFeZ3JD6xZwZ0rVyUYmNQlQV4kdMRClxy4beWMxNXaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcQb/foTCK8IYTNMZJ8LsvduxkwSZNrVHkqZhHAF4a097KZHkt/ZdVfu5CRcnV85o
	 QrgRc3iKO1Ss8fbQIK9byT8ZuuH7KCx0odwnToQuxMYUAaynAuV+CN+TwGZsY64HA7
	 aP2MuFPn0OinY5BxzFa8Di/89hJ6injMyOmlMVMIMp71P8DHYDf6Le5xQWxeY7Lzqv
	 ptembayki+YsqOSM3m5YsSrptY4ZPprnm9JsgG624xNGXGxhjMLLzBHxmrfu9zzsYD
	 WeyZutoAibY4uCOV/qYHu6NMA2BzKPT/g5jmGE4QYubUW0mXd2/QO2rSdu2O6KsxNB
	 ijRZ4soW55WJA==
Date: Tue, 23 Sep 2025 18:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, vadim.fedorenko@linux.dev,
 joerg@jo-so.de, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next v13 1/5] net: rnpgbe: Add build support for
 rnpgbe
Message-ID: <20250923180854.46adc958@kernel.org>
In-Reply-To: <20250922014111.225155-2-dong100@mucse.com>
References: <20250922014111.225155-1-dong100@mucse.com>
	<20250922014111.225155-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 09:41:07 +0800 Dong Yibo wrote:
> +===========================================================
> +Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
> +===========================================================
> +
> +MUCSE Gigabit Linux driver.

You already said that in the heading above

> +Copyright (c) 2020 - 2025 MUCSE Co.,Ltd.

copyright is metadata, it should not be part of the user-visible doc.

> +Identifying Your Adapter
> +========================
> +The driver is compatible with devices based on the following:
> +
> + * MUCSE(R) Ethernet Controller N500 series
> + * MUCSE(R) Ethernet Controller N210 series

These are out of numeric sort order

> +Support
> +=======
> + If you have problems with the software or hardware, please contact our
> + customer support team via email at techsupport@mucse.com or check our
> + website at https://www.mucse.com/en/

Please don't add support statements. People can use a search engine if
they want to find the corporate support. The kernel docs are for kernel
topics, and "support" in the kernel is done on the mailing list.


> +config MGBE
> +	tristate "Mucse(R) 1GbE PCI Express adapters support"
> +	depends on PCI
> +	select PAGE_POOL

you're not using page pool in this series

> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");

Only humans can author code, not corporations. Delete his AUTHOR entry
or add yourself as the author.

> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> +MODULE_LICENSE("GPL");


