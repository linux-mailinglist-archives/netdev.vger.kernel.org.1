Return-Path: <netdev+bounces-127790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59B9767D9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91F428592A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02281A4E67;
	Thu, 12 Sep 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Uz8dRX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A319F413;
	Thu, 12 Sep 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140190; cv=none; b=k86QLLxR8DRmrdi9X/h4ICKyl6MGXtT+6ykEpIuGgaD+Gwg0suv/nB2byNQ1bUGmvv7VL4Z+JQzc3akaWmahw60dOMGjjyZGbcsKf/xpFNZuShofKO12Yzg+wiqRAV7+Y5ISyo+2XdDk1+DsiiDyMV1Sr/QOgHqaczjvc4K7o2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140190; c=relaxed/simple;
	bh=33KehDS2Zh2JpRsyuh9H8ALYXCPuFVSL2YvbS3cyYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbCvbJigNnUD9BB7I4wQQd7GXiWHSVANpiNxyy0lT8G2p+m8UVZzjJVkHUm0MzrWFF/3MGBuBCFzwceXVb+Lldp0l9u4DnFtKGVwnSwdLCTjtiuakUh+A/aPQj0c2mriADaycptHE3YHgTAFO0QjWlILcbAb9tLuK8zXEDYLbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Uz8dRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3033DC4CEC4;
	Thu, 12 Sep 2024 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726140190;
	bh=33KehDS2Zh2JpRsyuh9H8ALYXCPuFVSL2YvbS3cyYWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9Uz8dRXuyoGD/QXOlGC0Bxx3xcYdStYD+JkCNOVbYzSGNJh7Xvis3YN0KlRYa47m
	 mOXOieyItzt71M0J9GVeKDSibGTSSDt77GWo4V1GIrIh5UufNE4O/p3MxLzsSUHBfL
	 91J1ezMkSURtdO3MOlBKlxWmQFTlxt2qyVT35Kc9qiC0qaDJOPOLJu5EK3OTmMUgeq
	 4qEsI3N/TpCnkw9hJuBYmTjHqNQSy77HXn3nvAC7YCSYaWfJON59eD8Cq9uD5PKMPz
	 tB4dLoYE0QI+uH47pZs40Kd9ZtZvCaO5W4LW5LAsphvlaXtOORU3WRwwiWbdPScZm1
	 bwybqpjbBudVQ==
Date: Thu, 12 Sep 2024 12:23:05 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Justin Lai <justinlai0215@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] rtase: Fix error code in rtase_init_board()
Message-ID: <20240912112305.GJ572255@kernel.org>
References: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>

On Thu, Sep 12, 2024 at 11:57:06AM +0300, Dan Carpenter wrote:
> Return an error if dma_set_mask_and_coherent() fails.  Don't return
> success.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


