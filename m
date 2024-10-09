Return-Path: <netdev+bounces-133970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B9997944
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C11C20D6F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45941922C4;
	Wed,  9 Oct 2024 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oolEmO5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D317B500
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517632; cv=none; b=UYmlCOXHmYO6MfHmbljuxW7JbIsC19O5kVxRGU9AjJLuclrlpfry2ESQ8u4Qp7QVWs6HiDTXj7uaTvOmSdvUhuIpRHCyvouIp2D903Ed9TfjLxPWwFR4RvvKlACQSJV5GVz2Rc/jie9nkNyrxD+jGQJbRQFci/V+lOkJFb/BSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517632; c=relaxed/simple;
	bh=yeuccXA62QEkyelLn+/ZTQs/IU2iNQBjLOgo5hnLQeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8t7N1ljpk7U5Y6wuo+EhcnME8OgHH11OzyRTYFThaQliW1snTAQrAnOaAsGwdwjNxAxdX6xxEM0tLaBpeN2zWknoGvCnEN2e6tEqdWLFQ6JBQUT0N/F1KoZu3SNsnFDzZT8uTyML7UUc1rNsGUO5AG+eC/b3BiJ5T7Ir40W4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oolEmO5c; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728517631; x=1760053631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vU6f2B+9bVyvVi2WGXbZBqjbDmrePTgY6G06Uqu4buM=;
  b=oolEmO5c7q9nJBlYwefZx5cSw36ujPymRvQIzspAwsqKgdW/YnWOSakZ
   DgKzK0jhpNkETjlfctxtScsSsT3mRlMUTvJQRmelYN+Wn0SnBoyMqSwfI
   x1rbJRpb7nrnI86+5IUgETurDUPEix00tDzXcpFbdGgc0+LspoGzsQ0kp
   w=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="137239273"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:47:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:21096]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id d624e1d7-e8b6-4cc1-abd0-64f4543127f6; Wed, 9 Oct 2024 23:47:10 +0000 (UTC)
X-Farcaster-Flow-ID: d624e1d7-e8b6-4cc1-abd0-64f4543127f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:47:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:47:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/5] fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
Date: Wed, 9 Oct 2024 16:47:03 -0700
Message-ID: <20241009234703.60192-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009184405.3752829-2-edumazet@google.com>
References: <20241009184405.3752829-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  9 Oct 2024 18:44:01 +0000
> Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.
> 
> Writes are protected by RTNL.
> We can use READ_ONCE() on readers.
> 
> Constify 'struct net' argument of fib_rules_seq_read()
> and lookup_rules_ops().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

