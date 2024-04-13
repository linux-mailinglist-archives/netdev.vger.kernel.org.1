Return-Path: <netdev+bounces-87567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFD8A3A18
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 03:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAFAB20EA6
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D54A33;
	Sat, 13 Apr 2024 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A+VnxO1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F017C68
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971557; cv=none; b=bKKPyqKdEO8gyDYxQpcwe9wEnvh6tOQ+etgMRCeFJ6ylCEpIEGvHZHOj5KabzHiLFYxDfvyPxB3vgZrcnVqb+JAoIev1P+/V1mjz6E+1SNPG1sNJWzV3srXIpVjfJBqkR9EA2W62VWWkhgVYYttK8xxmmra92xtYHeUznAM3EQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971557; c=relaxed/simple;
	bh=nLEgaK4nVCnQWZVFmuVrMyyzF+oAJDNMKVwDrfL3fBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZfxskAZiA2d9cO+gFm4HG56IglogwyCQZzJ2LHkfhaooSQssUd6uHhvMMTA7SU51wz5PF6imQXni7bJM+PqkEtIZOMDV1j9ZMPH8SpIDQh5V7rAPULH9E6xn2Y1euUcw4GIVbkXKsfgBnWZVJjsi/n+b48sjTwn8PbR+RxAPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A+VnxO1n; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712971556; x=1744507556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rw/yxkM2MHnlmCxVNO4N010i4b27pLReASIUKGMRRBM=;
  b=A+VnxO1nIrR7C7UUAhe3+xCyjckvFFgsrkMTd+gYNJXgChdtwFoCQ1I8
   gDwF5bBBsa3LjJJSllpG62Mj0QzdG+n9CMJT0CO5Pl1I3NZVXRer/MkGx
   AAvHTqPaYEPlaypQBCyBDjOWijOLfLNZxRHlL8LCJ0WNj/FJOQtj6a8U0
   c=;
X-IronPort-AV: E=Sophos;i="6.07,197,1708387200"; 
   d="scan'208";a="626181665"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 01:25:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:15570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.40:2525] with esmtp (Farcaster)
 id e956ca2d-0c18-4fa8-877b-d57dd6ed16da; Sat, 13 Apr 2024 01:25:52 +0000 (UTC)
X-Farcaster-Flow-ID: e956ca2d-0c18-4fa8-877b-d57dd6ed16da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 13 Apr 2024 01:25:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 13 Apr 2024 01:25:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <krisman@suse.de>
CC: <davem@davemloft.net>, <kuniyu@amazon.com>, <lmb@isovalent.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3] udp: Avoid call to compute_score on multiple sites
Date: Fri, 12 Apr 2024 18:25:39 -0700
Message-ID: <20240413012539.16180-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240412212004.17181-1-krisman@suse.de>
References: <20240412212004.17181-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gabriel Krisman Bertazi <krisman@suse.de>
Date: Fri, 12 Apr 2024 17:20:04 -0400
> We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> sockets are present").  The failing tests were those that would spawn
> UDP sockets per-cpu on systems that have a high number of cpus.
> 
> Unsurprisingly, it is not caused by the extra re-scoring of the reused
> socket, but due to the compiler no longer inlining compute_score, once
> it has the extra call site in udp4_lib_lookup2.  This is augmented by
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
> 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
> 
> where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
> baseline is v6.9-rc3. harmean == harmonic mean; CV == coefficient of
> variation.
> 
> ipv4:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline 1743852.66(0.0208) 1725933.02(0.0167) 1705203.78(0.0386)
> patched  1968727.61(0.0035) 1962283.22(0.0195) 1923853.50(0.0256)
> 
> ipv6:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline 1729020.03(0.0028) 1691704.49(0.0243) 1692251.34(0.0083)
> patched  1900422.19(0.0067) 1900968.01(0.0067) 1568532.72(0.1519)
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
> Cc: Lorenz Bauer <lmb@isovalent.com>
> Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

> 
> ---
> Changes since v2:
> (me)
>   - recollected performance data after changes below only for the
>   mitigations=auto case.
> (suggested by Willem de Bruijn)
>   - Explicitly continue the loop after a rescore
>   - rename rescore variable to not clash with jump label
>   - disable rescore for new loop iteration
> (suggested by Kuniyuki Iwashima)
>   - sort stack variables
>   - drop unneeded ()
> 
> Changes since v1:
> (me)
>   - recollected performance data after changes below only for the
>   mitigations enabled case.
> (suggested by Willem de Bruijn)
>   - Drop __always_inline in compute_score
>   - Simplify logic by replacing third struct sock pointer with bool
>   - Fix typo in commit message
>   - Don't explicitly break out of loop after rescore
> ---
>  net/ipv4/udp.c | 21 ++++++++++++++++-----
>  net/ipv6/udp.c | 20 ++++++++++++++++----
>  2 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c02bf011d4a6..4eff1e145c63 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -427,15 +427,21 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  {
>  	struct sock *sk, *result;
>  	int score, badness;
> +	bool need_rescore;
>  
>  	result = NULL;
>  	badness = 0;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -		score = compute_score(sk, net, saddr, sport,
> -				      daddr, hnum, dif, sdif);
> +		need_rescore = false;
> +rescore:
> +		score = compute_score(need_rescore ? result : sk, net, saddr,
> +				      sport, daddr, hnum, dif, sdif);
>  		if (score > badness) {
>  			badness = score;
>  
> +			if (need_rescore)
> +				continue;
> +
>  			if (sk->sk_state == TCP_ESTABLISHED) {
>  				result = sk;
>  				continue;
> @@ -456,9 +462,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  			if (IS_ERR(result))
>  				continue;
>  
> -			badness = compute_score(result, net, saddr, sport,
> -						daddr, hnum, dif, sdif);
> -
> +			/* compute_score is too long of a function to be
> +			 * inlined, and calling it again here yields
> +			 * measureable overhead for some
> +			 * workloads. Work around it by jumping
> +			 * backwards to rescore 'result'.
> +			 */
> +			need_rescore = true;
> +			goto rescore;
>  		}
>  	}
>  	return result;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 8b1dd7f51249..e80e8b1d2000 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -168,15 +168,21 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  {
>  	struct sock *sk, *result;
>  	int score, badness;
> +	bool need_rescore;
>  
>  	result = NULL;
>  	badness = -1;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -		score = compute_score(sk, net, saddr, sport,
> -				      daddr, hnum, dif, sdif);
> +		need_rescore = false;
> +rescore:
> +		score = compute_score(need_rescore ? result : sk, net, saddr,
> +				      sport, daddr, hnum, dif, sdif);
>  		if (score > badness) {
>  			badness = score;
>  
> +			if (need_rescore)
> +				continue;
> +
>  			if (sk->sk_state == TCP_ESTABLISHED) {
>  				result = sk;
>  				continue;
> @@ -197,8 +203,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  			if (IS_ERR(result))
>  				continue;
>  
> -			badness = compute_score(sk, net, saddr, sport,
> -						daddr, hnum, dif, sdif);
> +			/* compute_score is too long of a function to be
> +			 * inlined, and calling it again here yields
> +			 * measureable overhead for some
> +			 * workloads. Work around it by jumping
> +			 * backwards to rescore 'result'.
> +			 */
> +			need_rescore = true;
> +			goto rescore;
>  		}
>  	}
>  	return result;
> -- 
> 2.44.0

