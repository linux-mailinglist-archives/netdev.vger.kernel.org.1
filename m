Return-Path: <netdev+bounces-141563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0C9BB696
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AFB21FD0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41C73501;
	Mon,  4 Nov 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NUkKF+Yn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABA224F6;
	Mon,  4 Nov 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727830; cv=none; b=uq0A5JepWK+4rx0hUbWYn0Qzt0QzncjUwoHQpiy0wCY1qQkrRtfq9SkAV+weu+bNgPWSJs5QfGSrK/MTbQbiAwTLUHBiDFv7kIUDXNXqJxyv1O6YL4RkSO/XHPMCiIjmlQ7YOeNYIhNT27l5Ac+apuRyxuZwkEVs5/M3NAImWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727830; c=relaxed/simple;
	bh=7273RisU05ZxH4OueEs/7zsU9DdzaCrocRm0ZPvQzjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwPw4bRQdq7WstWtDnE9pAMqznBnaXfnew6SnOUSigvKLVUHPw+wtszmUI4Ikcu8BH1cW0eUnV2tG69rTnKX+8eQxBo6dHj6rT8BkXsuQu8xf4wdpRUbsZZR5uohsxUTmUQ7OotUKxfdfvQgfJmvAuN3GfZH8ML/LMfXacdwd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NUkKF+Yn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PZZ+VskREZ1SAqWw91Fq2H9w91sZ2sS2fZte5zbRKIM=; b=NUkKF+Yn+Yvh6LQiQVoxySRbPf
	PeqkHlEFUA5/OwfdyzEboAtyZcjVieB3X6OhT0u9+GbNjTbkCTu1B6MoVKno9LrRcKmZQ4+EyoSoG
	FGXcYRVeqwuRbn6taHHsSA0oSjFSMJcQyTLsutRG8Yo2Im57WjJQNqZB0iaR1Hls145I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7xMl-00C6iS-Go; Mon, 04 Nov 2024 14:43:35 +0100
Date: Mon, 4 Nov 2024 14:43:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 2/5] net: pcs: Add PCS driver for Qualcomm
 IPQ9574 SoC
Message-ID: <3677dee8-f04f-45f0-8bfd-dd197ec71616@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-2-fdef575620cf@quicinc.com>
 <8f55f21e-134e-4aa8-b1d5-fd502f05a022@lunn.ch>
 <ec76fc73-79e5-4d09-ac4a-65efa60874fe@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec76fc73-79e5-4d09-ac4a-65efa60874fe@quicinc.com>

On Mon, Nov 04, 2024 at 07:14:59PM +0800, Lei Wei wrote:
> 
> 
> On 11/1/2024 9:00 PM, Andrew Lunn wrote:
> > > +config PCS_QCOM_IPQ
> > > +	tristate "Qualcomm IPQ PCS"
> > 
> > Will Qualcomm only ever have one PCS driver?
> > 
> > You probably want a more specific name so that when the next PCS
> > driver comes along, you have a reasonable consistent naming scheme.
> > 
> 
> We expect one PCS driver to support the 'IPQ' family of Qualcomm processors.
> While we are initially adding support for IPQ9574 SoC, this driver will be
> easily extendable later to other SoC in the IPQ family such as IPQ5332,
> IPQ5424 and others. Therefore we used the name with suffix '_IPQ'. Hope it
> is fine.

So are you saying after IPQ comes IPR? And then IPS? In order to have
a new PCS design, Marketing will allow you to throw away the whole IPQ
branding?

	Andrew

