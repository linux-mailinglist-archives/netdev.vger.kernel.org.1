Return-Path: <netdev+bounces-186177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D420CA9D5F4
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCAF3B40B2
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B355296146;
	Fri, 25 Apr 2025 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3olF4qb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEA221266
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621931; cv=none; b=tRp5uK4a4WsKotGsgxX5Rdq5u5SdwSZ8cBys9GAL2aYsz4We9xN6hosouxEU7Pr3ugKVkD0NOt6ztqme1OU+1YNuUr3sSvjipmuBo7jOxAwoEmPgHu+0blg5DR2tXG/zlyP/FvUaYBPm98W5+qFCfO7ndLg4svl2fKq97VT/Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621931; c=relaxed/simple;
	bh=C3GK3eA+zo+jNzYQ4U0hhAUFyre7u+hWL/LH2ctyYgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLnLZNC4R2TiXsrZypaIzcnLKnPi1Rjxkfz6ZD9toxO9QM2nYC1Qb07ObPDvhUtkTYbMSQX/ramVe2r0rZNKGHwHuvSCRHIM+wHJ5qKK76muIAlztaP5kqoLLdXG1i7ajUYq5mxwDrmcwtAyGYYtLIidUcZvXiFlvCtUEuATH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3olF4qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E429BC4CEE4;
	Fri, 25 Apr 2025 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621930;
	bh=C3GK3eA+zo+jNzYQ4U0hhAUFyre7u+hWL/LH2ctyYgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C3olF4qbAYSphNZAzP0/EU8cNJclNAzF4v2RVoIkIziU4XJHSIQ6hcSbjBxcI18/k
	 vhqi8Y1aJz8yv2ZrEET9txKX6EAnMgKRilKjRwwuVOi8V5+RVO9Met3B86KVFDKw1U
	 +lZgGY019tqno2XjWpe3067VR0mJoOtVc+IaXipKAYmNcAMdVjeblFmLjZCCNevXQD
	 TQo1RE9a2aLwvxrLZaFVmenI+KyHGVDVzERZ2h9sYpR+tPWJ1jm8hg8ZkjGYcA62KV
	 qBH/ZuXSOU76H56KPV4kD3XTmYJQ1VG0dXc6QxOuBOUudI/gkwAUZS0q/LlBFPIBhW
	 r8y5Euj7NA9zQ==
Date: Fri, 25 Apr 2025 15:58:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk,
 asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com,
 dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 08/22] eth: bnxt: support setting size of agg
 buffers via ethtool
Message-ID: <20250425155849.0e3a6109@kernel.org>
In-Reply-To: <CAHS8izMH55e9hD3dC7zy_eTVf+PRgOGunsuidtY+yW3-2jO-jw@mail.gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-9-kuba@kernel.org>
	<CAHS8izMH55e9hD3dC7zy_eTVf+PRgOGunsuidtY+yW3-2jO-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 14:00:01 -0700 Mina Almasry wrote:
> Where does the power of 2 limitation come from? bnxt itself? Or some mp issue?
> 
> dmabuf mp can do non-power of 2 rx_buf_len, I think. I haven't tested
> recently. It may be good to only validate here what bnxt can't do at
> all, and let a later check in the pp/mp let us know if the mp doesn't
> like the size.

I haven't actually tested anything else, but no real reason at this
point. I was wondering if it's worth trying to allow 64k - 1 since
that'd still fit on 16 bits. But left that for future work, cause
it will make all copy offsets funny-sized. We'd probably want something
like 64k - 4k ? Dunno, either way slightly unpleasant. There's probably
more that can be done from the NIC side.

