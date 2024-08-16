Return-Path: <netdev+bounces-119248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26A954F75
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DF1F2262D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C11C2334;
	Fri, 16 Aug 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxyHRms0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253211C2326;
	Fri, 16 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827710; cv=none; b=uhjjRg1DFjapL4bMWp27BCCuD/S3FsNYfxzZS2Fp78fl1hC0X2qTfTneHpKfb1PZrrD4uwm0ObRwa+sq7gm24I3BAfIv3lsEvafUMjnA8E9Q3xQYLlhUO8Gasv9XAotkVK92RFQGtvfgwMcGmkvphdRaXG9th/2Xb7DPYPgl0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827710; c=relaxed/simple;
	bh=v2kzBBRptVNV1+RRu9YabyIo3w1DpQo+MXl8LfNqrJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCcC+Glc7lyJq6x1rceJlYzdqAF8kZySypQGHWN/eNfnB1pKWn04hRcIxqmAsmi/MxJEIE9Fzwpd6DdreXsGfiXlMiiFNrmE6Q00p1EI5DofCF3irZ8Y1PgPV/hamT2Is8iIVVbvkZc9Yqb/5gPRXuMLXfJSbjNCp1qDcFyjGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxyHRms0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79017C32782;
	Fri, 16 Aug 2024 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827709;
	bh=v2kzBBRptVNV1+RRu9YabyIo3w1DpQo+MXl8LfNqrJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HxyHRms02cXyeyBA58z6wZs9gc3eDrmeqd24c5QHmiPb+hAPF2oiTRbWfVzCC7Req
	 aYrIRd4qJlFUgspUgOhFqvxqpE/AtiiQ+0j7I9oCnK1SIli3k5vOiHo1tt9MfK1MR9
	 xEQ81a0f5oB9ZdVyruib4cT6ERamzxV8/CD3pk7Ay3lLOJuYXRuR8xNaJNGryJRw6+
	 3CWux7fP29iLay+xHdH3eiLFPtUjVOPeAjx1MdU8iIX+PNal1M5dAFgayMywPXxOld
	 yC+FAJjQpj9uAG7pkeiWGosncboF/u+tpbnw3wV+3g7DbuzmM0jht7kg1tWtH/7+ce
	 QjHSA5rnZmmGw==
Date: Fri, 16 Aug 2024 10:01:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
 <ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
 <vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
 <krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
 <Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
 <Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
 <linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <20240816100147.0ed4acb6@kernel.org>
In-Reply-To: <20240812102611.489550-11-Parthiban.Veerasooran@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
	<20240812102611.489550-11-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 15:56:07 +0530 Parthiban Veerasooran wrote:
> +	if (netif_rx(tc6->rx_skb) == NET_RX_DROP)
> +		tc6->netdev->stats.rx_dropped++;

This is a bit unusual. If the core decides to drop the packet it will
count the drop towards the appropriate statistic. The drivers generally
only count their own drops, and call netif_rx() without checking the
return value.

