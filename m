Return-Path: <netdev+bounces-179946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B244A7EF83
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809331791C3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D4221DB0;
	Mon,  7 Apr 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y/9GI/Ks"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00731EF0A1;
	Mon,  7 Apr 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059798; cv=none; b=QIWTOuq7qlPUhzDN2ejGTuGsgjTp5gXgXA4mTPdnB6ZrrkA7bRzRaPwsroYuAcCDZAzSUq9sb2Zq2qWqImZ5YTXsPXDgE3aKvppQgvcqOTyRLcnfuV6OUgfJSYykd5g8WiTl2G7mO0FjNSkjdyG0F8zB7ARYi8RKNv59iSqOHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059798; c=relaxed/simple;
	bh=9qTnwNOMC0AWU39j/+kHj2r1vw3uxvLwrRgiXRRcTiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmvwfRBwb/x8MOMfI5Pt8EFA02KaWSXa6Qf9qx+4G2oDPgMDH4oHsmi150zvBksiQZidKynwkqn1+KXVGJZpexyHrviFYMRpC9ScV3xBdGo9J4in8Ln7SxzFwMbydxa4QE2PZNDqEi0rbpBeMZGK2XspZliw7Hc3xDW+lECBqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y/9GI/Ks; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kLNgl0jju5uVhFt8lSFnoVT/LIcWf4ddeNIP99ztnFA=; b=Y/9GI/KsWvPklbZCHXWbAAeG5Q
	WuPZ697SvDZCFUvvK2jKsok3+zOTDA9DPw7rUElZqBSQYDNNNZFfDUHtgoyrbZ/yJg4vZJdMF5uOb
	2HSOKEJ9SUmKLY8R9wy7gnqWk2mdCeRQCxN1yny/PbsuHa4PXTVofxkG2nLxvaoUVzxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tcW-008J2N-73; Mon, 07 Apr 2025 23:03:04 +0200
Date: Mon, 7 Apr 2025 23:03:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/28] mfd: zl3073x: Add register access helpers
Message-ID: <bd028787-4695-4d7b-9000-c725a9ae4106@lunn.ch>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172836.1009461-4-ivecera@redhat.com>

On Mon, Apr 07, 2025 at 07:28:30PM +0200, Ivan Vecera wrote:
> Add helpers zl3073x_{read,write}_reg() to access device registers.
> These functions have to be called with device lock that can be taken
> by zl3073x_{lock,unlock}() or a caller can use defined guard.

regmap has locking. It would be good to explain in detail why regmap
locking is not sufficient.

	Andrew

