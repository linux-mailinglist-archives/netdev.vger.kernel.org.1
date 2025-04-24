Return-Path: <netdev+bounces-185376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B03A99EC8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61C51946651
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6484FAD;
	Thu, 24 Apr 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iRdAcJVp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F714F70
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745461549; cv=none; b=SjzczX30hWbFz+jDrP2+xNTrA9spjVXnFZU7PFIxJfYwwseQuJ3RtfmYdGNRpNhUSM+ZFB+10bFSoufFEOHRHT+k6AM9IeMOVs3g0t04MOEy3i6VdXhG97rVnN9dKLWGQEEfIvyFdjFPEZOM5/GWKRzCWZ+2vJmLUjsSvUa/35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745461549; c=relaxed/simple;
	bh=P92eQpy4G9iNyKYdeJ497HouSr4nW4CSkS0Hqg195tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIXN9isSSokubLT7OAgcm1mfcLzc7OEe52T9XqBx51vue3rH1K2IP+jN7COjkzuPrE9XBshF3qvDcAtCGcu43em1Ft620AXiAJ7zTvwpr4hklK0Eomq9jF8S1Knkv9dhUdue1lwRjI3Dh3Itdk4d37Fy0cHPsqDqwyU6OoL2xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iRdAcJVp; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745461548; x=1776997548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWph8SLVCku0XNJyk1OqjpHhXMAlS6sar8hHPyy5us0=;
  b=iRdAcJVpr468ChV6GlWGgNP1KIKbaVXJ0i9ZdogjqmwR5sXsa/V0dIWk
   cU6YPRFoXId2DPYUl0WreepOeldQ5Lo7xSugVcw2Fa95TLRcuv/EFqHR7
   BjcyAMr/kve6b/7kfv/IF5pU/INxKRYnWY70WvEi4EH7ZF4PhdoGLOqVv
   E=;
X-IronPort-AV: E=Sophos;i="6.15,233,1739836800"; 
   d="scan'208";a="483188675"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 02:25:45 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:5226]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.220:2525] with esmtp (Farcaster)
 id 431d1046-ee6c-476c-b694-03a241be0f31; Thu, 24 Apr 2025 02:25:44 +0000 (UTC)
X-Farcaster-Flow-ID: 431d1046-ee6c-476c-b694-03a241be0f31
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 02:25:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 02:25:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
Date: Wed, 23 Apr 2025 19:23:28 -0700
Message-ID: <20250424022531.93945-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423155233.33ac2bd3@kernel.org>
References: <20250423155233.33ac2bd3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 23 Apr 2025 15:52:33 -0700
> On Wed, 23 Apr 2025 07:12:55 -0700 Kuniyuki Iwashima wrote:
> > > >  	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
> > > > -		pfcp_dellink(pfcp->dev, &list);
> > > > -
> > > > -	unregister_netdevice_many(&list);
> > > > -	rtnl_unlock();
> > > > +		pfcp_dellink(pfcp->dev, dev_to_kill);  
> > > 
> > > Kuniyuki, I got distracted by the fact the driver is broken but I think
> > > this isn't right.  
> > 
> > I guess it was broken recently ?  at least I didn't see null-deref
> > while testing ffc90e9ca61b ("pfcp: Destroy device along with udp
> > socket's netns dismantle.").
> 
> Not sure, nothing seems to have changed since?

It's been broken since the first commit of pfcp, but the bug seems
to be exposed recently by the commit below, which changed the per-cpu
variable section address from 0 to relative address.

  $ git bisect good
  9d7de2aa8b41407bc96d89a80dc1fd637d389d42 is the first bad commit
  commit 9d7de2aa8b41407bc96d89a80dc1fd637d389d42
  Author: Brian Gerst <brgerst@gmail.com>
  Date:   Thu Jan 23 14:07:40 2025 -0500

      x86/percpu/64: Use relative percpu offsets

Looks like before this commit 0 was a valid per-cpu variable address
on x86, and that's why accessing per_cpu_ptr(NULL, cpu) was handled
(im)properly.

The fix is one-liner assigning pcpu_stat_type, but no one have used
pfcp for the recent 3 months and haven't noticed the wrong stats nor
used stats for a year.

Do we want to fix it or remove ? :)

