Return-Path: <netdev+bounces-37523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F17B5C4B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CFFAF1C208E3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45125200DB;
	Mon,  2 Oct 2023 20:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016920309;
	Mon,  2 Oct 2023 20:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7B0C433C8;
	Mon,  2 Oct 2023 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696280157;
	bh=3SUjHS1R/+k33+41I8df1OAaO4gb+JCavb+GatMXfr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ts6e8OPAXbwJSqbHZh7OB/J5bL/OHFILZtb1yBVm7HXPB1PZk/XGQ7AuIW4n29dj+
	 ecoBTO+7hrPW8Q6xuPPASkVTEUpIET4SQ0Jsvd2gVlk1zyw1YTaRy14t4smDjHCbYx
	 Ip/BJuo0W6EjA2rvCbaan0iEIW+cj78pq0AqAEptDJPl392/1LNQKv84du3Y6mEcD5
	 kLx5VdsMxdIHgNASSD2ZmOJqOflab/gjsH9hwidf2wGhMgu6x7m8pUtG4MO1ahLvP5
	 y4L8a3M2ByHooguBVfjxXHjB0K4VvDBx4MXBRBHPNchRHELaiLL3HcPvunO0YVRUT/
	 sMrIc2mpMLNtQ==
Date: Mon, 2 Oct 2023 13:55:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231002135551.020f180c@kernel.org>
In-Reply-To: <xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
References: <20230923031031.21434-1-rohan.g.thomas@intel.com>
	<xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 14:25:56 +0300 Serge Semin wrote:
> On Sat, Sep 23, 2023 at 11:10:31AM +0800, Rohan G Thomas wrote:
> > Enabled the following EST related interrupts:
> >   1) Constant Gate Control Error (CGCE)
> >   2) Head-of-Line Blocking due to Scheduling (HLBS)
> >   3) Head-of-Line Blocking due to Frame Size (HLBF)
> >   4) Base Time Register error (BTRE)
> >   5) Switch to S/W owned list Complete (SWLC)
> > Also, add EST errors into the ethtool statistic.
> > 
> > The commit e49aa315cb01 ("net: stmmac: EST interrupts handling and
> > error reporting") and commit 9f298959191b ("net: stmmac: Add EST
> > errors into ethtool statistic") add EST interrupts handling and error
> > reporting support to DWMAC4 core. This patch enables the same support
> > for XGMAC.  
> 
> So, this is basically a copy of what was done for the DW QoS Eth
> IP-core (DW GMAC v4.x/v5.x). IMO it would be better to factor it out
> into a separate module together with the rest of the setup methods
> like it's done for TC or PTP. But since it implies some much more work
> I guess we can leave it as is for now...

I think we can push back a little harder. At the very least we should
get a clear explanation why this copy'n'paste is needed, i.e. what are
the major differences. No?

