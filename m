Return-Path: <netdev+bounces-206746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35996B04414
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B383AC4F5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9425F97D;
	Mon, 14 Jul 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJXmeLtT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3425E824;
	Mon, 14 Jul 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506825; cv=none; b=usjMHs5lwHOVD+8s89jT6VQr9tkHCXb2KEsI8+80TYYC5NsRynm00OG/uwMLjhFxwa4INxJuGY9/PHgFQZEBtSHxqssr1pKLmt1wXtH6Bq2ztN7NzDRkvmb5jCZluewshRHYHZ9FbF2WZ2i8pYET8wv9oKyPwLmk+MVRAdoY+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506825; c=relaxed/simple;
	bh=CPLE1p+qZm9bk1t2sLfSrZ2YNotCwR4UDxuJhB4GjzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfQbILXn3aVIW3vnghe5RTIR0573/F58/TyrBD9x9zSQSsE7oN/Gp6rmI0Fx1pgLC67h2ZTdX/L5FwMHZUHlk3SD3qQZatNzwIhnXxPTsCn/H8XyUeRUXUAlun2hEIgFYV2AEC6kndDK9yivrxt2z32oozbS/Bio4zfGDO6OmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJXmeLtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D079BC4CEF0;
	Mon, 14 Jul 2025 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506825;
	bh=CPLE1p+qZm9bk1t2sLfSrZ2YNotCwR4UDxuJhB4GjzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJXmeLtTjA5wBa0009sVY3hhufOHNvRzLUk5K4DnMoEkjd7+kOSgiWfQBH+7IekPR
	 ePTnmD8RiIjAuYzFDzyadYZy8PpWE6QL/ZsLqah2iZ1Ndn0lIV6CkuGUjkN2EyTNFm
	 f2vcw1M60E4CYLSOecKg6SisTagZe7qgS7zigDG6m4SRAR5i0hq9TnPm9qLCmzf+Ha
	 SrcPM4GGLLPYUrLDW0YwjSuWqToOXrlIvISY80c+uSfHDc63Uze+VX6ekFqmyRQrtk
	 T1BZh+dRh1Cvd3ZvqMjvu0O8bdvU8IuGLdw+Ex02itt1KEjAGnK5U0AGX/5vzJPGS0
	 iQ8M3lKWpurlg==
Date: Mon, 14 Jul 2025 16:27:01 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: mcast: Simplify mld_clear_{report|query}()
Message-ID: <20250714152701.GO721198@horms.kernel.org>
References: <20250714140127.3300393-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714140127.3300393-1-yuehaibing@huawei.com>

On Mon, Jul 14, 2025 at 10:01:27PM +0800, Yue Haibing wrote:
> Use __skb_queue_purge() instead of re-implementing it.

Hi,

I think some mention of the changed drop reason is
warranted here.

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

...

