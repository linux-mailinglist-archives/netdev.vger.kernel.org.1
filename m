Return-Path: <netdev+bounces-119170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96432954732
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527D528500D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B01B9B4E;
	Fri, 16 Aug 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1n2KYkq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0B1B9B41;
	Fri, 16 Aug 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805703; cv=none; b=snTNw/hpENphTMl8D4PfUylQa7Sf1uHzbScssr8OwddtjjDGwdpk4b5h9uK7BNMUMnMbE6kY5NpIX/XJGM8i55Qy5VD3FtnNadHZnRtSC3h4Uqemf13JC0u/S9S3XYjGK40vzxoTEcd3+t1lMgTZULfqzloVuWCoHihXOVjtDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805703; c=relaxed/simple;
	bh=iXwPjY/2OXN3pzBaT6tWz/A/Lrxef/t0PSx5EIp8LAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkT/fEfsj8haGd0IAGHxQO40ZudQpI8erGYUDwRq1q4bKoXTQnDDSSC+VNjoL+kDSBluWAfkIluMZ1i+dQpLZla48d2actZK38M82zhdtiFggKi2nIVqxuAZbgvZfCSnW19R7ZNtezZslU5QbT66CcV4FApOQsH7MPWxQF6QvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1n2KYkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99EBC4AF09;
	Fri, 16 Aug 2024 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805703;
	bh=iXwPjY/2OXN3pzBaT6tWz/A/Lrxef/t0PSx5EIp8LAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1n2KYkqz9YvEHrO7EZ5jqvbDonBnyhPgx8LxcsJwWPrbqPkcEkSZfJqOEuJnd2lH
	 gUOiZXLz/wjQX5c8w/i/4ODxRvE4tm3BID5CCT+wOv5QeqHBuFQnWyH/pWKhXPT/kP
	 dGvfcVRRQZWs9WYc14w3Z6QAb0tLTnyZCL3WOz/bxflIbdF/FP6W9ljpD6OKRAdYQO
	 QlxvDyGNeHmCBlDAI2ryMpPc+p0gruG4pkcnnKH0bhY4UZRjhhW6/7R2O7vRahhfdz
	 s+56FSXXtlPYFyCdqVxwFayvOm1IYui4/2xg3Utgjh0nzostS/U1P3cDFeoKaqhqpW
	 W23aCts8evpXA==
Date: Fri, 16 Aug 2024 11:54:57 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 4/5] net: xilinx: axienet: Don't set
 IFF_PROMISC in ndev->flags
Message-ID: <20240816105457.GS632411@kernel.org>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
 <20240815193614.4120810-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815193614.4120810-5-sean.anderson@linux.dev>

On Thu, Aug 15, 2024 at 03:36:13PM -0400, Sean Anderson wrote:
> Contrary to the comment, we don't have to inform the net subsystem.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Split off from printing changes

Reviewed-by: Simon Horman <horms@kernel.org>


