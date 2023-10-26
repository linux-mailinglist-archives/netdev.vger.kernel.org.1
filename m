Return-Path: <netdev+bounces-44607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2B7D8C44
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D494F2821A7
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C702B3FB3B;
	Thu, 26 Oct 2023 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D+F0CTca"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BA3C6B2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:39:36 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21ED58
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698363576; x=1729899576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zb795HRfWpwZfurHjJ/VXoss9A1dVcgsGzpyu/ZbWHE=;
  b=D+F0CTcaBt+8IoSpuxQJfqWdbSU7sX7DGzgSeIpU012Bajyq6kB1jaXK
   N6YxzKgvlC5D8Xjpek8oc3mS9DjqIrKpD/eGSs0k072pRz05i6q7AIqu/
   ZQ6QEm+vXFgRo6QOectWcRsGg47f2FAMcZEnz2KN9Y5VGlso6GGad9NPI
   M=;
X-IronPort-AV: E=Sophos;i="6.03,255,1694736000"; 
   d="scan'208";a="248056367"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:39:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 3735F48831;
	Thu, 26 Oct 2023 23:39:27 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:16458]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.227:2525] with esmtp (Farcaster)
 id df466884-ee17-4445-8fe4-5e42f7ec12b1; Thu, 26 Oct 2023 23:39:27 +0000 (UTC)
X-Farcaster-Flow-ID: df466884-ee17-4445-8fe4-5e42f7ec12b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 23:39:26 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Thu, 26 Oct 2023 23:39:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <corbet@lwn.net>, <daniel@iogearbox.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <lixiaoyan@google.com>,
	<mubashirq@google.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <pnemavat@google.com>, <weiwan@google.com>,
	<wwchao@google.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
Date: Thu, 26 Oct 2023 16:39:14 -0700
Message-ID: <20231026233914.57439-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231026071701.62237118@kernel.org>
References: <20231026071701.62237118@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.42]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 26 Oct 2023 07:17:01 -0700
> On Thu, 26 Oct 2023 08:19:55 +0000 Coco Li wrote:
> > Set up build time warnings to safegaurd against future header changes
> > of organized structs.
> 
> TBH I had some doubts about the value of these asserts, I thought
> it was just me but I was talking to Vadim F and he brought up 
> the same question.
> 
> IIUC these markings will protect us from people moving the members
> out of the cache lines. Does that actually happen?
> 
> It'd be less typing to assert the _size_ of each group, which protects
> from both moving out, and adding stuff haphazardly, which I'd guess is
> more common. Perhaps we should do that in addition?

Also, we could assert the size of the struct itself and further
add ____cacheline_aligned_in_smp to __cacheline_group_begin() ?

If someone adds/removes a member before __cacheline_group_begin(),
two groups could share the same cacheline.



