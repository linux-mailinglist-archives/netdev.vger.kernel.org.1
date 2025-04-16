Return-Path: <netdev+bounces-183093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05AA8ADAF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F13AD859
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA16F221F0D;
	Wed, 16 Apr 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pa/XibIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCB30100;
	Wed, 16 Apr 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768396; cv=none; b=Yj+apEpzmcN1iuTB97qBGDLIUwTwFibgWVSU25997+4XR7GH/EekUKTuz+IydSVnfqTZXhBFL23e1SjtpFdZzCoR0dKmgUa4Mb6p9HYAjMeoqdAXinYdO0+mMQJuCabClCuFepGlG2+iO8kY3paYlsYC2hZ+yEtJLrO+rA8uhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768396; c=relaxed/simple;
	bh=aJ8lGRkf83DQPCwwfYee34QAINj2qyiMplVOGEtg9+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpUF873NThc9IXhM568vFACEbFhV14qwz/vBKAokjr/xwW2QYd3jV9u0mJY1g2kXctp51ydpvaxCI/DouB4LsUghQBh3djJjyEoJC+4aIaFc4kHdeB3/KzqQ5rvmkninv3sVRADfO6cYJmK64ZG00YaHJdyMDqITn9cW4f9aoW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pa/XibIY; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744768395; x=1776304395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXXPPqOrMo2xZU+pnYHJJFCVstFjJanNQ0tSPmVe3U0=;
  b=pa/XibIY4N5s9uL3ofCZy90b0L9b09BzcEX/rHlRo/JKvkF74G+TSXrs
   8G11P8bzgqp28HgnBnhgnQpiDloPIXxj/SO9U1ma2/RSLHwFXTLFJq+JM
   l75k6xmbwGWkRDrAVB2s74X8R4KjnZXYQPY3ATEWkvAYK8WgBJHdhtkkV
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="714151914"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:53:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:22464]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 3e52a99b-0279-4bae-9a2f-e2209376aafe; Wed, 16 Apr 2025 01:53:10 +0000 (UTC)
X-Farcaster-Flow-ID: 3e52a99b-0279-4bae-9a2f-e2209376aafe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:53:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:53:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qasdev00@gmail.com>
Subject: Re: [PATCH v2 6/8] net: add ref_tracker_dir_debugfs() calls for netns refcount tracking
Date: Tue, 15 Apr 2025 18:52:52 -0700
Message-ID: <20250416015257.36336-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-reftrack-dbgfs-v2-6-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-6-b18c4abd122f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:44 -0400
> After assigning the inode number to the namespace, use it to create a
> unique name for each netns refcount tracker and register the debugfs
> files for them.
> 
> The init_net is registered early in the boot process before the
> ref_tracker dir is created, so add a late_initcall() to register its
> files.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/core/net_namespace.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 4303f2a4926243e2c0ff0c0387383cd8e0658019..f636eb9b8eba28114fd192d64bcd359a25381988 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -761,12 +761,44 @@ struct net *get_net_ns_by_pid(pid_t pid)
>  }
>  EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
>  
> +#ifdef CONFIG_NET_NS_REFCNT_TRACKER
> +static void net_ns_net_debugfs(struct net *net)
> +{
> +	char name[32];

Perhaps define REF_TRACKER_NAMESZ (I'm really bad at naming) and reuse
it in the next two patches ?

Otherwise looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

