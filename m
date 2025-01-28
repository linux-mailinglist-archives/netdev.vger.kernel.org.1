Return-Path: <netdev+bounces-161421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5993A21424
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23153164182
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C051ACEBF;
	Tue, 28 Jan 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p38sq237"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D519CC28;
	Tue, 28 Jan 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103252; cv=none; b=YcqdqJJOFW2k9/YhHGG8NaE5bTROe4Y5lqgFN9Of6UXowyKQcYK3gT4MRBbMdT9dH1R5lkBAFhXauFU44yeiwXZ10OvuiQdoh0frTzU1gac3tdJR4HXOHooMJowviOxcPt1vaGiCK0/SY2t/5Aylc0JPnj6g7q8vuT1sWarRxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103252; c=relaxed/simple;
	bh=+sCER/TvfbFT8BvofkZPUfcwnYmE1UU8CTEHTAioC8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzXDaTJuVXwSfLxwfdyi2e44fU9L+RLYFiBfhVVxkepmsY8M05NJxH11pejBHkJ7luEqWPiXI9jjLBNPpOWLoam6yffVhC+DxYT/1oZm06Ca5VLst9DyeElPTNEgFv4w5cDVIlvl0EmpyFPAHZt0M/fAP40p1dTJJffLxNriVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p38sq237; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3633CC4CED3;
	Tue, 28 Jan 2025 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738103251;
	bh=+sCER/TvfbFT8BvofkZPUfcwnYmE1UU8CTEHTAioC8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p38sq237eT3LqbbHAZsmFb2hKLWTxJAWjwiMEQAYPM1un+pM1hrqryHm/qMEYN0o8
	 znzZjmhptq6Cu2k3iaqemU1898+eFhAqPfhbG9MdFSnaFpepSUowIJnNBNKFaenDNZ
	 7mPSKmcVrUOkYfOpnb5f4jGXN/vkT+IUctDXJwpIZg5KHV3f+550+ma5cO9DyX1OEU
	 eQ1KNQSajrj+2vQyPI3/4h6tcgzzAYoj4u4Zp0Im6RbE/dlUFpmaQ/TbL9UbB3cXuQ
	 njBFSApfsihwbiuf5mV5EatCqTd9iapqL8yXW9Nh4J634oGcEzxElGDEx/EbQh9lwr
	 vCwM0Qd/N/R6Q==
Date: Tue, 28 Jan 2025 14:27:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net-next] netdev-genl: Elide napi_id for TX-only NAPIs
Message-ID: <20250128142730.39be476b@kernel.org>
In-Reply-To: <20250128163038.429864-1-jdamato@fastly.com>
References: <20250128163038.429864-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:30:37 +0000 Joe Damato wrote:
> -		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     txq->napi->napi_id))
> +		if (!txq->napi)
>  			goto nla_put_failure;

Skip the attr but no need to fail. We're reporting info about a queue
here, the queue still exists, even if we can't report a valid NAPI ID.

> +		if (txq->napi->napi_id >= MIN_NAPI_ID)
> +			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> +					txq->napi->napi_id))
> +				goto nla_put_failure;

Similar treatment should be applied to the Rx queues, I reckon.

