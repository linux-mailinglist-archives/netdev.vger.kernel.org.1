Return-Path: <netdev+bounces-115869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD90948213
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4356B211F0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680016A397;
	Mon,  5 Aug 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC3oh9sy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452E2AD13
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885000; cv=none; b=CKsEb9rzaU/2UKB3T0f66pvtU1Xj5p2u9mINY6T2TJmBUhGsfvMuhIiAyJ2DnNjwhM645Z+CAue7QrJwXvzgImBILGX4xa6PWSobk8K+MQqTNDpQUmH/JB52KnB47af/j0WO4MT1hJOjagaTFWcA+sCCHhDE6/cyok6IvX1YXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885000; c=relaxed/simple;
	bh=5MWJ+hkhvIBMmv6d0zCuMirXiJ9AU/CMw6EDAS06MCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajQyMTKAdbYnR5NwlYm4s6BRZuvUIWiARUKeCyEbjwFZmW5Hzs85O+Bpj/bLLlSH5VWfRlVXYIkyMubAo7K62an1ZwrzWBSGrtGs1WNdqdcjk29xgeeQUHVZQZmxwHCmSx8ZRNALTET+txOol0bWjpa+pvgwGWYonVeSHvayFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC3oh9sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289C8C32782;
	Mon,  5 Aug 2024 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885000;
	bh=5MWJ+hkhvIBMmv6d0zCuMirXiJ9AU/CMw6EDAS06MCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nC3oh9syqpKA1/6Z6ncLUiSZcJ0RY4XkOIaUIDmQDmcY+UuA8BPaWBpvLxncVVTVy
	 jghLAHTNGGy+4W6t1xiJ3uei6RQYUygzg/XzyDCCI22Hdt9Im84v3YdZ5QltXtUR0k
	 bLjreWCstR3lWrAX8JRiQxpj0J7QJJE1EvnklZzrcAO+la45KVosfqZ7xZqFfb7HZf
	 mWmtCvzuMS55sxdwTjXoe4VTJwSr7FPIh8vJBbS1KMAm47bEBaYIlG/y6ndOieVnZ9
	 UwkwW31/U1ce6OYqALsixTOYeIiVeavWcS3D2G+K6TSHqXkifXBySnm//gJ/8zDOgb
	 Djk14xTfB+H2Q==
Date: Mon, 5 Aug 2024 12:09:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com
Subject: Re: [PATCH net-next 7/7] ibmvnic: Perform tx CSO during send scrq
 direct
Message-ID: <20240805120959.70608deb@kernel.org>
In-Reply-To: <2ee7dd51-c45a-494e-ae24-b47fa938d321@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
	<20240801212340.132607-8-nnac123@linux.ibm.com>
	<20240802171531.101037f6@kernel.org>
	<2ee7dd51-c45a-494e-ae24-b47fa938d321@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 08:52:57 -0500 Nick Child wrote:
> On 8/2/24 19:15, Jakub Kicinski wrote:
> > On Thu,  1 Aug 2024 16:23:40 -0500 Nick Child wrote:  
> >> This extra
> >> precaution (requesting header info when the backing device may not use
> >> it) comes at the cost of performance (using direct vs indirect hcalls
> >> has a 30% delta in small packet RR transaction rate).  
> > 
> > What's "small" in this case? Non-GSO, or also less than MTU?  
> 
> I suppose "non-GSO" is the proper term. If a packet is non-GSO
> then we are able to use the direct hcall. On the other hand,
> if a packet is GSO then indirect must be used, we do not have the option 
> of direct vs indirect.

It'd be great to add more exact analysis to the commit message.
Presumably the change is most likely to cause trouble in combination
with large non-GSO frames. Could you measure the perf impact when TSO
is disabled and MTU is 9k?

