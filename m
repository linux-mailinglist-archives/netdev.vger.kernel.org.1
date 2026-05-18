Return-Path: <netdev+bounces-289067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGkUObgRC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:18:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CE56D7E2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE49D30CAF78
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC12480DE9;
	Mon, 18 May 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSctSz/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BF480DDF
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109833; cv=none; b=L6kMng7a8bOWfCjOuajFLalZJypPJyRaHwO8f+FPHgQvPIyYjyewE1U08BsBgDdRhrW23A1LYZ0F6so1Wofr4th3qEiBfXlB8+pUXml8mVy/4L/Xrn7aaDCjakmWbOaUjowdQtFSyyv+YUeyqjZ6eGYOviq8VIxivRS9Cs17K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109833; c=relaxed/simple;
	bh=bdpvLG+gFY9h4p1lC6abxDav9L9x4QA4XU5mkXfwVNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUJrDA982OGDAgjVFlD3jfRLZap659wTfA1IvB23CG7x1IHw3jrwd1avDSHAhkovRAkaf5mTwiS2f81/GS7SvVpKRbEQBXP62uq8moBVfEJmGW9iLmq40TtXQKtVxN4f+H9VDdo3CjYFcA7k8SFg5IVyLJO+nxTCFDDqL1hyIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSctSz/N; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-135200bc7d2so5915364c88.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109830; x=1779714630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvfojoDUhq19W6xSdTJNJ21UPmBlnLqe7fWJcFFdjuI=;
        b=dSctSz/NUUNRfd/vry+QRcrqSAFbH5aj6w/TyxKGXVsa5vCjPPZ0Gk2GhMJ2ATG2os
         LYC3eyeEVfmZ0VYDkmuggnOzYKpyLXmEs3aSPr3RBVdVacBPRPffxfHifshXMh1NCgda
         TzT7Ul2KjsbvgA12L9Sw6CjiFZsIR/OA1rhWWuIA94vFn4AMgp837XyHzRIS2tTFsVCL
         Q0cD4X/8z5eGcQ1Q+ghwsQGAjPWkZTRqGCqYlddr7uFT9kUKoqW3rpDIXsJ7h/yPiT0+
         Ct1oW2j0DoMAS8Xitd6i3qbgc3LWsV54PE3m1JTQwJjo0YjrwdG1Vx/Q3p7JGlYugOFT
         7Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109830; x=1779714630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvfojoDUhq19W6xSdTJNJ21UPmBlnLqe7fWJcFFdjuI=;
        b=FlCY5ctOHgi8HHmvOw3kRi7uenKn5+jSIYvwrf71+PODJCArV9BVJAh/Gp6k+uJ/OI
         cYO2nwOhNYMZXfqwLkH+LuHJ8e4riJjvR/zzY25jQZAg+iXCN7hpAaoIs0gD44yQBauu
         U1N+HxcOkHaag4xaL2ESrXfPsJZW/LqQwD3TyPluEm7fBzz8dtJXJSR/SzxgXyvY6vmk
         6/SCvmUzpwLrlqFXHiovRzrW5riZCuYIi0ez5nLO1xasI5E4FOrTTr851XsuYYllz2OY
         SvCtmfRH/YbRbS0cI7aTtak4sxsYJFPCwh6ezYSwlFP/GywF0vCjsnNWbvsn2/4WGuAg
         AqwA==
X-Forwarded-Encrypted: i=1; AFNElJ/rIW9cvq1TGg7j4vc/Ab7yM9kwmDM5wgYhLvNx+i0EnO+VeV8HgixzgH/cRIgZVGjlzdHNqMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Q6nCyd+d7/sg97t9YXS2rmRADAqknDysOa7makklq+FL3XyW
	GN/6QG2IE3rWwgrkz5290uYgbeZi8zgbSj/c1FSb8L9LQzY+kP/7osxD
X-Gm-Gg: Acq92OGVPTcLZCNqwAbiJrFqWLCg0JYSlgxEFJH5GqdBGklRU5I7QvKekRq5cm4dor2
	08u9oKYmsn3DaTgXt5afIjPpWeW+O7JICtmcvGSmt8i47E50xz5pi+PIRtwhwQkkkcQrdFBv8dh
	JcXn+266bUHFMCbyiVIFKPNGPEHOp8OJcfHTS10whz7pBDLeimgoMM3CBAN+Uf37xy8C97npUDt
	hG2u0eiF6Tu6a321QuBraCN2UFVg0utkgKd/oT4qFYlA6qxOB2BjTqxEzu447XKZZo2KaeT365O
	lUqiFHAA698jfSZIHiF8MiCWqOduviSC4vMiWkIAwS+yP3lPCuq2B/xWvWkx15r6EWIMKXnCW0g
	QwkO59EFs7KN34fYHqtDwW0W8+u7vg0x1qRFsCwokqxB058KZocDlMY+oM5jcIl8QG+/OXRVdLo
	LJeijxYeGMttfwSF2CkhZxd10ECGKxm8Q+Lam5gsJGl/DoGw==
X-Received: by 2002:a05:7022:fb09:b0:12a:72af:83d1 with SMTP id a92af1059eb24-135046255femr7029013c88.11.1779109829980;
        Mon, 18 May 2026 06:10:29 -0700 (PDT)
Received: from 2045L.localdomain ([172.58.118.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm20759822c88.3.2026.05.18.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:10:29 -0700 (PDT)
From: Han Guidong <2045gemini@gmail.com>
To: rajat.gupta@oss.qualcomm.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Han Guidong <2045gemini@gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page cache
Date: Mon, 18 May 2026 21:10:03 +0800
Message-ID: <20260518131003.108757-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <604ca54c-a94e-4ca4-83e7-4486d7392d71@oss.qualcomm.com>
References: <604ca54c-a94e-4ca4-83e7-4486d7392d71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 616CE56D7E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-289067-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mojatatu.com:email]
X-Rspamd-Action: no action

(Resending to fix broken email threading. Sorry for the noise!)

On Sun, May 17, 2026 at 06:30:31PM -0700, Rajat Gupta wrote:
> >From f12ea6484dbb75d1c13495e921d0595532317f2a Mon Sep 17 00:00:00 2001
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Date: Sun, 17 May 2026 10:11:44 -0700
> Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cache
>  corruption
> 
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
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Solid fix. Linearizing shared frags and dynamic COW checks completely
resolve the offset drift and page cache corruption. Verified locally.

Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>

> ---
>  net/sched/act_pedit.c | 52 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2..e077a2e82 100644
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
>  
>  	return true;
>  }
> @@ -393,17 +396,19 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
> +	/* If the skb has shared frags the user is likely using zero-copy
> +	 * (e.g. sendfile).  Those page frags may point to page-cache pages;
> +	 * writing into them would silently corrupt the page cache.
> +	 * Linearize so pedit operates on a private copy.
> +	 * If you want zero-copy, don't use pedit. 
> +	  TL;DR if you want to use ZC, don't use pedit*/
> +	if (skb_has_shared_frag(skb)) {
> +		if (__skb_linearize(skb))
> +			goto bad;
> +	}
>  
>  	tcf_lastuse_update(&p->tcf_tm);
>  	tcf_action_update_bstats(&p->common, skb);
> @@ -414,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
>  		int offset = tkey->off;
>  		int hoffset = 0;
> +		int write_offset, write_len;
>  		u32 *ptr, hdata;
>  		u32 val;
>  		int rc;
> @@ -451,12 +457,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
> @@ -475,7 +501,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>  
>  		*ptr = ((*ptr & tkey->mask) ^ val);
>  		if (ptr == &hdata)
> -			skb_store_bits(skb, hoffset + offset, ptr, 4);
> +			skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
>  	}
>  
>  	goto done;
> -- 
> 2.51.2.windows.1
> 
> Thank you,
> Rajat

