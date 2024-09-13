Return-Path: <netdev+bounces-128084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE123977E78
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ACA1C20FC4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685441D86D8;
	Fri, 13 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVLXGJdY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447887DA9C
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226925; cv=none; b=NN328G0FjSy1XAmS3P05EvHsiV22UFuQGVgUr8UyljDm+r7s2tgkkzDcE11Ke7b96yoKi6CgLEl9LJJGEGGUFZOMKwR+knj8MvKuhnoK8FT1UWMPGyNygGIaxHZp3r1u6d3Dk0xsw8aimwubpJ1fxrsVeCbYJdZkYbkVLkTiJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226925; c=relaxed/simple;
	bh=1eI8o7ZIACUVk4LdgzVshUMF3MuVJX7Q2D34HBA21kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvtSe7Acn4A4Yi/jYTH0EiHT5o4HAdjPV3z/cHb2hQ75B32JpZg+PTuGAqLnGHTKwQECHDo0yRmsO2GV30YekA4ZRe7HVlSg+UQqeseJdCDIubP7JdWAVATPjRTy8Llk9TfA7sICY2TUTH0NgsvlBFWkPpRfsMjyIJegNbtG2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVLXGJdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F80C4CEC0;
	Fri, 13 Sep 2024 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726226924;
	bh=1eI8o7ZIACUVk4LdgzVshUMF3MuVJX7Q2D34HBA21kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVLXGJdYwhxTPxPiOl6x3QJHCznAOWtu91SeDQyTpoMTAzdJXKJfeO4bf1CC9EVLg
	 2G5chnsM5Qzj2gru2YmxbVcQybvzwzn5bzUaiIzPvcivgLT5UUf+Cydgkqb3wUqh3W
	 vkEozPYBXWOdpqBM8ld4c+e2FSmxGMHZGCCWJSuAhJ4W7hFAwB2KJEEMXoiyKDxOLx
	 wVoy5ROHMePHVmXf0th8zCnxU3s5/TWC4Q6ve9DOPFrWnUMx3SLWtmvUj5WRPlTIIu
	 pqI6FpNaicLljg6SJWO/u4XeBLhWK3GXaJ+4q6ayG22ov0dddz4RU3rDM5Gc2C68ul
	 UZPkbS0L0S0oA==
Date: Fri, 13 Sep 2024 12:28:40 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
	Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH net] ipv6: avoid possible NULL deref in
 rt6_uncached_list_flush_dev()
Message-ID: <20240913112840.GW572255@kernel.org>
References: <20240913083147.3095442-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913083147.3095442-1-edumazet@google.com>

On Fri, Sep 13, 2024 at 08:31:47AM +0000, Eric Dumazet wrote:
> Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
> as spotted by syzbot:

...

> Fixes: e332bc67cf5e ("ipv6: Don't call with rt6_uncached_list_flush_dev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Martin KaFai Lau <kafai@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


