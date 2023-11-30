Return-Path: <netdev+bounces-52335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886677FE4DA
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7591C20B4B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4D187D;
	Thu, 30 Nov 2023 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xl7G6ik/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A41A6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701304450; x=1732840450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiQZM9uFEdCXMdQgrqXY4j3bJSSutSlyPA8qHzUJPvY=;
  b=Xl7G6ik/uGLcxrSYo6ixKNBCMIidhlOjBfDkDfYPDdl8eXYZgA8G1A4l
   rlKXfzbLvNS6ETH6FrLvR6IUr/bBNmccIJUcwpmxrX6IE+51eUd5Lf9ND
   DePHEJ9nM3nlYAUoMTbQwmAR5NHnJmmyDo/OZFWLDRKtk2VpgZvo+dHcH
   M=;
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="687336494"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:34:04 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 4A8A8C064D;
	Thu, 30 Nov 2023 00:34:03 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:64576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id b52301aa-46d6-4621-baad-753f28ca6e22; Thu, 30 Nov 2023 00:34:02 +0000 (UTC)
X-Farcaster-Flow-ID: b52301aa-46d6-4621-baad-753f28ca6e22
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 00:34:02 +0000
Received: from 88665a182662.ant.amazon.com (10.118.240.181) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 00:33:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
Date: Wed, 29 Nov 2023 16:33:49 -0800
Message-ID: <20231130003349.60533-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231129022924.96156-1-kuniyu@amazon.com>
References: <20231129022924.96156-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 28 Nov 2023 18:29:16 -0800
> This is a preparation series for upcoming arbitrary SYN Cookie
> support with BPF. [0]
> 
> There are slight differences between cookie_v[46]_check().  Such a
> discrepancy caused an issue in the past, and BPF SYN Cookie support
> will add more churn.
> 
> The primary purpose of this series is to clean up and refactor
> cookie_v[46]_check() to minimise such discrepancies and make the
> BPF series easier to review.
> 
> [0]: https://lore.kernel.org/netdev/20231121184245.69569-1-kuniyu@amazon.com/
> 
> 
> Changes:
>   v3:
>     Patch 8: Fix ecn_ok init (Eric Dumazet)

I just realised that Reviewed-by tag for patch 2 of v2 series contained
a wrong email address, and I happend to copy-and-paste it for patch 1-7...

> Reviewed-by: Eric Dumazet <edumazert@google.com>
https://lore.kernel.org/netdev/CANn89iLy5cuVU6Pbb4hU7otefEn1ufRswJUo5JZ-LC8aGVUCSg@mail.gmail.com/

Sorry for bothering, but it would be appreciated if it's fixed while
merging.

Thanks!

