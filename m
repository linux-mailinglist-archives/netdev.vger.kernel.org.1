Return-Path: <netdev+bounces-89765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBC8AB801
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 01:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5482819CB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DA13D890;
	Fri, 19 Apr 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kNaa3SMo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDE2B9C5
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571053; cv=none; b=ue+dyYsbwGltmVexbk6XP4lzChbTAQ1qi+4mVVyTFvR/Te84n49AuLA6l0vTMxhpfaQbLdA+CokazY0pXBl3EIazPpll/Hra11EbcajpKPEtXx3AM8+AhuNO713jaCBkeRuQmPr5nQtgaIJmH7g3mx7qeQGlX78pJjY9uKZBe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571053; c=relaxed/simple;
	bh=7L6LPmrIoRn6UY7ouIc29C9ZHJwdObsuIDsyFOCHR3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN0ALsA+SGs6icPw7VqGKNo99vYNTW24zSaUQRm5pP/6LyODbHerLmmrwVSHfMIVX8Uz0dTVc3EecwT0wsbyQegWyk49iuRlbWiPlIY3CBk0XDSM5STRSmRQun0YMvciwC4dYxca7C81H7EXnty8QToi1gDRSJg8zdUYR5OHSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kNaa3SMo; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713571051; x=1745107051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVArf8MfVfvXv7UCcCo+yS/h+wZ3/WQ8M9erlARx+hU=;
  b=kNaa3SMo4dAnIwX+izoe5XDCjfB/HRTWl46znJWC84ZkqG47vDBwlpFk
   BeTx6ZOlkLa/iDPEBPj0Dygbv9UjTXVuqXhps9dh/7Vci2poKvYbpcr/g
   Eucf7LKOTTpkDmOMQD6uXM3k8R4WPe1f3Pkon7ZC7v4RmQZGo5rylfg99
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,215,1708387200"; 
   d="scan'208";a="82763028"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 23:57:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:1389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.230:2525] with esmtp (Farcaster)
 id 40ad0b54-3fef-4cc6-98b6-e0e3d0cc365a; Fri, 19 Apr 2024 23:57:30 +0000 (UTC)
X-Farcaster-Flow-ID: 40ad0b54-3fef-4cc6-98b6-e0e3d0cc365a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 23:57:30 +0000
Received: from 88665a182662.ant.amazon.com (10.119.231.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 19 Apr 2024 23:57:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: do not export tcp_twsk_purge()
Date: Fri, 19 Apr 2024 16:57:16 -0700
Message-ID: <20240419235716.32952-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240419071942.1870058-1-edumazet@google.com>
References: <20240419071942.1870058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 07:19:42 +0000
> After commit 1eeb50435739 ("tcp/dccp: do not care about
> families in inet_twsk_purge()") tcp_twsk_purge() is
> no longer potentially called from a module.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_minisocks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index f53c7ada2ace4219917e75f806f39a00d5ab0123..146c061145b4602082d149e65f8e6bbcf4bd311b 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -403,7 +403,6 @@ void tcp_twsk_purge(struct list_head *net_exit_list)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(tcp_twsk_purge);
>  
>  /* Warning : This function is called without sk_listener being locked.
>   * Be sure to read socket fields once, as their value could change under us.
> -- 
> 2.44.0.769.g3c40516874-goog
> 

