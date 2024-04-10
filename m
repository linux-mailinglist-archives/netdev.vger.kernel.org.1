Return-Path: <netdev+bounces-86758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5578B8A02FF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20351F23364
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7A184102;
	Wed, 10 Apr 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JPeoTgcS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4416D4FC
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787196; cv=none; b=r4XnzfVHjJgSQxeihlnVn/ONirJLErZQkvNFvs4r+daUhhqdbjrhyRMJRktZSO2L1kWkPk7zh1Y2GO1z1ZbxH1B855acgP1BcQxchAtOYQaJuZWngT1MzztYNFE6xUqBaFj3R6b8TX3DqMas5BKqOBF1t2+OOPR0+ofk6o3Uy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787196; c=relaxed/simple;
	bh=337PoNy5hHXi/nBtubQGpqzHN+7XoK2mpmWg0n1Xpto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOtZJpZu8EU+WMEouw2d2s4SFG+OFOlcoK/eULvzp1H1SvOAR3SQYFXkq7FbKBtImSPDoPvKokJiD8wzXg+XPX4iZ93rMZ79b3N51FuhePX9BeJkRxa1+GztUe00+4HvfZ2xVU+uF0Z1sz0wX64hHUoyhJmjeRXqYMBoRwnEqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JPeoTgcS; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712787195; x=1744323195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmJlHtyCaojXycyHhl57A6ON5T4AIb8dBCbBDEzRK60=;
  b=JPeoTgcSsDrEjJo+bZq65ddVnAjyhrs8Z3zgrSWdA38g8zerYucrDE+x
   vPVzWjC9mSO8KxS6pEQqDpr2XywX9rswhd9VGfQ4MlLHcCSIk2IlYNqDT
   cwYnrz+eRVJDcfpkk1bHa2ONlAlMV4Gtzimb1PxioUqy7yGElD3I0o5+W
   c=;
X-IronPort-AV: E=Sophos;i="6.07,191,1708387200"; 
   d="scan'208";a="287754973"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:13:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:30600]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.203:2525] with esmtp (Farcaster)
 id 55995940-58b8-4c29-86d9-3757c3f49946; Wed, 10 Apr 2024 22:13:12 +0000 (UTC)
X-Farcaster-Flow-ID: 55995940-58b8-4c29-86d9-3757c3f49946
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 22:13:12 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 10 Apr 2024 22:13:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <krisman@suse.de>
CC: <davem@davemloft.net>, <lmb@isovalent.com>, <martin.lau@kernel.org>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
Date: Wed, 10 Apr 2024 15:13:01 -0700
Message-ID: <20240410221301.44576-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240410215047.21462-1-krisman@suse.de>
References: <20240410215047.21462-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gabriel Krisman Bertazi <krisman@suse.de>
Date: Wed, 10 Apr 2024 17:50:47 -0400
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
> baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
> tree. harmean == harmonic mean; CV == coefficient of variation.
> 
> ipv4:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
> patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
> 
> ipv6:
>                  1G                10G                  MAX
> 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
> baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
> patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
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
> 
> ---
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
>  net/ipv4/udp.c | 18 +++++++++++++-----
>  net/ipv6/udp.c | 17 +++++++++++++----
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 661d0e0d273f..a13ef8e06093 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  {
>  	struct sock *sk, *result;
>  	int score, badness;
> +	bool rescore = false;

nit: Keep reverse xmax tree order.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  
>  	result = NULL;
>  	badness = 0;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -		score = compute_score(sk, net, saddr, sport,
> -				      daddr, hnum, dif, sdif);
> +rescore:
> +		score = compute_score((rescore ? result : sk), net, saddr,

I guess () is not needed around rescore ?

Both same for IPv6.

Otherwise, looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> +				      sport, daddr, hnum, dif, sdif);
> +		rescore = false;
>  		if (score > badness) {
>  			badness = score;
>  
> @@ -456,9 +459,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
> +			rescore = true;
> +			goto rescore;
>  		}
>  	}
>  	return result;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 7c1e6469d091..7a55c050de2b 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -168,12 +168,15 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  {
>  	struct sock *sk, *result;
>  	int score, badness;
> +	bool rescore = false;
>  
>  	result = NULL;
>  	badness = -1;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -		score = compute_score(sk, net, saddr, sport,
> -				      daddr, hnum, dif, sdif);
> +rescore:
> +		score = compute_score((rescore ? result : sk), net, saddr,
> +				      sport, daddr, hnum, dif, sdif);
> +		rescore = false;
>  		if (score > badness) {
>  			badness = score;
>  
> @@ -197,8 +200,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
> +			rescore = true;
> +			goto rescore;
>  		}
>  	}
>  	return result;
> -- 
> 2.44.0


