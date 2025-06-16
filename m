Return-Path: <netdev+bounces-198046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D12ADB07D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FC4167709
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D81292B42;
	Mon, 16 Jun 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ9SabpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EE2E426A;
	Mon, 16 Jun 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077906; cv=none; b=bRa9rVIPvYzaEtiQVsW5HCVfMgUT7tHufqDooxc9C2bE5eoPvnhGzZmbITfW0LznJ4LGVdbxYlPwS91o4dC6XLCj0678dw7h8Xz4WFdUPQmO1+WS5BrquUL0KtLZbb1MDpntuqlw9hsVkVdQNPjoC+e+B41TI75Img7A40nZnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077906; c=relaxed/simple;
	bh=ZVyAGY9uvV8zGILCtLHdo9FpcXKflZV70WsG162/e3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2mtZ4J3a/8QsF51LbCTQGbjk5GMeb5AGG99suS3A9HXlEfGxhJCPq7ECZKKXuYFDOf20Q9gg8/+kpnNQMlGw7fhBFV5evRb1i0/zoX3c08GQS0/6wZ24DtrTBTnvvhSb+M17gab/H/npuETp8+ncFujmi7wVgIAI8L5XiPKCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ9SabpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620E9C4CEED;
	Mon, 16 Jun 2025 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077906;
	bh=ZVyAGY9uvV8zGILCtLHdo9FpcXKflZV70WsG162/e3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQ9SabpN1E5RXzuOl58XwzcXFmc2tqwLXLBbpZHIQit25OsYhpDeLs8a6TAG6P7UA
	 q4DAgX+hkUjGJQY4j4Yw19L3OLnO1PbMaQYENdDDKv0/O9FIan1igFf3rrOpjWst/7
	 y2pifYFqQ62s4YQUIOnQeAIFKf2Av+VfZ+aMrvTlZOD967X2MgD6wo2lSmXwAS44xa
	 hvtRdgfqEEZ75E1jpYeXkA1Tc9ZZC+YHuLGaS4x21HA836fDhHsNwKc/5s73QL3A/n
	 WHHhnx2D0R0BvTf2D1FIPyqQoiOv157rISCOPzl//7IVZn2Lxy4kAWfCJbj7BS9Uye
	 j8FtdOZ5Wfr2A==
Date: Mon, 16 Jun 2025 13:45:02 +0100
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Asmaa Mnebhi <asmaa@nvidia.com>
Subject: Re: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
 available
Message-ID: <20250616124502.GA4750@horms.kernel.org>
References: <20250613185129.1998882-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613185129.1998882-1-davthompson@nvidia.com>

On Fri, Jun 13, 2025 at 06:51:29PM +0000, David Thompson wrote:
> The message "Error getting PHY irq. Use polling instead"
> is emitted when the mlxbf_gige driver is loaded by the
> kernel before the associated gpio-mlxbf driver, and thus
> the call to get the PHY IRQ fails since it is not yet
> available. The driver probe() must return -EPROBE_DEFER
> if acpi_dev_gpio_irq_get_by() returns the same.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>

Thanks David,

I as a bug fix this needs a Fixes tag, which you can add
by simply replying to this email.

Else we can treat it as an enhancement for net-next.

