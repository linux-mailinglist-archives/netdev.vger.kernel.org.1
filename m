Return-Path: <netdev+bounces-132771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3019931A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2853F28424D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC561D9321;
	Mon,  7 Oct 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lT0hyBAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797D1D7E3D
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315747; cv=none; b=fmCfe8wfARDz1e6zjN4ML8B5pVwqS4T87Vi11kb0kSSg5s8ITAhZVT0eJRi0fjS4TF4nv7gINAL269dd48uTll+ehnFnazAT3l+sqTeZ/ct1iQl2GumoQfOL4uCx4jVvjRPBJAs+j/82olYsbcl8uv+eRXhUlEcPCOuCE/2b2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315747; c=relaxed/simple;
	bh=TqLKueBMqf9jTKYen4U+juDcJr2WjeOMHHozB2f2kks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klrNPgdTj5Ix/zY1CzIgQmq3vvw9Bj/jr87yIh5hwmfuvdsHYe/lElxMlmkbhDPlnk4WMJMkv0sNhDp0eQadmsesXWUsCSRYl70M9Vgu80JAVBwD/RBqu7wiz40X/yUP05wT3P3jJixqEsxZreUkX2+0Mkk517BzBezjaS6cHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lT0hyBAb; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728315746; x=1759851746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUNTW725DQeC3Z+ZhdGlU1B6jsQEQ89jS8JqIAkvLfA=;
  b=lT0hyBAbZNlXPzoBBqrH8VzKHPV5iKkxxzIL0UUXTvIp3jZgd+iHyNO2
   MIZu/5DHR7RVfyXWUkoXN22ilFMvmKzvPdqsP8ObF9Bz1WIh5e6SxHEHl
   l7T4LShNcvYD8Wnm94p6Xf3+BYcem2XyAkn1WHO8LtL6Ru+z9VxulEvr9
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="237359171"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 15:42:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:35572]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id f972aa19-53be-4014-a4c9-4b961062f212; Mon, 7 Oct 2024 15:42:21 +0000 (UTC)
X-Farcaster-Flow-ID: f972aa19-53be-4014-a4c9-4b961062f212
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 15:42:20 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 15:42:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ebiederm@xmission.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 08:42:10 -0700
Message-ID: <20241007154210.22366-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87h69ohsgj.fsf@email.froward.int.ebiederm.org>
References: <87h69ohsgj.fsf@email.froward.int.ebiederm.org>
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

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 07 Oct 2024 09:56:44 -0500
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> 
> > Since introduced, mpls_init() has been ignoring the returned
> > value of rtnl_register_module(), which could fail.
> 
> As I recall that was deliberate.  The module continues to work if the
> rtnetlink handlers don't operate, just some functionality is lost.

It's ok if it wasn't a module.  rtnl_register() logs an error message
in syslog, but rtnl_register_module() doesn't.  That's why this series
only changes some rtnl_register_module() calls.


> 
> I don't strongly care either way, but I want to point out that bailing
> out due to a memory allocation failure actually makes the module
> initialization more brittle.
> 
> > Let's handle the errors by rtnl_register_many().
> 
> Can you describe what the benefit is from completely giving up in the
> face of a memory allocation failure versus having as much of the module
> function as possible?

What if the memory pressure happend to be relaxed soon after the module
was loaded incompletely ?

Silent failure is much worse to me.

rtnl_get_link() will return NULL and users will see -EOPNOTSUPP even
though the module was loaded "successfully".

