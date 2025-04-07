Return-Path: <netdev+bounces-179616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E16A7DD7E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D43216CC97
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE7236A73;
	Mon,  7 Apr 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+NmIhaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2622DFAB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028135; cv=none; b=NxbzfabRUlaJfp0bMW8kvPrxtD88HbXa7QM5C22FSieTXjmjr60fPYkXjs5OE5xaLBtwcUcqkwhAZ+xSMtX1sxMsyiY+BGXzc5F0K7GF+0wSijNjxyfXUaOUjKE+bBNmW+nkUxG6dZm6SWo0rSxCmenQn/obGW2HkGtbMgs3UWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028135; c=relaxed/simple;
	bh=x8PILicDw7ElWqEsqusAWTz1GtuqGC6QMG+UHx9R1lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAfZDSCrIETts7InNOFQdOOWp5ScZO87V9rHxZYiJu9fZZrxnQ3PyNHQsvRVWl3FUgBQi7PQMOEM6dfWNeWqxdvnNUhSmIF1OCCenhHuHxIBNxaJE7Ca2JuALrTXInCa5X7Jl0X53YvN+O8zSwQ1BOkXaOsYZQYgugt9E8hBZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+NmIhaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D88DC4CEDD;
	Mon,  7 Apr 2025 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028134;
	bh=x8PILicDw7ElWqEsqusAWTz1GtuqGC6QMG+UHx9R1lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+NmIhaM5TFzw5t7gE2Wg6NgW+DqHYomOf8idUpC6c8lWXze/jVEzSlRiBfyimIJ1
	 0uiyqKt8kRuKJeXA3vY072/LVAqVML7W13emfCzoTfv8MRrKyFs9ysDg2SY02Pn5aG
	 c5noxZG5vg/VomFMo3RiK8jd/cAwLM9e8r5kMkjFCvJbMgIf8KQoh6NkEcvukMLHuS
	 aT3VTC1DjNuD3PcIiAnYrNP8ukbchh+6svfiJ2LLsSgWsh35V53ixQM6QA6TdyvZi+
	 ZtPExV2GiJGvZ5XMfZNLiS5va6Mf7dzkFr+tZR/z7BDeFIfJCKHFYHy2bQn769NH5u
	 QXrwLL3l/LvkA==
Date: Mon, 7 Apr 2025 13:15:31 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 03/11] sch_hfsc: make hfsc_qlen_notify() idempotent
Message-ID: <20250407121531.GF395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211033.166059-4-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211033.166059-4-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:10:25PM -0700, Cong Wang wrote:
> hfsc_qlen_notify() is not idempotent either and not friendly
> to its callers, like fq_codel_dequeue(). Let's make it idempotent
> to ease qdisc_tree_reduce_backlog() callers' life:
> 
> 1. update_vf() decreases cl->cl_nactive, so we can check whether it is
> non-zero before calling it.
> 
> 2. eltree_remove() always removes RB node cl->el_node, but we can use
>    RB_EMPTY_NODE() + RB_CLEAR_NODE() to make it safe.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


