Return-Path: <netdev+bounces-90599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838FE8AEA15
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EE728971B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAE13C3D4;
	Tue, 23 Apr 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrKLXKGk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8113BAE2
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884591; cv=none; b=fbYvrwNXFTOVIGh2TU/v7axNbRg0wizP+ICrXrVYObP6YkJt7SBWrhHQUxLSJ4l2te6LP79s7mUpvnKksfIAgcdoSM7Hc9NhYlB0Ka/cA4iUsloJmSgeBicBorJZkLgek7aCeSf94Qu5OAjep70+zYC+9/E5/F3bEql03+8j0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884591; c=relaxed/simple;
	bh=CgozWDivC9Pd3reXCJXpK2HYWMsdw023Gj62MJFJLp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkzmcLcotCmO0cl6dI8NByC02Zc8xSRtdFbTDbxucIbOEW9i4/CwYBytxEP7ywTUm5xQlIeiBvAJXAXnGlLCtKw32qgHHdI6iYw7gqzPz+mv1r30EsuPpYiPSN7Bgb/Wgu77keiVNqvWJSjfqiuBn53T6rBX9Q0GXBMJf3fkF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrKLXKGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713884589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SD5mZTVzFRrNyGJ4LurlEfLfoVxmvloZNzRB+jCldh4=;
	b=RrKLXKGkJxUDPEmx7I2SBwILUh4XuAwTgAtTiVUkPAXImgzArEJFhT+OkbBX7pC7S8eXyQ
	b4I8ly8vHKh1j1I96vgfQUizwHKqFMOjUdzqQbi4laG+bxSWdB4qmZsLPZECY6eiGoEjUw
	th9XVUrv4YLTdTXleaC4f3sfRJPyN80=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-31edyEf0Nc-1k6o6YGXEWQ-1; Tue,
 23 Apr 2024 11:03:05 -0400
X-MC-Unique: 31edyEf0Nc-1k6o6YGXEWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57F0929AC01A;
	Tue, 23 Apr 2024 15:03:05 +0000 (UTC)
Received: from localhost (unknown [10.22.32.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9847112132A;
	Tue, 23 Apr 2024 15:03:04 +0000 (UTC)
Date: Tue, 23 Apr 2024 12:03:03 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Raju Rangoju <rajur@chelsio.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: net: cxgb4: Call Trace reported with PREEMPT_RT: BUG: using
 smp_processor_id() in preemptible [00000000] code: ethtool/78718
Message-ID: <ZifNdVsqlAPpm0tq@uudg.org>
References: <Zic0ot5aGgR-V4Ks@thinkpad2021>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zic0ot5aGgR-V4Ks@thinkpad2021>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Apr 23, 2024 at 12:10:10AM -0400, John B. Wyatt IV wrote:
> Hello Raju, Hello Sebastian,
> 
> Red Hat QE found this issue with cxgb4 only when the kernel has PREEMPT_RT set
> with the preempt-rt patchset:
> 
> git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> 
> We are also seeing this in the Real-time builds of RHEL9 and 8.
> 
> The specific build is an internal build that was pulled from the mirror Clark
> Williams setup for Fedora and RHEL testing.
> 
> https://gitlab.com/cki-project/kernel-ark/-/tree/os-build-rt?ref_type=heads
> 
> We use the branch: os-build-rt
> 
> I was unable to find the cause of this and I thought I should report it.
> 
> Please let me if you have any questions or you need any testing done.
> 
> Call trace is below:
> 
> kernel-rt-6.9.0-0.rc4.f8dba31b0a82.38.test.eln136.x86_64
>  BUG: using smp_processor_id() in preemptible [00000000] code: ethtool/78718
>  caller is cxgb4_selftest_lb_pkt+0x3d/0x3a0 cxgb4
>  Hardware name: Dell Inc. PowerEdge R750/0WT8Y6, BIOS 1.5.4 12/17/2021
>  Call Trace:
>   <TASK>
>  dump_stack_lvl (lib/dump_stack.c:116) 
>  check_preemption_disabled (lib/smp_processor_id.c:49) 
>  cxgb4_selftest_lb_pkt+0x3d/0x3a0 cxgb4
>  cxgb4_self_test+0x8f/0xe0 cxgb4
>  ethtool_self_test (net/ethtool/ioctl.c:2002) 
>  __dev_ethtool (net/ethtool/ioctl.c:2997) 

Hi John,

The patch below is untested but should fix the problem you reported:

======

cxgb4: fix smp_processor_id() usage in selftests

When PREEMPT_RT is enabled the following call can result in a "BUG: using
smp_processor_id() in preemptible [00000000] code: ethtool/xxxx" error
message:

    ethtool_self_test()
        cxgb4_self_test()
            cxgb4_selftest_lb_pkt()
                __netif_tx_lock(q->txq, smp_processor_id());  <--- BOOM

Replacing smp_processor_id() by raw_smp_processor_id() is safe in this
context given that __netif_tx_lock() is an inline function that takes a
spinlock and then uses the cpu value.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 1948b7bf99661..803dc62a4db04 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2674,7 +2674,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	lb->loopback = 1;
 
 	q = &adap->sge.ethtxq[pi->first_qset];
-	__netif_tx_lock(q->txq, smp_processor_id());
+	__netif_tx_lock(q->txq, raw_smp_processor_id());
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	credits = txq_avail(&q->q) - ndesc;



