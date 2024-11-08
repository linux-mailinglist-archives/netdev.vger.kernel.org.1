Return-Path: <netdev+bounces-143303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C89C1E2D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25E9289725
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22311E907A;
	Fri,  8 Nov 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRL9c8xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1F1EB9F5;
	Fri,  8 Nov 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072870; cv=none; b=pZgMPUfvXKWJkn1l0L94s8PLuVnFEdAq3JtWcRkB4xe4hUlA1zQ1l2X0HuiCkL2INsqUvz1gP5VuoNzcIW6GwYND+XtLpETP848bSax2EUGEtOOY3uXTOgzpLY61gC39unkyjCY7Ji6dyjb4JMgS2RYfji6ILBAe3Tn/vzs8EGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072870; c=relaxed/simple;
	bh=OkRh3lQ01rp+XrQxiTjUJ4feI+k1N+Wux0C2kgIhSOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbM02f5CYd/CmMmEk7TVWzqLT2YZBHHjqqgMnoqAePcmvlsl787gMomCCQ81hC+X/z647l/AvYeiemNzDIuoeFJOPZSJWN4RLsFnylRP358W3TqQ5ANtfNBKuks+P8ZDk4oAUutHBQbtCT/KtD+G7NmStqn1+spmkgBO+tJXVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRL9c8xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96AC4CECD;
	Fri,  8 Nov 2024 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731072870;
	bh=OkRh3lQ01rp+XrQxiTjUJ4feI+k1N+Wux0C2kgIhSOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRL9c8xdR2oOyeB7wpNaK7Y6NNDibQopvqE1CdvDsqPr0GZtZD8dM+7NBEe0dQFdx
	 uBJoQ6ftzFS7Mu/FuRj2zY9A0rouCd8tVl50c/UXZGRCMyzyt0aLBG5mRV1zqzudOq
	 gZYOPu5mq+vvTIIfbYnhoGwYRq5JN8BH23Nq6fiea//Oe/zPxOZ21EnBlVfGY93aRQ
	 dSGfiOhZE7qhOfa+Y1xFOJKWXroEwR15LUrhg4P8Ymh8WVadff7brOGfpfrZ05BpUU
	 uzC/H9QkghdJSl438D3L289Kp77c6BjmbBmvuX2CQSu7pDMiP504EwI6iKGatG8NdY
	 n80RsRB4afdPA==
Date: Fri, 8 Nov 2024 13:34:25 +0000
From: Simon Horman <horms@kernel.org>
To: Tuo Li <islituo@gmail.com>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	almasrymina@google.com, dtatulea@nvidia.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
Message-ID: <20241108133425.GC4507@kernel.org>
References: <20241030132352.154488-1-islituo@gmail.com>
 <20241104160713.GE2118587@kernel.org>
 <CADm8TemexVr3gcuhKJ9M4PLDg2bF85nhT17a8J1uf_qqj_fKiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADm8TemexVr3gcuhKJ9M4PLDg2bF85nhT17a8J1uf_qqj_fKiQ@mail.gmail.com>

On Tue, Nov 05, 2024 at 07:32:31AM +0800, Tuo Li wrote:
> Hi Simon,
> 
> Thanks for your reply! It is very helpful.
> Any further feedback will be appreciated.

Hi Tuo Li,

1. Please don't top-post on Linux mailing lists.
2. I think you need to do some careful analysis to understand
   if the condition you are concerned about can occur or not:
   can u_ctx ever be NULL in these code paths?

