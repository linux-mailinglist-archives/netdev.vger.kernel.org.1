Return-Path: <netdev+bounces-150454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0E9EA498
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC961888F46
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9232AE93;
	Tue, 10 Dec 2024 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mlX/pZAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECC1EB3D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796071; cv=none; b=mi6zuxsfZOV7zk4hJAz0CTdsrv90clYwPQYJAieQuGRP5E/V9Vz4Uk0/2xfnTj5Ochu8VldkiwLxe1Y70CmpMYb67ZvGZUUruXKfm5BTaLaLwHrlCiUk3yfgLTX/IMOAbo4nB2ZO3BFZFVoKIKRKFeBkXvI/FX8QNV+mJ2mrQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796071; c=relaxed/simple;
	bh=aRM1xZUh02CrChTdPKpoTd7fDfZlqD6aFfZ1E6TrF2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjS5V7GR0sZamLcgs7XPFnfv3MjQhQlNrGGu93EQTDFirT6d+wAzCp1KWXhf55JxEQPVv3E4+MkJbQpQK10PZgePeMy4DD7ayolewteP8R8GkLMFqUlBPgtfMHHGE7m4/Zxmnw8sOdRSyPGojEu2d67QZZPRLkG03Zr8JBUg8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mlX/pZAd; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733796070; x=1765332070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBZLGY7OvcNBoKKf60w8xCnxXIkzj/96W2HEaTIjXSc=;
  b=mlX/pZAdLYkAj9Kyt2A6cCtLQqg/L8DaP5GLlnRsZRyAGSVBXLWVmCpD
   QdA1Q8e0fWtPP5ocXnSxrp1bxnCL0+A3q1SxD+plpN1N76JQrXaODLNj4
   6bjTwgz+fdVcYunZKY51LAGeMUUkXgo458uHkwVOVfjsaeWNzMp3+aozd
   0=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="391806603"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 02:01:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:56986]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id 569882b4-2160-47a9-bcaa-5c8167433d04; Tue, 10 Dec 2024 02:01:03 +0000 (UTC)
X-Farcaster-Flow-ID: 569882b4-2160-47a9-bcaa-5c8167433d04
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 02:01:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 02:01:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dave.seddon.ca@gmail.com>
CC: <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: tcp_diag for all network namespaces?
Date: Tue, 10 Dec 2024 11:00:57 +0900
Message-ID: <20241210020057.26127-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
References: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: dave seddon <dave.seddon.ca@gmail.com>
Date: Mon, 9 Dec 2024 11:24:18 -0800
> G'day,
> 
> Short
> Is there a way to extract tcp_diag socket data for all sockets from
> all network name spaces please?

I think there's no such interface.

I remember there was a similar request for TCP BPF iterator,
but now it's difficult because each netns could have its own
TCP hash table for established connections.


> 
> Background
> I've been using tcp_diag to dump out TCP socket performance every
> minute and then stream the data via Kafka and then into a Clickhouse
> database.  This is awesome for socket performance monitoring.
> 
> Kubernetes
> I'd like to adapt this solution to <somehow> allow monitoring of
> kubernetes clusters, so that it would be possible to monitor the
> socket performance of all pods.  Ideally, a single process could open
> a netlink socket into each network namespace, but currently that isn't
> possible.
> 
> Would it be crazy to add a new feature to the kernel to allow dumping
> all sockets from all name spaces?

Iterating netns in userspace is much simpler than in kernel that needs
iterating net_namespace_list under net_rwsem and remembering the last
netns with the refcount bumped.


> 
> Maybe I'm missing some other better option(s)?
> 
> Thanks in advance

