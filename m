Return-Path: <netdev+bounces-75553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B886A73C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B08288012
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA705200A8;
	Wed, 28 Feb 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrXMh4s3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70045250
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091357; cv=none; b=T2I7yYK55GThGICXR/cIBNvfyTGUyYySJJY3BhRIYniURgigttMVR+kctBZnwm9aTgNmQJhGJdQguJMLiNh+CmV7dR54z/NU93fdFl+XqEs9s9MaYTM5bb1qkBHT0hVbbmUxw15Puadzsw8vxqy3Z9zjjm8Azq/1Pi8G56hygcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091357; c=relaxed/simple;
	bh=uj/dl5Uei2o+FljlGGM5Y6RY/j+vH0dGAC1pvuMhIBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfKQBPFpbA5lDirYRPWXne9OHT9aCbiF/uNFbJYDqxFHh3UGkWkCgOx2CiEnH5aUrBdKW6q3xINERTozSm0+WLY7tKoJ02MbPsVyL4+DSW1ILQEyQTfEpfq9SMLBAYtrN260AumdvAn2ZrrHub0uhT81WGU7PET7mVAtYCURRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrXMh4s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC5C433C7;
	Wed, 28 Feb 2024 03:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709091357;
	bh=uj/dl5Uei2o+FljlGGM5Y6RY/j+vH0dGAC1pvuMhIBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TrXMh4s3PeOeMiIHrX6sLbZd00s4umYJ/p0ELRtkXcsSIzwwSszXpDEupYH0Obuxp
	 1hRZlEpAMCPvU0Fmc1ZGsNeyDZFDbv5pWq19tGpGZ15oIfWqG7KiZ3bPc7uLVQidta
	 BvhLflZFQAJwtFvrNvTHf+N5zN7DJOKq+SbntQFrC2XkJLyfvNl4Puolc5SHpD37uQ
	 BcGBlLuyyNPY1FelvI9nQqa5jwxvCdndA08PM2Ba9SKSzerU/lV3aL6dSbCGxIV3W5
	 a2v4AGz+JDmLNEwd2tfitaRqBoxbFVU+kPF26sFmL2XK2txGegRKArTXY73PsLf/8G
	 5sFKPNAq9G/Yg==
Date: Tue, 27 Feb 2024 19:35:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 4/7] net: nexthop: Expose nexthop group stats
 to user space
Message-ID: <20240227193555.39e56436@kernel.org>
In-Reply-To: <b194971db40744eb8aa6e1e562564cac7118c42f.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
	<b194971db40744eb8aa6e1e562564cac7118c42f.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 19:17:29 +0100 Petr Machata wrote:
> +	NHA_GROUP_STATS_ENTRY_PAD = NHA_GROUP_STATS_ENTRY_UNSPEC,
> +
> +	/* u32; nexthop id of the nexthop group entry */
> +	NHA_GROUP_STATS_ENTRY_ID,
> +
> +	/* u64; number of packets forwarded via the nexthop group entry */
> +	NHA_GROUP_STATS_ENTRY_PACKETS,

auto-int, please - nla_put_uint() etc.
No need for the padding or guessing how big the value needs to be.

