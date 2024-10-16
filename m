Return-Path: <netdev+bounces-136018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00D99FFA1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77571F21A6F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF717BEC7;
	Wed, 16 Oct 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JqdLQPKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEC148FED;
	Wed, 16 Oct 2024 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050281; cv=none; b=kedo6D987Ioi3pCYuptL/iXZkkZM9goRKDNHt2b59q7X4sizenDoOsjs3QIAUj7KOxdmiE8tNZ1JBX/kY3fIA5A/Z/xFULPBf/RWkmvhBq51F7DmsNqOCVWl9SNAz8tS39+ypMVBLWqPw6a5buacmNgMENtOYDBaxAcOa2n5kO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050281; c=relaxed/simple;
	bh=XKIX/PPjlVjz+E9X1RtcSZEjQ2SxFf5rGp/JXYet2g0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVt1B4duxAYpDvF5IgFE04Etr/j9IvoeuWQguTlbLvkkUFBR/4dyAt0e8BfGIrhDX1nrjfRIny1SDscqrgTewmmfyeQUAjfN/i8J6L04uix90wqxkdEKRYeJsEyyT7JfRpugrGDDNpttQ+0elR3YNi4WZLrMWBrOtO7PRXJX23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JqdLQPKH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729050280; x=1760586280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTefGyhsaXlGrGMS7ueF3RA+bgVcym7IGr4Wg2bFR9I=;
  b=JqdLQPKH73Q5WoRRI58pyV+H8jZVNqN6jZZ01l+Em7lpLkPkhIOpx2BV
   s2XzaXqimlEvxV3ijWx3c5rZEEwnWS8x6RIpOZNF3DeHgcq4Cf4pr/x8D
   l4H4KtCZqfibvzAHNKttIRCRzeG0AsKvS5yO77xJ3NNK1+rZbkbsmGwIA
   g=;
X-IronPort-AV: E=Sophos;i="6.11,207,1725321600"; 
   d="scan'208";a="343490900"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:44:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:55992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 70b42be6-3f9e-4b52-a24f-c1fbff175f87; Wed, 16 Oct 2024 03:44:37 +0000 (UTC)
X-Farcaster-Flow-ID: 70b42be6-3f9e-4b52-a24f-c1fbff175f87
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 03:44:37 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 03:44:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gustavoars@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kees@kernel.org>, <kuba@kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid -Wflex-array-member-not-at-end warnings
Date: Tue, 15 Oct 2024 20:44:29 -0700
Message-ID: <20241016034429.90455-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
References: <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Tue, 15 Oct 2024 18:32:43 -0600
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in a couple of composite structs, which are currently causing
> trouble, from `struct sockaddr` to `struct sockaddr_legacy`. Note that
> the latter struct doesn't contain a flexible-array member.
> 
> include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, update some related code, accordingly.
> 
> No binary differences are present after these changes.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/uapi/linux/if_arp.h | 18 +++++++++---------
>  net/ipv4/arp.c              |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
> index 4783af9fe520..cb6813f7783a 100644
> --- a/include/uapi/linux/if_arp.h
> +++ b/include/uapi/linux/if_arp.h
> @@ -115,18 +115,18 @@
>  
>  /* ARP ioctl request. */
>  struct arpreq {
> -	struct sockaddr	arp_pa;		/* protocol address		 */
> -	struct sockaddr	arp_ha;		/* hardware address		 */
> -	int		arp_flags;	/* flags			 */
> -	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
> -	char		arp_dev[IFNAMSIZ];
> +	struct sockaddr_legacy	arp_pa;		/* protocol address		 */
> +	struct sockaddr_legacy	arp_ha;		/* hardware address		 */
> +	int			arp_flags;	/* flags			 */
> +	struct sockaddr_legacy	arp_netmask;    /* netmask (only for proxy arps) */
> +	char			arp_dev[IFNAMSIZ];
>  };
>  
>  struct arpreq_old {
> -	struct sockaddr	arp_pa;		/* protocol address		 */
> -	struct sockaddr	arp_ha;		/* hardware address		 */
> -	int		arp_flags;	/* flags			 */
> -	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
> +	struct sockaddr_legacy	arp_pa;		/* protocol address		 */
> +	struct sockaddr_legacy	arp_ha;		/* hardware address		 */
> +	int			arp_flags;	/* flags			 */
> +	struct sockaddr		arp_netmask;    /* netmask (only for proxy arps) */

I think we can use _legacy here too, 14 bytes are enough for ARP.

But whichever is fine to me because arpreq_old is not used in
kernel, so

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


>  };
>  
>  /* ARP Flag values. */
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 11c1519b3699..3a97efe1587b 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -1185,7 +1185,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
>  
>  	read_lock_bh(&neigh->lock);
>  	memcpy(r->arp_ha.sa_data, neigh->ha,
> -	       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
> +	       min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
>  	r->arp_flags = arp_state_to_flags(neigh);
>  	read_unlock_bh(&neigh->lock);
>  
> -- 
> 2.34.1

