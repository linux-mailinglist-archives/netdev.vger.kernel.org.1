Return-Path: <netdev+bounces-124335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1C9690B2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F6FB221E9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 00:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41FA5F;
	Tue,  3 Sep 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOTcKsq2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0CA32
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323827; cv=none; b=nJ8eIFbZtrOGhSrnIoDuSNvJciX6GdFj+aH5E5ZB8hGNPpqa3HdKE+u9QpOi9U9UZPUdsibHtwielJLT60eymZ5VdfYRSLFYjsiC2yhvUmvQoDw8hEAO1cw0xqSHs4uMeBAtvDivwsQS8PmYim5Lt7oCr8+rTyOS4CNT/aQRfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323827; c=relaxed/simple;
	bh=W/A4XMjAkThRmR1Qu06rR2z3sjh6iTSU03vzeapf8YA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os1aG/VyQuH4zDcj9aHbM9e1D/rxISLPank1nElfq0DtezrDzmQzFNj0chYY0kzvLrN2bjvwwYMVp889yTYdY0VbFDhaciCwc+sdalh/1Ze1MViI3tkFUJ45wLZUyAdXh3abiOrCl3eiKZCS2nJmjja8HZD3n52DFc2Wp+nwduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOTcKsq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E0C4CEC2;
	Tue,  3 Sep 2024 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725323826;
	bh=W/A4XMjAkThRmR1Qu06rR2z3sjh6iTSU03vzeapf8YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOTcKsq2O8g9HZTRct+iDno3H1bYpqmaTGAOdC5DR6/J0DPF2efa/UVbolo4tyIJP
	 dBBz3MqPKE6GQDgaN2imfhusIsRYdzD/G3Cda82U53D6R6dB4FVc1loCX/OEwf6Pim
	 6u28OSrfugAatiWg3p/q5u9WRIUJPBv46s9tWx0sFdoMCiRHj+GijXW4fhUHXVnCfr
	 LQbFX8O6EYVl7qEe1hfoCEFlahzrhLyjJJiqcijQhgTj8VwqzNUje4L8TRJwQ/U5TJ
	 JY4ceOcJL2QyFuy9liFegV/R3ebSBuyp7ETO/ugoYlYIgOP/WoiFlvgFEMFv+p2YPG
	 JEYeertEZ/ykA==
Date: Mon, 2 Sep 2024 17:37:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240902173704.71c6b35a@kernel.org>
In-Reply-To: <c6d8052c-c5a0-48e2-8984-0063afc1e482@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
	<20240829182019.105962f6@kernel.org>
	<58730142-2064-46cb-bc84-0060ea73c4a0@redhat.com>
	<20240830121418.39f3e6f8@kernel.org>
	<c6d8052c-c5a0-48e2-8984-0063afc1e482@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 12:10:50 +0200 Paolo Abeni wrote:
> >> Was that way a couple of iterations ago. Jiri explicitly asked for the
> >> separation, I asked for confirmation and nobody objected.  
> > 
> > Could you link to that? I must have not read it.  
> 
> https://lore.kernel.org/netdev/ZqzIoZaGVb3jIW43@nanopsycho.orion/
> 
> search for "I wonder if the handle should be part of this structure"
> 
> I must admit by wannabe reply on such point never left my outbox.

"I wonder if .." does not sound like a strong preference.
And the parent ID remained in the struct, so it still partially records 
its position in the hierarchy. Since there is no "move" op it's really
not worth multiplying arguments to most functions 2x.

