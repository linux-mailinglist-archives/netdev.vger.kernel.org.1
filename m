Return-Path: <netdev+bounces-58719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A1817EA4
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304D61F21A68
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701E179;
	Tue, 19 Dec 2023 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O30SxQO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6527F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702944786; x=1734480786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6nPRE2aY6NvPNmezma7BYh31Uc3pgg74ZAFJLbzf6M=;
  b=O30SxQO4PFXNfcin1ux4b6h86EDF7QRIflvHMeDs9iyHnHM4XZk1SmS3
   r4F6xdrQm48PNq0p5OpydRahgbZftCrStpAjdEecUVvQ9fNH8c50iIHzo
   ACUts42EaSGxfu0Zgd2g1ZXk/n1EMoVHCTJ7s94xoesdTR8F3wRgsyqFq
   M=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="374873841"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:13:03 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id CDB6940D7E;
	Tue, 19 Dec 2023 00:13:01 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:45852]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id c87057a3-2411-46a4-b18c-df1dfbfc8d2b; Tue, 19 Dec 2023 00:13:01 +0000 (UTC)
X-Farcaster-Flow-ID: c87057a3-2411-46a4-b18c-df1dfbfc8d2b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:13:00 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:12:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 00/12] tcp: Refactor bhash2 and remove sk_bind2_node.
Date: Tue, 19 Dec 2023 09:12:48 +0900
Message-ID: <20231219001248.9294-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231218160121.34cf8a3c@kernel.org>
References: <20231218160121.34cf8a3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 18 Dec 2023 16:01:21 -0800
> On Wed, 13 Dec 2023 17:20:17 +0900 Kuniyuki Iwashima wrote:
> > This series refactors code around bhash2 and remove some bhash2-specific
> > fields; sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.
> > 
> >   patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
> >   patch 2 -  4 : optimise bind() conflict tests
> >   patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
> >                  remove sk_bind2_node
> > 
> > The patch 8 will trigger a false-positive error by checkpatch.
> > 
> > After this series, bhash is a wrapper of bhash2:
> > 
> >   tb
> >   `-> tb2 -> tb2 -> ...
> >       `-> sk -> sk -> sk ....
> 
> Someone marked this series as Deferred in patchwork, could you repost?

Sure, will repost v3 with Eric's tags for patch 1 & 3.

Thanks!

