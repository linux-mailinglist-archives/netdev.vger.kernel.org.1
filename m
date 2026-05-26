Return-Path: <netdev+bounces-291634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKaVHrZvFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:02:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A05D3DF2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19078301AF15
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A93BB136;
	Tue, 26 May 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJt1TenG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578130C371
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789191; cv=none; b=eDVMig/J7dl4899T68Uncn6eQ1F/dbQnMFSGCGr+r9uRooYqjMJnN0gUzo5e/YiUW5rF9cSA8jYRRcyWCH++et8nv+WEH3c8qe8Yxvj0Jq13TP7gtuVipoTdQxbimWM9Jq2kHV0CRMs3rjkcbPOOlBurh5maXnYMV19zgxh+/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789191; c=relaxed/simple;
	bh=70ynDi2L3uscEQfoDluDgZl8oK3oxEsA5cZPdxPoUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC53BCN7FW1aB6+LlYLJco037rePxyRNuEOhqIz7a0LyRw3ka/QOpBbo4GkD/Qd0O55irvS+BloVla1IWdjpnOAMjy3ksCCpzjqMyNwLKMZK4HE0SqywQuYmgzNKfG2rpPFxF1meBXYKl3swc+tzqnBiNyBny5C09XvY8FwpWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJt1TenG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe62837baso6047512f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779789188; x=1780393988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv50VYILycxc0uUmsVq37bo7/xzHtJZ9rbhp1QhjG7Q=;
        b=KJt1TenG6FQxFJQRdUblqrLwpRcPLDHGfBlc415GJot7I6DD1AFiJzW024r0n5mb0p
         BdF8rg2ZLA2KYpsDrstJYPZegNKKsTTUSh+7GxBGHuvKfUuQIxvcPyPk+/xyczJQd0s3
         4Mpfdw4534qKRPoK0MrV0rEjO/vR5ubetQMd6oAseSmNRta78YNAsvJgLGhTIU3UY6/d
         /cdzbZJqzPYCqXLXG6/CAJoi6NeQT5PZWvzIPCXgPpHC+MmOOR6j3nOh+2IgLGh4UoBD
         29AfOs4NPuxqCsDXuhhfgygsBu3PhSTOP1x+MCTTKC0/+3PWIiXe8IHs83Q3cvJQgBwW
         S0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779789188; x=1780393988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lv50VYILycxc0uUmsVq37bo7/xzHtJZ9rbhp1QhjG7Q=;
        b=mc7mjDfzmFdbldEYBQFI+yU23eNuApySRHoOSD09KCmQdYa5IMMHkfxw1h4QDuxGj6
         NlI7vziBHaOFP7RaLq9Ko1GFlVaFaKl8chV1pQpjhsX9uDi0oSiYuhoEOhGxKtNj8mR/
         eUUY7v19+27OxAP1w/AwZO0iMqJr8pOVNXZlxEgqcz+lQeHz7UoYlPvjqrUl+Z5Zlvsl
         EbsJVTaExh1NG/R2bb0uoHuKXcjSL3aEQ0yc5rDgJ9zNfO6SaW9YzdVV6fg8DV5miMDd
         D2x3wHzOurQrGJGQlra4FGgAshyiNMNmm8ylVaHabF1CSGBY/PPnGR2bzfQwrW5f8K6W
         +Ujw==
X-Gm-Message-State: AOJu0YzOPfBlSd8S9W6qEjOMk582lo+RR6lwrapKiNJ9DMiY27a8uFPQ
	SgDyiunOzJgQ79+xfQVGBIIcoj6iwUZ5UjwPhQUvzmGsLwv3gsfsb6Mr
X-Gm-Gg: Acq92OHy5vCoaiHGun6ojrfdZjpx/YpO3yS1NfxTVM6ghSPwk6YnWWkSkbbToJuiC8k
	ckHMs7y1KM0i3gg7GeCaUjrqsWQ4XjompuUC/hmoyxI9m9CwsHUJI9iXP4UlNIb1XSsqICpW8yh
	ju+fnK+aoMyh8gFRqSoiBZNind+NKOYlAOz5EZi2kS0hAPt3xSkh6bnb6ROfAskHC626USsgYWq
	pHGMJIXG5TwhS0llf4uIGTsgsShV+3m+Yv+KWpLwOxf4Evd5qFTPnEXMrd0CCGtKAV/WGULiH8X
	/ArI7cG2V1uXtw1gRiUdl+5Z5gAQn8RBm4tkrUi5U19Ji5Hg9io9Jg8rJIpGJw9kJAs/ttWmhfP
	mWXlP/6qY9rv76d52rl31JII3GpLmME5ibJP5sZfl/bxwYRytK3LHcsXs4EGtnllg8u8CUf5EK7
	dIfXvhTV/xsVajiTyqxAPzyaTmPFgkFEFdYvbZyAfgJ/XKYQljEL2UHTVIm5H9+JEfjW5K3GGgb
	ts=
X-Received: by 2002:a05:6000:2603:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-45eb3af632emr27729099f8f.39.1779789188096;
        Tue, 26 May 2026 02:53:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm35022992f8f.8.2026.05.26.02.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:53:07 -0700 (PDT)
Date: Tue, 26 May 2026 10:53:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260526105306.48a2bee7@pumpkin>
In-Reply-To: <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291634-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 871A05D3DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 20:39:50 -0700
Rajat Gupta <rajat.gupta@oss.qualcomm.com> wrote:

> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
> 
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
> 
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
> 
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
>  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2..79921b8d8 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -16,6 +16,7 @@
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
>  #include <linux/slab.h>
> +#include <linux/overflow.h>
>  #include <net/ipv6.h>
>  #include <net/netlink.h>
>  #include <net/pkt_sched.h>
> @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int offset)
>  	if (offset > 0 && offset > skb->len)
>  		return false;
>  
> -	if  (offset < 0 && -offset > skb_headroom(skb))
> -		return false;
> +	if (offset < 0) {
> +		if (offset == INT_MIN || -offset > skb_headroom(skb))
> +			return false;
> +	}

Can't you negate skb_headroom() instead - that cannot be INT_MIN.
So:
	if (offset < 0 && offset < -skb_headroom(skb))

>  
>  	return true;
>  }
> @@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  	struct tcf_pedit_key_ex *tkey_ex;
>  	struct tcf_pedit_parms *parms;
>  	struct tc_pedit_key *tkey;
> -	u32 max_offset;
>  	int i;
>  
>  	parms = rcu_dereference_bh(p->parms);
>  
> -	max_offset = (skb_transport_header_was_set(skb) ?
> -		      skb_transport_offset(skb) :
> -		      skb_network_offset(skb)) +
> -		     parms->tcfp_off_max_hint;
> -	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> -		goto done;
> +	/*
> +	 * If the skb has shared frags the user is likely using zero-copy
> +	 * (e.g. sendfile).  Those page frags may point to page-cache pages;
> +	 * writing into them would silently corrupt the page cache.
> +	 * Linearize so pedit operates on a private copy.
> +	 * TL;DR: if you want zero-copy, don't use pedit.
> +	 */
> +	if (skb_has_shared_frag(skb)) {
> +		if (__skb_linearize(skb))
> +			goto bad;
> +	}

Should there be a way of 'unsharing' frags by just copying the frags
rather than doing a full linearize?
That would be much less likely to fail for big skb.

-- David

>  
>  	tcf_lastuse_update(&p->tcf_tm);
>  	tcf_action_update_bstats(&p->common, skb);
> @@ -412,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  	tkey_ex = parms->tcfp_keys_ex;
>  
>  	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
> +		int write_offset, write_len;
>  		int offset = tkey->off;
>  		int hoffset = 0;
>  		u32 *ptr, hdata;
> @@ -451,12 +459,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  			}
>  		}
>  
> -		if (!offset_valid(skb, hoffset + offset)) {
> -			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
> +		if (unlikely(check_add_overflow(hoffset, offset,
> +						&write_offset))) {
> +			pr_info_ratelimited("tc action pedit offset overflow\n");
> +			goto bad;
> +		}
> +
> +		if (!offset_valid(skb, write_offset)) {
> +			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
> +					    write_offset);
>  			goto bad;
>  		}
>  
> -		ptr = skb_header_pointer(skb, hoffset + offset,
> +		if (write_offset < 0) {
> +			if (skb_cow(skb, -write_offset))
> +				goto bad;
> +		} else {
> +			if (unlikely(check_add_overflow(write_offset,
> +							(int)sizeof(hdata),
> +							&write_len)))
> +				goto bad;
> +			if (skb_ensure_writable(skb, min_t(int, skb->len,
> +							   write_len)))
> +				goto bad;
> +		}
> +
> +		ptr = skb_header_pointer(skb, write_offset,
>  					 sizeof(hdata), &hdata);
>  		if (!ptr)
>  			goto bad;
> @@ -475,7 +503,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  
>  		*ptr = ((*ptr & tkey->mask) ^ val);
>  		if (ptr == &hdata)
> -			skb_store_bits(skb, hoffset + offset, ptr, 4);
> +			skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
>  	}
>  
>  	goto done;


