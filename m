Return-Path: <netdev+bounces-180519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58820A81988
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3D51B802D4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CC22B8CE;
	Tue,  8 Apr 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J2Ecp8DQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9802063FA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744156424; cv=none; b=YDhxlshFNvSLn0m0K6G9cXb9mUMYfjBXPLi3n0nNw1uom7zlLr9hkeUBmvj1TqjbVIuvi+wVlE225WS12wbeLt+2Be/bIYFRrp2X63k7mAAZWUveiSyiIh1i0N9EcpqQHzTaxFczpb8isBXy3fg2oJPI7r0rMoMAouRhKGNN1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744156424; c=relaxed/simple;
	bh=UswTBl/MvNfzP97mDlcVEo9GeYVJUOTBj8rfbJVwYtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfkIb0Aj54jwxw4nR1qaFKSyQfP1r0X5nbsmZikAlyXQt35yiBdtKbKV/MbF00eLx+Qn6cqZwtBwIrpSCZVmYlkEiLVAgw7uiK/y5jL2Y5ZaUf7x8/XgmrIDFLTv7y4x1bMJmCGb+Szcbut09ZH3hFZpvSLy2zLwlqPwjoKBzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J2Ecp8DQ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744156423; x=1775692423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSSkAxmu65pAdu1izDQ9rqj9zECYPLgNuMFaZNKR74E=;
  b=J2Ecp8DQc3g6dIdUuItIcfZnzMRTn528vfcVO79rvlBz8S4EeQZumfG0
   rW80gv7y/hTupymTUcFoed6acPbIAFQ42LyI45g1/2ILmD2jux0H80dq8
   RBco3MFDmAFSeQRweJeZrEsw2yXhIFX2ssmmnEjLw9rVtBLSCRtjrUeKw
   A=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="286816376"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:53:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:31313]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id d0392c62-4199-4822-9baa-49539dd1eed0; Tue, 8 Apr 2025 23:53:36 +0000 (UTC)
X-Farcaster-Flow-ID: d0392c62-4199-4822-9baa-49539dd1eed0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 23:53:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 23:53:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <jmorris@namei.org>, <kadlec@netfilter.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pablo@netfilter.org>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 3/4] net: Unexport shared functions for DCCP.
Date: Tue, 8 Apr 2025 16:53:02 -0700
Message-ID: <20250408235316.13501-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408162512.23a84b5e@kernel.org>
References: <20250408162512.23a84b5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 8 Apr 2025 16:25:12 -0700
> On Mon, 7 Apr 2025 16:17:50 -0700 Kuniyuki Iwashima wrote:
> > DCCP was removed, so many inet functions no longer need to
> > be exported.
> > 
> > Let's unexport or use EXPORT_IPV6_MOD() for such functions.
> > 
> > sk_free_unlock_clone() is inlined in sk_clone_lock() as it's
> > the only caller.
> 
> netfilter wants inet_twsk_put
> 
> ERROR: modpost: "inet_twsk_put" [net/ipv4/netfilter/nf_tproxy_ipv4.ko] undefined!
> ERROR: modpost: "inet_twsk_put" [net/ipv6/netfilter/nf_tproxy_ipv6.ko] undefined!
> 
> allmodconfig builds seems to miss it :(

Thanks for catching this!

I actually had ran allmodconfig but it couldn't catch it
because the error would be reproducible with IPV6=y.

I'll test allmodconfig + IPV6=y explicitly for v2.

