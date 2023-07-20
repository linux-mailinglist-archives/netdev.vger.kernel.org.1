Return-Path: <netdev+bounces-19584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA975B475
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F1B282061
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B961BE6A;
	Thu, 20 Jul 2023 16:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670A1BE67
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:33:20 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7426A3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689870792; x=1721406792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmRajQXKkcNjMDK3HL+kyKX0cjPf7kuHKljPPTIyBsU=;
  b=HPJy23B2sf5PfPSZspRTFnwMm74TqbZ7tWrb61fiX6LOfujOW1wpdWlq
   jZHOxifIXGYJTQ+HkyKA/5bsCXIXUVKDVDBB4d1CoDiKBl5qRf1+Xyz9U
   qcam9IZul9D2XzgeQCihJRFJW0EeWJMnIWswc9fRAIJtZ8G/S7abK4xPn
   A=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="573284630"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 16:33:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id 5712F80F98;
	Thu, 20 Jul 2023 16:33:08 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 16:32:55 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 16:32:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <leitao@debian.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
Date: Thu, 20 Jul 2023 09:32:43 -0700
Message-ID: <20230720163243.640-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <64b93bb6d30dd_2ad92129482@willemb.c.googlers.com.notmuch>
References: <64b93bb6d30dd_2ad92129482@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 20 Jul 2023 09:50:46 -0400
> Kuniyuki Iwashima wrote:
> > Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
> > applying strict rules to standard string functions.
> > 
> > It does not work well with conventional socket code around each protocol-
> > specific struct sockaddr_XXX, which is cast from sockaddr_storage and has
> > a bigger size than fortified functions expect.  (See Link)
> > 
> > We must cast the protocol-specific address back to sockaddr_storage
> > to call such functions.
> > 
> > However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
> > unclear as the buffer is defined by char[128] which is the same size as
> > sockaddr_storage.
> > 
> > Let's use sockaddr_storage implicitly.
> 
> explicitly

Will fix in v2, thanks!


>  
> > Link: https://lore.kernel.org/netdev/20230720004410.87588-1-kuniyu@amazon.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

