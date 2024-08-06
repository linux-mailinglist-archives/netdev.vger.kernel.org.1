Return-Path: <netdev+bounces-116124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C49492D3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF251C219AA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75318D656;
	Tue,  6 Aug 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8gzNpB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E018D654
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954044; cv=none; b=WCvJEVAlxdfEuyPCmC3iBhritA5KvWOkF/zGeqbED48XNaKiznYRKKuFZtp4lkXtWTcSX/b0VD0gI6IpObpsBJpbUKwsYbAiO4aeWXRwzQMMAlI5mH4AqwUsG2w3IMqYBRpCZwst9gs6if4SL6f9DpYZrhqtkOwkNC0aOFpYfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954044; c=relaxed/simple;
	bh=LCB5aZcCg8EOSqY1WaMuXL7FFMU2HOODQu8NZoKgpFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2+rsgaEOEdFXg06H2IRrCgwnpxHH68r8lLqHwgnISmI+IIYTuy3gMwcoiiF7DJymfohXrlLSCCBUCZBtFpM79/WCQDSKP0HYlNMqiSIHkYvOpg0HVH8UvY9Wm78cY05Ib1Jbxnh67VQh3wlYv4s4C7Bv4JLZTjXS88bnFAxois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8gzNpB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3B2C32786;
	Tue,  6 Aug 2024 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722954044;
	bh=LCB5aZcCg8EOSqY1WaMuXL7FFMU2HOODQu8NZoKgpFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8gzNpB9F+Kjo3gTZCZTuSBFttocSrOJ5QFFfFybPtGdd/1wbAUlNQlUFVSHPgMYF
	 AA15Y/hMY6yjFO0pQn3u4BtfXpA/gtBPoQp8B1nuFjv7Hwq5sF5qBEqy+moWB1IDDP
	 KJIbNoN09rHCq2N3RPifQFBRzeRRh6nqGwdY5xabszeRhlHuvTpc0Mn9hmj7Ri1AZL
	 M8etH1h3EVTIY62vdGyyw/aZ2ZHOIu7cg1S1PUVxjYGvLF/w2KCPmjcm/06V8n1y6W
	 wf3w51wShjujNEl+64azE3yqeacgOQNeNKJtyAtyYUNDhc96ljNmSMWX9MI3j9iQUA
	 YytEADmsaqEoQ==
Date: Tue, 6 Aug 2024 07:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com, Ahmed Zaki
 <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and
 netlink context dumps
Message-ID: <20240806072041.06bf085e@kernel.org>
In-Reply-To: <cbdb41f5-c157-49a5-acc0-cbce5516ea62@nvidia.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
	<20240805151317.5c006ff7@kernel.org>
	<cbdb41f5-c157-49a5-acc0-cbce5516ea62@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 15:22:07 +0300 Gal Pressman wrote:
> > I guess we just need to throw "&& !create" into the condition?
> > Sounds good!   
> 
> Yes.
> 
> > We should probably split the "actual invalid" from 
> > the "nothing specified" checks.  
> 
> And make the "no change" check return zero?

My knee jerk reaction would be to keep the error return code.
But I guess one could argue in either direction.

> > Also - curious what you'll put under Fixes, looks like a pretty 
> > ancient bug :)  
> 
> Maybe 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS
> spreading of filter matches")?

Nod.

