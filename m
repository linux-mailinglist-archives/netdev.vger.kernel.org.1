Return-Path: <netdev+bounces-104179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C690B70A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0D72855F8
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B561161924;
	Mon, 17 Jun 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js6dk8wq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038EA1D9526;
	Mon, 17 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643108; cv=none; b=evNesHPpfan7Bpu+o0tzbE/afKRSjBocjhwSXtTMLM1zRC0e589/Wq2Rvcos2x1mxJwHSLaRjyINQmK2VfFjIjc+MITnZLuWdYYDMPk0YToWM3f0o2LkoRxWgQLihZq8kGifXykvcFIkwIeyFRd3mtsDI14GN4JUe8cC8DMAVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643108; c=relaxed/simple;
	bh=JQ9/ew7gNBZkCvIaaYqgstiKB/4Vesu8cj+i8F8ugsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktpti6ki88geR1F2bk9hiunwaTQh3xzMILMT7PIMZLWA7H8NSkwr7kKoI93kGQTLwgRpUcp277XVmxZUiZFD9qW9NOdIBn6wGgcSdnDgFjzbDWsoMsUUfENOUfY9SpYjIdxJaGITbKFA5BqGLq9/8BmnXKicYMiuO2m1JA1bKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js6dk8wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35318C2BD10;
	Mon, 17 Jun 2024 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643107;
	bh=JQ9/ew7gNBZkCvIaaYqgstiKB/4Vesu8cj+i8F8ugsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=js6dk8wqM2vGwMzBeUoVi9zTNzBclB3440OFZMVql27MEzKvs9qPHQ+iFbYjg4RPl
	 e6LfgSYfhvTz/ZAASx9i/y+n5osVCeyw3wyX+2V1Bybmxn/iiL2uTEy5IWrMUCin4o
	 NFHkjg/Dq2HSuud6miltzRHaXxmuMoQGnzsv6/wj2ODGlySkqlZuR8+GL9qw8oofio
	 xc0xNZpCkErpd/26ZwF9hyqUBISr53j5kzktT6RQYO8O6D86cHHXwqCupZMCVRwbgH
	 FzsB4/rTrfpP48RKMUaUsOOTHBeB6bUehepbWadDtqo2CErEnNq5ARbmlXF/+auxme
	 eFHf/oNq/37Cg==
Date: Mon, 17 Jun 2024 17:51:42 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Corinna Vinschen <vinschen@redhat.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v4] net: stmmac: Enable TSO on VLANs
Message-ID: <20240617165142.GX8447@kernel.org>
References: <20240615095611.517323-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615095611.517323-1-0x1207@gmail.com>

On Sat, Jun 15, 2024 at 05:56:11PM +0800, Furong Xu wrote:
> The TSO engine works well when the frames are not VLAN Tagged.
> But it will produce broken segments when frames are VLAN Tagged.
> 
> The first segment is all good, while the second segment to the
> last segment are broken, they lack of required VLAN tag.
> 
> An example here:
> ========
> // 1st segment of a VLAN Tagged TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1518: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [.], seq 1:1449
> 
> // 2nd to last segments of a VLAN Tagged TSO frame, VLAN tag is missing.
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 1449:2897
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 2897:4345
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 4345:5793
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [P.], seq 5793:7241
> 
> // normal VLAN Tagged non-TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1022: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [P.], seq 7241:8193
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 70: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [F.], seq 8193
> ========
> 
> When transmitting VLAN Tagged TSO frames, never insert VLAN tag by HW,
> always insert VLAN tag to SKB payload, then TSO works well on VLANs for
> all MAC cores.
> 
> Tested on DWMAC CORE 5.10a, DWMAC CORE 5.20a and DWXGMAC CORE 3.20a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   Changes in v4:
>     - Re-arrange variables to keep reverse x-mas tree order.
> 
>   Changes in v3:
>     - Drop packet and increase stats counter when vlan tag insert fails.
> 
>   Changes in v2:
>     - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.

Thanks this both seems correct to me and
I believe it addresses the review of earlier revisions.

Reviewed-by: Simon Horman <horms@kernel.org>


