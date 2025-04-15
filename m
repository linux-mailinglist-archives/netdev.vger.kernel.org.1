Return-Path: <netdev+bounces-182538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0CA89064
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F24E3B0ABF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389A1CA81;
	Tue, 15 Apr 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lm4RtWnm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD318E25
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676276; cv=none; b=P+D8lh3Pt0E/v+UrkT/bty/5hBdSjbou5kn/mIHpb0DOiPoqQ+QaxHwUdY63QUOmxld4mUrkNFI2VS4wYJwEERicz51fmWWHr9H49rJ+DL6G4RHJKq/lf41qGMASuAzuzuJAeuGa5QjnBh1UaDzRG43bdB32amSKfSKyhoyJKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676276; c=relaxed/simple;
	bh=UU5FgNDWWY6Knuki1U1T0GBraElsR4aSpMVUzieZ2Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHTnKI8nFq4ph2k3Qm7k0ldPskErPVPWp0QcbMdsTw0DxzFnmBD+XFJQY4hBPRVUwTIXURYYC0yHY6nf+EjE+MO9LuMlPWnsD9Zudu3e8Rxpk5BQBX+9aiIt9jRNlx8gfBy8KkMCdMaR8nUYlxXDYA+aZmrhsQrlA68ltlF8QYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lm4RtWnm; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744676275; x=1776212275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMNNRaolTa3DuJTPl9jU/0E3uVJ0sv4S8/RlobuSpR0=;
  b=lm4RtWnmngM3VHTuh21bpYQU9Kqb74h24Y4ixx2mecgG354qrXfd7SJ+
   +mpWY0N8opXf1tZdTtzx7rx5nz6HtfALdQBquZe6+Kx3Eyfr3j99UvCU6
   eEnU3EcwbqoJj50HwAFIAdPCrFVtisZvp4IiwcrSqGhVAqtC4SOA5aVw/
   c=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="735593747"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:17:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:35666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 2e09a1c3-90cf-4814-bc7e-76db56973ec0; Tue, 15 Apr 2025 00:17:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2e09a1c3-90cf-4814-bc7e-76db56973ec0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 00:17:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 00:17:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 02/14] net: Add ops_undo_single for module load/unload.
Date: Mon, 14 Apr 2025 17:17:10 -0700
Message-ID: <20250415001738.91572-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414171205.703b743b@kernel.org>
References: <20250414171205.703b743b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 14 Apr 2025 17:12:05 -0700
> On Mon, 14 Apr 2025 17:01:48 -0700 Jakub Kicinski wrote:
> > On Fri, 11 Apr 2025 13:52:31 -0700 Kuniyuki Iwashima wrote:
> > > +	bool hold_rtnl = !!ops->exit_batch_rtnl;
> > > +
> > > +	list_add(&ops->list, &ops_list);
> > > +	ops_undo_list(&ops_list, NULL, net_exit_list, false, hold_rtnl);  
> > 
> > Is this the only reason for the hold_rtnl argument to ops_undo_list() ?
> > We walk the ops once for pre-exit, before calling rtnl batch.
> > As we walk them we can |= their exit_batch_rtnl pointers, so
> > ops_undo_list() can figure out whether its worth taking rtnl all by itself ?

nexthop is the only built-in user of ->exit_rtnl(), so hold_rtnl
will be always true for setup/cleanup_net().


> 
> Either way -- this would fit quite nicely as its own patch so please
> follow up if you agree. I'll apply the series as is.

But I like that way so will post a follow up in case we can get
rid of ->exit_rtnl() from nexthop in the future.

Thanks!

