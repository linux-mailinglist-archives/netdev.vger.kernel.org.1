Return-Path: <netdev+bounces-139020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE79AFD5D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497991C210B3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43101D31B6;
	Fri, 25 Oct 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgKC9HW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5661D2F5F
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846686; cv=none; b=Slfag6Fc22TLWFNAE5O8CLxKdT7f5AJLIyx4E8AgOzBwQyD7tHQsUu1HCrGQuqbYJdvv+Cs4mdK78SpmoEwQiRXv0Btz9YjnUQx6w7m10+Tz28KvsqjLVyoUofa3pan0LSYelrBvk3afi1zzQPO95ahD7MNULADXagsST9hObf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846686; c=relaxed/simple;
	bh=BxjTuCHQr1Mxj7X8jFs7Vo505tpKlo2OUK2XG4uxfP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccEHNKJwWjUuKEKrBM8GuRQBOrWPzCpj/j7hgY4J4gjSXM7o4pnCXJcdGdyP+ImXLrr5Dk0KZZszN7Px/xSdnPkDEHWwvy9D/S9nNgkiyZUgr8j6ePKYfQjrR+33wAZXmSjamTuFt6E0yrRXUEfvwwPGBvaCL5Bs94whX2evLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgKC9HW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F307C4CEC3;
	Fri, 25 Oct 2024 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729846686;
	bh=BxjTuCHQr1Mxj7X8jFs7Vo505tpKlo2OUK2XG4uxfP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgKC9HW5Nk/CU4/KUT5yrufR9XS21G7QWmzM28+8sB7U85diqjOhMEHHhCUKr7juS
	 f/MH5ig4Z2wGjEaExCdUXW8CybI9jkTtHHsu0nz11mcuR9W/dbgweOj6OUfO9wHtBu
	 yWrLRMCR3Ff1DSVlcjr7L2+EivPRFcP6h30LX+EKkqqV25cTa/zoBBN/FZOz+wp8Me
	 N/ps/Ekwjz7IwvdcO7njOxmUQU9vyhTqBsRW0fNYeVPu87ZrWdZdTlKOwxRrq0OHn3
	 gX8hZzwhs23AUR3/6mS33nhZrJ5AafD7zIjZhusMD3QhZTb16QdA0jj6MbOcuISKIy
	 dNgLWEvL0Y9jw==
Date: Fri, 25 Oct 2024 09:58:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, markovicbudimir@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: Re: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on
 TC_H_ROOT
Message-ID: <20241025085801.GG1202098@kernel.org>
References: <20241024165547.418570-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024165547.418570-1-jhs@mojatatu.com>

On Thu, Oct 24, 2024 at 12:55:47PM -0400, Jamal Hadi Salim wrote:
> From: Pedro Tammela <pctammela@mojatatu.com>
> 
> In qdisc_tree_reduce_backlog, Qdiscs with major handle ffff: are assumed
> to be either root or ingress. This assumption is bogus since it's valid
> to create egress qdiscs with major handle ffff:
> Budimir Markovic found that for qdiscs like DRR that maintain an active
> class list, it will cause a UAF with a dangling class pointer.
> 
> In 066a3b5b2346, the concern was to avoid iterating over the ingress
> qdisc since its parent is itself. The proper fix is to stop when parent
> TC_H_ROOT is reached because the only way to retrieve ingress is when a
> hierarchy which does not contain a ffff: major handle call into
> qdisc_lookup with TC_H_MAJ(TC_H_ROOT).
> 
> In the scenario where major ffff: is an egress qdisc in any of the tree
> levels, the updates will also propagate to TC_H_ROOT, which then the
> iteration must stop.
> 
> Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix qdisc_tree_decrease_qlen() loop")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


