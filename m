Return-Path: <netdev+bounces-68251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0968464F7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8006B1C22A3B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AA179;
	Fri,  2 Feb 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yPRfnFY0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97C28E7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833005; cv=none; b=EizIbgyU+IHuM96b6NHHuYtU8YRW+1drIK87sqThdDSBZoOqQuabu3/ML6Zn3hQTffBBBovym31/qVeF6ihF0w4W6f4TzP4DCx6tRmBD1qDits3uoLIyib9hb5SU8PQIaA7G2KeyiK6584ct2rERGx9ubeVbTgPhNJtsDxd+4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833005; c=relaxed/simple;
	bh=EDN3BfRv1w1pPwAiNA+iUu5GTyIkfOxd66/MZOM6us0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKogYoMHBAP4rU34QdEBRDVa7rL/rY5TBRmvFDn/PZLewL6oss7RBG9eyCv3ng8Qdi91GB4XGMirO0Jhq8Z3TKpFRIvqeGvqL4kCcFpm77nLugwiWtV9dbSHQSNORUW9KFF6t+XsNMcSdiFOVyUpzeDwe2b6bd/H7ZHDkBVRbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yPRfnFY0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zdm007S7lyUpdZhrFArK1IUdu4h6iTcrLOUKfuRw6T4=; b=yPRfnFY0N2SEtd1dWrm5V+Op4E
	GCVRB8WmYdTzyRyzhL2l8fVHwVaPBzHgqLc0wY/f3iHEpLlWGNMSFwbpq9bDBJw3mXSzXYOk4DQfi
	YYEgf27AkNmSnkQHg0vop3G1wHhlyzagyKvTpucS4nlllXFShdnDP9h7tE6Sm7v7NxZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVhEQ-006jY2-E8; Fri, 02 Feb 2024 01:16:34 +0100
Date: Fri, 2 Feb 2024 01:16:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
Message-ID: <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>

> @@ -5058,7 +5033,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  	}
>  
>  	tp->phydev->mac_managed_pm = true;
> -
> +	if (rtl_supports_eee(tp))
> +		linkmode_copy(tp->phydev->advertising_eee,
> +			      tp->phydev->supported_eee);

This looks odd. Does it mean something is missing on phylib?

	Andrew

