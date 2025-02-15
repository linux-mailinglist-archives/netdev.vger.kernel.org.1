Return-Path: <netdev+bounces-166654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4087EA36CF1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 10:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E4B172A5E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29218A95E;
	Sat, 15 Feb 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t30z1Qji"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BE1373
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739611841; cv=none; b=najGpkUX7yIhgWMJJHhv8gfIVu+4nwijvWpEinXEtvZ1+/7xfCJOwN/bgqNBwnXl0Y0/uX3MCOnbOY7RQPw1wBURcbwZu4yFtNlyFwNL9QQFLGrJmjpigkiAzszBitfa1YqhouXL431HDYede4P0gWe+iSPtTK7pSBXvKGrncvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739611841; c=relaxed/simple;
	bh=OVANeRrv5qqPEz30Uq2Z2qHdzlU6zKKxvs9Rrqe3dBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlF9BWNENRlhazaWs7ACyX+DYawLOIdCVIUs2N8P/1FhSBFUIaP4KfLCr/rXjvWT7joILLqe756kXDrFI/rn5gGVNpBwe6JwFcKLZIBn8Sx//cGe1V9DqbOQKfZ1fv7hxO0/QCXKy8X1ei1rZOidDi5pHcXD3GKgA6SiY5OWNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t30z1Qji; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739611839; x=1771147839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2oD3dqrdZ2jpcFMoT6Lk0evTIM8Qq4DJGMsDhcsY84=;
  b=t30z1QjiNdOlxt4EKZPP89ZaIv8mQCGit+5sVP+L6L4mPhUkXEa21ZPz
   5XOU1I/FAruaBSTQnN+m4++j09f3aoRTgtMc9GfAGtMRxEMCKhsTHjZZl
   obaLLV2z6W6mBE2krOA1f6htvfDoJ5s2zM6aVF1NStfpI+Hq3X2Kqbtn0
   M=;
X-IronPort-AV: E=Sophos;i="6.13,288,1732579200"; 
   d="scan'208";a="169953944"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 09:30:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:45601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.245:2525] with esmtp (Farcaster)
 id 4ece41e5-6b02-4040-a2d0-3998ef3f946a; Sat, 15 Feb 2025 09:30:37 +0000 (UTC)
X-Farcaster-Flow-ID: 4ece41e5-6b02-4040-a2d0-3998ef3f946a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 15 Feb 2025 09:30:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Feb 2025 09:30:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Sat, 15 Feb 2025 18:30:24 +0900
Message-ID: <20250215093024.11328-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250214130827.35d59981@kernel.org>
References: <20250214130827.35d59981@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 14 Feb 2025 13:08:27 -0800
> On Fri, 14 Feb 2025 09:25:57 +0900 Kuniyuki Iwashima wrote:
> > > Is there a plan to clean this up in net-next? Or perhaps after Eric's
> > > dev_net() work? Otherwise I'm tempted to suggest to use a loop, maybe:  
> > 
> > For sure, I will post a followup patch to net-next.
> 
> Sorry, I meant that as distinct alternatives :)
> The loop we can do already in net.
> The question about net-next was more in case you're planning to rewrite
> this entire function anyway, in which case the contents which land in
> net are not as important.
> 
> Does that make sense?

Ah I see.
I didn't have the plan so will post v5 with the simple loop.

Thanks!

