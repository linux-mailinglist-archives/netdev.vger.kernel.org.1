Return-Path: <netdev+bounces-242337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E2C8F65C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA33A975A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BA338F5B;
	Thu, 27 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AyyGsmkv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721633893A;
	Thu, 27 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258989; cv=none; b=LbgGHkWpIR/jnJJO7UHY2U+Q75K90+RBMVZcPtAGKROVzFT5AtcQ9OmAdh+WDdTKt0c5tZ+8txUPQ8psaakWWAc614ZbXcT6bQrXBdtKCk1OiMobvK4mdsZ3nLMFnmRwEZ4cbjZgFaGYbiBmYKb+Xn2ScyMYKnLLMEBTFD6oAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258989; c=relaxed/simple;
	bh=tV6Mko4OcH+BRs/hwl+PIoVt+JtdqFrzfqVvSDARuu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afNv6pYbrY0AnCebvCYt+y3ecQ4U89mBIEv/Pjc7W1hXx9oNh9QT+BTdSmZvkndC7IUIdQQT2q3c2+JW2mlv/ShisX8kX7orFNnmf8sM/JcfN9WRGpJZWU3h0g5VNW0CkSfHbHlfnWC+0RL+a263c17QEX5eCEeiMCt8j1B5NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AyyGsmkv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=76FJT75Kjp6ENeuKI3CQYQWgK2lcdUAiw2gY9LhCcoc=; b=AyyGsmkvks1nnkGd1W5pyGGNPb
	yJKQe9ApPw+DNqiWRINv0KnW4D9S8XfJstMBR/Eao77Glyr02m/InixHitansVmVgQaCVa1pTJwFg
	JaJEq7OxyNBnGFFS0cy8N4IQ+WAOQofmMPXk+Waa9goI3pBA7k5iI4HA992fMhjq5bKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOeLw-00FHEe-VQ; Thu, 27 Nov 2025 16:56:16 +0100
Date: Thu, 27 Nov 2025 16:56:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to
 access ID register
Message-ID: <54f2a7ff-640d-4a9d-bfc9-5190f295f466@lunn.ch>
References: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
 <20251125184335.040f015e@kernel.org>
 <aSgzRMf1LZycQoni@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSgzRMf1LZycQoni@debianbuilder>

> c) what about using EXPORT_SYMBOL_FOR_MODULES() on the problematic
>    functions? Are there any objections against it?
>    This type of export is rarely used in the kernel, so I am uncertain
>    about that. Is using it on functions declared in private headers
>    also discouraged?

Rather than _FOR_MODULES, how about using a namespace.

https://docs.kernel.org/core-api/symbol-namespaces.html#how-to-use-symbols-exported-in-namespaces

Add a name space "NET_PHY_CORE_ONLY", and put these symbols into that
name space. We should notice any driver importing that namespace and
reject it.

	Andrew

