Return-Path: <netdev+bounces-134337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA94998D9F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1245DB22620
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A061CDA2D;
	Thu, 10 Oct 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i//0KTqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44961CDFC3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577646; cv=none; b=DcoYq12VLN3VsiKXPM5MrGfNVlVVOrO83AfAU2a/L6R/rNReoDj7P7yi5h28ADLnkqvOIHWW3Mo8TruC+Xk4naAht1hOWlrf3AYz8kCyMFWWig6TmN3jKm4M95b/P6C1XAhuBZuGoUve2JoqCWIouK+7W8XoWrSoMosQSRNCzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577646; c=relaxed/simple;
	bh=SAFm/YqWOwPoiBW+G+yDt/o0c0VSizPOj8E29D7gkts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7bsfdD5VvakYltJXFL8tGw0VfwDEnXDFsq1GWE7q2fN9H3GMXo6vjbStzjC7L51cZ6d2d3EzTmvGu1Z/LVbog8azvum0W/FKVh5lCbNaGN88hvgUDSUmudWVUKZ2CEZ9+kQ6cPu2/QfYPW/vaIAVFjbTrqi9t5rddCP6bNxSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i//0KTqK; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728577645; x=1760113645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+iFH6iyVz8LJ0vh8yjqwbfqiHi8CGSQ0tTDDF1bKkQ=;
  b=i//0KTqKNHwbyKi0EZHBM6D4cPsL00+XVSjRj7xnQODp9BD8p0G7kJD9
   NEWgmN19pqwQGU/G9o2/DpO+BOEv9rBMKw2w9oS9BiAPQBVGShmDYRarw
   PzR+WLp/Y7uikAdoAMAZZL+mQPgC2Nex8j8/dRKtfTPwpTI/edjNoyAo2
   k=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="32241254"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 16:27:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:30193]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id b47e0769-213a-4451-8c4e-e6b1342fcd77; Thu, 10 Oct 2024 16:27:20 +0000 (UTC)
X-Farcaster-Flow-ID: b47e0769-213a-4451-8c4e-e6b1342fcd77
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 16:27:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.181.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 16:27:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 13/13] rtnetlink: Protect struct rtnl_af_ops with SRCU.
Date: Thu, 10 Oct 2024 09:27:15 -0700
Message-ID: <20241010162715.62120-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iJUX3nkQJDOTsj9RN0dH4_u=mVQd4Z9m_mMCLm60Eppug@mail.gmail.com>
References: <CANn89iJUX3nkQJDOTsj9RN0dH4_u=mVQd4Z9m_mMCLm60Eppug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:16:20 +0200
> > @@ -683,6 +696,7 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
> >  void rtnl_af_register(struct rtnl_af_ops *ops)
> >  {
> >         rtnl_lock();
> > +       init_srcu_struct(&ops->srcu);
> 
> Same remark, this could fail.

This requries rtnl_af_register() to return int, and that needs
few more changes conflicting with rtnl_register_many() changes.

I'll see if it'd be a bit noisy, and if so, I'll split this patch
to another series.

Thanks!

