Return-Path: <netdev+bounces-167398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95232A3A250
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22CB18812FB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE326E171;
	Tue, 18 Feb 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jlil5M0o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91B26A1A5;
	Tue, 18 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895232; cv=none; b=Tz0CQGrLWawq7UgLXnElRTZm9EcRUEsVpCbWQaLLX5OF0OXmOuXzFw0DW9BsJmkw61/fBLjg86M57bmWorgN9MQiLCWZPtSD8ApStLJQI8hdjHLrAl0KOq0WpCDt1eWpO55jSYBd/MHe+EQ4IX8kvMxFvhLDG4IB6JmA8nh3XFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895232; c=relaxed/simple;
	bh=gvszVN3gXjDeLF2eKyqbBWxAngG9+KqNtkhPbzdlorw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIZGeH6N0YyTpImw63hmuUkXnO9l0rC/Y227/9G3eMTBAcDQk3/Kxtn6DrSPlv1tjQM/Y2MmV1OHuApH0SoLmSDc29h1Lr9tbBgHaPngNdctAykmoRSzuEfu3uJ531Cn2m6/ZO5abOm72Z0ltCZ9vkHGIky91RIp3ETWJKbEb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jlil5M0o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/v+sG3TD6jlERhEZjj4JDFveXDMRMidR1SaMnbjck9w=; b=Jlil5M0o3R9rb3t3PBPnDyNjWf
	rwe6CYWwux1Fnga6sHKoWl84G7d8BUb3Q3ShtwqBUTFhP/AkvdSAnT0ng5LzjovAGacDbnMRfo7WS
	2mzW28ZKoVORAWY77+8Dx89RqD86A3RKjMCuWDUsCQSHAUWOJVU3g4pRHOBb7PV3xikg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkQDy-00FLX1-UW; Tue, 18 Feb 2025 17:13:30 +0100
Date: Tue, 18 Feb 2025 17:13:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH v2] stmmac: Replace deprecated PCI functions
Message-ID: <c88920f3-ec6f-4ee9-a1d6-8423668480d0@lunn.ch>
References: <20250218132120.124038-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132120.124038-2-phasta@kernel.org>

On Tue, Feb 18, 2025 at 02:21:21PM +0100, Philipp Stanner wrote:
> From: Philipp Stanner <pstanner@redhat.com>
> 
> The PCI functions
>   - pcim_iomap_regions()
>   - pcim_iomap_table() and
>   - pcim_iounmap_regions()
> have been deprecated.
> 
> The usage of pcim_* cleanup functions in the driver detach path (remove
> callback) is actually not necessary, since they perform that cleanup
> automatically.
> 
> Furthermore, loongson_dwmac_probe() contains a surplus loop. That loop
> does not use index i in pcim_iomap_regions(), but costantly attempts to
> request and ioremap BAR 0. This would actually fail (since you cannot
> request the same BAR more than once), but presumably never fails because
> the preceding length check detects that all BARs except for 0 do not
> exist.

Thanks for the extended commit message.

It would be nice if the loongson Maintainers comment about the removal
of the loop. I will leave it a couple of days before adding a
Reviewed-by.

	Andrew

