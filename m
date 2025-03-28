Return-Path: <netdev+bounces-178155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C9A7506A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB7417567F
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E81E0E05;
	Fri, 28 Mar 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="voAhDDmF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B01E0DDF;
	Fri, 28 Mar 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186667; cv=none; b=lIPztxYNSlTRso86XPGWTzsfB5UY3lhKhbX1HuRAuIc7yt9Bw2R/ubkluc5jTAwlLO9/9LmPCjLUYphqFwjhoO3U6UZFew777rod5/jbpotQ+AS7Q0F3Y5ObDRXQinjKx3/qNC4slz/OhtigmZ8nUQK5SpKS3xlttLBLTcJvIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186667; c=relaxed/simple;
	bh=6137y1Xw2RpHNL6chJ4AQaAhXntZ5VPTTUSMUoeKTN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+s8eW6DsMZjlUm6Jth6UlHSUWjkX+qhyCiScXt5B85Ayfa14db0tbc3zhyPyWqUfF7WFsfZGief5xq+t0yppn1p5pBezQAqZOhi+xpEy9oTWSZbuB8WvoJdttEb78pQWgUTpEvun9c+EHIbbOk9lYT0TB8fXRl/nrGQGbN4ijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=voAhDDmF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KiZdMQWB/LsyZGPavTpYkl+cafFMzaAm8u3dZnX0TIg=; b=voAhDDmFQUd7Im9imS7sFMtFb2
	gQicI5Us87m5OL3aZpSiJF7BQn3+6kS+M2bxrKbsje/yWRdIaH/Il/iEvnG8SW6kJzIE4t1tCSZIk
	qUliprkYscKX+kFLDyWxHNPmGi3F24FvEB38292R1tXrc2ciIsDBcioRKFg7Q1fvjwGk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tyETm-007Nvs-Im; Fri, 28 Mar 2025 19:30:54 +0100
Date: Fri, 28 Mar 2025 19:30:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <b187dd05-2d9d-45d0-81d4-fc619dbba1d9@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328133544.4149716-2-lukma@denx.de>

> +                        /* Both PHYs (i.e. 0,1) have the same, single GPIO, */
> +                        /* line to handle both, their interrupts (AND'ed) */

ORed, not ANDed.

Often, the interrupt line has a weak pullup resistor, so by default it
is high. Either PHY can then pull it low, using an open collector,
which is HI-Z when not driving.

	Andrew

