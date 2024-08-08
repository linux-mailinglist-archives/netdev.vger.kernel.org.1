Return-Path: <netdev+bounces-117011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA494C5AB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A88289616
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED2155A25;
	Thu,  8 Aug 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e00ovFjI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC89460;
	Thu,  8 Aug 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148649; cv=none; b=EwJUGL56lcgM5/vx6wsfw7ZlvK5xRPSw/zDXHA/rMCVSNaoscgUhcX6wHat53ZImjFSUTPi0n7lCf6geCy3zjdz4LFB7iJXxxSGkK6Y7Q7iGuKnEd2uB/0uvQXA3xCflUJLQWznqjxOWa1/74uUEMhPe+YZ1HOkcjbdbNKLLJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148649; c=relaxed/simple;
	bh=nGOKmcYa2GqAZGGM4TwV9aMx94jdZdU4OgIWQcz6S7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH5W28YUqJGgHXb+/1MKEpmtN0RV/wUNfAykLZ1sw++DRNfsdmdA6253G7wghahikDwwpAGth+m7P92u/TTC0YryoUWtXB0ZqpJa7N34AQwpqmow5dV92YwXxO4ErzcH3eW0n1b1rZBXDueHWgWTNWABlSaPqwgtY0OyEQHPIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e00ovFjI; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723148648; x=1754684648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+KLIuHN566HMfi/HLyPSsItSaDkywNHO18IjThmaLI=;
  b=e00ovFjIBXnPNCCT2gIBq+4hjDHd1cosJx8s5bpD5EOu3gdnTu9bMxEN
   WqExItegCT6zPuzwTYWaGvOS7f+uFjx8ShTjtrSc+KGT/o0NixJLkHa6E
   kw8Hj27b7eka+CShSrJBKb9XIePQaWpsintebEUPqHPFgh0Eppjza1/5z
   U=;
X-IronPort-AV: E=Sophos;i="6.09,274,1716249600"; 
   d="scan'208";a="361339915"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 20:24:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:56246]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.243:2525] with esmtp (Farcaster)
 id 4fbb66ac-c146-4a90-a52e-4df7c0f164d0; Thu, 8 Aug 2024 20:23:59 +0000 (UTC)
X-Farcaster-Flow-ID: 4fbb66ac-c146-4a90-a52e-4df7c0f164d0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 20:23:58 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 20:23:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bpappas@pappasbrent.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] ipv6: mcast: Add __must_hold() annotations.
Date: Thu, 8 Aug 2024 13:23:47 -0700
Message-ID: <20240808202347.32112-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240808190256.149602-1-bpappas@pappasbrent.com>
References: <20240808190256.149602-1-bpappas@pappasbrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Brent Pappas <bpappas@pappasbrent.com>
Date: Thu,  8 Aug 2024 15:02:55 -0400
> Add __must_hold(RCU) annotations to igmp6_mc_get_first(),
> igmp6_mc_get_next(), and igmp6_mc_get_idx() to signify that they are
> meant to be called in RCU critical sections.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  net/ipv6/mcast.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 7ba01d8cfbae..843d0d065242 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -22,6 +22,7 @@
>   *		- MLDv2 support
>   */
>  
> +#include "linux/compiler_types.h"

Why "" ?

Btw, I think for_each_netdev_rcu() / rcu_dereference() in touched
functions are enough to cleary annotate RCU is needed there.

Even without it, I prefer rcu_read_lock_held(), I'm not sure to
what extent sparse can analyse functions statically though.


>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> @@ -2861,6 +2862,7 @@ struct igmp6_mc_iter_state {
>  #define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
>  
>  static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
> +	__must_hold(RCU)
>  {
>  	struct ifmcaddr6 *im = NULL;
>  	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
> @@ -2882,7 +2884,9 @@ static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
>  	return im;
>  }
>  
> -static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr6 *im)
> +static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq,
> +					   struct ifmcaddr6 *im)
> +	__must_hold(RCU)
>  {
>  	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
>  
> @@ -2902,6 +2906,7 @@ static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr
>  }
>  
>  static struct ifmcaddr6 *igmp6_mc_get_idx(struct seq_file *seq, loff_t pos)
> +	__must_hold(RCU)
>  {
>  	struct ifmcaddr6 *im = igmp6_mc_get_first(seq);
>  	if (im)
> -- 
> 2.46.0

