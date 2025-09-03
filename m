Return-Path: <netdev+bounces-219667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF764B428DD
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623341BC0800
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC353629B8;
	Wed,  3 Sep 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4MvYT+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775C1547C9
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924717; cv=none; b=BPByBfnE0fpNr/szXwMbHH9ZIfY04L81cjc55eNkq0tytXG/+rPvnz1SYcibR0ChZxML0FSOoZpB7BmJqTTeRIustG0JhSA1c9MxRSHR/yXvs7W4mc6H2xpfg3rsd1jBXhfSEq0ZEswPFGFZyDOaWuB71jok1bDD7rzClOiE9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924717; c=relaxed/simple;
	bh=j8OqivN37U7s/3MXyiGRY0V9zEvCu9lIMomm6PVYCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiNOqauA6uh+tYEadd7fYqWiGshshbw7njh0X8LisiZsN1wvccswFLGlGyzP1eqmrmKV6Qmx+792CSKwBHjAHwMumb8ZXJzTjsRh65VE885KZ0GcunZAJEz6XC+B9i6OqBPyiMpgU7W8YZz1X2e8m77RvbDk71me3bzB692PP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4MvYT+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D90C4CEF7;
	Wed,  3 Sep 2025 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924717;
	bh=j8OqivN37U7s/3MXyiGRY0V9zEvCu9lIMomm6PVYCJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4MvYT+4HWfKOeRmVv/QVqMHo0ZHV6viDUD5TCHmInuzXrQC9briLLdhe6nPf254m
	 DJHpH8YKEbcC5AhFSqObCVrYvSw7CXSXGHTkRvroq8y6MEJckf0cuUTB+apvw+m0Tb
	 fSCqoc/XeI/Ddcia7IcAxJj49Md8mgTxdJLDkT2Qz1tnDtcbqEO0MjlWT8G+fJcDXB
	 7Yxy06GTC2TJ4FRJ/lKMxjkA2Ol1ouTfpGgn/wj4+/04GEopzIeRGv1rFslRQVaRWC
	 W077qbNHaIattrXPS4xVpttQ82fH1ifGj5qpod/COxwqlYlLtF2HNxQvnaDG1N26sx
	 j4sPqLpu04VnQ==
Date: Wed, 3 Sep 2025 19:38:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: correctly populate
 ptp_clock_ops.getcrosststamp
Message-ID: <20250903183832.GE361157@horms.kernel.org>
References: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>

On Wed, Sep 03, 2025 at 03:00:16PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> While reviewing code in the stmmac PTP driver, I noticed that the
> getcrosststamp() method is always populated, irrespective of whether
> it is implemented or not by the stmmac platform specific glue layer.
> 
> Where a platform specific glue layer does not implement it, the core
> stmmac driver code returns -EOPNOTSUPP. However, the PTP clock core
> code uses the presence of the method in ptp_clock_ops to determine
> whether this facility should be advertised to userspace (see
> ptp_clock_getcaps()).
> 
> Moreover, the only platform glue that implements this method is the
> Intel glue, and for it not to return -EOPNOTSUPP, the CPU has to
> support X86_FEATURE_ART.
> 
> This series updates the core stmmac code to only provide the
> getcrosststamp() method in ptp_clock_ops when the platform glue code
> provides an implementation, and then updates the Intel glue code to
> only provide its implementation when the CPU has the necessary
> X86_FEATURE_ART feature.
> 
> As I do not have an Intel card to test with, these changes are
> untested, so if anyone has such a card, please test. Thanks.

Hi Russell,

Although not strictly related to stmmac,
I am wondering if similar treatment is appropriate for:

* drivers/virtio/virtio_rtc_ptp.c:viortc_ptp_getcrosststamp
* drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_getcrosststamp

And if some sort of documentation of the behaviour you describe is
appropriate. Say in the Kernel doc for struct ptp_clock_info.

