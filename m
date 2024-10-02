Return-Path: <netdev+bounces-131231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814B98D665
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC44B22177
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023801D07A2;
	Wed,  2 Oct 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhJXxZn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4071D0786;
	Wed,  2 Oct 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876338; cv=none; b=haW3O+0p9ILvSItFmDreMr5i83zI1/S9eeWBBIccQl0WrCnc9ETzTTmegK3qNE0PGzzEYy3kzgNsmPOOoq11l5OKWM2ObNHGQSOSy9mkx4CpsUOu1OA/jMUXKy0l3jZ0wFyPg61V+FQCZw7z9+kyK4YqX19mVfi7z8pnWczJzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876338; c=relaxed/simple;
	bh=aO3YejTwGuOW+jjXmNHB32USpFmDnr7m5k5efM4WnLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBp0eKceYFeaE/i5uTqW8dJJErAtPmIqw5hbBGqoUNKXE4yJLlQFob7axhook5VjB+sU4YVSQEk8oo0du+38LLhuEAzSX2bvScpsE3/cYShGYoofvsMSZfg8yqs/npDJnas/xUFQnRKtyR6iZMGpSopZPFp+aL3qzipDmSVtQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhJXxZn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740C7C4CEC5;
	Wed,  2 Oct 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876338;
	bh=aO3YejTwGuOW+jjXmNHB32USpFmDnr7m5k5efM4WnLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhJXxZn9VKGMC4MSRoDl2ZCuQI0rvB7mbIuoyc0LwCPSeAlueHywef+rMHPzfztrR
	 NRXU/g4JIhlh1KUNuWRQ1FWvYJqzMaHCJ0NG17lJVjQog/cppbZfXXpdX6VlMOkMrE
	 NvOGpGsbs+p5tLPF86sVGrkP6Q4pBr63w1kgUGwiASFHnGblcnlMc+M7DwDG6KtAyq
	 VN8IjxQRQSfIDKJUg3XNYqV18IKrulHaX9SmwfO6iZFHDTwEqW/rM98Usl5HuRGDos
	 9UYa2LBrg6qvSuIg6XjMUxiyPeTdG7Tb686o/aOPDQzaji48ClRCJar9aHQe+56ffP
	 jaf5Y7ekfOltQ==
Date: Wed, 2 Oct 2024 14:38:53 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/12] net: vxlan: add drop reasons support
 to vxlan_xmit_one()
Message-ID: <20241002133853.GE1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-10-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-10-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:22PM +0800, Menglong Dong wrote:
> Replace kfree_skb/dev_kfree_skb with kfree_skb_reason in vxlan_xmit_one.
> No drop reasons are introduced in this commit.
> 
> The only concern of mine is replacing dev_kfree_skb with
> kfree_skb_reason. The dev_kfree_skb is equal to consume_skb, and I'm not
> sure if we can change it to kfree_skb here. In my option, the skb is
> "dropped" here, isn't it?
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


