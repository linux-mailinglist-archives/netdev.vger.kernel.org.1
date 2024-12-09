Return-Path: <netdev+bounces-150043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29879E8B9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DB2281615
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC320FA9A;
	Mon,  9 Dec 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dVt0Sb4a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665751E4A4
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726573; cv=none; b=AY+YIcQTAEPcSQzb10ruK2vLFsds/K0Oz8jrOp7V22PNsSFgqffoSf1OBOI5ftHDyqJofMfEMu5OzKWVBzNeTS0ZS8dPFWM4I5B/GNwU/FFKWT4gdig8qph////LFBqqGmSDGJJxbnR+XJCwXA3ygJ9Q7YsXI6OO2HKZudDDAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726573; c=relaxed/simple;
	bh=AJZZjliWJW8m4PkR5mjAobUKxgxdwvSe80nUnEdzbDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmkv5HTXrnzhafbTGomuXYQ0omkSu9vTTzYxOJzI5xzXABc3uDsUSezs3ylKkevvIWv9ex6ijZ1YeZJzhiEL98EBj8fHlcxHOlA7YlWby5EwS72XzQcBurb4Z2X9YC6It+h1UabjmJy6k8dtsAt7AHs6/IdDEwoaKUMADbetfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dVt0Sb4a; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733726572; x=1765262572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zffpAM3VgYaM0O9KhZGJ6IIidR+AehOiZ+CFyd2IZBw=;
  b=dVt0Sb4aCQyHB0il+OYq5+RhWF7nDOTnavzRr9hwG9nZg+Jbdwv1Sgt/
   9sv0W6fS3qflORLbFqShbStF4cnyllJx46/RJI2rf+n4DItfcFvFtqOvC
   jM8DOR7DQie6tFBGIeI/vvLP/t2zYGfR3l8Kohcr3GiSDxcZfD6xcIWSR
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,218,1728950400"; 
   d="scan'208";a="154157690"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 06:42:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:51083]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id a96e32b4-823a-4fc1-bf6b-80724919ce1c; Mon, 9 Dec 2024 06:42:50 +0000 (UTC)
X-Farcaster-Flow-ID: a96e32b4-823a-4fc1-bf6b-80724919ce1c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 06:42:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.254.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 06:42:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <david.laight@aculab.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 00/15] treewide: socket: Clean up sock_create() and friends.
Date: Mon, 9 Dec 2024 15:42:43 +0900
Message-ID: <20241209064243.20600-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241209052643.9896-1-kuniyu@amazon.com>
References: <20241209052643.9896-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 9 Dec 2024 14:26:43 +0900
> > >   2) some subsystems use sock_create(), but most of the sockets are
> > >      not exposed to userspace via file descriptors but are exposed
> > >      to some BPF hooks (most likely unintentionally)
> > 
> > AFAIR the 'kern' flag removes some security/permission checks.
> 
> Right.

This wasn't always true.

Currently, SELinux and AppArmor supports the socket_create hook
and do nothing if kern=0, but Smack supporting socket_post_create
does not care about kern.

Also, we can enforce security for kernel sockets with BPF LSM.

