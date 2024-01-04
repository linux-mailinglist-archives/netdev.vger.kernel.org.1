Return-Path: <netdev+bounces-61638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068D824751
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1228F1C2426E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E528DB6;
	Thu,  4 Jan 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UKLz4MZ1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4E2557D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p9uUzvKbDtCp3UfuALWP1SSqX7VdWxQDSY+fUv0baQc=; b=UKLz4MZ1qNIzNBpgWfngIjGUFM
	E9F1LlFHXpFgfdmLcLNFxTQ6nYX66kvoO5Tvl2f54QTszYf6cNVdbcfZ0L8He84x9F5kasXjKrDcd
	yQOqgcuwbFqZO8lSsnet/ovzpIAeQ09r2cnpNtaUUFnngFGc0jvLPcH1CumWl/MdiYV8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLRKy-004NGp-Ee; Thu, 04 Jan 2024 18:16:56 +0100
Date: Thu, 4 Jan 2024 18:16:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
Message-ID: <f704864d-56bb-4ff4-933d-8771d0bb6c19@lunn.ch>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
 <a044621e-07f3-4387-9573-015f255db895@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a044621e-07f3-4387-9573-015f255db895@gmail.com>

On Mon, Jan 01, 2024 at 10:23:15PM +0100, Heiner Kallweit wrote:
> In order to pass EEE link modes beyond bit 32 to userspace we have to
> complement the 32 bit bitmaps in struct ethtool_eee with linkmode
> bitmaps. Therefore, similar to ethtool_link_settings and
> ethtool_link_kesettings, add a struct ethtool_keee. Use one byte of
> the reserved fields in struct ethtool_eee as flag that an instance
> of struct ethtool_eee is embedded in a struct ethtool_keee, thus the
> linkmode bitmaps being accessible. Add ethtool_eee2keee() as accessor.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/ethtool.h      | 18 ++++++++++++++++++
>  include/uapi/linux/ethtool.h |  4 +++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index cfcd952a1..3b46405dd 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -163,6 +163,24 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
>  
> +struct ethtool_keee {
> +	struct ethtool_eee eee;
> +	struct {
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
> +	} link_modes;
> +	bool use_link_modes;
> +};

I know its a lot more work, but its not how i would do it.

1) Add struct ethtool_keee which is a straight copy of ethtool_eee.

2) Then modify every in kernel MAC driver using ethtool_eee to
actually take ethtool_keee. Since its identical, its just a function
prototype change.

3) Then i would add some helpers to get and set eee bits. The initial
version would be limited to 32 bits, and expect to be passed a pointer
to a u32. Them modify all the MAC drivers which manipulate the
supported, advertising and lp_advertising to use these helpers.

4) Lastly, flip supported, advertising and lp_advertising to
ETHTOOL_DECLARE_LINK_MODE_MASK, modify the helpers, and fixup the
IOCTL API to convert to legacy u32 etc.

The first 2 steps are a patch each. Step 3 is a lot of patches, one
per MAC driver, but the changes should be simple and easy to
review. And then 4 is probably a single patch.

Doing it like this, we have a clean internal API.

      Andrew



