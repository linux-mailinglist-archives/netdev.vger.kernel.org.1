Return-Path: <netdev+bounces-185713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C1A9B82A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E03C7A7D89
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06E28BAA0;
	Thu, 24 Apr 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZpkTmzFb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27F1A5BB6;
	Thu, 24 Apr 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522327; cv=none; b=up2VzLJO4ikuijr28ApLvHqT1oUCk0UlfFVGN0Qi0AS7I+rYotpZqKfhr6vsu5g+NidUX4gbG1Okbr1Ek6QGXZlQIQGjWfvI0Aoxk1FXrGBK1Ora9ffcrDo/k/a/ckpE2lO/3scizF5Ip9n/T9nwq9zn6ffzKDYHyIgm6uh0YRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522327; c=relaxed/simple;
	bh=5legdItJ0q6EqH5Fk5QJFNo2Mp5z6Cfpb77dkDQyYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svfzedzHj36dK9ZWSTIpq2osUjvig9jEJvd1+Yj064e080xlf6A5GXQQE19KDK51IdFy4BXOpRJm8+le45CWY7zrpgG2UI18+lRL/yX/akvc7StR+/Jj4p2YDygHmLbmYHX2g2cR53BgsP324U05hgvPRgFaDz/Bb6vgM9R4l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZpkTmzFb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8m9rwFWK2GB+1BAEonxrPntgARL+u2AKlrZ41aTOYIY=; b=ZpkTmzFbhoJFbm6pny0uunJg/x
	TyJkle2WGU+QBJ55+h4L63yWqqgQtDqLW333EkUm1hS8FW7R9Gb2lSYBo8wmKKuZgNs/sciMhKWQ/
	qDt8k1vOdu/ROX2vDQqQOjkhq7mxDPhIhBdVeWKM8YxBb2RIDP6A8blwl8c9ZBS42zPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u825h-00AVJi-7R; Thu, 24 Apr 2025 21:18:33 +0200
Date: Thu, 24 Apr 2025 21:18:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <8082254c-01a6-4aca-84de-76083fdcbb3b@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd645425-b9cb-454d-8971-646501704697@redhat.com>

> During taking 613cbb91e9ce ("media: Add MIPI CCI register access helper
> functions") approach I found they are using for these functions u64
> regardless of register size... Just to accommodate the biggest
> possible value. I know about weakness of 'void *' usage but u64 is not
> also ideal as the caller is forced to pass always 8 bytes for reading
> and forced to reserve 8 bytes for each read value on stack.

In this device, how are the u48s used? Are they actually u48s, or are
they just u8[6], for example a MAC address? The network stack has lots
of functions like:

eth_hw_addr_set(struct net_device *dev, const u8 *addr)

and it is assumed that *addr is ETH_ALEN bytes in length. There is no
direct typing checking for this by the compiler, but the compiler is
getting smarter at checking for buffer overruns over function calls.

	Andrew

