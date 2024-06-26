Return-Path: <netdev+bounces-107064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA81919A17
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B473B2468E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C48194080;
	Wed, 26 Jun 2024 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ibIDb6jX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B0433B3
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438439; cv=none; b=ss0/tIMNRKHm48eZ6PQx1OBX/1/bl1I2ywwJikAXm74IieNKMeM42AUO9+UdbVJLaUnsFj91PfptJF0w+09KrlZs0o8an/elwWZTAD8MlrajRvPsgjipylgA6hX27qpdsezwqTbgIWylk8biTWTXMjyd6oVwpmzO1rdUAdVoNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438439; c=relaxed/simple;
	bh=6AuNh0k9OAN2+Z1UQLw1EriPhw8qW30fEODy1P5eJns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4+u0EXR1kmzgMiRSNVkIuRnr6F2EhkohMyxB8Eo8VORJwDQGVQajzNow4o5FV4UjOb1YV65Bjffv7APETSVGZXaTj3CGKjUxvVLEZjC2mnBfhm5TpNzY41MnDRsNT0dmwsaNwl3a6TP7PI1xXKMZB4IzWMigIAyZ4Krik2tQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ibIDb6jX; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719438438; x=1750974438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqj6ulj2j3IhCsQVZcyvbTV1MyAjMPkKWpPvEplpi3Y=;
  b=ibIDb6jXusnjvtNGcUQfa0j85auYZzrtlEE2+2uZHsNIHMd6pvAa0iCP
   U/4evVpfX/PEQsON2B+Zaj7CBh/W3dQJ47wJiodNYU8cXAoMEpw4pB4Wu
   vDZRufjahHqfHl5Ba/jz3CHiYXc/lvM82vufo3N5SxxMb65XAE+d508Q5
   w=;
X-IronPort-AV: E=Sophos;i="6.08,268,1712620800"; 
   d="scan'208";a="736396767"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:47:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28117]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.187:2525] with esmtp (Farcaster)
 id 04b62f80-2861-427e-b5e2-0593470934c9; Wed, 26 Jun 2024 21:47:11 +0000 (UTC)
X-Farcaster-Flow-ID: 04b62f80-2861-427e-b5e2-0593470934c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 21:47:10 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 26 Jun 2024 21:47:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <Rao.Shoaib@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net 03/11] af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
Date: Wed, 26 Jun 2024 14:47:00 -0700
Message-ID: <20240626214700.5631-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
References: <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 26 Jun 2024 23:10:40 +0200
> On Wed, 2024-06-26 at 18:56 +0200, Paolo Abeni wrote:
> > On Mon, 2024-06-24 at 18:36 -0700, Kuniyuki Iwashima wrote:
> > > After consuming OOB data, recv() reading the preceding data must break at
> > > the OOB skb regardless of MSG_PEEK.
> > > 
> > > Currently, MSG_PEEK does not stop recv() for AF_UNIX, and the behaviour is
> > > not compliant with TCP.
> > 
> > I'm unsure we can change the MSG_PEEK behavior at this point: existing
> > application(s?) could relay on that, regardless of how inconsistent
> > such behavior is.
> > 
> > I think we need at least an explicit ack from Rao, as the main known
> > user.
> 
> I see Rao stated that the unix OoB implementation was designed to mimic
> the tcp one:
> 
> https://lore.kernel.org/netdev/c5f6abbe-de43-48b8-856a-36ded227e94f@oracle.com/
> 
> so the series should be ok.
> 
> Still given the size of the changes and the behavior change I'm
> wondering if the series should target net-next instead.
> That would offer some time cushion to deal with eventual regression.
> WDYT?

The actual change is 37 LoC and we recently have this kind of changes
(30 LoC in total) in net.git.  The last two were merged in April and
we have no user report so far.

  a6736a0addd6 af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
  22dd70eb2c3d af_unix: Don't peek OOB data without MSG_OOB.
  283454c8a123 af_unix: Call manage_oob() for every skb in unix_stream_read_generic().

Most of the changes are due to selftest.  The original test repeated the
same set of code but covered few cases.  OTOH, the new test spends most
of lines to add as many test cases as possible, which IMHO nicely covers
regression if we want to mimic TCP.

  On net.git:

  # FAILED: 20 / 38 tests passed.
  # Totals: pass:20 fail:18 xfail:0 xpass:0 skip:0 error:0

Also, now the original test is broken in stable after the commits above,
so I think it would be nice to have this series in stable.

Thanks!

