Return-Path: <netdev+bounces-127677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC69760E0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E1D1C22D60
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B10189535;
	Thu, 12 Sep 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V3zcNHiA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBB2D7BF
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120755; cv=none; b=mulEcXg2Fln+TeXpiW4YGhJCHZ6Q6+lF3e852qi3UZ2FsFgoI0/2bqCyx6sRvWQOQanGQxJdFcDAveMlrZr1Q5Vzo0orWlRNEf+JhGJpp/gZmOQhVAVIeT4VoA9CdgrsrOGb2M7mHP+U00gu+1lFKgxEYqFDSDtN2OEn17NMtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120755; c=relaxed/simple;
	bh=EB3G9Sehh01YUfMAKDR8vclOORFzuZLAAmGDYo0T6nY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKROaGJvsZxx8d266RIAtDDFZ3fNyXJPjvuE9iXQL8uv8JZdnoPkyV9iIbtWV/GiwpEEJ4dvkvYnHKz+LDucVsn+erHsRCgGCC+h7eZNjQKlrNlxyv6JEb7gMEbVdIyroQ2jxh73cCxE1IMIK7gA1s0TRlI+nJzFr+XwyyY2DOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V3zcNHiA; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726120754; x=1757656754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0BpsvH0ZIXadt3FuqthqZ0ZRFiH0wWbV0xnT/GKqtk=;
  b=V3zcNHiAQGRF3aNgTXzuc1xReKv0SUBrI9VFu6BGPXCSKo0L4iDwALtO
   B2lAHYB4+Bh60wYyIXCeDKxcB7HCfeLHAOPnfgN5ah6tFuwT423IQKc/c
   H9q9TO2n2hIuHyc1+CuEIR6nlC1oNZZ0vci6p75dJ1INfaCZGzs8dZ24E
   o=;
X-IronPort-AV: E=Sophos;i="6.10,222,1719878400"; 
   d="scan'208";a="658438466"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:59:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:44808]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.111:2525] with esmtp (Farcaster)
 id 1514a09c-8087-4278-9da8-f73b11ee95b2; Thu, 12 Sep 2024 05:59:09 +0000 (UTC)
X-Farcaster-Flow-ID: 1514a09c-8087-4278-9da8-f73b11ee95b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 12 Sep 2024 05:59:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 12 Sep 2024 05:59:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <atlas.yu@canonical.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stephen@networkplumber.org>
Subject: Re: [PATCH net v1] netlink: optimize the NMLSG_OK macro
Date: Wed, 11 Sep 2024 22:58:57 -0700
Message-ID: <20240912055857.55226-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240912024018.8117-1-atlas.yu@canonical.com>
References: <20240912024018.8117-1-atlas.yu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Atlas Yu <atlas.yu@canonical.com>
Date: Thu, 12 Sep 2024 10:40:18 +0800
> When nlmsg_len >= sizeof(hdr) and nlmsg_len <= len are true, we can set
> up an inequation: len >= nlmsg_len >= sizeof(hdr), which makes checking
> len >= sizeof(hdr) useless.
> 
> gcc -O3 cannot optimize ok1 to generate the same instructions as ok2 on
> x86_64 (not investigated on other architectures).
>   int ok1(int a, int b, int c) { return a >= b && c >= b && c <= a; }
>   int ok2(int a, int b, int c) { return c >= b && c <= a; }
> 
> Signed-off-by: Atlas Yu <atlas.yu@canonical.com>
> ---
>  include/uapi/linux/netlink.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> index f87aaf28a649..85dcfa6b33af 100644
> --- a/include/uapi/linux/netlink.h
> +++ b/include/uapi/linux/netlink.h
> @@ -104,8 +104,7 @@ struct nlmsghdr {
>  #define NLMSG_NEXT(nlh,len)	 ((len) -= NLMSG_ALIGN((nlh)->nlmsg_len), \
>  				  (struct nlmsghdr *)(((char *)(nlh)) + \
>  				  NLMSG_ALIGN((nlh)->nlmsg_len)))
> -#define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
> -			   (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
> +#define NLMSG_OK(nlh,len) ((nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \

If len < sizeof(struct nlmsghdr)
(more specifically, offsetof(struct nlmsghdr, nlmsg_len)),
you can't access nlmsg_len; it returns a garbage.


>  			   (nlh)->nlmsg_len <= (len))
>  #define NLMSG_PAYLOAD(nlh,len) ((nlh)->nlmsg_len - NLMSG_SPACE((len)))
>  
> -- 
> 2.43.0
> 

