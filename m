Return-Path: <netdev+bounces-138086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD79ABDB9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE1A1C2259D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D8136338;
	Wed, 23 Oct 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="le7EugvE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED54A3E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660703; cv=none; b=PhxNOqJF8aq0nCYXKEDR4dNca3IM9+jH6p99MBdfMj+2T4BJt9T1qGobJ3KgVrVrA5/0GpHmVJvz4qRGNiz4eTMVvail9C+bU6+PVGQwNmsBkzU93zW9TxsdwAaL/rz4MTfe0kTqQrchR39s8raLowbk97dSKQg4TzuUoKdjVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660703; c=relaxed/simple;
	bh=AYQxTk1nJCKKqt94OpWMPrI28t/rMbIpVTkfvDScfkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdG0fyxEbZaWBScCq6e7cHN9e6y18rZifo8OMOReyjJzSmbhdAK1r1QF0LxBklhO2GBdrCpCtZUg0aMAaKSqEtl5Dq2ZA2H/fMlRwi24sHqwlLYHVA2SInePNOnMc8+eFEe0+HeItkAtXNOWsDWOZ+/KYAudwte7AjsqqlAeloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=le7EugvE; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729660702; x=1761196702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ak4DivgXc9pHJJ/F5qdXQU3e1aBFfwzs1fxlk5eo2ck=;
  b=le7EugvEA5Nq+TpSBby35tShhF9d1rEKuOHg569y7A57p9BwJUHeRJkD
   IkCr0z8q2DAIvz0oYUPV2nXjRdYXSQOFmZpw9WJW2ULF3KGlkmeDUZd/8
   b+iLQNaMwod0PtZEIBkutWwbpBEfmWmBEOjQB4jVHSBIpcoBOMqA1rDLP
   4=;
X-IronPort-AV: E=Sophos;i="6.11,225,1725321600"; 
   d="scan'208";a="437034342"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:18:19 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:1472]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.247:2525] with esmtp (Farcaster)
 id 0e7a9493-fc75-4563-a3e3-0b62a3514190; Wed, 23 Oct 2024 05:18:17 +0000 (UTC)
X-Farcaster-Flow-ID: 0e7a9493-fc75-4563-a3e3-0b62a3514190
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 23 Oct 2024 05:18:16 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 23 Oct 2024 05:18:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stfomichev@gmail.com>
Subject: Re: [PATCH net-next v7 0/6] neighbour: Improve neigh_flush_dev performance
Date: Tue, 22 Oct 2024 22:18:11 -0700
Message-ID: <20241023051811.37782-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241023050110.3509553-1-gnaaman@drivenets.com>
References: <20241023050110.3509553-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Wed, 23 Oct 2024 05:01:10 +0000
> > Looks like the test is still unhappy. Can you try to run it on your side
> > before reposting? Or does it look good?
> 
> Hey,
> 
> Apologies if I missed anything.
> 
> I ran this before posting, after applying the entire series, and found no crashes:
> 
>     sudo make -C tools/testing/selftests run_tests TARGETS=net
> 
> Is there more info about this run?
> Was this ran on an intermediate patch in the series or all of it?

It seems the warning requires CONFIG_DEBUG_VM.

  [  110.446754][    C2] kernel BUG at include/linux/mm.h:1140!

But I guess the issue will disappear if you rebase the series on top of
Eric's patch and avoid calling free_pages() directly ?

https://lore.kernel.org/netdev/20241022150059.1345406-1-edumazet@google.com/

