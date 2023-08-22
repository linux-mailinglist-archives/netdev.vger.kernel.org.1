Return-Path: <netdev+bounces-29497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A2783812
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782DA1C209E2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECBA3B;
	Tue, 22 Aug 2023 02:40:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7F7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:40:55 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EDFCC8
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692672028; x=1724208028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=froljM2ApvXohr7GiU1HON6VlUr8Aoc+2G1FAxOy5qc=;
  b=Zfbs4mrSIOVQ+lJ0XKBGZJKzp31X4+OxJuyzWSaW0KzQlisF9cDydfRn
   /WSvW8jOc1wv/U6G94aCgeYJrmtowbkOPXsijzk/zjWUsFmBUOcQ3zH1Y
   CG13LkNHNBQ8QZy0OIgGnZintzb+9OKRiCLzOVaT5HnDlJ5UIdq0xV4nt
   s=;
X-IronPort-AV: E=Sophos;i="6.01,191,1684800000"; 
   d="scan'208";a="603264607"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:40:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id CD29280E11;
	Tue, 22 Aug 2023 02:40:22 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 02:40:21 +0000
Received: from 88665a182662.ant.amazon.com (10.135.203.70) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 22 Aug 2023 02:40:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] net: Allow larger buffer than peer address for SO_PEERNAME.
Date: Mon, 21 Aug 2023 19:40:11 -0700
Message-ID: <20230822024011.4978-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821191113.72311580@kernel.org>
References: <20230821191113.72311580@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.203.70]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 21 Aug 2023 19:11:13 -0700
> On Fri, 18 Aug 2023 17:55:52 -0700 Kuniyuki Iwashima wrote:
> > For example, we usually do not know the peer name if we get an AF_UNIX
> > socket by accept(), FD passing, or pidfd_getfd().  Then we get -EINVAL
> > if we pass sizeof(struct sockaddr_un) to getsockopt(SO_PEERNAME).  So,
> > we need to do binary search to get the exact peer name.
> 
> Sounds annoying indeed, but is it really a fix?

So, is net-next preferable ?

I don't have a strong opinion, but I thought "Before knowing the peer
name, you have to know the length" is a bug in the logic, at least for
AF_UNIX.

