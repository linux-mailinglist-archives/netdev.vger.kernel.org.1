Return-Path: <netdev+bounces-119083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24840953FCC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05181F21C07
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45F487A5;
	Fri, 16 Aug 2024 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E3XrUFDx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD123BBF0
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776011; cv=none; b=GXElfDJC0SKSESy8cY7/GZwfIW9EOy0dOo27wE6/gDjLVvI0tu5HMrwz3DUfb3XhUdu15MAlyL4iWm4UIQNymlF6Qag+JDwYsfWv/ZlOhGOYxI/QyTdeGdhFjXDhWANKN5Fr5j/6zuxfWX4Nkmsx/++/5Gu9aZrim6SmrxGdZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776011; c=relaxed/simple;
	bh=D1AmkjeQlgz0oNEwne18uOhoHbSfrMd38x5BTdk60OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz0Bc15qDEFhtVCUdJeYV9mkTdgEn1jR1QKlWmALpCDqn5Pu7NVOP6WobO1yz/gqQ/weXdzbGHNVDTNOBrsLKbNWI/TavfR17cwdyMjGoWXXoeS6QXwbEnhzwjma3UcBqYHUhuoSTAWcdcE65j3NhaxpqNPnb1HrRZNUbV1Ct2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E3XrUFDx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723776009; x=1755312009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vti/QWqUY9XKmyO9+TkSQexS2B7ivgGLcx4Ri7X2xdw=;
  b=E3XrUFDxzQHAmsOgJzxl7vQ4BC8QTW2k81UQeDvYCz+rtxNJ+A7gx3Xi
   db2/XwGDhQcef1sFjq9A4cdbZcwx6eOFW+IbJ7KRDUaRCgnaZJiY1cZnq
   m51f+DHCl1Hej2OkN7MsOLkzU9j4Vv9ayYpZi54W3i6SdA0CE4YTSowX0
   s=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="116013028"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 02:40:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:15684]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 71699cf7-e6cf-4fe5-9277-95921e510aac; Fri, 16 Aug 2024 02:40:07 +0000 (UTC)
X-Farcaster-Flow-ID: 71699cf7-e6cf-4fe5-9277-95921e510aac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 02:40:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 02:40:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <razor@blackwall.org>, <roopa@nvidia.com>
Subject: Re: [PATCH v1 net-next 0/2] net: Clean up af_ops->{get_link_af_size,fill_link_af}().
Date: Thu, 15 Aug 2024 19:39:54 -0700
Message-ID: <20240816023954.11958-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815183651.7692863f@kernel.org>
References: <20240815183651.7692863f@kernel.org>
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

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 15 Aug 2024 18:36:51 -0700
> On Thu, 15 Aug 2024 14:11:35 -0700 Kuniyuki Iwashima wrote:
> > Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
> > af_ops->{get_link_af_size,fill_link_af}() are called under RCU.
> > 
> > Patch 1 makes the context clear and patch 2 removes unnecessary
> > rcu_read_lock().
> 
> Tests violently disagree.
> 
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-08-16--00-00&pw-n=0&pass=0

Sorry, I missed the birdge one is called under RTNL.
I'll drop patch 2.


