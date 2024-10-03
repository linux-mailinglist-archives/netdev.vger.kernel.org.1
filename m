Return-Path: <netdev+bounces-131794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8017798F99C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A230B22C34
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0311CCB44;
	Thu,  3 Oct 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LDteMsVV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304B1CCED6
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993424; cv=none; b=LY3Cm0W3QELERV5rnHwsdNMvrnnsDgTHGDckMeZZdLqGY8CXvOpoRjebWJTsNP7CVnQaBFuiZyDV+I01DsauixeWTO5OgATSH7yrSUYwwqj9EPmssmoUrMBsDCj/dMLs3ruLUctZmf7q7WZ1D3gAFn1iAeOXwA+xWNo7uCVbnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993424; c=relaxed/simple;
	bh=e+TlRlSxxghzjYRAmtjmxSOmYSUG3vJTKZS++DLzkVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ1WjK3io3P0qkS3kYVxBLS3e82IjyzRTbfUil1HkJtBzYF9Tk7V9w7bv/kgfRfV9+XOu90jawMU5bfLkIQQRbElOH/xe0v1DpfIdKNqzmGTMrgPqS/dG7dRIC2CJonZPJiUXwzIkkQZ152ilgC7nXn7XwMMQhazEt+lxWvxZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LDteMsVV; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727993424; x=1759529424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nwv0LK28+JcG0KwPdGlDmCg0tA/98DE1OmArhdo4bes=;
  b=LDteMsVVmJ/IxMRyOjtcn3ZXF895zaAt0mgVrNEOhS2uGFuh2ytpaqBW
   lhn34fdG87WTGwH9QR1mERuPY323AMazzvO9U9jz5Godw/qqhw+2vZ8GR
   fvcD4Dv0JpEvJ2vLOqMkVhMNpEtEt2CTPsvj8JdeP3fAW+bOxy8dX72QW
   w=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="432407966"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 22:10:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:29139]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 1dc4f7a9-6fb0-40cb-9c5f-6876d4b939d9; Thu, 3 Oct 2024 22:10:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1dc4f7a9-6fb0-40cb-9c5f-6876d4b939d9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 22:10:17 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 22:10:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kernelxing@tencent.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <willemdebruijn.kernel@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v3] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Thu, 3 Oct 2024 15:10:07 -0700
Message-ID: <20241003221007.12918-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003104035.22374-1-kerneljasonxing@gmail.com>
References: <20241003104035.22374-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu,  3 Oct 2024 19:40:35 +0900
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 86a2476678c4..83622799eb80 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -491,15 +491,6 @@ static struct ctl_table net_core_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{
> -		.procname	= "tstamp_allow_data",
> -		.data		= &sysctl_tstamp_allow_data,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE
> -	},
>  #ifdef CONFIG_RPS
>  	{
>  		.procname	= "rps_sock_flow_entries",
> @@ -665,6 +656,15 @@ static struct ctl_table netns_core_table[] = {
>  		.extra2		= SYSCTL_ONE,
>  		.proc_handler	= proc_dou8vec_minmax,
>  	},
> +	{
> +		.procname	= "tstamp_allow_data",
> +		.data		= &init_net.core.sysctl_tstamp_allow_data,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE

It's already limited to [0, 1], so you can use u8 and save 3 bytes.

  grep -rnI proc_dou8vec_minmax.

