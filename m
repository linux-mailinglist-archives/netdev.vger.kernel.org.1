Return-Path: <netdev+bounces-117642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92594EABB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C9A1C21332
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5B16EBF0;
	Mon, 12 Aug 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIJfY2A0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02A33C7;
	Mon, 12 Aug 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458273; cv=none; b=WC7W8B/+1p7qoL1Rli3RCNADwH9B2fxSNDJSxImucrQy9H+RKrCwFrVU83mQOyscJmS/m86eOCn2bNu37W5vt18C5y+4CwhMeMijMh38LjsVgcaNfMe8JmK/Zf8U7x1IlA6L5TosZHtdaw5c8itcl+QuwYORhIZta9frsIR8TZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458273; c=relaxed/simple;
	bh=0lQ0DUfUrA4f4zuY26flaUw6GMonhLwYSD0k4emRCeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiavP8l3/cmjTRjcD0akyOggt7Si1EMCgGEgtuB+g+gj/Xxbk4uM+IAUd8MxE8Ud3ZeYmt1fgykECqLDFIlWQqKdXXQ2XbQxy3CzfH1hLq3N0IBUJeRtnTWq+4VVkpShbODXlKWlxPe68d2NcEIHxOEwIQEmQfOjeveWYD8hHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIJfY2A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBCC4AF0E;
	Mon, 12 Aug 2024 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723458272;
	bh=0lQ0DUfUrA4f4zuY26flaUw6GMonhLwYSD0k4emRCeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIJfY2A0lpYqFk2MvZxAmF6v3LamNtPNhD9yoGcdJXp5oeW7xxFhDwt3NoMoSWwpl
	 NglxBPZWkp/smZnDFbiTz1sZoZemEw71M2HhDI0dySWjCsgMcFwciHxZkCQXdZbav9
	 jIVKC/TKeX7xrclL9aqEnTA0KdpjHsXyN8badpJBiLBcdrydwOn7af5HbS49gOzM4D
	 b6WVruAHosJfmKev9LjepvYrOlok08CFsKcI1aDwprsXuCmlLFha4eUI+QbCnjorIH
	 OyQOQoaDO871BMcX/GrBQ5sMe6qH7f1Bz7M4wvBkmo0RDO5rX7XVV4qYFejn8nydVA
	 +knsiUkknNn4g==
Date: Mon, 12 Aug 2024 11:24:26 +0100
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, leon@kernel.org, yuehaibing@huawei.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@pengutronix.de,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: disable RX filters until RX path
 initialized
Message-ID: <20240812102426.GB468359@kernel.org>
References: <20240809163612.12852-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809163612.12852-1-davthompson@nvidia.com>

On Fri, Aug 09, 2024 at 12:36:12PM -0400, David Thompson wrote:
> A recent change to the driver exposed a bug where the MAC RX
> filters (unicast MAC, broadcast MAC, and multicast MAC) are
> configured and enabled before the RX path is fully initialized.
> The result of this bug is that after the PHY is started packets
> that match these MAC RX filters start to flow into the RX FIFO.
> And then, after rx_init() is completed, these packets will go
> into the driver RX ring as well. If enough packets are received
> to fill the RX ring (default size is 128 packets) before the call
> to request_irq() completes, the driver RX function becomes stuck.
> 
> This bug is intermittent but is most likely to be seen where the
> oob_net0 interface is connected to a busy network with lots of
> broadcast and multicast traffic.
> 
> All the MAC RX filters must be disabled until the RX path is ready,
> i.e. all initialization is done and all the IRQs are installed.
> 
> Fixes: f7442a634ac0 ("mlxbf_gige: call request_irq() after NAPI initialized")
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


