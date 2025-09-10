Return-Path: <netdev+bounces-221809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9791B51EA0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9BA1C87831
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD226B777;
	Wed, 10 Sep 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX9qxNEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C71199BC
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524152; cv=none; b=GmhT/vOSd4skKEytLKTl9IBG6dT2stabjWU1wdNlGJ19pRGszpvCNjqk3fSaN34mPTnPVgKa0+JmZ3+FIklAKgZEDwWK+XWwi8lmyrAP2Lz/okrJVu2H3KamKBiz1ewzN0dHeUO6kyHhEPZzSCWJ6mqs7pYNxv+k/hVinvc+AmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524152; c=relaxed/simple;
	bh=30ZxbiBnNIhA5EUXwOXCpynbzWvSWkG25+oay4O3pxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3MsPeI4YlQBq0J2ddaN2RcRaliEck0B1Ln/5OyKp0nGpYzPxEYr9oYRN9RIVD7X2z97FCIFPCR+dLMKstcJXeuaw72GCTE9DSijVRr5qiCUM/oJPItC1dMDKFvYu2WBOhGTFJKyf+p6Vs7DEFNsYO6XC3jpHgKkrptlOSZMlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX9qxNEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF90DC4CEEB;
	Wed, 10 Sep 2025 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524151;
	bh=30ZxbiBnNIhA5EUXwOXCpynbzWvSWkG25+oay4O3pxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FX9qxNEiurgj1LuPLB2hLMX6IX50R9KNa8g2JCD3kImCQb5+6SKsRG7gfFQiBai8y
	 u/J7kPrcuLKqFGRRIrZXov1mzjS1mRMLo7xg12crNGWEqKO4HW3Ash/Cgtx3k6/KVa
	 wfPJNjOxI3HlMrJfUDUgnsoKF384iPPP+nlH7c8m//YZAgV+18hJm0BYeCYvuuU/a2
	 T6nm7RePqjUiWUINk+LuxFcCbDOKXYhQSSgr5pqx7tgXE+a3ExFaEkfbfMZKcCn4yd
	 yuTmM0N0+QMOh+Cdpn0Y+vzW08JitTYtDuX6kEHmYkR9A8JRpk26mvDVQAWfZIQfLY
	 C6q9TBz0A8SIw==
Date: Wed, 10 Sep 2025 18:09:06 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCHv3 net 3/3] hsr: hold rcu and dev lock for
 hsr_get_port_ndev
Message-ID: <20250910170906.GD30363@horms.kernel.org>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
 <20250905091533.377443-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091533.377443-4-liuhangbin@gmail.com>

On Fri, Sep 05, 2025 at 09:15:33AM +0000, Hangbin Liu wrote:
> hsr_get_port_ndev calls hsr_for_each_port, which need to hold rcu lock.
> On the other hand, before return the port device, we need to hold the
> device reference to avoid UaF in the caller function.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: 9c10dd8eed74 ("net: hsr: Create and export hsr_get_port_ndev()")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks.

I agree with your analysis.
And I see that this addresses Paolo's review over v2.

Reviewed-by: Simon Horman <horms@kernel.org>

