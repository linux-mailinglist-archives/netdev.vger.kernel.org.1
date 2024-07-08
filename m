Return-Path: <netdev+bounces-109950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA692A71C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39114289785
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C613CFBD;
	Mon,  8 Jul 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8N1Vp8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C711E86A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455423; cv=none; b=VkzcyX/YNpa/5GjfNmZFABQZ9q9r32g/foN5tX52foxom61F8ws7kKn31bfMWqQUXMSjqv99tTXtcxUiLWaSFy4rSdaSc9YGyBAtaxYVZOJVFQ2cNlMn4DSiFCCRoNrM6WZtXXej0NZbGraDZLqrdF1HVRj3aRPb74YVQl3eEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455423; c=relaxed/simple;
	bh=yBBPASsLCsttAJgiPQQc7f90K9cbAI/LFcAqRY2vjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai05G2GVDp8FEYeGXdWLw1HS3tyTO3UhB1eZPOWA17CJAjeWwBdhR3HCfBfFC1cLBqtBWL1MhE0nqcm6+AiFyukiObvXpplW/c3D+9UE6A/EZt5jbqA59fblHMDWcdNWeMe3RkzDkaebwzfURcJtYd01f4dr/vhnLIgY9+NmZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8N1Vp8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B233C116B1;
	Mon,  8 Jul 2024 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720455422;
	bh=yBBPASsLCsttAJgiPQQc7f90K9cbAI/LFcAqRY2vjUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8N1Vp8QMOmSn2Mn16uRVk6tiGW8zr3LRu/5R/TvDemnWxGOX9DqfchZFyHu0RIaP
	 FfbsSaSVEW7qCLOaiLWlbHtR5RDl3ZEF4yueILsQBjwqZQ0xUgyWrxrEo4zuC9WEUi
	 RepPtbS6Csnu/WEfAeAzZK8ZuOZ2mztGHqBfc7eavoXeXVscga39aMPMVswimVjrA+
	 CFgzSAqh/g8022UNrBEIrFYjfS+YCHdMayWmsYzFGb7BlPwsyMco3w1HzJAWUKnXOr
	 0NjHschRWMztBhlLcrQ26YE6H6XqIQDd5QFSXQmnvHDCqZwAmYn87IrUcFx0tD7EmN
	 JErvYFXNR1yMw==
Date: Mon, 8 Jul 2024 09:17:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, petrm@nvidia.com, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue
 changes vs user RSS config
Message-ID: <20240708091701.4cb6c5c0@kernel.org>
In-Reply-To: <66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
References: <20240705015725.680275-1-kuba@kernel.org>
	<20240705015725.680275-4-kuba@kernel.org>
	<66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 10:00:58 -0400 Willem de Bruijn wrote:
> > +    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
> > +                                              other_key: (1, 2) })  
> 
> How come queues missing from the indir set in non-main context are not
> empty (but noise)?

There may be background noise traffic on the main context.
If we are running iperf to the main context the noise will just add up
to the iperf traffic and all other queues should be completely idle.
If we're testing additional context we'll get only iperf traffic on
the target context, and all non-iperf noise stays on main context
(hence noise rather than empty)

