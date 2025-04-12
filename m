Return-Path: <netdev+bounces-181936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E3EA8703E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 01:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2953619E0A08
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320C222595;
	Sat, 12 Apr 2025 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g0tvWINM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742119E83C;
	Sat, 12 Apr 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744500539; cv=none; b=QtG3Vv91h1TEFidKsEZ8Q2pTeKKnZ5YNFLDOe1HAb70gd13D1REQl6dTMDmA12WjZOGRmCahwnHa8kIHLgfUZYdulBjiuflRFI3K0zyHjTc0423PPycW1xF7ZY7+fxB+bN0uxNWfYhgxnbmkrAsu3EKDIQXusUuZpCTUT8D/uKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744500539; c=relaxed/simple;
	bh=gQMrL4+swJuQvx5mpzAd7Rauv7uGkymlaI2Gdq19Beg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRJPpXEMVJjAINSJOsrSct9eI5QDMB9+oqgl+A4VPJrGW8/zQQ/Y4I1beCrKe2eV5T7rGySVigM+QTnuf1/VtDI3GRK0GvuPfjZIbCY5RwJHaXQ+gSTjPt3JVwfB1nLxNUj4Le4s/a4JpnqmeV78rg4lcc5Lze6fq3ZLvGkCxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g0tvWINM; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744500537; x=1776036537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fLsPIBKLCkZ+nG1Keg61Tbv/X4V+aLxUpZHUG+AmbOo=;
  b=g0tvWINMiXh6uwLdtAHoiEdpryNaYe0+0VxU5FKzo3OaJg7MUJyIMclO
   P4I3EL3IxfdnkPOlqez5x+uZ/YsnjeW7D66bsna1xqxVKl9mr0w7OtP8j
   TtCcbPwAEXnO7+QuJu6pTLhix4ZEiI9a9UX2cbwId/VOqRPNXa8RWW3EH
   w=;
X-IronPort-AV: E=Sophos;i="6.15,209,1739836800"; 
   d="scan'208";a="186895245"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 23:28:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:23025]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id e1f47f7b-e72f-4af3-bd5c-2e670cfbc360; Sat, 12 Apr 2025 23:28:54 +0000 (UTC)
X-Farcaster-Flow-ID: e1f47f7b-e72f-4af3-bd5c-2e670cfbc360
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 12 Apr 2025 23:28:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 12 Apr 2025 23:28:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <qasdev00@gmail.com>
CC: <jlayton@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] net: use %ld format specifier for PTR_ERR in pr_warn
Date: Sat, 12 Apr 2025 16:28:38 -0700
Message-ID: <20250412232839.66642-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412225528.12667-1-qasdev00@gmail.com>
References: <20250412225528.12667-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Qasim Ijaz <qasdev00@gmail.com>
Date: Sat, 12 Apr 2025 23:55:28 +0100
> PTR_ERR yields type long, so use %ld format specifier in pr_warn.

errno fits in the range of int, so no need to use %ld.


> 
> Fixes: 193510c95215 ("net: add debugfs files for showing netns refcount tracking info")

The series is not yet applied.  It's not necessary this time, but
in such a case, please reply to the original patch thread.

Also, please make sure your patch can be applied cleanly on the latest
remote net-next.git and the Fixes tag points to an existing commit.


> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com> 
> ---
>  net/core/net_namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index f47b9f10af24..a419a3aa57a6 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1652,7 +1652,7 @@ static int __init ns_debug_init(void)
>  	if (ref_tracker_debug_dir) {
>  		ns_ref_tracker_dir = debugfs_create_dir("net_ns", ref_tracker_debug_dir);
>  		if (IS_ERR(ns_ref_tracker_dir)) {
> -			pr_warn("net: unable to create ref_tracker/net_ns directory: %d\n",
> +			pr_warn("net: unable to create ref_tracker/net_ns directory: %ld\n",
>  				PTR_ERR(ns_ref_tracker_dir));
>  			goto out;
>  		}
> -- 
> 2.39.5

