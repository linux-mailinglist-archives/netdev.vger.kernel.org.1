Return-Path: <netdev+bounces-215660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFAB2FD07
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028173A296B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88522EDD6F;
	Thu, 21 Aug 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4DNNvaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A42EDD71;
	Thu, 21 Aug 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786766; cv=none; b=A+fLgp1trCNQW2sHdYhX3UpC3ouy7uZRvDfvhthUyYu1KnanwrC2O1PNVI4LVftxA0KjRVN2t6ZuMk2AqCSdfbQ7704Xrl+tbBoXna2XQxBt9maX10J7eEXpIijCb1zuf/lM8W+8n1nzAcrX0d0U0cdTisCENO6tgYfMEJeEfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786766; c=relaxed/simple;
	bh=Xo1a4XU2LFDPYD8x3IfXLvba6QZUZ4f1jrg2g57aUCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlex9WoAB/Oi1jv1OzbBx6e+gWruSqKtkPQICuKvnK4ao/jKZK25eeM5SackPN24Bzg8/GIyKbT4a2ns1F9tWDfJTbk3gWISlfBic7syjzh5kDB6chsPs0NudduH0uMqWLi52Rnw1vd74cme8Oh1jNiCJIXJDFJawIIW0LfSZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4DNNvaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0366C4CEEB;
	Thu, 21 Aug 2025 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786766;
	bh=Xo1a4XU2LFDPYD8x3IfXLvba6QZUZ4f1jrg2g57aUCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4DNNvaYXcGM4p5MFinmZw1HXEDXxECTc3qZSERFN5F33hlxCxuUWl+h9JMex9s4W
	 lstk2E/hdj0HIORoRmW71FDC9XUdkT64dT+qvuSKZvjEcpNkIrdmXH5QA7GpT0famn
	 +1n2jYD8DJ92xhAYxDc+7pkqTPD6Cx3WMJc7XNwXS0U5RjS4X1A2YoKbR+b6lsZm5Z
	 AZ0xLmxd4jssAIDytA5cmhWn/M/wSYVM346M4n49vzetA4wGt//HbJKwf13ysVF7k3
	 a9rZcLwk/WJ99Axjaronu/A9b6XIxU5MPVS+MuikOQ6SKdy7H1jCU0EQanVnbydbAk
	 kqIx1Jgw+TvVA==
Date: Thu, 21 Aug 2025 07:32:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com,
 parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues
 with same DMA devices
Message-ID: <20250821073244.2b1bd1f6@kernel.org>
In-Reply-To: <73yte2bgpw4e6vdycrbgiyhujtl4z6h33e743vvo2rg3bioajb@u3ebcsmuench>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
	<20250820171214.3597901-9-dtatulea@nvidia.com>
	<20250820181609.616976d2@kernel.org>
	<73yte2bgpw4e6vdycrbgiyhujtl4z6h33e743vvo2rg3bioajb@u3ebcsmuench>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 11:10:57 +0000 Dragos Tatulea wrote:
> > I think we may want to bubble up the Multi-PF thing from the comment to
> > the user. This could be quite confusing to people. How about:
> > 
> > 	"DMA device mismatch between queue %u and %u (multi-PF device?)"  
> Sounds good. Do we still need the comment? A similar remark is done in
> the commit message as well.

I think the comment can go away with the better user-facing message.
The commit msg LGTM as is, doesn't count as extra LoC..

