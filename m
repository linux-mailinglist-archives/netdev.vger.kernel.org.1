Return-Path: <netdev+bounces-106730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D097C9175AB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECDE1C21AD6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA3B65A;
	Wed, 26 Jun 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OVINphNE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541C12E6A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365479; cv=none; b=Q05mCXVSxBVQEShRExcahiV8WCSxRLqQoqfkWA8GOROKnGSHTTsG34MjRvOxSgn4/tN7D1COgpdtfrG52IVYyMT9tozoBUizakdGCh8WEU3+fm9EDhlnHfCzhWVw6snZWQBU87bhxU9svPfsfAhyuW29zFo8NH0Mj0+USb7SQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365479; c=relaxed/simple;
	bh=brFioV20IEk2eMyQt+X9iqPqGg9Mqp+WTq8rkMnPOMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhgSB6muQNlV1pO81XXfVwNaRFxuQH1iUKgn81oFChfUluEqXHb+zE8RsvTX4R6qypWWcfTeSWV8QRuDNtsbw229VaH/xRn79V+E1xrJFiBG9sZ1qari5DLsRo4XKuYr9mY+xjZTug2PxUS1FxpQ817can5dgbgxw8cllOcaJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OVINphNE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719365478; x=1750901478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJ2qar6rPKZF3o7Qs6aRwyXlt3LewY0TUCfc7S5FjDU=;
  b=OVINphNEn5hLTd91RxZop+XKOROqm5XXYxiqmsVGXf4RWvtiHiXyWbpM
   zfAvt4BJ+S02dRfjn0/WoX/gjLgxCCdADTP5rcR81FzaRx7E1Z44u5rhl
   e2K31AWJlWAE5rOUxRt87f0burzA13KEKK0fukcvvCqhvK23bGQ6kVmSY
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,265,1712620800"; 
   d="scan'208";a="99565132"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:31:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:56493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.229:2525] with esmtp (Farcaster)
 id 17a627d8-5e87-4549-86aa-1ce739e61f6f; Wed, 26 Jun 2024 01:31:16 +0000 (UTC)
X-Farcaster-Flow-ID: 17a627d8-5e87-4549-86aa-1ce739e61f6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 01:31:15 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 01:31:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <Rao.Shoaib@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net 00/11] af_unix: Fix bunch of MSG_OOB bugs and add new tests.
Date: Tue, 25 Jun 2024 18:31:03 -0700
Message-ID: <20240626013103.86122-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625174318.76c8a57d@kernel.org>
References: <20240625174318.76c8a57d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Jun 2024 17:43:18 -0700
> On Mon, 24 Jun 2024 18:36:34 -0700 Kuniyuki Iwashima wrote:
> > This series rewrites the selftest for AF_UNIX MSG_OOB and fixes
> > bunch of bugs that AF_UNIX behaves differently compared to TCP.
> 
> I like pairing the fix with the selftest, but at the same time
> "let's rewrite the selftest first" gives me pause. We have 40 LoC
> of actual changes here and 1000 LoC of test churn.
> 
> I guess we'll find out on Thursday if we went too far :)

I hope it's worth for finding 4 AF_UNIX bugs and 2 ancient TCP ones,
let's see 🤞


> 
> >  net/unix/af_unix.c                            |  37 +-
> >  tools/testing/selftests/net/.gitignore        |   1 -
> >  tools/testing/selftests/net/af_unix/Makefile  |   2 +-
> >  tools/testing/selftests/net/af_unix/msg_oob.c | 734 ++++++++++++++++++
> >  .../selftests/net/af_unix/test_unix_oob.c     | 436 -----------
> >  5 files changed, 766 insertions(+), 444 deletions(-)
> >  create mode 100644 tools/testing/selftests/net/af_unix/msg_oob.c
> >  delete mode 100644 tools/testing/selftests/net/af_unix/test_unix_oob.c

