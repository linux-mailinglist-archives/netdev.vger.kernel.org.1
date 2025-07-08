Return-Path: <netdev+bounces-204954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096CAFCB07
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13EF1628A1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28D1E5B91;
	Tue,  8 Jul 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO9rVKBc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675817A2E0
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979256; cv=none; b=adoCQM9LoZHNn5m35DGUm+/rqoUKTA3IlrZk5t1qNdahPr+eJyjRVFXfzRX9uHMKC6vgEKhAY0bmbtkJAENlm1m0u+WQy5GlJOGWaYzz60osb1b7F/9myqYZCvcsTw9a9yShrX6PK9gQpFFWhmyD+tF5kO31iBGXagCrEf7Y0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979256; c=relaxed/simple;
	bh=3O9SvEELPCZWLNvUMALSaF8QGYE6SIvr2Lo9P57qY0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd1sOiR9CZHU/jiF72Gwo6pfCyq8wekCsvdHl/8H63dZ+sUdYfYbmQzsgqDlHmszc3k1WMtIvl1QnX2WoiMiAzoY6keMGWKmJN1NxU/ESejDH0lUkSVvZxQP+i4S8ahjG3Bn6G+72QApKmh889JdjfLsr491jhxZilLpmONqRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO9rVKBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CC4C4CEED;
	Tue,  8 Jul 2025 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751979255;
	bh=3O9SvEELPCZWLNvUMALSaF8QGYE6SIvr2Lo9P57qY0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO9rVKBc0rTDRIFZ+I/luiF6wNXvMSbf1LUnwAcuukZoh6btXwH3CmzEDBSAhxA4q
	 9jJgebeT4FzKLJcOrLpebphhhmBRKyTsuHZeMhGFKxl5EeN+tMRsaVcuW6bHWuNXFa
	 2N69gWnx6KUJyDePzSUDbzDKFOSTYB2ud67T7HjmgeWODjOpO4Db2+k8xnYaFv0a7z
	 ShiITLXUOdpkIL85yuUzJoOa9z+aUK9voR/Gub1k9sGxr9P0I85VSSBtDs2Gn9QiGT
	 RADBt9xO6XPYw3DJVP3RwFFAv3gBX3lhIWTkGt95TsWiGa1Hd602q1SdwKOScZs2OQ
	 A5fZtMB6WW6YQ==
Date: Tue, 8 Jul 2025 13:54:11 +0100
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
Message-ID: <20250708125411.GG452973@horms.kernel.org>
References: <20250707130110.619822-1-edumazet@google.com>
 <20250707130110.619822-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707130110.619822-9-edumazet@google.com>

On Mon, Jul 07, 2025 at 01:01:07PM +0000, Eric Dumazet wrote:
> Also storing tcf_action into struct tcf_nat_params
> makes sure there is no discrepancy in tcf_nat_act().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

> @@ -268,21 +268,20 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
>  			int bind, int ref)
>  {
>  	unsigned char *b = skb_tail_pointer(skb);
> -	struct tcf_nat *p = to_tcf_nat(a);
> +	const struct tcf_nat *p = to_tcf_nat(a);
> +	const struct tcf_nat_parms *parms;
>  	struct tc_nat opt = {
>  		.index    = p->tcf_index,
>  		.refcnt   = refcount_read(&p->tcf_refcnt) - ref,
>  		.bindcnt  = atomic_read(&p->tcf_bindcnt) - bind,
>  	};
> -	struct tcf_nat_parms *parms;
>  	struct tcf_t t;
>  
> -	spin_lock_bh(&p->tcf_lock);
> -
> -	opt.action = p->tcf_action;
> +	rcu_read_lock();
>  
> -	parms = rcu_dereference_protected(p->parms, lockdep_is_held(&p->tcf_lock));
> +	parms = rcu_dereference(p->parms);
>  
> +	opt.action = parms->action;
>  	opt.old_addr = parms->old_addr;
>  	opt.new_addr = parms->new_addr;
>  	opt.mask = parms->mask;
> @@ -294,12 +293,12 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
>  	tcf_tm_dump(&t, &p->tcf_tm);
>  	if (nla_put_64bit(skb, TCA_NAT_TM, sizeof(t), &t, TCA_NAT_PAD))
>  		goto nla_put_failure;
> -	spin_unlock_bh(&p->tcf_lock);
> +	rcu_read_lock();

Hi Eric,

Should this be rcu_read_unlock()?
                        ^^

Flagged by Smatch.


>  
>  	return skb->len;
>  
>  nla_put_failure:
> -	spin_unlock_bh(&p->tcf_lock);
> +	rcu_read_unlock();
>  	nlmsg_trim(skb, b);
>  	return -1;
>  }
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

