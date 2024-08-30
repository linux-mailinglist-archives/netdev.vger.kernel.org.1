Return-Path: <netdev+bounces-123570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9B965535
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E35B2269B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89787D07D;
	Fri, 30 Aug 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4aWE44S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543227473
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984452; cv=none; b=d/p8M0SPrKZaiUs9L07PgatNPPS4kzq5s7ER9OFx7uD5c43ODitXZ1mgv0FhteGISEaV47SW/2LddJUJgvisV4/sRpar2WoJvW2N81S8ARpBaILl3fMvb00WCbAqwlAQJCKJihp+kNkT8eiQGSjHsHiN5kzvZ6RN8m96Nq+ZfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984452; c=relaxed/simple;
	bh=vcA9w7mD0VA/8RRfwM5k2UiZ+Tm/MDdgeagvF6v8wCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsdUIV4kUHNiHTg9EpOkVzNvof9HDNx3bigW9LE88kLmxb6yq2zMPPPzz1mAnMko/FOGrX5DskRSMpuy85mJcnonX6HLK/xQ1V+qV2uUtDwMGy4HnOqRA5Jv0RIEooBBm6yXrxf92vHNoftJ3G2j9zzGgVXI9bM2ioIAkxb6+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4aWE44S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE12BC4CEC1;
	Fri, 30 Aug 2024 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724984452;
	bh=vcA9w7mD0VA/8RRfwM5k2UiZ+Tm/MDdgeagvF6v8wCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C4aWE44StZHjia6jXa84DUgZkRV1Qfmk1fOcN1D6YNZHAj9UaiAtZ8OBBuGmrjSqY
	 IzCQiPaWaoVndm/x6Gh0XTqaspNwgete59Hn05SxbIdsIBhcqHiyYKGqr+UtLoJwQR
	 S/WupaivK263PFTdoZYsrKUs2OH63JhW6t1T6ikigTZ9dPTBn4irFNU85Ps62hA1Mo
	 czoH/367g7zqbcjc/sEapYO8uiLmVITH+8BfeAX7T4rIRB34XrzOpPo7/23RuGXeaN
	 lj2YsSx3goPWBLsejad349gCx+oyES9E/x0UkLTqJOfuHUtOgPYk0s75AYWp1lBcPt
	 fZOykfFMO/QbQ==
Date: Thu, 29 Aug 2024 19:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <20240829192050.1d1d2dfd@kernel.org>
In-Reply-To: <ZtECRERXK7lZmbw6@x130>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
	<20240815054656.2210494-4-tariqt@nvidia.com>
	<20240815134425.GD632411@kernel.org>
	<0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>
	<20240827150130.GM1368797@kernel.org>
	<20240827152041.GN1368797@kernel.org>
	<ZtECRERXK7lZmbw6@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 16:20:36 -0700 Saeed Mahameed wrote:
> >as both counter->id and last_bulk_id are unsigned I agree with your
> >analysis above, and that this is a false positive.
> >
> >I don't think any further action is required at this time.
> >Sorry for the noise.
> >  
> Jakub, can you please apply this one ? 

It's too old, repost it, please.

