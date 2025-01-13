Return-Path: <netdev+bounces-157595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0AA0AF49
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB2918872FB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F84191494;
	Mon, 13 Jan 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t3S32xgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAA10E0;
	Mon, 13 Jan 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749201; cv=none; b=mxngXTarm8T1B8LO4Frh30UVkav7CZCLqpWuu4RAftNyZsJhbjIgxs55c+yh6E3KWNDHJF6YrZ/RsKRNRBwnb9D7qGLKrBl+uM6XicStIb30X4PXBSMDK0FFecHYxXce4xBXiJcRqZEF+n0fKzondb6NTIW5ufrqaj8BVSXh5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749201; c=relaxed/simple;
	bh=CNhtFXWZmbnSULL6FZmLWqMJsFBmRCW7JxUJY3SQHSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8JrkpRHndkUUGpQ5ECaVAXLHuvK+paegODXrtfkdeNRl0jrPDVyyncOFHCrr6Y3CrmPi/mL3xOmM45PopGvUHGB/rTwCdu2Wklc2rrGsF52x2YvmdIWXbTnZM0GwaRAf5kAoT1I5fvXyh5nEWExui+BzZOq4LgJPJTN8kI2uW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t3S32xgI; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736749200; x=1768285200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tjc2kE2DLHSxHpA+HUJspggi/bjbxP+ihTV8u263IdE=;
  b=t3S32xgIjb2XWTsprowWwkKVCuJ1emdf1gPucE1yr1My2rSm4rPijaND
   tnMErEUs4o2+6cf9O4m8XoUpKFiJprKy0yTjjJ7jV1PTR+Jt9j/Gs9NR9
   QrTqjbDgOy15edAe3PuXPqHPBM3x+7xIglDBIoUgrChsA0SgHKsdy+1JG
   U=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728950400"; 
   d="scan'208";a="688740237"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:19:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:38856]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.12:2525] with esmtp (Farcaster)
 id f7184e3f-776a-4bfa-a50a-258d4c409124; Mon, 13 Jan 2025 06:19:55 +0000 (UTC)
X-Farcaster-Flow-ID: f7184e3f-776a-4bfa-a50a-258d4c409124
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 06:19:54 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 06:19:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <geert@linux-m68k.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] ipv4: ip_gre: Fix set but not used warning in ipgre_err() if IPv4-only
Date: Mon, 13 Jan 2025 15:19:42 +0900
Message-ID: <20250113061942.57178-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <3dc917cf6244ef123aa955b2fbbf02473d13cdb5.1736672666.git.geert@linux-m68k.org>
References: <3dc917cf6244ef123aa955b2fbbf02473d13cdb5.1736672666.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 Jan 2025 10:05:10 +0100
> @@ -191,8 +189,9 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
>  
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (tpi->proto == htons(ETH_P_IPV6) &&
> -	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
> -					type, data_len))
> +	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len, type,
> +		type == ICMP_TIME_EXCEEDED ?
> +		icmp_hdr(skb)->un.reserved[1] * 4 /* RFC 4884 4.1 */ : 0))
>  		return 0;
>  #endif

No need to pack everything in a single line.

---8<---
#if IS_ENABLED(CONFIG_IPV6)
	if (tpi->proto == htons(ETH_P_IPV6)) {
		unsigned int data_len = 0;

		if (type == ICMP_TIME_EXCEEDED)
			data_len = icmp_hdr(skb)->un.reserved[1] * 4; /* RFC 4884 4.1 */

		if (!ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
						type, data_len)
			return 0;
	}
#endif
---8<---


For the future submission, please specify the target tree in Subject.

  [PATCH net-next v2] ...

See: Documentation/process/maintainer-netdev.rst

Thanks

