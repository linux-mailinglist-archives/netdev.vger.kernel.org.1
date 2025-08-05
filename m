Return-Path: <netdev+bounces-211650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67ECB1AE7A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D604E16CA29
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C221B196;
	Tue,  5 Aug 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EExD8YAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BCA927;
	Tue,  5 Aug 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376003; cv=none; b=PtZxElX4h+7XqiXwXy9sreqcfyY/JQa5z3GdlGNoUPmZPoFyDXK5NYvfXE9pfz7bLA8W9rjmxRtEQYLjeQQl7o15OzUHGkdd7N09suH0shqWB2MOPlGApjsgcb6SfweMH+nKFfNecngXU66XdHvGrJuGhsrlO3mZjH6P0cMQxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376003; c=relaxed/simple;
	bh=y43eChycutdYzUFJz6MO9DSyRcPKyMzwMzBdeUn8eDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwAbjflXEPABIEcffvj4saFaQmrMw6uurj7PqMm1X8uLd46BXCXOIDuFzwIqNw3kXBLWG5u+muvKR6z0jmhwlO8prBzVtr9HpFjNq1yIegz3PrIHv6M15Qd7VPL4wvVJdGzBY3AMglS2H9bmLcZxMF9M4x5katL365tHyPmMuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EExD8YAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE1AC4CEF8;
	Tue,  5 Aug 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376002;
	bh=y43eChycutdYzUFJz6MO9DSyRcPKyMzwMzBdeUn8eDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EExD8YAyPy4IntVrNv5HTw9a1S6WReOOAccYEoeuwQqzW9g5z9BuZfedX6pSz20zP
	 orXKOtidCIjP+kxPbYY1e+lLSNgDfrKR+/EH4KPG/xXnptdo1zMWniyJoNRxMjfkYg
	 CWQXzDHySZnCw3Q2wzVl7TrIFgUQ9Mas0WBCPbOrGDc2aFYQqjFCCTjqgnmS9chBOv
	 75eseopcjBLp7ptbCoiV59ighwvz9ClTA/cbuw7Tf9Xy1rORgy4EZQ3wZEigiL/HyQ
	 RAHNiLuvfWa4B6R5/qyDoYmeJEfeTsSgYCt4V3OnMiQCBhjf1xAzIgyQB9mB2JrGBq
	 d+54i7k65Ecsg==
Date: Tue, 5 Aug 2025 08:39:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <20250805-portable-jasmine-marmoset-e34026@kuoka>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801091240.46114-2-ziyao@disroot.org>

On Fri, Aug 01, 2025 at 09:12:38AM +0000, Yao Zi wrote:
> Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> requires one more clock for configuring APB glue registers. Describe
> it in the binding.
> 
> Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Tested-by: Drew Fustini <fustini@kernel.org>

You cannoy really test the binding, except part of build process and we
do not consider building something equal to testing.

> ---
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


