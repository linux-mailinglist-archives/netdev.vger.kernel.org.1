Return-Path: <netdev+bounces-223398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E880B59048
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1CF1B24657
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E420286890;
	Tue, 16 Sep 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="M5jmvdY2"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0C1B532F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010856; cv=none; b=TdtbgdCcoey020yDHW6pdeb7dJwrNGqoFOCMdQSvTaWjTkOOe3atKKBKFsOeQd5OkD/UeggXwTPoATbhCw7i+e5h9XIFAyjEIPCMZroa4lrAkBuL20v0yxqwIJRBIWaWyeADd7e3ciJPUCRDU8PPIZeTmWk6ZlR9ezQvVXhYs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010856; c=relaxed/simple;
	bh=4KE3ZIM46VZBGWx1rOrIwDYke0hW1+PjLACdRpNqbEQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkmSGwYxDVK+AALyYhd1YRJlZjIav8ZnC8zEH6tfwRjHiFe9x/eQgqqHbrwotiJw+shYwD0homsGxRy+g2fErBGPhx5NcKBCMG5I+TFjUWXu2bjjRd5noL7BOWFj31CqYdJn8zHlaY1Sze2cAB/wqogndgGbhF0mmWwrjF+Fkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=M5jmvdY2; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 799302076B;
	Tue, 16 Sep 2025 10:11:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUMulOkRt5Pq; Tue, 16 Sep 2025 10:11:14 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B152620704;
	Tue, 16 Sep 2025 10:11:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B152620704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758010274;
	bh=2XIifIGekRVtEO8555U5kYgBep2JshmsVkCS7TmCgIM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=M5jmvdY2cHCBVyM2opoCHe3KjpNoWNq3CegKvHtT9Aw61/3u3q6yO4E5gQyW9wwP8
	 zCuukYjydFikqjlD3u5VujRihNUWd7HktvXoHLBT4onc7Ayaff0A+cB4KYXDfcOoRE
	 E563uY6e+hC0TToEiUtToP+gJkX8twcJkVyOnUS6KhcdtyE2qBv5XQsQyQRpt0N/6g
	 kuPUegaDRjp1HlmfroDswrV5yagdUBKtWZJ1LfJj2v7cNQF0EaJvLgwEFq7nENtxre
	 tgFqyJdQ9fLEkC39+if3syfnHZmsrEI3FKjRl4jHXaVOq4oxSEHyVnPZ3O+wsxTZh0
	 gcUDospxSADvw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 16 Sep
 2025 10:11:14 +0200
Received: (nullmailer pid 1264670 invoked by uid 1000);
	Tue, 16 Sep 2025 08:11:13 -0000
Date: Tue, 16 Sep 2025 10:11:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Xiumei Mu <xmu@redhat.com>, Leon Romanovsky
	<leonro@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH ipsec v2] xfrm: fix offloading of cross-family tunnels
Message-ID: <aMkbobzEx53SfGEx@secunet.com>
References: <c4b61b2da197f2ef3742afec3f8866c5ab8e9051.1757516819.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4b61b2da197f2ef3742afec3f8866c5ab8e9051.1757516819.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Wed, Sep 10, 2025 at 05:22:13PM +0200, Sabrina Dubroca wrote:
> Xiumei reported a regression in IPsec offload tests over xfrmi, where
> the traffic for IPv6 over IPv4 tunnels is processed in SW instead of
> going through crypto offload, after commit
> cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> implementation").
> 
> Commit cc18f482e8b6 added a generic version of existing checks
> attempting to prevent packets with IPv4 options or IPv6 extension
> headers from being sent to HW that doesn't support offloading such
> packets. The check mistakenly uses x->props.family (the outer family)
> to determine the inner packet's family and verify if
> options/extensions are present.
> 
> In the case of IPv6 over IPv4, the check compares some of the traffic
> class bits to the expected no-options ihl value (5). The original
> check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
> Innova IPSec offload TX data path"), and then duplicated in the other
> drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
> because those traffic class bits were not set to a value that
> triggered the no-offload codepath. Packets with options/extension
> headers that should have been handled in SW went through the offload
> path, and were likely dropped by the NIC or incorrectly
> processed. Since commit cc18f482e8b6, the check is now strict (ihl !=
> 5), and in a basic setup (no traffic class configured), all packets go
> through the no-offload codepath.
> 
> The commits that introduced the incorrect family checks in each driver
> are:
> 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> 8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
> 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
> 32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
> [ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
> mode, thus no cross-family setups are possible]
> 
> Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Applied, thanks a lot Sabrina!

