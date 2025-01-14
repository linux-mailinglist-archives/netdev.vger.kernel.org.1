Return-Path: <netdev+bounces-158096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE77A10743
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894CD3A6CC6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A76234D0A;
	Tue, 14 Jan 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3Zvp6eHE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48765236A92;
	Tue, 14 Jan 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859745; cv=none; b=QkfeQNxrKCWuvpyyyvoHCs0Vc2XqlNqrZVZTpDAcldJxy9CYkeTBvHQJxpQKsO97YkdeDg9SRTgmk593/qE+9Sm1a9r610aZOaSBDyo4T3S+aZrTd61eUek6cOFLpda6eZToLEa0ZqYiZ6WtTEjwsHA5yV91qPm6/GdI2qbKrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859745; c=relaxed/simple;
	bh=4KYk04ivc4ZtfYoz6pDV3Q2k/bfEVkdo5B18FdRn4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUZcQftWP7wHGi3w3vb0gvb8odluQnsA93dGbbPMmlk2xrfD1Ei0801jVOUMbjZJElgv1H77PmSm5Khpd7BjrJB3BDqdfz6+BIf2998m7CwYIPUDZAO1ousY+faNbiDhHhQOAj3WpwNdbpEG638P0T7DbFJZEEFYyPoRrjxe0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3Zvp6eHE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q+YL+GREgbidA0eFi2fS0Vb6HkSnj+9SAko3nhv83Yc=; b=3Zvp6eHEcdajmQ16XPZNsvJ5qa
	p+IR0twCn0HkAiOlDXII51pf1gQPXQNuktN90W2COIEpo8TQc+Ty5oRVwpcbIzXmyN/v20m+98I3C
	RVzAMDvKOlAfpnhiwWIWynNaPSC7Hv/gxTef3E54E9mdEo8rLklAFvsBrjalUBTVwOUw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXgYY-004RpV-HC; Tue, 14 Jan 2025 14:02:06 +0100
Date: Tue, 14 Jan 2025 14:02:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
	srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org,
	john@phrozen.org
Subject: Re: [PATCH net-next v2 12/14] net: ethernet: qualcomm: Initialize
 PPE L2 bridge settings
Message-ID: <b7b13bba-e975-469c-ad59-6e48b5722fc7@lunn.ch>
References: <20250108-qcom_ipq_ppe-v2-0-7394dbda7199@quicinc.com>
 <20250108-qcom_ipq_ppe-v2-12-7394dbda7199@quicinc.com>
 <4dbf1550-32e9-4cce-bf0c-8b92dbd49b50@lunn.ch>
 <c67f4510-e71b-4211-8fe2-35dabfc7b44e@quicinc.com>
 <8bdde187-b329-480d-a745-16871276a331@lunn.ch>
 <4599e35b-eb2b-4d12-82c7-f2a8a804e08f@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599e35b-eb2b-4d12-82c7-f2a8a804e08f@quicinc.com>

> I would like to clarify that representing the bridge and its slave ports
> inside PPE (using a VSI - virtual switch instance) is a pre-requisite before
> learning can take place on a port. At this point, since switchdev
> is not enabled, VSI is not created for port/bridge and hence FDB learning
> does not take place. Later when we enable switchdev and represent the
> bridge/slave-ports in PPE, FDB learning will automatically occur on top of
> this initial configuration. I will add this note in the comments and commit
> message to make it clear.

So it seems like the comment is not the best. You don't actually
enable learning...

	Andrew

