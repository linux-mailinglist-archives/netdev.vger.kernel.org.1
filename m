Return-Path: <netdev+bounces-153212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D589F7325
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DBE16B7E0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2A50285;
	Thu, 19 Dec 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0r8TAp/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25584C6C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577510; cv=none; b=gDzCfhJPoDGxiykeEoIQj2FK8Aj3cVSN/QlcaGlkvIF7T2M0EnUwa1I1ETwHDn4ZeMENlHlL0ByLR0YNc8hbbP0ajqXbYH/KIsmjx0M+VKIPX8MhQju8xP1AiOmuIPYOP24RCTZ8UbqN1gMVaQ15sfZx/PgzP8SccXEJL77jEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577510; c=relaxed/simple;
	bh=m3JoGt1l4F1+H3VEd5laWgM3Wo07t9bbtutn2FCKQe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9mEz3pLr2CuWed+E6iJGjQNRnxft4CbHlMybGjwkwz1A4AH+Te0ntfji9lz7EQVHUCdps+XwlbPa9WDl87BDs5mSHZIgMurLeVlPPDE1AmjZrRdlxBOo8FCKYagK7I4whiwH4sSZ3SJtj+FQ5eaUmmoQqiITWR9DSOUBNkOhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0r8TAp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85F5C4CECD;
	Thu, 19 Dec 2024 03:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734577510;
	bh=m3JoGt1l4F1+H3VEd5laWgM3Wo07t9bbtutn2FCKQe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0r8TAp/WnL+FqIzY3HgRWsBGTvJ7gJBPhNmPn9m4dxWI44UR1ZpATi0j3rtXO6MG
	 MuHiv/MdOh75fvKF++JoVU99aXU28xLv4+Zi3jg4hnH7TldRUGFMUUfNDQHw/ql/Bh
	 M7I9X95RhLppvO2YYihflvTuXhQWfkfhBu3skSY+Ncm/wU9t4UmT1F9QFmVSJaOPA/
	 fPE3Y3aat1UMbtxpaKHU9J+A76FVcQfOxvHTvaXgROM+FKAmPwIo1JeO05MZqfPMt3
	 Qa1To7ZRkeIZjsiBHwQrN+9LKQ90zXQnx5RZhTn7BTaQ6osU/tfCoC7o+MUqHTPkRf
	 zqyRbXbDqvMwA==
Date: Wed, 18 Dec 2024 19:05:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
 <horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Message-ID: <20241218190509.5aba9223@kernel.org>
In-Reply-To: <20241216171201.274644-4-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
	<20241216171201.274644-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 19:11:55 +0200 Ido Schimmel wrote:
> +	if (flowlabel_mask & ~IPV6_FLOWLABEL_MASK) {
> +		NL_SET_ERR_MSG_ATTR(extack, tb[FRA_FLOWLABEL_MASK],
> +				    "Invalid flow label mask");
> +		return -EINVAL;
> +	}

Have you considered NLA_POLICY_MASK() ?
Technically it does support be32, but we'd need to bswap ~IPV6_FLOWLABEL_MASK
and you need the helper anyway... so up to you.

> +	if (flowlabel & ~flowlabel_mask) {
> +		NL_SET_ERR_MSG(extack, "Flow label and mask do not match");
> +		return -EINVAL;
> +	}

