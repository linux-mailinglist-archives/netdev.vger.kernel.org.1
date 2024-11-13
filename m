Return-Path: <netdev+bounces-144366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D79C6D42
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0882C1F246F2
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B941FE0F8;
	Wed, 13 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmIkJA9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89E17B4E1;
	Wed, 13 Nov 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495584; cv=none; b=RD9chz5BUvndSoxs+9chw7qezlQvHNUOJkbhYyuWFjWTamIwA+XFlWWX68+E8xLRGP5dKQq204gNrG2NOyNe28FO530BraLJwnc7mNT+KciXvhURALp/WPDfljZAXmrwu/SDUd+Yh2TEVRwQlyNhPUnQnZprMouAt0mFBL0lfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495584; c=relaxed/simple;
	bh=BKaUYDw/P1PGeiWYW7UZnkQeRpPmCuUSx5yNkIMEaYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8deTJT7i4zDK5a2rZL0N7Z5reV9eSkClIgQT2c01qJvspkUTiwtBGxBM1WhDYbeqMNYthvEg7W5Zl0/LjT+KF7+R5VZoagUiJPUYUN9YtguJjnWq7GFv2yBzDA1Akn9OLGH+FivxkJilPVS2062755akV5GRYrTujjcW1CR704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmIkJA9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892EDC4CECD;
	Wed, 13 Nov 2024 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731495583;
	bh=BKaUYDw/P1PGeiWYW7UZnkQeRpPmCuUSx5yNkIMEaYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmIkJA9NhjNyzCi38HO8YSVInKmoGfvESQWp6L+AHdUJ6yCPcI0/nZcBymm17FymQ
	 I//Pcl2+QzWDE8b/UxPdzS8b4o7zhQnuifUVus3SNwEHIGe7qOm3ZpF+y/ngbdBC0f
	 lU+8WYEx8bdRjjvd1i9dxASQnaUepWW8mkwJd0hQWjrPkbNxNtWf8ggf7P3sT5/kEs
	 gAjyGnQNfb3J019xWGXEmLM69bpMJfysMKQng7+guZ9jGb0lboPpy+RT9KeCY8zQUB
	 WgfZqkpmJoPNPZwcpDLm5BlEtowkaG5ukWKzFdsKTSbFE8Gab0kF4/UbbOUdMfZLNQ
	 oatoIyEm+4RoA==
Date: Wed, 13 Nov 2024 10:59:39 +0000
From: Simon Horman <horms@kernel.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32()
 returns an error
Message-ID: <20241113105939.GY4507@kernel.org>
References: <20241112233613.6444-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112233613.6444-1-everestkc@everestkc.com.np>

On Tue, Nov 12, 2024 at 04:36:06PM -0700, Everest K.C. wrote:
> Error handling is missing when call to nla_put_u32() fails.
> Handle the error when the call to nla_put_u32() returns an error.
> 
> The error was reported by Coverity Scan.
> Report:
> CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
> returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
> to err here, but that stored value is overwritten before it can be used
> 
> Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference, I think the appropriate target for this tree
is ipsec-next rather than next.

	Subject: [PATCH ipsec-next] xfrm: ...

...

