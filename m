Return-Path: <netdev+bounces-204042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635BAF8992
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7CA1CA0CEF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E325DB12;
	Fri,  4 Jul 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dpiJI5Hf"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637B1DA60F
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614392; cv=none; b=XNGOSCS0/0ivXuc80mkVy1hFkw/o3YBthq43cE4BQs78s3c8a0FU1j1bSMoP+Sq//K8DWVhOZoIst3vSU+/XfsnhkhtvglkOSbQ0OHU4kjdJxaI9D4MjQboWoaWxVQm4PV6zXcGEGh53ytunaNra8YIB9+dsL5VDY4DM8syNOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614392; c=relaxed/simple;
	bh=ou2E/EvLccmqd/8ZFdRpV88aLt4+699+y2rqeS0rCHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J36N7zGeCDumCHcMkD/1zbBUORUSc3gRxPFAOnsIqDUZzakVB4ysuObNkszL0sxDh3KFkxCUIyDGRZD0fGxINRBxcowNt+tjOnjGCjA6XPn7UciRKgSfOKMWbsBhjKwJFwfhXMZEObGN/D/oeLqXsvRsUd0QrTwd6/BgLcZ26fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dpiJI5Hf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5EB9D20754;
	Fri,  4 Jul 2025 09:33:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgJL8LImDPX2; Fri,  4 Jul 2025 09:33:06 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B1C1B2074F;
	Fri,  4 Jul 2025 09:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B1C1B2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751614386;
	bh=eQNIUVW2/NOe4Ox8kJi0kMa1CNhWoXHPGyL261cv/yE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=dpiJI5HfFSVNQmsrzEO6SmTvRjMUcOKPkZwRVe092zous+N8/+QcnMeL54+8n9c6t
	 6ioQlfvmtpYESuu4r6ZFw7QSpSkjG0DtOeKL6Ywv60otuCgJYs4bdsyLR0s5j8WzNF
	 vPnvKuh1BkqUhoK5TieZuncuwwXtLWLwuKd8gldAniJhddEcNTYg2Qqj5v4Y1F5OUq
	 oX1HXsVVWtYK4nkPtIcis2ONjz0T7/ixJOogmp1EdAWvIhnBc7/MovWqHKnLb29cCw
	 LGQvlmUFMIfXF0WuIjp99oOOquATMGc6JOPfX548tj3WM5/aAlyYgXZA9nbSBCPsMi
	 ASAz+5js+7hqA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 4 Jul
 2025 09:33:06 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 09:33:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6B5CC3183D37; Fri,  4 Jul 2025 09:33:05 +0200 (CEST)
Date: Fri, 4 Jul 2025 09:33:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aakash Kumar S <saakashkumar@marvell.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <akamaluddin@marvell.com>,
	<antony@phenome.org>
Subject: Re: [PATCH] xfrm: Duplicate SPI Handling
Message-ID: <aGeDsU-DjJG7Saj7@gauss3.secunet.de>
References: <20250630123856.1750366-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250630123856.1750366-1-saakashkumar@marvell.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Jun 30, 2025 at 06:08:56PM +0530, Aakash Kumar S wrote:
> The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
> Netlink message, which triggers the kernel function xfrm_alloc_spi().
> This function is expected to ensure uniqueness of the Security Parameter
> Index (SPI) for inbound Security Associations (SAs). However, it can
> return success even when the requested SPI is already in use, leading
> to duplicate SPIs assigned to multiple inbound SAs, differentiated
> only by their destination addresses.
> 
> This behavior causes inconsistencies during SPI lookups for inbound packets.
> Since the lookup may return an arbitrary SA among those with the same SPI,
> packet processing can fail, resulting in packet drops.
> 
> According to RFC 4301 section 4.4.2 , for inbound processing a unicast SA
> is uniquely identified by the SPI and optionally protocol.
> 
> Reproducing the Issue Reliably:
> To consistently reproduce the problem, restrict the available SPI range in
> charon.conf : spi_min = 0x10000000 spi_max = 0x10000002
> This limits the system to only 2 usable SPI values.
> Next, create more than 2 Child SA. each using unique pair of src/dst address.
> As soon as the 3rd Child SA is initiated, it will be assigned a duplicate
> SPI, since the SPI pool is already exhausted.
> With a narrow SPI range, the issue is consistently reproducible.
> With a broader/default range, it becomes rare and unpredictable.
> 
> Current implementation:
> xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
> So if two SAs have the same SPI but different destination addresses, then
> they will:
> a. Hash into different buckets
> b. Be stored in different linked lists (byspi + h)
> c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
> As a result, the lookup will result in NULL and kernel allows that Duplicate SPI
> 
> Proposed Change:
> xfrm_state_lookup_spi_proto() does a truly global search - across all states,
> regardless of hash bucket and matches SPI and proto.
> 
> Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>

Applied, thanks Aakash!

