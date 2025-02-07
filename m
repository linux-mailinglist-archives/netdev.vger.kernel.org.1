Return-Path: <netdev+bounces-163831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC5A2BC0A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCDD3A5A80
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5E1991AE;
	Fri,  7 Feb 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S6NdkQ6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96B19049A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912064; cv=none; b=gyq0qHYgFcsvKsnjyrq+irgvpK/KAw36GBDu7akCL0swETyjfWmvI3UkjWeJat48BRgg1lUXzIBcZoXmoAvcZYWBoIQhK/XSDuJJL4wZvfk7LRAxqfjG1B5fpPyUNkw1D85MXtvOW98sMqwHCbYpcz/oWaaeOGtdHfSLwyK4Cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912064; c=relaxed/simple;
	bh=aHcMPDjaxTiPi291Be+scXYNgtdQ08HkY3paCHYEyAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDb3/QhQmmkxRJg6dtZ5VifKmy17KesMkc1NMgAFjI+2p1Zbk0Z9vGpF26X+YVvyt4GFP967ydcH71A2CdgEU1R4F8lhxSyZT3edqFkMIwVKzxbr8qn4nPIKHVgYDtpSdEC9rtA0BiYxmZCZYzHMBhcYfk0VHexPYuHgqOMIkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S6NdkQ6T; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738912063; x=1770448063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GGRGJa9aagWKCaT3sJqJPRS4gOIN7swcdwA1Y8DwPoM=;
  b=S6NdkQ6TCOieCHx4x4SlRBNaGDnjhqbShXqz5OueKjNZStmFG7lHDLm2
   pEwyvQpV/X0/Y2lHHpOknbZ1kgzSCLHxLypSenKDizygTSPnsidNqMMBF
   AYCNu/l11LRWnuVHX1sNxEo6mgUiA6PYzz7DBwYExE4m3Lec/aYV6c9YL
   I=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="63911298"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:07:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:13714]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.41:2525] with esmtp (Farcaster)
 id ec73055b-b536-4793-970c-9b7fc7521702; Fri, 7 Feb 2025 07:07:39 +0000 (UTC)
X-Farcaster-Flow-ID: ec73055b-b536-4793-970c-9b7fc7521702
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:07:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:07:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v2 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Fri, 7 Feb 2025 16:07:26 +0900
Message-ID: <20250207070726.85080-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLyO=sXP6hvuDVxnJpq6Y_AT97NmUO6NK+DrQZ8UvQ6Yg@mail.gmail.com>
References: <CANn89iLyO=sXP6hvuDVxnJpq6Y_AT97NmUO6NK+DrQZ8UvQ6Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 08:01:36 +0100
> On Fri, Feb 7, 2025 at 7:59 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> 
> > > /* Why is this needed ? */
> >
> > The following rtnl_net_lock() assumes the dev is not yet published
> > by register_netdevice(), and I think there's no such users calling
> > register_netdevice_notifier_dev_net() after that, so just a paranoid..
> 
> Please add a comment then ;)

Sure, will add a comment there!

Thanks!

