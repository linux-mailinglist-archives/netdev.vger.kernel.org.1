Return-Path: <netdev+bounces-167040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB42A38771
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA2F3B1818
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D22248A0;
	Mon, 17 Feb 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p43H3GmK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C491494DF;
	Mon, 17 Feb 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805890; cv=none; b=Twj8laZofdGZDbdJLeS0diCVF1a2/VxKoUI7i89bmpUUCHqIqZQ9BhjhiHxQUMGZMcQnXYUEBmvDjXPdBc2mbzxIRkVroe2U5ElHHSCo1M5rkotpXA4zM1SBu4ZI0CSyXphNTg7IYvyeJ8bRZkU1sOJiYVkGZljTKjkLfkj+0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805890; c=relaxed/simple;
	bh=Lij+t1Aeajsr0I1KQ1zMSIWrmWGeEcioWYS1vwi2iAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nigxJiUcOQicSVMfM27ffCsl3+p8K6Jl1M8lP5QFWDmPBM7EJBHAxGJqtmyb/lP+ZRJYlMARErnGtPVnHmytEhkdONEtZ9zV0iJbPLpj7X34hmky0IXDH2CoSKfCfDRqtAnNpk7jvz+rrdxrTeGOK1WAeaM8hDv6SqYC6KuiW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p43H3GmK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GZhQbA2qmEEPaFa8/WvV+gd8ztvFBbpcbeuOt8OV75w=; b=p43H3GmK5oVOPEBcz8V7aIrgCn
	rafylrj35we5GCtPho7YmcL8UbezlOO4BjlvU1zmv68/qzRVhIIP7vBfTwFZX9SmS3iSyhlzOdp/z
	ZJdtOtWLE5F/RZAAJcmj++Ue/xYV1WAMzCOYzkPldNPrL+rGzP59rHsnt6Br2CrHNYU4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tk2zE-00F0QA-H9; Mon, 17 Feb 2025 16:24:44 +0100
Date: Mon, 17 Feb 2025 16:24:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power limit retrieval
Message-ID: <bb058f5f-31f2-4c20-848e-54c178ecaf6c@lunn.ch>
References: <20250217134812.1925345-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217134812.1925345-1-kory.maincent@bootlin.com>

On Mon, Feb 17, 2025 at 02:48:11PM +0100, Kory Maincent wrote:
> Fix incorrect data offset read in the pd692x0_pi_get_pw_limit callback.
> The issue was previously unnoticed as it was only used by the regulator
> API and not thoroughly tested, since the PSE is mainly controlled via
> ethtool.
> 
> The function became actively used by ethtool after commit 3e9dbfec4998
> ("net: pse-pd: Split ethtool_get_status into multiple callbacks"),
> which led to the discovery of this issue.
> 
> Fix it by using the correct data offset.
> 
> Fixes: a87e699c9d33 ("net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/net/pse-pd/pd692x0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index fc9e23927b3b..7d60a714ca53 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -1047,7 +1047,7 @@ static int pd692x0_pi_get_pw_limit(struct pse_controller_dev *pcdev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
> +	return pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);

Would the issue of been more obvious if some #defines were used,
rather than magic numbers?

	Andrew

