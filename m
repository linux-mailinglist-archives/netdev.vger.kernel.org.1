Return-Path: <netdev+bounces-211766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E02B1B8E1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D7B7A30FC
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F2291C10;
	Tue,  5 Aug 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRXBUwJT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9245C14;
	Tue,  5 Aug 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413148; cv=none; b=b2VHYM5x3tChLCZe2Va5JBo046Yd5m8gAtgUBreYiNlRjHiSRCBVyQWwpgXQsXOJcm7C0TCfl1j4+G2x+pjpt7D3D+Pn7EelpmGC84umd8oxhIzn5mFTmVckrLd4PhJHIYHCfYt5GFZ9PO7z/IRf8B0EXX0sJokH8wM+FXr5sLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413148; c=relaxed/simple;
	bh=MzHn4PwFNsPUQzIyRmZAIovqpKUpUowJ7E/2uYiGNa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtvMQSK+pV/WOFd5n/6uazpNz8H0cZ/ByyKlLObMt88E1iRqkNC9dF6PTTmm1B4oftxGR46Nz4ezyn2tPX4r6qQRkhrCqrtUlP2TdkqsDOlvlBT0vbwy1Th8gkgo37G5MLs/oH84/DKOU6O0Jyk+PERPLM08JZG0m/MqD2YmppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRXBUwJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A10C4CEF6;
	Tue,  5 Aug 2025 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754413148;
	bh=MzHn4PwFNsPUQzIyRmZAIovqpKUpUowJ7E/2uYiGNa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRXBUwJTBUuDu7ysnWSTbhDmoC2ydPzwS0mRrz1R5+vCmwIS/hnRoOAlvgj5L9CLT
	 7S84UBIOeuUVMygMLcDycTWnszyvCMly2AscPtmLlQnLsOnnsSrCkGfWfYkpU49D4p
	 30kaHW5ZxIMrP3smVIob2b73cBGxYg0PGgCJe0jY/Gk6KNrZF24yHEjtCyerYWXwdI
	 vYtgsGRG2mx/bekg+6CubBNn9Ry5tN5Ig56p1fLqdRUIXKoyjq/8OL9mdR6rLfAQX7
	 uaY+EO6K+ShrBC/AGz0S9V30xltg94Eq+sCVRCx3mFVKUCZHDKNviX/JnT103TqV0f
	 GYJCbLlVBxvPw==
Date: Tue, 5 Aug 2025 09:59:06 -0700
From: Drew Fustini <fustini@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <aJI4WiigJFoYPXU1@x1>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-2-ziyao@disroot.org>
 <20250805-portable-jasmine-marmoset-e34026@kuoka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-portable-jasmine-marmoset-e34026@kuoka>

On Tue, Aug 05, 2025 at 08:39:59AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 01, 2025 at 09:12:38AM +0000, Yao Zi wrote:
> > Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> > requires one more clock for configuring APB glue registers. Describe
> > it in the binding.
> > 
> > Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > Tested-by: Drew Fustini <fustini@kernel.org>
> 
> You cannoy really test the binding, except part of build process and we
> do not consider building something equal to testing.

Good point. I've since provided my Reviewed-by: in this v2 thread so the
Tested-by: should be dropped if there or is another series or when
applying this v2.

Thanks,
Drew

