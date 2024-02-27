Return-Path: <netdev+bounces-75512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC286A333
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 00:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F15A1F23AA4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5E1E86C;
	Tue, 27 Feb 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIr7/0Fk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0255C28
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074906; cv=none; b=fXfima1igdqn2DwCvboSwC93+NJFv5zTFx/7EjeJr3k9Jagj6aobfEPpvW3WxSV5EMGlscJRYiZWCOjCIscnXhKPFd9+OFInFgDw9nqZj1UzPj3B6GoZuAKkmFDqgrKuuApWoxUiXwdwv667YUuHLe382GF6+nM5/z9JP7/NKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074906; c=relaxed/simple;
	bh=HX866CGbg3nfTRT2238OAPPxVxIIn84/IoJEpdc9Ffk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAnBRinsljMtxzA94aH7GXeQuf6z7mYW+DK0OH/MXf4RiKKVFuzsH7CuXOqX9eBdmHiBS+CxZTrhrLHdrEuY3Sj4nMC2oixMOKDwOtdeuQbWtoXJxbuS88vrbkvsqbKHx+I1vtLF4pIVRIPuLdAB8b0gkl2RgpG9qN77omjC6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIr7/0Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCAFC433F1;
	Tue, 27 Feb 2024 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709074905;
	bh=HX866CGbg3nfTRT2238OAPPxVxIIn84/IoJEpdc9Ffk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIr7/0FkhuZgJG5LpO+4mameALP8SIrH2PwkgeioiyOVZNt2BO3j6Q29tbcRdG8ff
	 C++Uidxm23/ael1i363Z4HsxOruW19S0wvaR+X0CuKlOJVSuxFjzGzi0KjzbOCGQYf
	 Z4yaxJkG/pUSoJH3v5pZzXbk7P1YiFzHJ3Cp801Umq2RsoLAgUcp53gf/LriQwolqI
	 fF1bqs1z/J5/FjYDnE1v3Zbm/KiJRJGcD42PYYGT6nyNOYjFLT497MLzP9AjGF1c3l
	 OT0msCDMQjy1X0sVRCWkc07TVEnoZtm4VHmLrT5iY4dJvZ4kGSsfOt5kHGZj/Kknj1
	 IlYDFbOhVr8jw==
Date: Tue, 27 Feb 2024 15:01:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <amritha.nambiar@intel.com>, <danielj@nvidia.com>,
 <mst@redhat.com>, <michael.chan@broadcom.com>, <sdf@google.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240227150144.01b33697@kernel.org>
In-Reply-To: <6dcf163a-c089-4047-a3d7-ee492778db48@intel.com>
References: <20240226211015.1244807-1-kuba@kernel.org>
	<20240226211015.1244807-2-kuba@kernel.org>
	<e05bed50-ef3f-466c-92e9-913b08bbc86c@intel.com>
	<20240227070041.3472952b@kernel.org>
	<6dcf163a-c089-4047-a3d7-ee492778db48@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 17:17:38 +0100 Przemek Kitszel wrote:
> >> I get it, but encouraging users to reset those on queue-count-change
> >> seems to cover that case too. I'm fine though :P  
> > 
> > What do you mean? Did I encourage the users somewhere?  
> 
> I mean that instead of 'driver should reset on q num change' we could
> have 'user should reset stats if wants them zeroed' :)
> 
> but this is not a strong opinion

Let's revisit the recommendation once we actually have that API for
resetting? :)

