Return-Path: <netdev+bounces-47136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE377E8313
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4942280FDA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02503AC1E;
	Fri, 10 Nov 2023 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7IwgU2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5E3AC12
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE5AC433C7;
	Fri, 10 Nov 2023 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699645946;
	bh=ASErf/rN4eiIrM6smaHpuAE1GebOU2yCVy3Hl2BGlt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s7IwgU2rv2i5oXz5LMfdGA9lGPwV3UZBotxM4Vm+Y73ePVba2R8ZWKFPfscj+eLzE
	 xOZco8Nw1YuYAvOgJjHALtgkGKzvKfO6bzibnRdDOGJ2wuuJXG07Xewxx3b4Y93roy
	 O/sHEx4WhFdUvue2hmNVBfmEcMY7lDOijn6+l6xppdMb2U/2X253DeapXr3WaBcGMA
	 inQB4Zcn8NBMeURZHHLrv+3cEKOSnHLZ0LAbC4a61mju0qt2wFyYpAgtYaWmWvmfTJ
	 D7LQ+DScIbFgjIOBEF0VaFKc2D8rF/kuqI3lrpfgO4EOt1q2tBXXcPiham1Cq5aYUX
	 l1eQG/utZpOeg==
Date: Fri, 10 Nov 2023 11:52:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
Message-ID: <20231110115224.3d2f180c@kernel.org>
In-Reply-To: <ZU5j2V9aUae0FE1o@hoboy.vegasvil.org>
References: <20231109174859.3995880-1-edumazet@google.com>
	<ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
	<CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>
	<ZU5j2V9aUae0FE1o@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 09:09:45 -0800 Richard Cochran wrote:
> > I do not see how races are solved... Shouldn't
> > pccontext->private_clkdata be protected by RCU ?  
> 
> Yeah, the test is useless, because the memory is allocated in open()
> and later freed in release().  During ioctl() the pointer must be
> valid.
> 
> However, there was a bogus call to ptp_release() in the read() method,
> but that has now been removed, and so the test is now bogus.

Meaning we should revert 8a4f030dbced ("ptp: Fixes a null pointer
dereference in ptp_ioctl") ?

