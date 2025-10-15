Return-Path: <netdev+bounces-229561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09395BDE3C8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAAB535749D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6931D362;
	Wed, 15 Oct 2025 11:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FF31CA5E;
	Wed, 15 Oct 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526892; cv=none; b=Ws1hduez/Z3CzHrazU1jhs49mP0IYiZK2fmBHy99vfy+m2udqPaI6KYHg41yFSY8jlvW7037unYRf3nczWzmTcbWmc2IoYa75wpi51Bu1Vrh/+8MckHchw05NE1XeU9V+DmgY3zOsiGh/99L/rOsIpiKcoJo5JbHGqY+JOXZF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526892; c=relaxed/simple;
	bh=ZwOtUeDhzBVShiH61wkDeAhUAucVh3Z70Jw0fG2U3uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCCbwzFnNE3N723mnR2y5ggXiDf/d9eXeloOmdaToBfmv873nqPrG2Rnvav8KMpLzYeTiR/En73kof5CA42pG1mbfX19c66llUW3ZN0gFLaM+G24bG6L4I1YCEGzj8EVJrOoCztnjpH4q2wgZjsDRTrQ6rGyiCpauUqlzeWy78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4390160186; Wed, 15 Oct 2025 13:14:48 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:14:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Wang Liang <wangliang74@huawei.com>, nhorman@tuxdriver.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH RFC net-next] net: drop_monitor: Add debugfs support
Message-ID: <aO-CJ7caP083oBJg@strlen.de>
References: <20251015101417.1511732-1-wangliang74@huawei.com>
 <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLZBMWpU7kMjd8akT+L8FbsnO+wqgjCaXF2KOCFz9Hiag@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:
> I do not understand the fascination with net/core/drop_monitor.c,
> which looks very old school to me,
> and misses all the features,  flexibility, scalability  that 'perf',
> eBPF tracing, bpftrace, .... have today.
> 
> Adding  /sys/kernel/debug/drop_monitor/* is even more old school.
> 
> Not mentioning the maintenance burden.
> 
> For me the choice is easy :
> 
> # CONFIG_NET_DROP_MONITOR is not set
> 
> perf record -ag -e skb:kfree_skb sleep 1
> 
> perf script # or perf report

Maybe:

diff --git a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -400,15 +400,15 @@ config NET_PKTGEN
          module will be called pktgen.

 config NET_DROP_MONITOR
-       tristate "Network packet drop alerting service"
+       tristate "Legacy network packet drop alerting service"
        depends on INET && TRACEPOINTS
        help
          This feature provides an alerting service to userspace in the
          event that packets are discarded in the network stack.  Alerts
          are broadcast via netlink socket to any listening user space
-         process.  If you don't need network drop alerts, or if you are ok
-         just checking the various proc files and other utilities for
-         drop statistics, say N here.
+         process. This feature is NOT related to "perf" based drop monitoring.
+         Say N here unless you need to support older userspace tools like
+         "dropwatch".



