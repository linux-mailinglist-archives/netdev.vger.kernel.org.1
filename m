Return-Path: <netdev+bounces-127136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E8974427
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C203E288166
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEB1A7074;
	Tue, 10 Sep 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FYZ/F6Fa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A4197A6B;
	Tue, 10 Sep 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000826; cv=none; b=eYTW2fWJpGjtUV+QJZBqNomil44FQRNiONzTApCbpH1fh+CURPSh4v2+WhMzSKc9RHc8gVqfBkt0uqlf0zGk5vqU0h/OFpoFhB7tuQm8+M6zN3fEzVsU07mLnFJE4Kurxel3dbt7nAgJRNgyeSPUGkj1QkPNp+mXZDjatcRjAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000826; c=relaxed/simple;
	bh=6T7SOnIsI601KN0KFoLcN/ZzSCZuK2pskDXrkO5CCWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJIS7tzPGw/rD+pfH4W7sKnMn6K1Nq8GPgArxO1qPheJZz8Ci6zKO7IAGBnkuiZ6rELYnwDRHRBMkMe1ldee2vAamoEcmPtqoyeJoPTjWIfbMFe1m9XLIlhv02/kyE1sjiX8qKDUJfoDmB63QMJuUscqGsIXLboUvz165qIAqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FYZ/F6Fa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726000824; x=1757536824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XY4SJY6vgtWRAaNWx9MgjEkq7Me3c0gkRLKGE36HnnA=;
  b=FYZ/F6FaH22P5o5Ge0hT5foSZRSzE3fR7d/gbcqowzBFDMhF7fgxrnH/
   R9q0u4sFDlhoKxGOrFoGBPH1bRvLENEX81HVfOb/586SB1xb9WmP1Ylf4
   MZL991IITs/iE8PA6XQauSI0q9CqVKRmUvpMZ+Fz/+sWF4Psfbp1mb0Zu
   U=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="329665798"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 20:40:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:19696]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id ba656067-30b6-43dd-804c-bc9ab56be096; Tue, 10 Sep 2024 20:40:22 +0000 (UTC)
X-Farcaster-Flow-ID: ba656067-30b6-43dd-804c-bc9ab56be096
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 20:40:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 20:40:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <justin.iurman@uliege.be>
CC: <aahringo@redhat.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv6: rpl: free skb
Date: Tue, 10 Sep 2024 13:40:10 -0700
Message-ID: <20240910204010.96400-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240910100032.18168-1-justin.iurman@uliege.be>
References: <20240910100032.18168-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Justin Iurman <justin.iurman@uliege.be>
Date: Tue, 10 Sep 2024 12:00:32 +0200
> Make rpl_input() free the skb before returning when skb_cow_head()
> fails. Use a "drop" label and goto instructions.
> 
> Note: if you think it should be a fix and target "net" instead, let me
> know.

Please do so.

For the future submission, this kind of note and changelog between
each revision can be placed after '---' below so that it will disappear
during merge.

> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/rpl_iptunnel.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 2c83b7586422..db3c19a42e1c 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -263,10 +263,8 @@ static int rpl_input(struct sk_buff *skb)
>  	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
>  
>  	err = rpl_do_srh(skb, rlwt);
> -	if (unlikely(err)) {
> -		kfree_skb(skb);
> -		return err;
> -	}
> +	if (unlikely(err))
> +		goto drop;
>  
>  	local_bh_disable();
>  	dst = dst_cache_get(&rlwt->cache);
> @@ -286,9 +284,13 @@ static int rpl_input(struct sk_buff *skb)
>  
>  	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
>  	if (unlikely(err))
> -		return err;
> +		goto drop;
>  
>  	return dst_input(skb);
> +
> +drop:
> +	kfree_skb(skb);
> +	return err;
>  }
>  
>  static int nla_put_rpl_srh(struct sk_buff *skb, int attrtype,
> -- 

