Return-Path: <netdev+bounces-104011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF990ADAF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DA1C22D8E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032E194C7C;
	Mon, 17 Jun 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKjnky9d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C4194C67;
	Mon, 17 Jun 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626234; cv=none; b=DShLjoMi8DWwXMMYu9sT6b50vzSG8B3YBYO9eeIXvwKbYucProIa/ODx3rzXg5bCMKB6OoNOxmw9wSMS5WnBNNGgXVML/TJKOSdrmgOVBH9Fl6fkYgqlbgx+DK3ZK82tN2bUzyngXvLXNvpmzYZeKZbrRY02iH66wuG6SCW+i7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626234; c=relaxed/simple;
	bh=qblzdiviYT3MtcEgu/h6QToMzITqf5gDxw6DymenjaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNVLgArw5fzmtoLXm5S1E8lc3xDq4xYCVyctX7E1oajJoTM7zpADlgQKdk8mrVBzuxhQJlkGztOW3wJanRgBbqvKniTywJwmGTsJZMHthyRLfgdLWsKWwLxLQfiCwlrT120i4IuBlktUBvMzXwJsjxSea6B7W1rS1rAXcsDfoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKjnky9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136A8C2BD10;
	Mon, 17 Jun 2024 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626233;
	bh=qblzdiviYT3MtcEgu/h6QToMzITqf5gDxw6DymenjaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKjnky9dDHoQC1/PAnQ2MoxtSE6seSeo8gyCE1GDx9vw1xE9cwLDkoC3dSoODukmX
	 57MNMHvbDDXZjb0lhaax8Pkl016LgJGZNvmvN1Uq2xnS3RgxciVKZEugzWjYa/Ugtb
	 9V9N4T8hB2FZQsy0av6+pOzDd2iPlZxAwc7tdZeMJUUQca8GMKyD73/f5D4uVfJDRp
	 xV4KFjOG4djUXLLj3U/l8goPT7DB8m2JAkYl4iJfER2jKTg7QPv1LOxoRGsOdxmm82
	 x5uYxYaywk1IkaL7MsOhT5963mAr1lbv8nJQp2SINU4Ih1YCxC1m6B8c70Kqo2jKFa
	 kGRIpVaDKOFHg==
Date: Mon, 17 Jun 2024 13:10:28 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240617121028.GS8447@kernel.org>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
 <20240611195007.486919-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611195007.486919-3-paweldembicki@gmail.com>

On Tue, Jun 11, 2024 at 09:49:54PM +0200, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

...

Hi Pawel,

Two minor spelling nits from my side for your consideration.

> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 2997f7e108b1..fc8b7a73d652 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -14,6 +14,27 @@
>   */
>  #define VSC73XX_MAX_NUM_PORTS	8
>  
> +/**
> + * struct vsc73xx_portinfo - port data structure: contains storage data
> + * @pvid_vlan_filtering_configured: imforms if port have configured pvid in vlan
> + *	fitering mode

fitering -> filtering

> + * @pvid_vlan_filtering: pvid vlan number used in vlan fitering mode

Likewise here.

Flagged by checkpatch.pl --codespell

> + * @pvid_tag_8021q_configured: imforms if port have configured pvid in tag_8021q
> + *	mode
> + * @pvid_tag_8021q: pvid vlan number used in tag_8021q mode
> + * @untagged_tag_8021q_configured: imforms if port have configured untagged vlan
> + *	in tag_8021q mode
> + * @untagged_tag_8021q: untagged vlan number used in tag_8021q mode
> + */

...

