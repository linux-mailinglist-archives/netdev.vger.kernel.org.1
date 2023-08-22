Return-Path: <netdev+bounces-29719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AB78471A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D623F281055
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B71DDD3;
	Tue, 22 Aug 2023 16:25:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D01D2E6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:25:12 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57255137
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692721511; x=1724257511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nc2Hsov0d/vti+NNY/7HsQIDEN4/xp9cWwGFVgalEK0=;
  b=QXPfw0VKhfGoeqTFkr7DK/thugWsOZr2FWKA52yxH+DRl97xUV7LzRFY
   1YzFb/91mfijmmcg6NS+ZVuPVzrGG4ZKqbjEb/xioa///Refe/mgX/ah2
   bboSYj19qIe0yidbBxJFA4pfLjS7RMloszBGkEh/Cn8hr+M8+zg2E70F+
   4=;
X-IronPort-AV: E=Sophos;i="6.01,193,1684800000"; 
   d="scan'208";a="600044424"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 16:25:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 8AE14A35BD;
	Tue, 22 Aug 2023 16:25:07 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 16:24:55 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Tue, 22 Aug 2023 16:24:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] net: Allow larger buffer than peer address for SO_PEERNAME.
Date: Tue, 22 Aug 2023 09:24:43 -0700
Message-ID: <20230822162443.28625-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1d3b98744dfe0ad0f276239b67e84c26c88aa03e.camel@redhat.com>
References: <1d3b98744dfe0ad0f276239b67e84c26c88aa03e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.30]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 22 Aug 2023 10:43:06 +0200
> On Mon, 2023-08-21 at 19:40 -0700, Kuniyuki Iwashima wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Mon, 21 Aug 2023 19:11:13 -0700
> > > On Fri, 18 Aug 2023 17:55:52 -0700 Kuniyuki Iwashima wrote:
> > > > For example, we usually do not know the peer name if we get an AF_UNIX
> > > > socket by accept(), FD passing, or pidfd_getfd().  Then we get -EINVAL
> > > > if we pass sizeof(struct sockaddr_un) to getsockopt(SO_PEERNAME).  So,
> > > > we need to do binary search to get the exact peer name.
> > > 
> > > Sounds annoying indeed, but is it really a fix?
> > 
> > So, is net-next preferable ?
> > 
> > I don't have a strong opinion, but I thought "Before knowing the peer
> > name, you have to know the length" is a bug in the logic, at least for
> > AF_UNIX.
> 
> I'm unsure we can accept this change: AFAICS currently
> getsockopt(SO_PEERNAME,... len) never change the user-provided len on
> success. Applications could relay on that and avoid re-reading len on
> successful completion. With this patch such application could read
> uninitialized data and/or ever mis-interpret the peer name len.
> 
> If the user-space application want to avoid the binary search, it can
> already call getpeername().

Ah exactly, getppername() has the same behaviour with this patch
in move_addr_to_user().

