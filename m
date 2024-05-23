Return-Path: <netdev+bounces-97739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9C8CCF92
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5211F238E9
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285E13CABD;
	Thu, 23 May 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj5YYoNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99C13A88D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457542; cv=none; b=SdFCqNtldNk/BdLkSsaBCCJkt2Y52EtA0H9rSELnn4/3VVuQNq2V8pm73+H+dsa03TCEJw9rRZ5LChF+0hZJ32R6J1QAtVQx1Qwp6YKoG+lhRUIUzSDXSfoz9PBvzQZh5un+jNzfH/oInjHmC4TtHZyLvCGIzR7y79lhsfN7ETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457542; c=relaxed/simple;
	bh=5PWGW3dJyxmDAwUvEuQ7h0de7CJLMQ6mHYFLuQ2DcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hda30Q18wHKNYlDd320+wa8+AyBuzyRDDkeLGq9AzUo/h4PrF5EP8LFCQgaE+r8dB+3IRzzH6ajhSRDRB8dGbENyBBrgiPiR+xjz15HXK5UhFgNwdB3QEcnLGnT3h9qdAVbooRuCgghQkWvvSIXe04K9+H7Em+ndUSVWYvmKUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj5YYoNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A388FC2BD10;
	Thu, 23 May 2024 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457540;
	bh=5PWGW3dJyxmDAwUvEuQ7h0de7CJLMQ6mHYFLuQ2DcG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lj5YYoNm+SaHSCv8AaF7Vv8mWMABQLnfoBx/6KvU2oB6FK3yHj2piWYuA9KI5Yi/g
	 W/CITVPtCas71ThEaxZjkbJtj7BRZUH3AkFV2DZ6Q2h1XYEP4FykmUcq09PtaNSsn0
	 z3vWby2bVFDqyvdkStjO+F8gy/NHuWJROqdMbf566eMHKdF6mzY9X6MeciO3SJeMH4
	 QesFxeWHjFkAMNaRmEAHeydLTv/eQQuNk2OwkZ0rw1iVQYA6Scnc3jonIBb6dfcWSB
	 D1K0PpunVwOrRVI9aU0FtqLyCzokqTabBevGxMKjkf3RHZpTHcrZ7hBD/2YdmtDdiC
	 YoZrZ7I/VPJ5Q==
Date: Thu, 23 May 2024 10:45:36 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH net 1/8] net/mlx5: Lag, do bond only if slaves agree on
 roce state
Message-ID: <20240523094536.GD883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522192659.840796-2-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:52PM +0300, Tariq Toukan wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, the driver does not enforce that lag bond slaves must have
> matching roce capabilities. Yet, in mlx5_do_bond(), the driver attempts
> to enable roce on all vports of the bond slaves, causing the following
> syndrome when one slave has no roce fw support:
> 
> mlx5_cmd_out_err:809:(pid 25427): MODIFY_NIC_VPORT_CONTEXT(0×755) op_mod(0×0)
> failed, status bad parameter(0×3), syndrome (0xc1f678), err(-22)
> 
> Thus, create HW lag only if bond's slaves agree on roce state,
> either all slaves have roce support resulting in a roce lag bond,
> or none do, resulting in a raw eth bond.
> 
> Fixes: 7907f23adc18 ("net/mlx5: Implement RoCE LAG feature")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


