Return-Path: <netdev+bounces-92824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDFF8B9035
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 21:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22FCB215EE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120F1607B2;
	Wed,  1 May 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkA0yw1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0F182DF
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592879; cv=none; b=M8qMS6QAg7JTZSp/Zwg88qtc2GieZFdVkOZeoPOl8KGMcXqnwDCrvigVnOWEYlEdbrav9uNXbHymk7ZxxxYQ1yF1jlfbFHYuqDnuG2fX0myuapkd7ZVUf77+y7qo18I3E/Qr5tAqNMVzaXxZPGYFVaEPefGQRMPL+uUMNWZTq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592879; c=relaxed/simple;
	bh=MWn8Fu8l/lBv65ezrsoO6hSBnZPQPZ+V3syerBuyLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q028rnuB0+uU98M5sZtJds2jsdXzEGnEkuM4/CTBCAMC0dTMtuu0kHCS/GeaDqy20prI+YzkNQHqIhM6B7uWMp/Ni6/H5JMJjj1GQCgF/3/yapt1VrOiqvT9fE/k6aG1IDY9R+M7oN0B7AChKg7Fboba3HR+46jTBPV660fMcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkA0yw1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C442C072AA;
	Wed,  1 May 2024 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714592878;
	bh=MWn8Fu8l/lBv65ezrsoO6hSBnZPQPZ+V3syerBuyLOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkA0yw1TNsuZZJJo6zO4bYN6wPm2TB8q/wOzpYF5CyRDHs3TvY/6b49AmzjcnsGVa
	 lEW7J63gjxGL3QAKPbnfzyG/KLrKXrHy35hVcOzl99RqQAGhZovdn/dZsOrwjVQ+P1
	 dKBMjK8FL82qZ4BxP5oxYMpPHNbR4hlyEihEaSwJIZnBQ3novyXhDRkBH5m9vEeyld
	 jIAveAobjIXBKkYuSQPV/D7TfzSrlFZFYTbbTtGfM9k6/Lq8jiNgIO7Xr4bZWpF/Fx
	 rRa54MxSZ+8g2fPYcfLU5ZKKydIqK5hvlHJ6BkhP2o64C+RgJDHaZMVJnwwC5zGycX
	 MwTLZ6emQiibg==
Date: Wed, 1 May 2024 20:47:54 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net_sched: sch_sfq: annotate data-races around
 q->perturb_period
Message-ID: <20240501194754.GI516117@kernel.org>
References: <20240430180015.3111398-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430180015.3111398-1-edumazet@google.com>

On Tue, Apr 30, 2024 at 06:00:15PM +0000, Eric Dumazet wrote:
> sfq_perturbation() reads q->perturb_period locklessly.
> Add annotations to fix potential issues.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


