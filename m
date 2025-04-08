Return-Path: <netdev+bounces-180051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2523A7F4B9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5CB3A64FF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB24261366;
	Tue,  8 Apr 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="stRNo9MQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C861B21AA;
	Tue,  8 Apr 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092509; cv=none; b=Hx+nCdjboT1kTilWdexsa+sjAbGMuhDn2SJMg7Khbw6AuxmbzG4tk9ZZ0qnY5LdJ7VVuVe/+tq74tv+Y7FakN254f3YcNoVFzvnl8J9dYG1xwRRnYEGFIs7vdApesSrDIpq8snShKvyJ3ChYukzr8Kb+AIWJlQJdV3VuI/5Y9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092509; c=relaxed/simple;
	bh=dE/3mxg4aDk8ZVqEmroY44DZ5XwUFIHKJcLTBMq23Qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdIJARo9dboLTYAgG3fyw7qKV7iE6MC+qNLNldHzFUdOdJKQ2xXUkJzkY2dfbbWUciOUIq9wE8W7EVbC8mEozaNyAS83sdnPsxrT7MKDFqqT507dleAdD5f0YhPGlR0jzAy4vBUIlZpUsIv1Pb0LnsX83evvFCfjI/cp/LW878U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=stRNo9MQ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744092507; x=1775628507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkQR+Pqjxb7qD2vxoEoYXOmPzl6qLR7UVCq3LQivBf8=;
  b=stRNo9MQ6mAp2KV/6Khe0tF4/IEOXpegBc6Hn7pR0m87de0ux6aJlbdt
   enair4U0FrO2HVDnEpzaPWEOkejPJkPLXSfekRBmvz6R0yhsACx+sGBHq
   ZjbYlrMInPFuNg6wHkIgnBh2z+MJOYoKQEJTyNRRsW9dcgsSih8P5aPqJ
   E=;
X-IronPort-AV: E=Sophos;i="6.15,197,1739836800"; 
   d="scan'208";a="814217596"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:08:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35289]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 7e2c9346-85be-47ed-8283-ea868b0c771a; Tue, 8 Apr 2025 06:08:21 +0000 (UTC)
X-Farcaster-Flow-ID: 7e2c9346-85be-47ed-8283-ea868b0c771a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 06:08:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 06:08:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>,
	<sagi@grimberg.me>, <shaopeijie@cestc.cn>, <zhang.guanghui@cestc.cn>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 23:08:05 -0700
Message-ID: <20250408060810.19654-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408055830.GA708@lst.de>
References: <20250408055830.GA708@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 Apr 2025 07:58:30 +0200
> On Mon, Apr 07, 2025 at 10:55:27PM -0700, Kuniyuki Iwashima wrote:
> > Which branch/tag should be based on, for-next or nvme-6.15 ?
> > http://git.infradead.org/nvme.git
> 
> nvme-6.15 is the canonical tree, but for bug fixes I'm fine with
> almost anything :)

Thanks, will post a patch tomorrow :)

