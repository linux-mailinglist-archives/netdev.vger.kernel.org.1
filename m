Return-Path: <netdev+bounces-76649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8586E70F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA5B2AA57
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C205663;
	Fri,  1 Mar 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXlnE59G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8045394
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313538; cv=none; b=T+zoJai+cOd0doaQ/Tq1gIji+xzvetdzUzAZvog9dHHHqIVixSD+PJGipKeG0KfbVMpNWYHOdFJfdLFG+pUK7gppdunhhFn37BpNdIIfppx+mn+wdnYRC8X+PGSkUGsNJPvwEYjFtHf4gw3AJTgbd12UB1SN+MGYGojIbRNuvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313538; c=relaxed/simple;
	bh=qmqDcDsvijwOtJxPiMfwYXE87/zWFNMI4/lPT6C/TL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q42jv29EgDoYlEhL9tHSg2vWK1/jnv62p5mZVuOklZP63p7KEmR7vyAok5BkmEgsb8LgrfF2IYFQohfDhyzENG48dIh9AvJLCETOa+V/cyDZbRYNKBvIOz1C3kCFOpttlt7a2pVvTdWS3ZqNfMkxOvW422mxgpCGL0VgyJFB2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXlnE59G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3262C43390;
	Fri,  1 Mar 2024 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313538;
	bh=qmqDcDsvijwOtJxPiMfwYXE87/zWFNMI4/lPT6C/TL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YXlnE59GYkeEpoPsn3wtfznZxaPEMbw5jLAVfKHVTBmjpVpkOuHdzkdJsgN0e9f6a
	 54fiEirQSIcETGrhHXrb/utDqDJOORBm2NDzslKE4iAqPH8ZpfPrvSKAL9QwQizUeD
	 d15OsdtiTKWyNUS4IRrSlTyehay2HgNGWdAE3uF9agQhKair8x+ybB8WktH8o0UJMK
	 zr4yIU6Q+k/guSvwgFIJAWp8f9TIKZ48vjbIAlPU6Hy4rQfgLp9CSZVMZCKyNgfDbs
	 nhI0Hz4VOF9bAhimy8LUU4/+dgYkg/ouHozaQLC7fSsHBAfvCKYvb0EZffN6DoRp2/
	 Bd7sqkokaHrTA==
Date: Fri, 1 Mar 2024 09:18:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko
 <jiri@resnulli.us>, Michael Chan <michael.chan@broadcom.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <20240301091857.5f79ba3d@kernel.org>
In-Reply-To: <CALs4sv1WSJSxTM=cJ84RLkVjo7S8=xG+dR=FGXmDHUWrj7ZWSw@mail.gmail.com>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
	<20240229070202.107488-2-michael.chan@broadcom.com>
	<ZeC61UannrX8sWDk@nanopsycho>
	<20240229093054.0bd96a27@kernel.org>
	<f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
	<20240229174914.3a9cb61e@kernel.org>
	<CALs4sv1WSJSxTM=cJ84RLkVjo7S8=xG+dR=FGXmDHUWrj7ZWSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 13:09:30 +0530 Pavan Chebbi wrote:
> > What I was saying is that in the PTP daemon you don't know whether
> > the app running is likely to cause delays or not, and how long.
> 
> As such timeouts are rare but still normal.

Normal, because...? Why do they happen?

> But if you've an environment where you want to have some kind of sync
> between the application and the NIC, as to when should both conclude
> that the timestamp is absolutely lost, we need some knob like this.
> Like you pointed out it's for an informed user who has knowledge of
> the

Let's start from informing the user why timeout happens.

> workloads/flow control and how (badly) could they affect the TX. Of
> course the user cannot make an accurate estimation of the exact time
> out, but he can always experiment with the knob.
> We are not sure if others need this as well, hence the private devlink
> parameter. For most common users, the default 1s timeout should serve
> well.

