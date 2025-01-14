Return-Path: <netdev+bounces-158277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33FA114EB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF23A05A3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E692139AF;
	Tue, 14 Jan 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6+hp4c6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7262135B1
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895645; cv=none; b=mSvpc0Pgb3iz+Xj96WV5vnw5HMmYkEzkZmc6laog2G/jeHDql6VufWV6gx69Og30KfwvxR7kGzyK04vKfrchYb0LOYCxw88c1IX/mFfFlfxAPnW/LJUAKfmapN4fGbp+l9Mf6yHbaugiTi7BcNJzAnhWZzDlgAaEBgGE+HgPfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895645; c=relaxed/simple;
	bh=/yZeoqUg4CR+9Fo38AJo8FzVHVUpTvoc0KzAQl57i0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGLsb4aOrzaZgFgJ2t2MKnU4U6qTO1put/Zpfbx1jsyGkDPfFU99NocrpmGH1MMLIrRbqT3KxoFPef64bcePqVjzsinxncIM6732/pw31dIPd/ey33yUUUjCftzG05BCVzLUYUJ9TwvXBbEOjWsDyZ5u+bBPirZSjNRIf+1kFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6+hp4c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EE1C4CEDD;
	Tue, 14 Jan 2025 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895644;
	bh=/yZeoqUg4CR+9Fo38AJo8FzVHVUpTvoc0KzAQl57i0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6+hp4c6TxdhEbc8tcp0alGna3gSrkUJE4H80zEn/o06AZFfZauKGiUalkU2yP8cO
	 ZZHI1VHyGqg5jfWZIlisy1EwwkIUhacndp9DnxFPr7tHqV5zWL71hD+pQ8nMw4UXhq
	 3mtVat4o7JlEH3SKGBy45fg1iMQdF3+EZWCi0R7llP83GNZBsq4FULpcU87vcBE4AX
	 1NGp9P4Y/6L83h2xRDiCWKifZA2x8+GBmzp3e9gy45KV/5xCBBHQXeX324NLeALpTu
	 iqCgc8ZH+xrhXIcb5ZWsYz51yGtnv1ClihUNG3HW94IHHSBmu/wO9327LqCgV61yre
	 CEYr44Xb8PeNw==
Date: Tue, 14 Jan 2025 15:00:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
Message-ID: <20250114150043.222e1eb5@kernel.org>
In-Reply-To: <e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
	<e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 14:28:22 +0100 Heiner Kallweit wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index f711bfd75..8ee047747 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -270,6 +270,7 @@ struct ethtool_keee {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
> +	struct netlink_ext_ack *extack;
>  	u32	tx_lpi_timer;
>  	bool	tx_lpi_enabled;
>  	bool	eee_active;

:S I don't think we have a precedent for passing extack inside 
the paramter struct. I see 25 .set_eee callbacks, not crazy many.
Could you plumb this thru as a separate argument, please?
-- 
pw-bot: cr

