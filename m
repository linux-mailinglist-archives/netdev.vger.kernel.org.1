Return-Path: <netdev+bounces-184929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B2A97BC2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692B01897DEA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2652561A2;
	Wed, 23 Apr 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L42+mSNc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA51F2B88
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369048; cv=none; b=NkkZPpI4Kw5LlldnTDWO4uoBIjBTBMDoSsAPdc0m46iAASqWVzBJrlkTKlhY9Mqg4LA2lnvZFxgicd5zC++iY0AI7bDNnFZjO0Xt/XzdxZuTZM7R5kxcT4vHc6elZ7WUXS8zC0EM5sgQcTVuNKOv8BY2+0F5lxGb38MEhq3bVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369048; c=relaxed/simple;
	bh=K0viF8YdgXAd8GjltFpc+FLwDWe+JSxlhOOo++VszXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp+dsgj11xOu6TKTKfoWBVd4azrhUXmVIz363hsHFvpZX1PbfUg+UcVb7ZD3Y4/ADIL6I0CDkgwVUoDq/Wbu7peYhNMKmQ6XMo9afihwLHOyQUPLFwowjQ0SCAmjRR4r5pQxVxq7GGuInEkcoLeU6cWVKD5HwwKWj16kNremeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L42+mSNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6794FC4CEE9;
	Wed, 23 Apr 2025 00:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369047;
	bh=K0viF8YdgXAd8GjltFpc+FLwDWe+JSxlhOOo++VszXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L42+mSNcJaMF9BXsjWgqX3pyrWkmka+UUPLVmgbffW5KrxzVh2Zrr+OeQDZjKC5GP
	 WRsxcfwLjqUFxYPtojI8Se5pTBr0EtY/9ElHXisO7bETf+PIPbE6qvZTNpa5fv2rqt
	 zur3TE60Uc+JyaGn5N7CSCHI74VXajryfqecJ4qWzgYA4VWdgWmDO6yyndLfWAN5++
	 aiYel0OE6cCZFWnOGjji4cT1yF2hZ9Q6i2P9+Jve+XSuBOl661UsB76YF/yvaNz6OL
	 ZkjjUlEa/9T47xnZV3XKJvj9voj6nhg5CHzzGQHbcF1xsZcoe4b0QP5wt2kpxnye/r
	 7e4ySK+a0G8+Q==
Date: Tue, 22 Apr 2025 17:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com
Subject: Re: [PATCH net v2 1/5] net_sched: drr: Fix double list add in class
 with netem as child qdisc
Message-ID: <20250422174406.38cc5155@kernel.org>
In-Reply-To: <20250416102427.3219655-2-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
	<20250416102427.3219655-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 07:24:23 -0300 Victor Nogueira wrote:
> +static bool cl_is_initialised(struct drr_class *cl)

cl_is_active() ?
Had to look at the code to figure out what it does, but doesn't seem to
have much to do with being "initialised". The point is that the list
node of this class is not on the list of active classes.

> +	return !list_empty(&cl->alist);
> +}
> +
>  static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
>  {
>  	struct drr_sched *q = qdisc_priv(sch);
> @@ -357,7 +362,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		return err;
>  	}
>  
> -	if (first) {
> +	if (first && !cl_is_initialised(cl)) {

I think we can delete the "first" check and temp variable.
The code under the if() does not touch the packet so it doesn't matter
whether we execute it for the initial or the nested call, right?

