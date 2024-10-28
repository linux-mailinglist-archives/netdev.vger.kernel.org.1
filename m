Return-Path: <netdev+bounces-139554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD59B303B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A7E1F214FF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01ED1D90C9;
	Mon, 28 Oct 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X9Gxc8ko"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F01D8E1D;
	Mon, 28 Oct 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118521; cv=none; b=WTmWA1j76fyyDFA2Vjn0koG92FCsVhvLZklFrW3PInZcBdm6diPPz9SQMMDySGNXyqEUJQiAYY25b5+L90pANpn3eQXXcJe860yse2/YrjLIOgfjvGQKqxpZdGhnqmF3H7+bL4WOgDgxKQp8srCmNRt558MIQzwIlsIo1j+KyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118521; c=relaxed/simple;
	bh=p8c3yFftQuOyQ/iEmX2zARlTSUYS8TzTsqqVg9inSPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT/hQUsiJT3A7scf9ueF9N0T2a1qe3KnUFpSAUjCjldeDFCzhzvkTehHnBWlj4SINWAVsD6fgmCw1dgEOlQnI7/0aPfj7/KxuUlgeMtgvrJcTLnOVb4cNKGs61g9GXcR/VXpQH6sKpD9hXZrDsEKK0onF1feiINeFAeWaqwSkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X9Gxc8ko; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OmnXAfgH5krb4Qa7xH5WkPMr5z7E41xpqGjszUtCldQ=; b=X9Gxc8koh4tsaSTZBwfaPLp/kY
	m6eXMrD6ioDtr1nxU1xTZHt+frSGzd5XWC96Tu5CuDdH7ol4XYE/tvXajHbazmoXo8ph7lhrL4WKv
	qMw5WfSghV6DVEw5aJzy7SrUfHvp2qT7ZSxU6ALB+N40ooz4rBIB3Pb2VdVjUTFhmogM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5Or7-00BRXh-LZ; Mon, 28 Oct 2024 13:28:21 +0100
Date: Mon, 28 Oct 2024 13:28:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: Add T-HEAD dwmac
 support
Message-ID: <a3d6c6a1-924c-41a8-b70b-38056fdc079d@lunn.ch>
References: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
 <20241025-th1520-gmac-v5-1-38d0a48406ff@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-th1520-gmac-v5-1-38d0a48406ff@tenstorrent.com>

On Fri, Oct 25, 2024 at 10:39:08AM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add documentation to describe the DesginWare-based GMAC controllers in
> the T-HEAD TH1520 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: rename compatible, add apb registers as second reg of gmac node,
>        add clocks and interrupts poroperties]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

