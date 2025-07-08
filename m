Return-Path: <netdev+bounces-204956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF0AFCB2F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB79561BEF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C52DCF74;
	Tue,  8 Jul 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZf9RTjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC72DCBE0
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979604; cv=none; b=HjwV5/fCmse1QdLK0k7l/g+twN1vQSPdjjDISNK0uOoCuOP0YEyR6exkm/ROjp8tPrtwRGhKBG7yrMOtWAy1KuodY/Ui6fcTumn2pCq/ihBn1g6fMp3nMYfncuX+ItyK1eTzQB37BsHBNIoJXN9nY/FkGBIJqAjrVmYoC4p5gqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979604; c=relaxed/simple;
	bh=HrX39qnuRphmeD6X1pyFMClfVUfwX7EDB4jhKskJGGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJz7EXCVVC4CmXmzYSWKQtrViTNSPgp6X0FoKYT9fIphxME3cdQ+1Jb8WPlENDJyZmrLyBoRpkPqeJtccixzz9uWOVKq49oSc8Z3WIxYW9aTZSYroRQAlWHeWBR65FX6T/+BVbkeoHcq1faDnsCDaSyDT543/pqUueTKFz4Wv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZf9RTjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D80C4CEED;
	Tue,  8 Jul 2025 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751979603;
	bh=HrX39qnuRphmeD6X1pyFMClfVUfwX7EDB4jhKskJGGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZf9RTjoCviMSxTxGPh05dtZLyekkg+K5Kq6cM5FrG1US08/yTDVh57/ScEptxyU5
	 kwALdaSduVLCJROXXG+Y4nLxUH0ZDgKmeZZl++AN1DxvgShGq5LTHoE7Mz3iMi21GW
	 3Cqy9pNztWAu8El7rIld4I37fG+iHmTjExYuuwi9HjQNrPNovwTsuYs6tVBUB4DKo3
	 43zCQMG3az6asquIs4lgb/vgJg+W5EUw84cqBMEQ4ilX0gi8Byh+vWew85cnLTMa/I
	 rUq84GIaxGWposM/x+o2d+BxgemWxjMhBPtBLYXUcRzHg8yG4Isvu/snkO19UkX78f
	 x9ZAvfZqfE1cQ==
Date: Tue, 8 Jul 2025 13:59:58 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 08/11] net_sched: act_nat: use RCU in
 tcf_nat_dump()
Message-ID: <20250708125958.GI452973@horms.kernel.org>
References: <20250707130110.619822-1-edumazet@google.com>
 <20250707130110.619822-9-edumazet@google.com>
 <20250708125411.GG452973@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708125411.GG452973@horms.kernel.org>

On Tue, Jul 08, 2025 at 01:54:11PM +0100, Simon Horman wrote:
> On Mon, Jul 07, 2025 at 01:01:07PM +0000, Eric Dumazet wrote:

...

> > @@ -294,12 +293,12 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
> >  	tcf_tm_dump(&t, &p->tcf_tm);
> >  	if (nla_put_64bit(skb, TCA_NAT_TM, sizeof(t), &t, TCA_NAT_PAD))
> >  		goto nla_put_failure;
> > -	spin_unlock_bh(&p->tcf_lock);
> > +	rcu_read_lock();
> 
> Hi Eric,
> 
> Should this be rcu_read_unlock()?
>                         ^^
> 
> Flagged by Smatch.

s/Smatch/Sparse/

...

