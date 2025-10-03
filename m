Return-Path: <netdev+bounces-227741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C061DBB66A1
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 12:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BB3C7E9B
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C029D277;
	Fri,  3 Oct 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igEA8nE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E912628D;
	Fri,  3 Oct 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485795; cv=none; b=gJZsoqSuY77xSzT918m4klD5ezrBtpCC9SO6GMxGs+4CMZJJjZtm61+GPecvZHSaAfTMJJeRJ7muaHdt+6w7zc6dz0Xfd2XIIxbJWqtUBZLuKi/EJtkFL2lNmHCt1iFvGDWXhlSH29iXtsHUKwmp6wz3ayK7X6MqHloev2b/KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485795; c=relaxed/simple;
	bh=BgSuB7GWMd8DJOutNjpsgHVOVudfak5NQQHVEXr7idI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+122t1sWEGwZAjyiStDvMryi9BPqFUpmt/4z4wGx5qq93gJRjLgbeSLCXeySTjSn1U8ZyIHvA/X1rlw97DrcoTJyLrF08bWxBId1/t869EgGCyW3TBXfyja7xX0goqjTwfhnOIVvSwwL7kjGfEtcT3IKrXYSuuJ3KlcJpsByag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igEA8nE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AA4C4CEF5;
	Fri,  3 Oct 2025 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759485793;
	bh=BgSuB7GWMd8DJOutNjpsgHVOVudfak5NQQHVEXr7idI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igEA8nE5FRxfdKJdsQFMTKoGR3FUIcR/sZYLuRRRs3N/iZnfma/VAGSZ4zk1OzfBY
	 nFPz2GQ246wOuIr7ASL5yaNJOlGRZNz44LorsVG8NnejmvEddyJTfWb+T6aUDEXdMH
	 CUps38QSo4q+oG88RlO5vm4VpxjI4qiO/FthIMZYBAcpfAxM4fbzttzWHm2mSPQgDJ
	 PS72rdukPvmDyxAyuAwpsG8kxvLT+N63xtA7QiZHmCPMjA+VCl1EK/Guz/mcGGn5X2
	 hzDZCXlOWDBXVQq2HjUdtfPB6s4eBpH8fR7EPWLLOQDskfOXMJBKJ0eUhezYU5L0zt
	 buvpnRUyHl0IQ==
Date: Fri, 3 Oct 2025 11:03:09 +0100
From: Simon Horman <horms@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khalasa@piap.pl, khc@pm.waw.pl, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
Message-ID: <20251003100309.GH2878334@horms.kernel.org>
References: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>

On Fri, Oct 03, 2025 at 09:29:18AM +0000, Kriish Sharma wrote:
> Fixes warnings observed during compilation with -Wformat-overflow:
> 
> drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
> drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Update proto_name() to return "LCP" by default instead of NULL.
> This change silences the compiler without changing existing behavior
> and removes the need for the local 'pname' variable in ppp_cp_event.
> 
> Suggested-by: Krzysztof Hałasa <khalasa@piap.pl>
> Fixes: 262858079afd ("Add linux-next specific files for 20250926")

Perhaps this should be:

Fixes: e022c2f07ae5 ("WAN: new synchronous PPP implementation for generic HDLC.")
But more importantly, and sorry for not noticing this in my review of v1,
I'm not sure this is a bug fix. In his review of v1 Chris explains that
this case cannot be hit. And that the patch is about silencing the
compiler.

If so, I'd suggest this is a clean-up and thus you should consider:
1) Removing the fixes tag
2) Retargeting the patch at net-next

Please also note that net-next is currently closed for the merge window.
So any patches for it should be sent after it reopens, which will
be after v6.18-rc1 is released, most likely on or after 13th October.

See: https://docs.kernel.org/process/maintainer-netdev.html

The code change itself looks good to me.

> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> v2:
>   - Target the net tree with proper subject prefix "[PATCH net]"
>   - Update proto_name() to return "LCP" by default instead of NULL
>   - Remove local 'pname' variable in ppp_cp_event
>   - Add Suggested-by tag for Krzysztof Hałasa
> 
> v1: https://lore.kernel.org/all/20251002180541.1375151-1-kriish.sharma2006@gmail.com/
> 

