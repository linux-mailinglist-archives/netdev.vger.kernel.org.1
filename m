Return-Path: <netdev+bounces-95136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD98C17D0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C562812EF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C27FBD2;
	Thu,  9 May 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uewZFYeq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E24770EB;
	Thu,  9 May 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287596; cv=none; b=I3tnqdmyGv37fhZl04PbD3nvhguENn6IzzQn5meJpmqg7mncYFucLXYrRDdrgqe2R0VM6ivdFUxq8seHh5WW/Q6abKW5ljA1eFqcMVsyRopNOPDQVmCnl7MMIwiR3vg3YbzeT0VpiO8M9FggJONgH3QAWEMw2AVLC/7p4KMLFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287596; c=relaxed/simple;
	bh=ugCNzJgR3FfH7MP1fs5r4yQAZSoJF6d+ZnO3Ch7oZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohsBk6e3fqeq2jK3c5v1k/vj0KCFg4Yrd7NsqJmzSvIIKQa8Hz0Mi0dpthsaj+U3HIpnU8ZQXiHxkzqxZZz3X5QJ3ZIFkRGpee7S6S3yD65AE2HgrUlX+YIq7UPS76UzdSjjfol88GOiy6FsLbR5hoYsvANfpvjlXQ+SXFYOTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uewZFYeq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T6hs9QIjhwEwsFH/YAWaRyCLK6C1G5kwXs7g/a4WgSE=; b=uewZFYeqDpl09bnvCCVVwCNwKe
	X/Coa95kEWDV5urBgRgaO1jn85JMK4YbM54f7q0VeofK8G7koD4Qil2nDCd5GUmuGlRb2WIvLqqP5
	5YEGK6rTzQQia6tpUkQFb06X6pIWDzTLsXUhUECmU/IeIa7NNFjRfEIal+kdgUNWG9os=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5Aes-00F52c-QR; Thu, 09 May 2024 22:46:30 +0200
Date: Thu, 9 May 2024 22:46:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jiri@nvidia.com
Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Message-ID: <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509163216.108665-2-danielj@nvidia.com>

On Thu, May 09, 2024 at 11:32:15AM -0500, Daniel Jurgens wrote:
> TX queue stop and wake are counted by some drivers.
> Support reporting these via netdev-genl queue stats.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
>  include/net/netdev_queues.h             |  3 +++
>  include/uapi/linux/netdev.h             |  2 ++
>  net/core/netdev-genl.c                  |  4 +++-
>  tools/include/uapi/linux/netdev.h       |  3 ++-
>  5 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 2be4b3714d17..c8b976d03330 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -439,6 +439,16 @@ attribute-sets:
>            Number of the packets dropped by the device due to the transmit
>            packets bitrate exceeding the device rate limit.
>          type: uint
> +      -
> +        name: tx-stop
> +        doc: |
> +          Number of times the tx queue was stopped.
> +        type: uint
> +      -
> +        name: tx-wake
> +        doc: |
> +          Number of times the tx queue was restarted.
> +        type: uint

I'm curious where these names came from. The opposite of stop would be
start. The opposite of wake would be sleep. Are these meant to be
opposites of each other? If they are opposites, why would they differ
by more than 1? And if they can only differ by 1, why do we need both?

	Andrew

