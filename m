Return-Path: <netdev+bounces-110905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E292EDF9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B6B20DDC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6316D9BE;
	Thu, 11 Jul 2024 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sqp0yI76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9342AB5
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719700; cv=none; b=hG3U0rOiFUqEL8Cu9RpKaHAosGfq8daHm+PBSv3HNrHnOMOfxoFen39+Mk7BRHaM9ZWliJS7jCOlo2lAz7j2oNuteUjpy42Zbr+GuY7IAYjff4cVq10snTroudqrHBb9H2dU50ViJlPXi/Oo9i1RmAaA4C7QWiGupiX4hDFWSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719700; c=relaxed/simple;
	bh=6MvoPzqV0cy8SIdODz7OzSR38E2by4yFRfeSbGFUx3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1dgEUQfZulLQfnEb7McaveB8QBfMSbsPxTyaJuAgaKnxlSTJPm4wfQwdFfzn9cmLlJdXm+WeWwIFrPcmmya0tR/g0df1bxaBnBnsuToQULKZS1P3vqBYELaU+SrYEu2vu9YEg5ew4d3NK38MBsBHFSRD64iY32WUpgcnfOrvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sqp0yI76; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720719699; x=1752255699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqKrSrlClA1kv2JkQ4QgJsWLgcOM9AMFF+TJ3I3Whds=;
  b=Sqp0yI76SlKQw6zpQsjgMwKEhTyAzUjSu/9wsYW8icY5Nrqbv1nF1uFJ
   w591LeQzkhP+6Jgkm4qogEw1Q6ZhmlKBRjxkZcMl/+iPFr5GNiv+nLQ7u
   o+YwJvDthhLCK8unC8VX9v563xxaLPrsw0ZvSLDWLhKa02ksM8Glku9rx
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,200,1716249600"; 
   d="scan'208";a="666752617"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 17:41:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:38570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.210:2525] with esmtp (Farcaster)
 id 78872bc1-630b-4f53-81d1-aa30c13b068b; Thu, 11 Jul 2024 17:41:35 +0000 (UTC)
X-Farcaster-Flow-ID: 78872bc1-630b-4f53-81d1-aa30c13b068b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 11 Jul 2024 17:41:32 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 11 Jul 2024 17:41:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <grzegorz.szpetkowski@intel.com>
CC: <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net] net: core: sock: add AF_PACKET unsupported binding error
Date: Thu, 11 Jul 2024 10:41:23 -0700
Message-ID: <20240711174123.66910-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CY5PR11MB6186C896926FDA33E99BD82081A52@CY5PR11MB6186.namprd11.prod.outlook.com>
References: <CY5PR11MB6186C896926FDA33E99BD82081A52@CY5PR11MB6186.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Szpetkowski, Grzegorz" <grzegorz.szpetkowski@intel.com>
Date: Thu, 11 Jul 2024 13:48:07 +0000
> Hi All,
> 
> Currently, when setsockopt() API with SO_BINDTODEVICE option is
> called over a raw packet socket, then although the function doesn't
> return an error, the socket is not bound to a specific interface.
> 
> The limitation itself is explicitly stated in man 7 socket, particularly
> that SO_BINDTODEVICE is "not supported for packet sockets".
> 
> The patch below is to align the API, so that it does return failure in
> case of a packet socket.

SO_XXX is generic options and can be set to any socket (except for
SO_ZEROCOPY due to MSG_ZEROCOPY, see 76851d1212c11), and whether it's
really used or not depends on each socket implementation.

Otherwise, we need this kind of change for all socket options and
families.


> 
> Signed-off-by: Grzegorz Szpetkowski grzegorz.szpetkowski@intel.com
> ---
>  net/core/sock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 100e975073ca..1b77241ac1f7 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -639,6 +639,11 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
>  	if (ifindex < 0)
>  		goto out;
>  
> +	/* Not supported for packet sockets, use bind() instead */
> +	ret = -EOPNOTSUPP;
> +	if (sk->sk_family == PF_PACKET)
> +		goto out;
> +
>  	/* Paired with all READ_ONCE() done locklessly. */
>  	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
>  
> -- 
> 2.39.2

