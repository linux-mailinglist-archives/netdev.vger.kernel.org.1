Return-Path: <netdev+bounces-70489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC6884F380
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA4BB2115C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829712E4C;
	Fri,  9 Feb 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWMkJEvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343E8C1A
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474865; cv=none; b=Zrf/Wa5G70mAWKf7ccXUSclvgLdWGWz1u0PlAgCqj/cUUSUcm/GJ2hkhSqacNcBKNF78dV09DPX5ytmcivW/rDqf8fB5acNX4hstbqboptdWEmfMJvFoe8yKmB40dl2Em2DLD9GHxVfxrndzx317n16XnxKCZvGlLAbScAqo13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474865; c=relaxed/simple;
	bh=/ip+PIOjx5aTnWVaExLgigrHBVUJrumlV+cWrEQb8pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOtyBqMqvkUqCgXKjjEtkHiiTEfOmq2eO7V5VKi1Ba9LPG6iHulKSsjPwdYlhvCtoQvF8AEEtw7QVEOWiY7Uv38Rn5cEVLu9Sc0or110i6lLNkv7EySaZRKTUnT0pMvsJHYIpWmcZDJBJMs2RKcgoJ1nMVlXLKcCmi4CLMWKs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWMkJEvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0922C433C7;
	Fri,  9 Feb 2024 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474864;
	bh=/ip+PIOjx5aTnWVaExLgigrHBVUJrumlV+cWrEQb8pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWMkJEvFO51+vQQBv733lcOiUqHYEYNlPL27MGRa5/8y7E8TUFNSq5jwr/7ETs+sk
	 UtKpJ9KvDwRQsRWXtmZs5AQlGyJ/3Uf35WCXb1ekKgacUqC1Fh+NgfV+DMrH6LCqS8
	 d9g0pn/N4NRCILbbEkA53b6VFMdMvf9esrCivA03d1ou+whWEwy7gIdsaL4XAOGvid
	 xzFRmVgKSJJjCAWNtB32ISQCpFGzaTke0Ne50PebYqsgSPC2fndKJIhjo9T8K2tYWt
	 17oxT5qR6WQLSmbaeZ5sPydtzUyW20uHv3SfcyG9wa0ozLNkBACPG09NYS4Dos3OV2
	 nWvfWktOOrlvQ==
Date: Fri, 9 Feb 2024 10:34:20 +0000
From: Simon Horman <horms@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH 1/1 iwl-net] idpf: disable local BH when scheduling napi
 for marker packets
Message-ID: <20240209103420.GD1516992@kernel.org>
References: <20240208004243.1762223-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208004243.1762223-1-alan.brady@intel.com>

On Wed, Feb 07, 2024 at 04:42:43PM -0800, Alan Brady wrote:
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> 
> Fix softirq's not being handled during napi_schedule() call when
> receiving marker packets for queue disable by disabling local bottom
> half.
> 
> The issue can be seen on ifdown:
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> 
> Using ftrace to catch the failing scenario:
> ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
> <idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]
> 
> No interrupt and CPU is idle.
> 
> After the patch, with BH locks:
> ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
> ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]
> 
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


