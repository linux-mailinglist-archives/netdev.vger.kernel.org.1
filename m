Return-Path: <netdev+bounces-47226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 902987E8F6D
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A06DB20912
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBB6FCE;
	Sun, 12 Nov 2023 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkKG5VzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DA79CD
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 10:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB29C433C7;
	Sun, 12 Nov 2023 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699783384;
	bh=h1XRU2QcWSORmhiLe3AKlTnoXQyD1EhmC2394NTIt/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkKG5VzUR3khaNOdCySp4Mu5bVCWLVHGm1NtzYWgHxDifx6Wx0tkWNyhiT7WGFczH
	 4Ku9EGK0Qc3lePy6dR1GKclktz8avITT8dRxZYuSCiD53y0WQzxYqxNGJs+uFwVems
	 5hSkKAU9jjcwIrKvNrz6oE5PEjW1kOpT/LG1/u7/uumj5yrDZNUo3is864aWGN47ym
	 4ott/VHxSegguUTjsQJjriwHrJrY0fq7nAWlWC2YWLB5ydFY83Dsb4oYmyHHV0ryKa
	 vs3kL5TQkuB9unozeATpCAPadHs7hsIJahREjDCX6DvxXQxYmlOPLPA5FapLFWAhgP
	 MawNBULuZi8Tg==
Date: Sun, 12 Nov 2023 10:02:56 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next 8/8] iptfs: impl: add new iptfs xfrm mode impl
Message-ID: <20231112100256.GH705326@kernel.org>
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110113719.3055788-9-chopps@chopps.org>

On Fri, Nov 10, 2023 at 06:37:19AM -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>

...

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c

...

> +/* ================= */
> +/* Utility Functions */
> +/* ================= */
> +
> +static inline u32 __trace_ip_proto(struct iphdr *iph)
> +{
> +	if (iph->version == 4)
> +		return iph->protocol;
> +	return ((struct ipv6hdr *)iph)->nexthdr;
> +}

Hi Christian,

please don't use inline in .c files unless there is a demonstrable reason
to do so. Rather, please leave inlining up to the compiler.

...

