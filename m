Return-Path: <netdev+bounces-84957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B615898C9E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5EA1F280B3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D91CF8D;
	Thu,  4 Apr 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="crmcg7X0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302271CA84
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249508; cv=none; b=nRCQacNqiFVraSXsLTGXOqAuWJEraJDXxS0E9qH/T4r/byYviMeYv/d3kBTKHQQjToHBdCSD8c+sHJYbVRdRZ2J7psiw003bgH+df8pDIJs9uA43WdNLTcQcqL8EWBN3xBlHxu09iCTDVcZ3JhhbUjTEv48jM+bRBu5ttzXCHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249508; c=relaxed/simple;
	bh=5GHxIqIaZSiUcLzA68T+68MGEWbAkKEI2p6G0znkmVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+A4zeMI6nHDO1fPrcM+jYQSRKavMfb6S+TQTf+ohQr+YA26Gg0t74xz2O3/yZXbLYh7W8Ry4uWIXQKS3MJVf8xJfmkeGiRkowXIYE1jDUURreJFPj2ZRhaIdxpa+kAr/m4kvUmhw8cFzYk+iwg5DmEUYbyuRhZcqMYH3w4BMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=crmcg7X0; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712249507; x=1743785507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVLRxbeQ5EzZjL0RSy5K8s1AjlhqEE+NWQjxq0FBIzw=;
  b=crmcg7X0Ax03EzNK/B4xkLANV3szRpGAhdSVPdJVCtLo6BLD+flP5hL9
   DeShgXypL9FJWUbFl+QCPujPa3eBn2lKlWf4n5tdLk6an2zIrqGVSYPCe
   ohHW9EAjPLJrMMvjwYDWEHXedj96Kkowe3V5ywqxugd1wy9UxxyjwaHQ+
   M=;
X-IronPort-AV: E=Sophos;i="6.07,179,1708387200"; 
   d="scan'208";a="409181991"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:51:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.87:2525] with esmtp (Farcaster)
 id 9b8d5aac-c919-4ea4-ad5c-d911de36d69a; Thu, 4 Apr 2024 16:51:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9b8d5aac-c919-4ea4-ad5c-d911de36d69a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 16:51:34 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 16:51:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next] ref_tracker: Print allocator task name.
Date: Thu, 4 Apr 2024 09:51:22 -0700
Message-ID: <20240404165122.2634-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8576a80ac958812ac75b01299c2de3a6485f84a1.camel@redhat.com>
References: <8576a80ac958812ac75b01299c2de3a6485f84a1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 04 Apr 2024 16:42:55 +0200
> On Wed, 2024-04-03 at 13:17 -0700, Kuniyuki Iwashima wrote:
> > @@ -208,6 +213,8 @@ int ref_tracker_alloc(struct ref_tracker_dir *dir,
> >  	}
> >  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
> >  	tracker->alloc_stack_handle = stack_depot_save(entries, nr_entries, gfp);
> > +	if (in_task())
> > +		get_task_comm(tracker->comm, current);
> 
> This apparently causes a lockdep splat, hit by the CI:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/537021/16-vrf-route-leaking-sh/stderr
> 
> it looks like get_task_comm() is for BH-only scope.

Ah exectly, I'll move it down to the spin_lock_irqsave() section below.

Thanks!

