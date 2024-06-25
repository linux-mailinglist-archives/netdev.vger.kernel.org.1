Return-Path: <netdev+bounces-106679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D13917398
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC51B20FFF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E917DE17;
	Tue, 25 Jun 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QuazZayf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AA2F56;
	Tue, 25 Jun 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351559; cv=none; b=apFPSoMYRRT69EPMvmbj7conFS0CbYV15c1e3qXn02iCSX+QiQ0Xzb3oROe9TWidSjo/EvvBirAoLRMC3BdbXAl0X80eMoCq2t6pDV0OFsRViZEWCb1auPwlhaSPu7U/dIVT/kAlqn7i7cKPNm6Nsd4GtRru1HInFMJdnowuWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351559; c=relaxed/simple;
	bh=I7CGd1qyxMUB8zlJZZTnebEtJHmRGYQRKwlgpbToofY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGycx00QkRby/FDLIgyzFezY7FyKYM/LVa3yL8JiYfnkaDgVFuMUvNgbgcib2568r+sclbIZ04LijeNmSOV/24uvFYr6snugLdd4p8UFl1lkrYamVBCVYYrk2NveW0bcsoYEWD8xpTWhm72qnbNyRS4X6YAyi/ORvVPim9ooSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QuazZayf; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719351558; x=1750887558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lC5Ihbc1v1YGg/yIWksJtHnmIp6/hSGbGAZit1bJ8iI=;
  b=QuazZayfsnEcva7IYqbw/YInE8VCJDRvEuDvne+8p0XE5fGu2Su585tG
   fw0nVmNwmzFWTIArQ32XLBfcLJMKDC5mKovlEX12ZMe1DrY/HIDewzJJz
   xSYQQ6k8pcb6bYwskQ59aGnwBw2OxTDO72ovn4LpJZAp8EK6vhavK1ZMH
   I=;
X-IronPort-AV: E=Sophos;i="6.08,265,1712620800"; 
   d="scan'208";a="736073815"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 21:39:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:35824]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.169:2525] with esmtp (Farcaster)
 id f892e3ac-3faf-44b3-af11-a144650b3889; Tue, 25 Jun 2024 21:39:12 +0000 (UTC)
X-Farcaster-Flow-ID: f892e3ac-3faf-44b3-af11-a144650b3889
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 21:39:11 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 21:39:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mathis.marion@silabs.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <jerome.pouiller@silabs.com>, <kuba@kernel.org>,
	<kylian.balan@silabs.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0 segments left
Date: Tue, 25 Jun 2024 14:38:59 -0700
Message-ID: <20240625213859.65542-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240624141602.206398-3-Mathis.Marion@silabs.com>
References: <20240624141602.206398-3-Mathis.Marion@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Mathis Marion <Mathis.Marion@silabs.com>
Date: Mon, 24 Jun 2024 16:15:33 +0200
> From: Mathis Marion <mathis.marion@silabs.com>
> 
> Routing headers of type 3 and 4 would be rejected even if segments left
> was 0, in the case that they were disabled through system configuration.
> 
> RFC 8200 section 4.4 specifies:
> 
>       If Segments Left is zero, the node must ignore the Routing header
>       and proceed to process the next header in the packet, whose type
>       is identified by the Next Header field in the Routing header.

I think this part is only applied to an unrecognized Routing Type,
so only applied when the network stack does not know the type.

   https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4

   If, while processing a received packet, a node encounters a Routing
   header with an unrecognized Routing Type value, the required behavior
   of the node depends on the value of the Segments Left field, as
   follows:

      If Segments Left is zero, the node must ignore the Routing header
      and proceed to process the next header in the packet, whose type
      is identified by the Next Header field in the Routing header.

That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.

But now the kernel recognizes RPL and it's intentionally disabled
by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.

And SRv6 has been rejected since 1ababeba4a21f for the same reason.


> 
> Signed-off-by: Mathis Marion <mathis.marion@silabs.com>
> ---
>  net/ipv6/exthdrs.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 083dbbafb166..913160b0fe13 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -662,17 +662,6 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  		return -1;
>  	}
>  
> -	switch (hdr->type) {
> -	case IPV6_SRCRT_TYPE_4:
> -		/* segment routing */
> -		return ipv6_srh_rcv(skb);
> -	case IPV6_SRCRT_TYPE_3:
> -		/* rpl segment routing */
> -		return ipv6_rpl_srh_rcv(skb);
> -	default:
> -		break;
> -	}
> -
>  looped_back:
>  	if (hdr->segments_left == 0) {
>  		switch (hdr->type) {
> @@ -708,6 +697,12 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  		}
>  		break;
>  #endif
> +	case IPV6_SRCRT_TYPE_3:
> +		/* rpl segment routing */
> +		return ipv6_rpl_srh_rcv(skb);
> +	case IPV6_SRCRT_TYPE_4:
> +		/* segment routing */
> +		return ipv6_srh_rcv(skb);
>  	default:
>  		goto unknown_rh;
>  	}
> -- 
> 2.43.0

