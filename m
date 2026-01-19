Return-Path: <netdev+bounces-251186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D1D3B384
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45E631C2B44
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796503A4AC1;
	Mon, 19 Jan 2026 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhSOWhjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560173A4AB1;
	Mon, 19 Jan 2026 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840992; cv=none; b=KNYhpJN680g3u1mWjF9Rj7NITRAu37gJyYLAlgQhx1Uj/BvbZinbVAYq1scv00ltiJdsJ+aSgCz99uMX+ApbjJIGc7RPhHGx7Fmx2czOAa5EQA5fpq7UCSzwLj+RpNJSr+JvXIbpDRFnR4+wKRKeZ3PrqnDzrLkbmCOIQA4zF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840992; c=relaxed/simple;
	bh=IK4CqLAWsW4bKD4kWvQrYAnn/9aOTvD56ZKLXcmtBAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td716tIzTzZH5Vzuq2fkqonw9iRhP5kgJknFUzoBpsblREmbn7cpCfs2d8Vlp7zMOof1k9a4xjNdMOylcgBlkPBVWQuoWp4Rtew1DKgPFW4p6kRw/4bbyvmWoWeKgboxHLegEMVPV5hzZMHlWujNFPUpQSNnmAqOUFrE5DMy1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhSOWhjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA8C19424;
	Mon, 19 Jan 2026 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840991;
	bh=IK4CqLAWsW4bKD4kWvQrYAnn/9aOTvD56ZKLXcmtBAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhSOWhjY3PQN8ugHJ8QVBbakHW57WY7HhtG409S2qGRKqZkTB9E8AiF54hgX/qhcZ
	 Uv/TzpYPSNEiNkSeaO5nbvZ9EmJ5gC3tfoaIwXzoFsaTcFIkah6tkAtrARr2yvf7a9
	 +RsAIySnbkpSu0fjoz9SuXP0TZu9v4WRzZLQOSt6wywG4MEdnu8ENHDB5tULUKpr9q
	 CsewUgeWT8jwcqEAILLmCbk0DYZxV37c0Te2cMB89cXDhP4IR5h6IlJSC+40buV0+s
	 pOzqzndB9M/z+BG3G1efZw8FNHOTEFL9B/e5WcjlDexGlZNwyciP42iwjpYUIIF+FB
	 jvuN7P5ABHRxA==
Date: Mon, 19 Jan 2026 08:43:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260119084310.19f7feb9@kernel.org>
In-Reply-To: <34a10265-e6de-489d-b079-6f6c5cc48dc7@kernel.org>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
	<011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
	<20260104084347.5de3a537@kernel.org>
	<8dc3765b-e97f-4937-b6b9-872a83ba1e26@linux.dev>
	<34a10265-e6de-489d-b079-6f6c5cc48dc7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 10:54:13 +0100 Jesper Dangaard Brouer wrote:
> On 19/01/2026 09.49, Leon Hwang wrote:
> >> My input here is the least valuable (since one may expect the person
> >> who added the code uses it) - but FWIW yes, we do use the PP stats to
> >> monitor PP lifecycle issues at Meta. That said - we only monitor for
> >> accumulation of leaked memory from orphaned pages, as the whole reason
> >> for adding this code was that in practice the page may be sitting in
> >> a socket rx queue (or defer free queue etc.) IOW a PP which is not
> >> getting destroyed for a long time is not necessarily a kernel issue.
> >>  
> 
> What monitoring tool did production people add metrics to?
> 
> People at CF recommend that I/we add this to prometheus/node_exporter.
> Perhaps somebody else already added this to some other FOSS tool?
> 
> https://github.com/prometheus/node_exporter

We added it to this:

  https://github.com/facebookincubator/dynolog

But AFAICT it's missing from the open source version(?!)

Luckily ynltool now exists so one can just plug it into any monitoring
system that can hoover up JSON:

  ynltool -j page-pool stats

