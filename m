Return-Path: <netdev+bounces-222872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E292B56BEF
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF67174D4A
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422E2E5B05;
	Sun, 14 Sep 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp131/QX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220D1D618A;
	Sun, 14 Sep 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879991; cv=none; b=n6LCH2MefsyCSt53PU2opaV3M7dltWSu+9PAfS6Iv6FHl5gAsVfu/q3ZeDXqDRuUZ3UuqN+sfej2RxqqzzoxWMdqr4h4V/o6X/1K/cTB0+l/r4rcPLyJG3gGO1LPdip7tzehsMrqy1I3WuVQtfKusCSpTW2fvX3PwLQBy8MzGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879991; c=relaxed/simple;
	bh=KCDO0FIo3aS1URwHlNLM4ayB53/iGMScKvQzPkT54Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA+/6C5DMn8xmbDku9YHeI6cxeCDjye1HEmwegEkVZ3OJ/lo4VtiR/SrFwH53b8FDaQxEJ2Yei89YmVnO6DkHsf8uhueoB9EDOorfwhrCZ6zkQ9HxuKqJcaEE2lVf9llvXPjGFPbCRVI+ut1wVrPr2dFUFfTJKxwztr+ujkPYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp131/QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B85C4CEF0;
	Sun, 14 Sep 2025 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757879991;
	bh=KCDO0FIo3aS1URwHlNLM4ayB53/iGMScKvQzPkT54Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mp131/QXeuVe1nYVkFiSK2D5IFTzWWMf/NZTjIeouyIP4hJfqTjPrfaI+ovcClWHw
	 WMY320XloPJeBlGrtNXwxrxalMYlDE9tDBkv+VRwleZJY+Rt5rr6k9M74sxRfcS/vx
	 DG4LId2aKFYhgbCTNEzVKoUGQGQ68VhSkUo6Ot5T4NnUUdgjA3Pw6BI2Dnu8KbSGYg
	 j0mWOPrKEmybZFlG0u8LTO1QHmPKZIBVjWFHpJ7CrIIUzQKPW/Mzl4pzdtnwgeRVQi
	 aYu9cEhCF4+5xLEbyGABEOzQB7hXZAeCRCRPfVa0wl/z5B+c1CW9MMSaSZZRp+1HrO
	 BOAITpHqweUpQ==
Date: Sun, 14 Sep 2025 12:59:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, Lei Yang
 <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <20250914125949.17ea0ade@kernel.org>
In-Reply-To: <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
	<20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 08:59:13 -0700 Breno Leitao wrote:
> @@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = ops->get_rxnfc(dev, &info, NULL);
> -	if (ret < 0)
> -		return ret;
> +	info.data = ethtool_get_rx_ring_count(dev);

Is there a reason we're no longer checking for negative errno here?
It's possible that none of the drivers actually return an error, but
we should still check. For consistency with the other patches / paths
if nothing else.

>  	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
-- 
pw-bot: cr

