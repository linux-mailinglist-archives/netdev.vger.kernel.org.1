Return-Path: <netdev+bounces-46659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F807E59EA
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A402813D8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4293033A;
	Wed,  8 Nov 2023 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saEODZAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354A2592
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E6AC433C9;
	Wed,  8 Nov 2023 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699456854;
	bh=L2TmefYoNoCSJrOSXFsvAvjE74YUd8OCTAKEqDlpGoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saEODZAvekqYEa0N3X7p8X6z5o1s1upYYdc5l6ERtVMk4xaxY8VkBn6BDOhhur908
	 J2IF85xAhMow+b2ZwSuZoQQctNF1jLF9Js0YKeuimldNjUzoOT4Hy17EbhdmXccVyH
	 8zHznxyi+BMbEMU967cjCjEdoiSBE3rzhFJFmRU75hIsZvvEjfdJRFWTUddwhbGSqA
	 1FppFKXR2wIH5dsN04CB8aQbPlipcO2wSWON5Ev7hLutdbZtj5NDpxU+MwBnJD3c8L
	 d8w9k4rRmson6QJBUKd7QkA/73p0F39s5/b9baT2sKyPhQbib4qhawm5X5AJp6u/oy
	 8dOvlfGsJZEkg==
Date: Wed, 8 Nov 2023 10:20:50 -0500
From: Simon Horman <horms@kernel.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, pablo@netfilter.org,
	Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Always fill offloading tuple
 iifidx
Message-ID: <20231108152050.GC173253@kernel.org>
References: <20231103151410.764271-1-vladbu@nvidia.com>
 <20231107162754.GB173253@kernel.org>
 <87il6dldlp.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il6dldlp.fsf@nvidia.com>

On Tue, Nov 07, 2023 at 06:30:24PM +0200, Vlad Buslov wrote:
> 
> On Tue 07 Nov 2023 at 11:27, Simon Horman <horms@kernel.org> wrote:
> > On Fri, Nov 03, 2023 at 04:14:10PM +0100, Vlad Buslov wrote:
> >> Referenced commit doesn't always set iifidx when offloading the flow to
> >> hardware. Fix the following cases:
> >> 
> >> - nf_conn_act_ct_ext_fill() is called before extension is created with
> >> nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
> >> unspecified iifidx when connection is offloaded after only single
> >> original-direction packet has been processed by tc data path. Always fill
> >> the new nf_conn_act_ct_ext instance after creating it in
> >> nf_conn_act_ct_ext_add().
> >> 
> >> - Offloading of unidirectional UDP NEW connections is now supported, but ct
> >> flow iifidx field is not updated when connection is promoted to
> >> bidirectional which can result reply-direction iifidx to be zero when
> >> refreshing the connection. Fill in the extension and update flow iifidx
> >> before calling flow_offload_refresh().
> >
> > Hi Vlad,
> >
> > these changes look good to me. However, I do wonder if the changes for each
> > of the two points above should be split into two patches, and
> > if the fixes tag for the second point should be.
> >
> > Fixes: 6a9bad0069cf ("net/sched: act_ct: offload UDP NEW connections")
> 
> Hi Simon,
> 
> I considered this but decided to send as single patch because
> connections 'refresh' mechanism has already existed before the UDP NEW
> offload and it didn't update the iifidx. While yes, it wasn't
> technically necessary because only established connections were
> considered for offloading I'm still leaning more towards considering it
> a flow in original implementation since UDP NEW support wasn't the first
> change modifying the offload behavior (43332cf97425 ("net/sched: act_ct:
> Offload only ASSURED connections") was before that), so further changes
> should have been anticipated. Hope this clarifies my motivation.
> 
> Note that I don't have strong opinion about it and willing to split the
> patch, if necessary but to me it appears as just more trouble for
> maintainers without any benefits...

Hi Vlad,

thanks for clarifying, I appreciate it.  I also don't have a strong feeling
on this, and with your clarification above I am now happy with the patch
arranged as-is.

Reviewed-by: Simon Horman <horms@kernel.org>

...

