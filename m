Return-Path: <netdev+bounces-181372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE14A84AF1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124793BBCAF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE61F151E;
	Thu, 10 Apr 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wkA52WoS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB81F09B6;
	Thu, 10 Apr 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306020; cv=none; b=G5FRCPI99cmGI1x7CYfOTURX7Ra0uPJ2edgn7i7myeYVj0dDV9+m1/U7sthU1+nBCjLmwe4mWh5ivGcj65k89sHEIjZap1O/jN3u20jm0UAlkslHLiOpgE2alPpHkbKh8KkPRF1VLyJgSbw69wTPKKPddplwK39OtZemvoCARZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306020; c=relaxed/simple;
	bh=MfVxR2Uj+V4WKwQQH23p7VKKXkNaxTBisaeTiG/TFrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnUn3dRYinnrAHjHvglFdzr00aTIYDe7A7b09aVDCpEBK1gRO9mRi9N6n4Dgp2gb1Gb9TcUH1dn1Cl30D0n5SWOOeojGFxExeQZ1wYaWpSRSrUx4Gg/owgy2/zwaWIzResFjECpxYfs3HNzt78g9ERZ+k3kQKB9jsMu6BwIS7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wkA52WoS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K/+uq48uDxLTDaVDGJ5KGm/WGs8wAmdlqq63pxQGr78=; b=wkA52WoSYbOfd1xweNl/D4mZGg
	NKyf15w/D36skDsRdW6CpsuFVy37BMHOyJtNrs9Z57bUNS8LYqNyybUnS1RI4p6ZjT4g+FFAuN036
	+oj4RaqSA0N/E4oY/u0W5I8iykiqtpTbMf2mVKSpm/lkwtqLgpAjqPzkMQbsvRkDRyHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vfk-008iC9-VX; Thu, 10 Apr 2025 19:26:40 +0200
Date: Thu, 10 Apr 2025 19:26:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Message-ID: <205b3f32-5574-4006-8ba1-3ca35c89261e@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409171713.6e9fb666@kernel.org>
 <889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>

> Btw. I would be interesting to see a NIC that just exposes an access to I2C
> bus (implements I2C read/write by NIC firmware) instead of exposing complete
> DPLL API from the firmware. Just an idea.

The mellanox driver does expose an standard Linux I2C bus, with the
firmware wiggling the bits on the wire. But i've no idea what devices
are hanging off the bus.

	Andrew

