Return-Path: <netdev+bounces-186601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD2A9FDA4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5371A833AF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066720299E;
	Mon, 28 Apr 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POPMb9c5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98F211C
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882253; cv=none; b=K2F6n57SwRk2zAWSdjC3+H54soeyA0XxXfPgwT/Fw3cmFxuG1KDM7umLdcCqeBPYRHcdKt2QEREivpSArSzn71OiQ7G65aFXj0pvV7oBKeUq0inb3gwZlgHvcOd4k0d83ODltflC6KOqUsUhmzBaMHlARjhpS8gZDnBS5wAIito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882253; c=relaxed/simple;
	bh=SZONdNJsAKZ2T1W92f5nkBx4wfZSpDttLLNQbUltWiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxrpgyghVl6c+KB7+o9XYgjWLWlq3DZpJdGYy8k2g0/3H4aaTQ+7Fw14E9WCCFclWTpdprCv2BK70ct6OBYKBFvHuSEyBlvNMFBx2fVkxq7uyEnaxrHxy6yHNEs7VgOIcCR/5TzauPPT4075RNb+hCuycXiDChWXtvvhwi5Xc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POPMb9c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3179C4CEE4;
	Mon, 28 Apr 2025 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745882253;
	bh=SZONdNJsAKZ2T1W92f5nkBx4wfZSpDttLLNQbUltWiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=POPMb9c5IKhRbPYgXmuTCSCuBFgxwG2c1OvDerVV5UNqlr6xzmd6FTrq9qI1bg7n4
	 i2Ve5PMFHB4PGex+/rEVu63JTZ4BeDBGk8LHUVq4rhkdBPZTy0lSZ9g36mfO+BmPXh
	 Qc3+hFyL/oWDIZtABFOMoIGHHTZbl/+JwVjj0rlAU+AwppWn7A7n8LcVy57VcUrv6P
	 1uF8PObn+BBYOHh/K15KcKnoJqO+LyRZAiVLvdFkwoK3hPPcoXchDZQhPTshVdH3xo
	 BJ9vbv1fQJRBuX2q9fo8F8+5+zn5SYjJWgJxbfHxOziKA7eGlN7PS2fcjGit7Qdn1c
	 oEcv1v7fzDjtg==
Date: Mon, 28 Apr 2025 16:17:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param
 multi attribute nested data values
Message-ID: <20250428161732.43472b2a@kernel.org>
In-Reply-To: <20250425214808.507732-15-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
	<20250425214808.507732-15-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:48:07 -0700 Saeed Mahameed wrote:
> +	case DEVLINK_PARAM_TYPE_ARR_U32:
> +		len = 0;
> +		nla_for_each_attr_type(param_data,
> +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
> +				       genlmsg_data(info->genlhdr),
> +				       genlmsg_len(info->genlhdr), rem) {
> +			if (nla_len(param_data) != sizeof(u32)) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Array element size must be 4 bytes");
> +				return -EINVAL;
> +			}
> +			if (++len > __DEVLINK_PARAM_MAX_ARRAY_SIZE) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Array size exceeds maximum");
> +				return -EINVAL;
> +			}
> +		}
> +		if (len)
> +			return 0;
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Value array must have at least one entry");
> +		break;

I'd really rather not build any more complexity into this funny
indirect attribute construct. Do you have many more arrays to expose?

