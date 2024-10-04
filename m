Return-Path: <netdev+bounces-132157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A79990991
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415501F21413
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20E1CACD9;
	Fri,  4 Oct 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfvSajmq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AE1E3798;
	Fri,  4 Oct 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060196; cv=none; b=jtZX0u8mty7aE2cWI7MwsITpnui7YYJNJwn8KI+TUzno8r+dBXfNBN8vR9T9a84YVuNUOINRlgTcwNKoJ8yWzuJxK5Fkg07DdTR1Ur3ENk74r7m+XVRUGLZgBvQbpBxjUAMUYN13AqH7mCwIyp9anZ5xIBNNfZKYTQ6Ds6dJqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060196; c=relaxed/simple;
	bh=bslI7aYrHHJa8ElMwroQ8QfyHxy5X8O4+eVvZQS74F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feGOog5sEIBRsMvTz12RPbd4+cRim54oTSGxF0Zg22fWKyCBT6ytoeQabiyp9qtKZpchucUvdFE1c5/PzB9biS4XfCErrbSS7Nc92NNjpY0/WZ5Xz4Tqngmo9LVBgZZnzIBHCzN8VQOkyUNPAUVzvnRjFgNk/HONdgUzhY2F8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfvSajmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B76C4CEC6;
	Fri,  4 Oct 2024 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060195;
	bh=bslI7aYrHHJa8ElMwroQ8QfyHxy5X8O4+eVvZQS74F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CfvSajmqeTSFIiSU0753vgdvAgQKAsaJHk/CQx8jpEcYqR1mxR5xk03D+Qy/S3CLK
	 6ynJ5j7OUiEo17Ilthyg//noj8Za4wskJb/ojjoADmwDFzAWO7EWut21qaiJgG3bk+
	 9o7lLhZeS9/F20sINYztLr1tz1hTofGV3OJyuQnc58zif89rVqyxAh5y5w9Fo5sop5
	 4gPI/3r3tyxv9W6BwCw05PiI+B3KhRvRzfnJ526d3cVId3GdDZhFtQcb6oKbpLy+t2
	 0MvATDgxvvWq1x5OXMtHS7qDahWQmE4BAJOh77Q5i2LW50urOkos/nzqskw46rFBLP
	 zDx1I6+feeu1g==
Date: Fri, 4 Oct 2024 09:43:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
 gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
 razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/12] net: tunnel: add
 skb_vlan_inet_prepare_reason() helper
Message-ID: <20241004094314.735bb69c@kernel.org>
In-Reply-To: <20241001073225.807419-4-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
	<20241001073225.807419-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 15:32:16 +0800 Menglong Dong wrote:
> -static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> -					 bool inner_proto_inherit)
> +static inline enum skb_drop_reason
> +skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inherit)

this only has 5 callers, please convert them to expect a drop
reason to be returned instead of adding a compatibility wrapper
-- 
pw-bot: cr

