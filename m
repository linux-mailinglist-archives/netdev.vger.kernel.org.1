Return-Path: <netdev+bounces-178414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68065A76F5F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCCF1881998
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A87213E91;
	Mon, 31 Mar 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jBvrjUNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636EA1BBBFD
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453202; cv=none; b=puxpSWf87dZ1ICOzgr5xWrfUEDNBiVmSdIjzx5jxWvPpRINu382ysIThmIM7n1O2qND1Jwx7HzetlY6T4DFNxDkRDBn60rP9S4HhS+01d9iTxiI/xjfmA3oQuQJ/ZK9M32AV0HY5bHmAYrAY/SdvxHicEW8BHYJvXwpLzDADhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453202; c=relaxed/simple;
	bh=plnMsM57EoUO7hrAeMifabkaEJDkWm8t0oZrFr7VccA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPkrBzkTyj22/4zIEX7OQp/QLz1+cAK7+xo0ucGy0ya6VMymoxThYLCh20ArXqbB+ms83Mw590T6yxRl4TW6lPn4ANfGCuq18mFAhK9u03Iee90lJViyh31A3Jydejum2RMBUejUwyvekcVq6HHcAfW6m4Pkj5YklwilqE2LUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jBvrjUNV; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743453201; x=1774989201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yxhec+hwkUOmygMkgmM9nPC5g+E+Oy0Yu39iszRWMVE=;
  b=jBvrjUNVVqcSB51UGE7qY5kgTjjf1EatLB3Jz5vSu/ahOkqM4vas7vBW
   EfK36K4psCqtiytcOBbBo6VSbRJrqmFLG0XVEZwOR57tpYtlLOqP7F2kn
   l54pQDW5oBLnABuou9QlzXswuJx86xorju9vg4v/QK0BmYmcHoPMAXBsD
   A=;
X-IronPort-AV: E=Sophos;i="6.14,291,1736812800"; 
   d="scan'208";a="731548241"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 20:33:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:54180]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id f5f81f46-58e6-4f98-8263-900b9314c403; Mon, 31 Mar 2025 20:33:14 +0000 (UTC)
X-Farcaster-Flow-ID: f5f81f46-58e6-4f98-8263-900b9314c403
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 20:33:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 20:33:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Mon, 31 Mar 2025 13:31:47 -0700
Message-ID: <20250331203303.17835-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331185515.5053-1-kuniyu@amazon.com>
References: <20250331185515.5053-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 31 Mar 2025 11:54:53 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 31 Mar 2025 11:36:03 -0700
> > On Mon, 31 Mar 2025 11:21:34 -0700 Kuniyuki Iwashima wrote:
> > > > Plus we also see failures in udpgso.sh  
> > > 
> > > I forgot to update `size` when skb_condense() is called.
> > > 
> > > Without the change I saw the new test stuck at 1 page after
> > > udpgso.sh, but with the change both passed.
> > > 
> > > Will post v5.
> > 
> > Please do test locally if you can.
> 
> Sure, will try the same tests with CI.

Is there a way to tell NIPA to run a test in a dedicated VM ?

I see some tests succeed when executed solely but fail when
executed with

  make -C tools/testing/selftests/ TARGETS=net run_tests

When combined with other tests, assuming that the global UDP usage
will soon drop to 0 is not always easy... so it's defeating the
purpose but I'd drop the test in v5 not to make CI unhappy.

