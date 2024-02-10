Return-Path: <netdev+bounces-70722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09168501C1
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 02:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2545F1C21908
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644E2119;
	Sat, 10 Feb 2024 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OJCFPxz3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAB20F1;
	Sat, 10 Feb 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528590; cv=none; b=e5kKO24oATnzMEpxG6YIlCr94XzxMmUCKLTbXZrFmVVT7PIVQFrgLMQ3quCnUw2qAJXetQQ1IutCthJ4J/bvDjd5JhqUDFn9PYQiJlWwYOBBiE7NdJTnfAx3bqzVDxFqdk054Rdh1WCJRiMwa1jdvXG5ciJZRDGiHOPrpQcnkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528590; c=relaxed/simple;
	bh=1vD7KDNlqsg8JkEpGde2PbQOlMo9Lcj3c0CnKp0zrL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPdej7NcZWEQJBMEhR/QVAXW2V7bJrhtYXyhziWWHc3wUo4gxtBdpsUHf1eSP9NjBgUVQ1hCw8OtbI8ZPhYlrjEUBB3M6CrSMKEXUduL2NogiwTdn0q7CVNsFJzZrUvOEmrwVBdDKiKXxbdWwwNDxo9AqwgAG217ogubtBjHTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OJCFPxz3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lXjvJyQSxMWE1k+IEVNFiLWtuJ6+Glz08M1ntLI15EM=; b=OJCFPxz3q/SmnzEubNJ5E4zopi
	0uc0rXyuzXMj42Xl7d5RQH/6NRt7ZoG02VGcrmEMI/ZWQEnrU3WmX96iGMZU//eUFbWoawlBbcsrj
	OspBvRDW0RUe410Iw42LrVozYudDM7PlB3OKO4bqRHxHs9b6Q165cR1PJor08+BIBw1A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYcBc-007Qwt-05; Sat, 10 Feb 2024 02:29:44 +0100
Date: Sat, 10 Feb 2024 02:29:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v7 06/10] net: phy: provide whether link has
 changed in c37_read_status
Message-ID: <83fc4ff4-f5fa-4311-8a7c-0e2facb6d258@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-7-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:09PM +0100, Christian Marangi wrote:
> Some PHY driver might require additional regs call after
> genphy_c37_read_status() is called.
> 
> Expand genphy_c37_read_status to provide a bool wheather the link has
> changed or not to permit PHY driver to skip additional regs call if
> nothing has changed.
> 
> Every user of genphy_c37_read_status() is updated with the new
> additional bool.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

