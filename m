Return-Path: <netdev+bounces-92219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204238B600B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4CEB21359
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0E8663A;
	Mon, 29 Apr 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3UeKbYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77578811F2
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411765; cv=none; b=Exit7SitwfjjKf3FCP2ccmqx2dezBpJNn66uCZv+E84EgO1HuC22ZFOaz4yho8FVPq3nStJIUEcRqH7EkoCdbg/FfrHSpimjKOpehH92CNg1BkWdmT78l0buQ4W8942OYA11AHOGl/vjmzx9vhkQC4c9T8E+jWzzAPo7cn+qaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411765; c=relaxed/simple;
	bh=TpsQiCUGol0xjlL0j8a7euWyLmueTYUFVKc/yKSXbkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjVC8iFFoHTxV3ftd/YVp5nVSjPcbQpBPbpsIO75YSBIuDBr4hEUyVVnWtPU4ATaBABOY4hSh2ZEExDvFRJVZpzPDPJzCFdTmLtW7GWSBhLLMWr7ZDsDESkYzmguNPwfb29uPOoSfIptmcyUhGMbcpTAHStUSFFJPKQXVaQ4qlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3UeKbYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F802C113CD;
	Mon, 29 Apr 2024 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714411765;
	bh=TpsQiCUGol0xjlL0j8a7euWyLmueTYUFVKc/yKSXbkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3UeKbYe1dRYpUqINDqhxAc+6PlQ9RjchVy3gRuJA9H5peymsnsDb35vhti36qZyf
	 cdt41XpJpOd9U6jDNRF+MkKdbxD5x6XRzwg3rijiwbNp2F7w2Ajcw1n+nRzOk9KGuQ
	 VXUf8l0OpwhoD12HZkwzHqeH+9qtvo+A6AIP/4lHJ00n9YNxBtUzU73xAdi99YifnN
	 NxbrBDb7OV1mWucOebu2pEj1Boxcm4UHpdzKqj6TxSNY/loSwIIoczNXAlg/6p3LLm
	 yeqsa0LiKx50HEqobR291iAaLtgkiGJeNwq7cIHwBP0DRYuF/GsoxOr52dgIjmSwNH
	 j/J6itW8E6Z3g==
Date: Mon, 29 Apr 2024 18:29:21 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: use phylink_pcs_change() to report
 PCS link change events
Message-ID: <20240429172921.GC516117@kernel.org>
References: <E1s0OGn-009hgf-G6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1s0OGn-009hgf-G6@rmk-PC.armlinux.org.uk>

On Fri, Apr 26, 2024 at 05:17:53PM +0100, Russell King (Oracle) wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


