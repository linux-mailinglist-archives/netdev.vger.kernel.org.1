Return-Path: <netdev+bounces-139102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFC9B0362
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4591F228CB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8E1632E7;
	Fri, 25 Oct 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLuVuWRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793A1632D6;
	Fri, 25 Oct 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861704; cv=none; b=hD6DDLgmlti1xnQhoruV8D+ybcUF6e0I+A5QvJUmrSjxi0uoVj1nYcu2j2TguCRTCPJXZE3vfYTJ3x/95dpm/09F5mtsfHoQ45D0U2AjWjK9VCKsv3obEcPMTMjzNIFasDUZifq66LGflCAgYaRrDRg06fxrJ8NYlp9GeQAzyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861704; c=relaxed/simple;
	bh=MNxUl9WMfTQw3iIJsYXFRVHGk0K9abiM55dYNFiK5e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8KIKWRthIu+kWX9eadOAywmHWAeMDfm1oAMErNdpkvAApXVnMuYD1eFYpLCVG5At24tqYBuCb2Boo3/VuyujVYqgXb48LubJ3DPr0wXyqYi9zjMiXXFRJXV8DCTRe6zW+CAupGXw0ykEtBouuDTEZEV2cJ8RUvmT2Vai8H4sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLuVuWRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABB4C4CEC3;
	Fri, 25 Oct 2024 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729861704;
	bh=MNxUl9WMfTQw3iIJsYXFRVHGk0K9abiM55dYNFiK5e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLuVuWRItR+u7EjCXA0r2R1yl+hrN7eOVg2JORS94Y04yKk+Ixm+Vqh096eL8VhvJ
	 fP81fSfZTeqaQKaJEqTCl/5xxvCTN1wGqura+LhwxR+o1TJMH9P2DO7iqEGgYwfWFD
	 kWvsXEHLQg9axqXHm9GLXlHi/1hwmAbte+wpH7UQNzxu6tkchcpWJPivy3PdyFoeda
	 k8NnKNuPvOclEXju8nDiTV2ZqpL/qRrvj/+pv3hWZy1jtziKnLgZwsMttvRy9rc/xO
	 3VujCfFxoOy+tC/rwSEjJw7sg52VASkFvNdGwGyMwQrq9aqRzR8HkXDTdfiTS9NWjQ
	 tF9ocPkWMKh/w==
Date: Fri, 25 Oct 2024 14:08:17 +0100
From: Simon Horman <horms@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] riscv: sophgo: Add ethernet support for SG2044
Message-ID: <20241025130817.GU1202098@kernel.org>
References: <20241025011000.244350-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025011000.244350-1-inochiama@gmail.com>

On Fri, Oct 25, 2024 at 09:09:56AM +0800, Inochi Amaoto wrote:
> The ethernet controller of SG2044 is Synopsys DesignWare IP with
> custom clock. Add glue layer for it.
> 
> Since v2, these patch depends on that following patch that provides
> helper function to compute rgmii clock:
> https://lore.kernel.org/netdev/20241013-upstream_s32cc_gmac-v3-4-d84b5a67b930@oss.nxp.com/

For future reference: patchsets for Networking, which have
not-yet-in-tree dependancies should be marked as an RFC.
Our CI doesn't know how to handle these and we don't have
a mechanism to re-run it once the dependencies are present:
the patchset needs to be sent again.

Also, I'm assuming this patch-set is targeted at net-next.
If so, that should be included in the subject like this:

  [PATCH net-next vX] ...

I would wait for review before posting any updated patchset.

Thanks!

...

-- 
pw-bot: changes-requested

