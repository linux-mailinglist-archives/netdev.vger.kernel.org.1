Return-Path: <netdev+bounces-90211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2018AD1BA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143F41F2449A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58C153588;
	Mon, 22 Apr 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TuOMPPnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D7153BCE
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802641; cv=none; b=paxW+dy3VjtmLfxlvvlZzybmzuQTBA6hUTG9DnVv5+Vh2s5eCJ89f8TevPJ3Ngjt1PxVQBOoc+2gj0ZiqAxGBTLlgFFnmpWcuqeA0/0HYyZ8Y8X4zpjGADLUlYDPTvM2/tGg0GT5fyo1xPaBWb2LlkAA6JIHbMOh0tGRwQEsf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802641; c=relaxed/simple;
	bh=kPtHa1h75L0L9bPKO9qdnWB5Z/ik7V/Q4elzb5V6T+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=al3qkKiqgz24VVFEeJReke1R7VVTCHaMJqJtUQaVOEI2LQTxsXYAYyZeSb5zfmCqpZwb1oIrf3NrPeVHRKU8G+PNN4c/v7LHT9RxGS9W/wFsOAcPi1i1I1j4s3Jpm6+iD2Wi6QLkKrUOCA2bu6pCBiAIyJ9jUuxumfXyC8gbauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TuOMPPnH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713802639; x=1745338639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrah453q2MFwXAq9wjp65lEluNdemNuwyBu10e18TxE=;
  b=TuOMPPnHy9F49fdyHu2mNp0BeZGKZueBpuujYzT7jyp1s1wFA8CUQHCk
   Xbxz20i/RQ0xLoCJOWyCzywulPDTtLkXDRhB3dGgmFMBIz5YrFzcUx7DV
   Z/7ruhvXN+tMxrGIB/BwQ0hLEHF9kENCAHkttAD8PmpxVJtAQrdNVou5+
   A=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="290865115"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:17:17 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:7206]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.194:2525] with esmtp (Farcaster)
 id 57717e08-bd6f-460b-b357-06035a32e564; Mon, 22 Apr 2024 16:17:15 +0000 (UTC)
X-Farcaster-Flow-ID: 57717e08-bd6f-460b-b357-06035a32e564
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 16:17:15 +0000
Received: from c889f3b7ef0b.amazon.com (10.119.243.178) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 22 Apr 2024 16:17:13 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>
CC: <alisaidi@amazon.com>, <benh@amazon.com>, <blakgeof@amazon.com>,
	<davem@davemloft.net>, <dipietro.salvatore@gmail.com>, <dipiets@amazon.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v3] tcp: Add memory barrier to tcp_push()
Date: Mon, 22 Apr 2024 09:16:56 -0700
Message-ID: <20240422161656.60331-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CANn89iK69pB9y5eZTNjV6rH-2y3B2iAT2dnu13WfUPyPTBkTkw@mail.gmail.com>
References: <CANn89iK69pB9y5eZTNjV6rH-2y3B2iAT2dnu13WfUPyPTBkTkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)

We have tested the proposed solution and it doesn't introduce any regression in our benchmark. 
Moreover, looking to the assembly code, the `test_and_set_bit` generates an `ldsetal` and `dmb ish` instructions which are correct for the ARM architecture.
We do not see any concern with the proposed patch.

