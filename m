Return-Path: <netdev+bounces-137062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4A9A43DD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9797280FDD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A72022E6;
	Fri, 18 Oct 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sOBwxHxb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AE201101;
	Fri, 18 Oct 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269074; cv=none; b=cW0lSdOuPT6QH5ZXrdrrGry2+mCRH81ov3lmzA3SICtHgjKMK05lPS1AVdDBDopQ0UYXL+Z1c3WjXQlhO/h4MpNx33Ivyz6u7vH2SZGPbdid+Q/2nat5bmEiu9K/5ULdorbSKpilOu9hoehesgNYRI44nTf+CJ5FOpGHL/dOZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269074; c=relaxed/simple;
	bh=UV9m2RmlJtqTlnUQp2aKeeN+tm4yh3EfqLba8gw5mS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3UcgvRaX9KYgxwTG+x9/e6UzVQkHFHXpgtjDtGXY3X3a9qi8De2OqovxnQwuAqjFlVfSNMjSIik7uy8ad94ntMtGfCXvDBwtRyeEEags+be6fZnl3FLVr2xc3GjoGtXV053rWaVyE9Jtk97xdd9MK23cDW8r+CCH7KbPUB4OCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sOBwxHxb; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729269073; x=1760805073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SIF+R0GxqMw9QllLZYdFrl95UfBvBRNbwU8vDZYn+OU=;
  b=sOBwxHxbMuWQECwVJBZZ9IfgaIFJi4aPF5g5iABPaHALVmhADLiBJqJi
   FpZoiszbOeMSR5JGfAXF0LGyev/4K8SvhbfPPGLlb/baNxCxWugb/7h8a
   U2GF4CLd7je2QkJkMQ5PKTJ0PQoRypQQpFnnse3/ye8gEekuvrkNXIiV4
   k=;
X-IronPort-AV: E=Sophos;i="6.11,214,1725321600"; 
   d="scan'208";a="436230573"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 16:31:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:39548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id a7bbece1-89c9-424b-afb9-b45ea0e374ca; Fri, 18 Oct 2024 16:31:07 +0000 (UTC)
X-Farcaster-Flow-ID: a7bbece1-89c9-424b-afb9-b45ea0e374ca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 16:31:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 16:31:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <arnd@kernel.org>
CC: <aleksander.lobakin@intel.com>, <arnd@arndb.de>, <chentao@kylinos.cn>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<lizetao1@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] ipmr: Don't mark ip6mr_rtnl_msg_handlers as __initconst
Date: Fri, 18 Oct 2024 09:31:00 -0700
Message-ID: <20241018163100.88905-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018151217.3558216-1-arnd@kernel.org>
References: <20241018151217.3558216-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Oct 2024 15:12:14 +0000
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This gets referenced by the ip6_mr_cleanup function, so it must not be
> discarded early:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .exit.text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> 
> Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi,

I posted this yesterday.
https://lore.kernel.org/netdev/20241017174732.39487-1-kuniyu@amazon.com/

Thanks


> ---
>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 437a9fdb67f5..f7892afba980 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1367,7 +1367,7 @@ static struct pernet_operations ip6mr_net_ops = {
>  	.exit_batch = ip6mr_net_exit_batch,
>  };
>  
> -static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
> +static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] = {
>  	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
>  	 .msgtype = RTM_GETROUTE,
>  	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
> -- 
> 2.39.5

