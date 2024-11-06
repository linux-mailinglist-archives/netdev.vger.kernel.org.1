Return-Path: <netdev+bounces-142173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F99BDB1D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D85B283B52
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236AE188917;
	Wed,  6 Nov 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nqxj/CgF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CE10E5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856150; cv=none; b=fpFSmd8sI2cYtb88jGpRgkyhnfUGk2Q+pHiaxmo5hanu5NXau55BLKFoNGgLvPsS5+clnhooSwZ2Qurhoa2PQOtkkVouzQwnHcAue8qoOfBEjSxUfeV40C31pCxMM7N78Qc5qdrlcsbpsqQNZxgJ53LqvPnJFas+pjmoOfxjBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856150; c=relaxed/simple;
	bh=SZDnUm6Pqr+GxuFaYxZyGbvX2RTKFMNRNd/ivvcnAPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MChNlVXKSoYmxL/QUN/ioKqqio/KcYOu0uk32v+//T/9cGk+o9+p2dA5G+PbZfRaHh2myQ212xr1bUIHLAYE5BcqFFTaRQsaO84J1mCWTG/VlXMN3FaPA+Clhp3pthopiPTQi6l/aGTy3bmj1Qsot4EYvYoXE22dFreseuxz8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nqxj/CgF; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730856148; x=1762392148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tn9DGWQDoyXFGFUvedAuiWTgyNYZYM17gl2xbPcXBE=;
  b=nqxj/CgFnSMKRbG5rbs2rSNOAqZ/Z+bmLIW1+60zzQ9wU18HYP7GJRiP
   VJXG7s7MkztoXSL5S0BuAH9IE0eoEzpPXaey9rVyEGDX9q7XR1tgiCPXO
   XnJufIGj3HZ1xj8C7Kv8drGsoCwu9S/pWc5mVB46FlZqN11pB/yoZ/9OD
   0=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="773113725"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:22:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:44080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id 15c0c398-1a6e-4fdf-ad7f-882da96a5f44; Wed, 6 Nov 2024 01:22:20 +0000 (UTC)
X-Farcaster-Flow-ID: 15c0c398-1a6e-4fdf-ad7f-882da96a5f44
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 01:22:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 01:22:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Tue, 5 Nov 2024 17:22:14 -0800
Message-ID: <20241106012214.6867-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105170447.1d32beda@kernel.org>
References: <20241105170447.1d32beda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 5 Nov 2024 17:04:47 -0800
> On Tue, 5 Nov 2024 16:58:25 -0800 Kuniyuki Iwashima wrote:
> > > > I guess compiler will warn if someone tries to use < 255  
> > > 
> > > I chose 1 just because all of the three peer attr types were 1.  
> > 
> > s/chose 1/chose u8/ :)
> > 
> > 
> > > Should peer_type be u16 or extend when a future device use >255 for
> > > peer ifla ?
> 
> I think we can extend in the future if you're doing this for packing
> reasons. Barely any family has more attrs than 256 and as I replied to
> myself we will assign a constant so compiler will warn us.

I have no strong preference so will use u16.
Also, there was a 3-bytes hole.

Thanks!

