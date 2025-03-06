Return-Path: <netdev+bounces-172415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C58A54852
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804EC7A6061
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680A202984;
	Thu,  6 Mar 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZcjHyf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A953BE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258013; cv=none; b=FArTK0kjfVcr3hDSZ9s/PVv/sdx9eInbcTtR5XWJNY/PVtuhGs+DDjU9NAMkpA9y7Ur7Cb090sYLIqRQIoHg6OGdrsOtKj9F0Ztg19vJ025aGilaEc06u/n6nhFhLwm6lkJEEEsq+wPjil1pTxiwCMYwPYWppSgIxOOJtjwI/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258013; c=relaxed/simple;
	bh=lojiNXCclQcDM8RuW+yJvuFzUVUJspCuWIvSyWIclLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUkGsrzA+ltvWa36IF1xBCQBmqxUKA0DhMRQFamfqeqtkUbrP/0dVRj1LxFsgfnfE5yM2MqJwyFGkM6iFZ/PbpauYsqLaFvLQ4CvLTF+oTwr95yd2iPSFL0xAbe3wvCyRD+GUR2s1lIKSlXuO1bUA+5HiDGopC++uxhi3S9jYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZcjHyf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25DBC4CEE0;
	Thu,  6 Mar 2025 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258012;
	bh=lojiNXCclQcDM8RuW+yJvuFzUVUJspCuWIvSyWIclLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZcjHyf+wqG8t9vhRIu0UjF33cE9uvuIzAW2sTmbYy3CVOh0q17wiVnaHMtj462Nd
	 6UldRUZ+OG0GAQyvwxC0zAEyQ3aqQhpavLVEZ2YvsngJ+7pPRxUnoQyS8PBBaCmmco
	 hQlDAxOHP78w4bbJa4rXn1OWabqK4AqUin2j35RNZWDHWTsUqn68Ue7zAibPh5aY4V
	 PfWquf5gs+ijDMIATbkIvkGkNvfsN+je2GWpAq8YSQfAUxJ4lSYQcMywWyCiXPUhXr
	 x+j5uvJZUGLM/ry2o3/hiYKmQjz63RKDYxaReIBFp9cLcZyVkxqAXlDaM0wtwB4CqH
	 zMl5uFoJFe7uw==
Date: Thu, 6 Mar 2025 10:46:48 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: airoha: Move min/max packet len
 configuration in airoha_dev_open()
Message-ID: <20250306104648.GS3666230@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
 <20250304-airoha-eth-rx-sg-v1-1-283ebc61120e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-1-283ebc61120e@kernel.org>

On Tue, Mar 04, 2025 at 03:21:08PM +0100, Lorenzo Bianconi wrote:
> In order to align max allowed packet size to the configured mtu, move
> REG_GDM_LEN_CFG configuration in airoha_dev_open routine.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


