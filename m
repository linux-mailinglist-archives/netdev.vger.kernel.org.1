Return-Path: <netdev+bounces-101124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494408FD6A3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB30D1F26D3C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C115351B;
	Wed,  5 Jun 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTm4/d0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12692153512
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616413; cv=none; b=miweupaWQGEZE3xpB4DIft+7c6ERrxfDWUUdqmM4KTXa4SOGP4E7EKgxMYsDfXfQm5aC1HmzGU56CXRhCB8rthhN9NS9JWIt/C4isETxYP6bog6i1XmIOy4LvGiSABudMfajmypalxeOEvcLFRtOGfnhFjMv/C9sANsIdZ2TOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616413; c=relaxed/simple;
	bh=h6+pPkBMHnOMWMK47AYYXm2+5aUdmpSy1w2JgEsM1tE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWWJujW8l/E/3rVM2psiSDD5uauxtGm65S/ISd7il8WeifLSto3nEGWwY3sjS318OluMhlkFFyLTYnkI2/gFnl6pQ+K22RcYwpd3YbNvVYGd8qEPoZpgw12VMrs+JcHXt6w5BdfnEYD4grLAKJY1Ex0OF3RGZrub32KNZQtfLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTm4/d0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A796C4AF18;
	Wed,  5 Jun 2024 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717616412;
	bh=h6+pPkBMHnOMWMK47AYYXm2+5aUdmpSy1w2JgEsM1tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTm4/d0SUKXDpG/SSd8D3YPknNeCm8PYg6hwISdVKw0nQZvk+MEC2eZGjNl2GAYuf
	 +ax52VtgHIJphtLZ0bz+aXHYevpFdFVa0/6qritFNwXDoogg2ScGoXHDCaZ1dz9gTp
	 H3PM3P7s5fRaPNvG7T68YHZMHYkF6gTw0fmF9KjVbVIGGB71Jm5+uebcONR+9Yrjol
	 26aoxSfezFAUoQchnRez7/zDuioGEvu8TyhE+yi/tJHyEa26m4CFDkAJCCZRqisvNX
	 qA20e170/IcqqQkCE2c8nDd7EuWSBtGyrnfq5dsEpb/MYp9PGCM9z6gWe0skE5y1CW
	 m7gk/0hc7eXuQ==
Date: Wed, 5 Jun 2024 12:40:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org" 
 <netdev@vger.kernel.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "madhu.chittim@intel.com" <madhu.chittim@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>,
 "sgoutham@marvell.com" <sgoutham@marvell.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240605124011.69809be6@kernel.org>
In-Reply-To: <ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	<abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
	<ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 17:52:32 +0200 Paolo Abeni wrote:
> > Looking a bit into the future now...
> > I am nowadays thinking about extending the mlx5 VF group rate limit
> > feature to support VFs from multiple PFs from the same NIC (the
> > hardware can be configured to use a shared shaper across multiple
> > ports), how could that feature be represented in this API, given that
> > ops relate to a netdevice? Which netdevice should be used for this
> > scenario?  
> 
> I must admit we[1] haven't thought yet about the scenario you describe
> above. I guess we could encode the PF number and the VF number in the
> handle major/minor and operate on any PF device belonging to the same
> silicon, WDYT?

Just a minor clarification. _Internally_ we can support expressing VF /
PF shaping. uAPI for that continues to be devlink, right?

