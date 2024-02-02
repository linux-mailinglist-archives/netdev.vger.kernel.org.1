Return-Path: <netdev+bounces-68636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8BE8476A2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58643B2B657
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74214AD3E;
	Fri,  2 Feb 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkQf7Jiv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EC14AD2A;
	Fri,  2 Feb 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895982; cv=none; b=uurkS+c+VQB+ODVx1SUqpC04znojm8I7oT22YwwJ9gUctW7vQQgj1wl8u2J4yBoWqCU81sWs8BN0Ts9uxQZMQ5Q86RRzfrd8RdXnfEqal6OPxlgOEllF7ARxjixeKMdcXm5FPPS+ANNCLuKddXww/JvH+KgD0cYlE9ENKn6dEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895982; c=relaxed/simple;
	bh=7jgOF5NtTnU74w1rpsqxhGKkI60zcMEfbbeuZkMITbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwLsRNdhuOLgVPQpVrAqrYAXjY2PdKTjid2aO8xLKQW5OMhwvVZIBVe48/HWwAa7EAGWLnnwpYyYsFctcZwnq+F7+U252HSU85uLg+hRxQhHUaXPGzEKDHM8lEttNoERlCAX4T5Cgq+cswLlNZHHcZ8g8owQtR1nh3bpqdGQNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkQf7Jiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2405FC433C7;
	Fri,  2 Feb 2024 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895981;
	bh=7jgOF5NtTnU74w1rpsqxhGKkI60zcMEfbbeuZkMITbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkQf7JivLyt7i71KUt//AVXLcGeQVUqYyc544w7KuPB4ExMGFzAxOKXBeAtLNuaXr
	 kEjxO6XJU7llvVd57Y8CGNjRXZKDeb4hZUDy2ra88LdLWAwYrQEsH5P/lbqwpkErAd
	 GaFanAJ5xbDqikZRsKMUE+KdvMhxgM7I6oVGojQDEjh6Sf7kNWPxzNQSOW1FUi/JZv
	 5QHmPBCLVMGZDIffq+kWcU1nNG4pTRj5CDaT67esQ3gL0mWR0B5/eLiUi3VqkgBENd
	 yuHx7MFEaj4UooQ4Jao6zD3GsmdPS+KY681FTNefL1vjCm1K8mqkYLjwg8B739UvUa
	 kW3mm7/W/RM4A==
Date: Fri, 2 Feb 2024 17:46:15 +0000
From: Simon Horman <horms@kernel.org>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
Message-ID: <20240202174615.GT530335@kernel.org>
References: <20240130111234.1244-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130111234.1244-1-quic_snehshah@quicinc.com>

On Tue, Jan 30, 2024 at 04:42:34PM +0530, Sneh Shah wrote:
> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> mode for 1G/100M/10M speed.
> Added changes to configure serdes phy and mac based on link speed.
> Changing serdes phy speed involves multiple register writes for
> serdes block. To avoid redundant write opertions only update serdes
> phy when new speed is different.

nit: operations

...

