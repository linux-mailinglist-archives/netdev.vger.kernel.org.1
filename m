Return-Path: <netdev+bounces-72062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40887856631
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F113D280A4D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91FD13246B;
	Thu, 15 Feb 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o/OqBCkW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C512FB27
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008271; cv=none; b=oto1CSR3PMN70l/KMkHFMiIGbvggN3FxP+qAW7N/VkCBDOFTqf8gNz8/6gWmvIy3VqNo9SPtjg2pO4PonujQhWk8p2y5JOyxeEyO2gwHLcn3Ja5xv34sd8nXRl43k/Hg8Sx2pluwpQuy0WUVxneirJCJ/p++5kYSIcIyJv8yt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008271; c=relaxed/simple;
	bh=ichUW4VK+Ohv/T87xpSfJXdQ69sYS0ChnvAW4osqE1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMcNqxNgamR01oTlGm43GQgsABe7JqEn7G3IHe94XvKU0A+0y/M56+99pacujqG7+ndCKgttl1HZul0/M/AI3ZazTvn9FG7kbKZsYRVvoUlCfGazweRQme1N/IocY01pz1ADzFFBw3dpoo/3Sw/OsPny1/4hFck58ttYk+GxVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o/OqBCkW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ddFotxb4nV5I05CIsmtHYLc7uAnqqgbL+CAt3NoNzaQ=; b=o/OqBCkWpI21TJuVkbsMjOBGeV
	l3jhi/b7zq6Wcgl/0MDQ2NjBfGsQpaw+CqKYxIFoaUbnZTCxSDLds28fS+MBQLLfaRqPCUXMNZnSw
	INdLEKwBwyAa7kZbNwK2PNSC69+kYDR+AhV2ZMnufIThAH0YPif881s3v1ySSp5yZt+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1racyY-007tgN-7C; Thu, 15 Feb 2024 15:44:34 +0100
Date: Thu, 15 Feb 2024 15:44:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
Message-ID: <e7b6082c-6c41-43c3-85e3-a2d75a44c967@lunn.ch>
References: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>

> +
> +	if (ethtool_eee_use_linkmodes(&eee)) {
> +		if (linkmode_andnot(tmp, eee.advertised, eee.supported))
> +			return -EINVAL;
> +	} else {
> +		if (eee.advertised_u32 & ~eee.supported_u32)
> +			return -EINVAL;
> +	}

Do we have the necessary parameters to be able to use an extack and
give user space a useful error message, more than EINVAL?

     Andrew

