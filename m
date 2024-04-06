Return-Path: <netdev+bounces-85418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F279F89AB67
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6533D2823C7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233871CFB9;
	Sat,  6 Apr 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWk9bVZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032713ACC
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414702; cv=none; b=I8wfgFZXAc90KgBo6cTmt3gLM4P37hA1HeQBaoqZP8LZQ38+ER4zOVqzKCySokOYeYRoToOUZd1wJ/vPKU8D3/nEGZxTmmLHfALVEZX/E0Fd03cj/v7CTd6sfklJ4DDvm5//ZuQSXGfWccMjYPp7UhzPDn8Anmy9TVNJXZFGsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414702; c=relaxed/simple;
	bh=SHSnlPgLtuiSqTeBHQBQ+U/PulAsE8lDBOb6021vvwo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TzRubHH3khUrhjZaW/M9/6BcoWKUxj1uGEi4boUSfFWiUFepJOfhfFx+eG8TEEbf+vrwbgWglRIfxaOrWOe/Uj3uzp51GSKNs3GZReFgPIK/ZXvtJm8EP2j4GqFRz66IJOADozQwGSqzN+uKrh5O8CstafM/meZEAKWPaMzYZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWk9bVZu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78d496add91so96158285a.2
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712414699; x=1713019499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyHJzWTuN63brgWLk8PDjilIZS3b1K3f43CN718upBA=;
        b=cWk9bVZujaW7hhX/GGbNR6+Mqcff4yyAsfN3h305Yfoh2vjCdfw59DPXTvTtklo1dp
         22APecBQZUUSDJcf4spftClaBSaqfl5KpzoDu0JzhBzmdSUx1Rd1bjn19iEC7imXk4cz
         fsM0mvrpaZa0H9X5q/XNyPCV5ZsD11u3r0RhZFZMtriGfuz5uTWwKhEvDLVcUwAlqxJT
         1jxrPo2Q1g3AE50twNERbPMm0z/Va6o72UHzx0kEwDEj3zTK0MmD1ebTwlvuKxbnUm8z
         y3TfIJJZzTWg6nofRMzLWU3a0PiYESIrMYkzTRJZ0WgJpH2546kvYtiwm7NwzYA8Hcs5
         BsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712414699; x=1713019499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyHJzWTuN63brgWLk8PDjilIZS3b1K3f43CN718upBA=;
        b=JXTPrKMvUZNo5EQf+tIZQSzNDzVp451J48pgWwrZmItTI6VdNHvxiqlgw2/TZIXLDn
         7/iIV9N+Q0gKxkWCBoOApikDTzZ1aSaelP79SdStEUoHyvN/fD3xRpRWiMWwVZEEzwr2
         OytWy3vKR65AnlEgIVwqrxE7Yi6YS0B8KQwvWLBLHB2VJQedmNoN/Z70hDeo4Zg0B7cI
         5JgbdY6mDHB5i0hMl7t66oAEBuWH93nV22wuQ0y0p3hXTkwb2cGyFNSReTnFYrVl1CBH
         vdNsRqKIJRJ/W2JNQIAzEjIuQP45MmCzjUifn0mKVpPBkC596C9xXxOvNWNtBc+VZx1H
         SFPw==
X-Gm-Message-State: AOJu0YwHCWyW34FwkaNRqzeOvQ1ob0/7Kr7igc648wML0VzGc0CKIndJ
	hEX9EuO5GPjkD2NbJMG4Fn+wzTdXBj4tnoxj6v9eeVR6PIOPw/Af
X-Google-Smtp-Source: AGHT+IHb+yPAt6QRmTLYovQ2gs1mmwEkwDLtgOmqLKu54D/ISqalSgCROjKsY1bnMZ+Ltc5MnTT5xw==
X-Received: by 2002:ae9:f101:0:b0:78a:5fe4:6128 with SMTP id k1-20020ae9f101000000b0078a5fe46128mr4020571qkg.76.1712414699208;
        Sat, 06 Apr 2024 07:44:59 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id g17-20020a05620a40d100b0078bd8d2b272sm1523093qko.123.2024.04.06.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 07:44:58 -0700 (PDT)
Date: Sat, 06 Apr 2024 10:44:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 martin.lau@kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 Lorenz Bauer <lmb@isovalent.com>
Message-ID: <66115fea712ed_16bd4c294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240404211111.30493-1-krisman@suse.de>
References: <20240404211111.30493-1-krisman@suse.de>
Subject: Re: [PATCH] udp: Avoid call to compute_score on multiple sites
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gabriel Krisman Bertazi wrote:
> We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> sockets are present").  The failing tests were those that would spawn
> UDP sockets per-cpu on systems that have a high number of cpus.
> 
> Unsurprisingly, it is not caused by the extra re-scoring of the reused
> socket, but due to the compiler no longer inlining compute_score, once
> it has the extra call site in upd5_lib_lookup2.  This is augmented by

udp4_lib_lookup2

> the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> 
> We could just explicitly inline it, but compute_score() is quite a large
> function, around 300b.  Inlining in two sites would almost double
> udp4_lib_lookup2, which is a silly thing to do just to workaround a
> mitigation.  Instead, this patch shuffles the code a bit to avoid the
> multiple calls to compute_score.  Since it is a static function used in
> one spot, the compiler can safely fold it in, as it did before, without
> increasing the text size.
> 
> With this patch applied I ran my original iperf3 testcases.  The failing
> cases all looked like this (ipv4):
> 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2 2>&1
> 
> where $R is either 1G/10G/0 (max, unlimited).  I ran 5 times each.
> baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> tree. harmean == harmonic mean; CV == coefficient of variation.
> 
> ipv4:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline 1726716.59(0.0401) 1751758.50(0.0068) 1425388.83(0.1276)
> patched  1842337.77(0.0711) 1861574.00(0.0774) 1888601.95(0.0580)
> 
> ipv6:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline: 1693636.28(0.0132) 1704418.23(0.0094) 1519681.83(0.1299)
> patched   1909754.24(0.0307) 1782295.80(0.0539) 1632803.48(0.1185)
> 
> This restores the performance we had before the change above with this
> benchmark.  We obviously don't expect any real impact when mitigations
> are disabled, but just to be sure it also doesn't regresses:
> 
> mitigations=off ipv4:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
> patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
> 
> Finally, I can see this restores compute_score inlining in my gcc
> without extra function attributes. Out of caution, I still added
> __always_inline in compute_score, to prevent future changes from
> un-inlining it again.  Since it is only in one site, it should be fine.
> 
> Cc: Lorenz Bauer <lmb@isovalent.com>
> Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> ---
> Another idea would be shrinking compute_score and then inlining it.  I'm
> not a network developer, but it seems that we can avoid most of the
> "same network" checks of calculate_score when passing a socket from the
> reusegroup.  If that is the case, we can fork out a compute_score_fast
> that can be safely inlined at the second call site of the existing
> compute_score.  I didn't pursue this any further.
> ---
>  net/ipv4/udp.c | 24 ++++++++++++++++++------
>  net/ipv6/udp.c | 23 ++++++++++++++++++-----
>  2 files changed, 36 insertions(+), 11 deletions(-)
> 

> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 7c1e6469d091..883e62228432 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -114,7 +114,11 @@ void udp_v6_rehash(struct sock *sk)
>  	udp_lib_rehash(sk, new_hash);
>  }
>  
> -static int compute_score(struct sock *sk, struct net *net,
> +/* While large, compute_score is in the UDP hot path and only used once
> + * in udp4_lib_lookup2. Avoiding the function call by inlining it has

udp6_lib_lookup2

> + * yield measurable benefits in iperf3-based benchmarks.
> + */
> +static __always_inline int compute_score(struct sock *sk, struct net *net,
>  			 const struct in6_addr *saddr, __be16 sport,
>  			 const struct in6_addr *daddr, unsigned short hnum,
>  			 int dif, int sdif)
> @@ -166,16 +170,20 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  		int dif, int sdif, struct udp_hslot *hslot2,
>  		struct sk_buff *skb)
>  {
> -	struct sock *sk, *result;
> +	struct sock *sk, *result, *this;
>  	int score, badness;
>  
>  	result = NULL;
>  	badness = -1;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -		score = compute_score(sk, net, saddr, sport,
> +		this = sk;
> +rescore:
> +		score = compute_score(this, net, saddr, sport,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
>  			badness = score;
> +			if (this != sk)
> +				continue;

Can we just rely on screo not increasing indefinitely on retry
to break out of the loop.

Or, if an explicit "this is a rescore" boolean is needed, a boolean
makes the control flow easier to follow than a third struct sk.

>  
>  			if (sk->sk_state == TCP_ESTABLISHED) {
>  				result = sk;
> @@ -197,8 +205,13 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  			if (IS_ERR(result))
>  				continue;
>  
> -			badness = compute_score(sk, net, saddr, sport,
> -						daddr, hnum, dif, sdif);
> +			/* compute_score is too long of a function to be
> +			 * inlined, and calling it again yields
> +			 * measureable overhead. Work around it by
> +			 * jumping backwards to score 'result'.
> +			 */
> +			this = result;
> +			goto rescore;
>  		}
>  	}
>  	return result;
> -- 
> 2.44.0
> 

