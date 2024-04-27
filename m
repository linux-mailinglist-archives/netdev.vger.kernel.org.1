Return-Path: <netdev+bounces-91888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BC8B453C
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756C91C21BC0
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C145037;
	Sat, 27 Apr 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPalNNVk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440044C8B
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207991; cv=none; b=FFDfomMNd/UcxhW51CyC8OJjowKg1HKzOokg/i1ZSXx/OA2XpEjJFYbIe/e0AaOuJVHOdXC/2O+7VTeTu/6g9gyx/oF8DA+KNZEcgW/gcfMuSYP89KhBsIkaMmyMUKJO8Yca66pSwCP/ucnrbTX64CPTCEoVglCtxs8eCHZ2Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207991; c=relaxed/simple;
	bh=RuV5bHhdf5l3rWfXbGcymKWP21IN6JLsH1dB/74BIRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFEWvTWWjoFtonbw5q+SRpxeQxJm40PAPqp7HHDHy01f6irAzx7M22BR/LMJz/iA1Cl46xrKh636d4BqW7YCzM0V1lj6hNKC4OMLOcZRCkWtPbFUcGLa529zoVp5NcK6EepiKQNtnKMYKaIe1H9S6URlSXQlyqLPXX0b2HFwJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPalNNVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A706C113CE;
	Sat, 27 Apr 2024 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714207991;
	bh=RuV5bHhdf5l3rWfXbGcymKWP21IN6JLsH1dB/74BIRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPalNNVkmWShvGtx0IOyQNwV1FvGxHLjXtMfFL3XAmnLIbf7d5BCV6sI9BfBkfhzF
	 FTAzF5tixJ8uMH8r07nIB0yTz2E74DKsopzHj9s0dZBQ6wpaRSNPc4EbRnIO5/BeTt
	 8vy4HY/rHJUa4muYlTsPlypRM5FxI6bW9YMI5jfvoep8IaJWM53brQ2JIt+JZPDLjW
	 zRRYcjXtGscXIbEYLrvDIvQwnpqR0KQUN6iXvG5KZfmUf8vME2uRGi9+l2jY8S72fc
	 SS2qu7AGGmom2mnmBzIGRPOeVahDZryJNyXrQyfMQjHFgX1JYTUmkgbvegj1G/Iv81
	 PjhsWIWIBzqKg==
Date: Sat, 27 Apr 2024 09:53:06 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <20240427085306.GF516117@kernel.org>
References: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>

On Sat, Apr 27, 2024 at 09:52:03AM +0100, Simon Horman wrote:
> Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> busses") mv88e6xxx_default_mdio_bus() has checked that the
> return value of list_first_entry() is non-NULL.
> 
> This appears to be intended to guard against the list chip->mdios being
> empty.  However, it is not the correct check as the implementation of
> list_first_entry is not designed to return NULL for empty lists.
> 
> Instead, use list_first_entry() which does return NULL if the list is
> empty.
> 
> Flagged by Smatch.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Sorry, I forgot to drop the RFC tag.
I'll send a v3 after waiting for review.

> ---
> Changes in v2:
> - Use list_first_entry_or_null() instead of open-coding
>   a condition on list_empty().
>   Suggested by Dan Carpenter.
> - Update commit message.
> - Link to v1: https://lore.kernel.org/r/20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org
> ---
> As discussed in v1, this is not being considered a fix
> as it has been like this for a long time without any
> reported problems.
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index f29ef72a2f1d..fc6e2e3ab0f0 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -131,8 +131,8 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
>  {
>  	struct mv88e6xxx_mdio_bus *mdio_bus;
>  
> -	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
> -				    list);
> +	mdio_bus = list_first_entry_or_null(&chip->mdios,
> +					    struct mv88e6xxx_mdio_bus, list);
>  	if (!mdio_bus)
>  		return NULL;
>  
> 
> 

