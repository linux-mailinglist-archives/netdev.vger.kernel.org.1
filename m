Return-Path: <netdev+bounces-87192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28F8A20F5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B551AB2262A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38622BD18;
	Thu, 11 Apr 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cNLVywUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3139AC3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871302; cv=none; b=YjIOySiF88YQi3msPxQBYZNCbx3h4eqhogNZC7BFUe5B7zsVIXS5zPtDmXDdkPkCNMB/reAZFh8vla1roVOgXwh8l+pCcrVFC5GhXK+VJCCXAQfD//Y2hrDfA5kgj3zgHHsvAQEhWcTcWd+sdkKneUZTSveQomflUY1Px6yBxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871302; c=relaxed/simple;
	bh=9kv3nA9dBJfgVtxfxbnvD3z3ZW7eh2XUIGHkV6V9Zos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS2Ongbzmoppxu6G83Kqef19yGEYGp4TrKysCXDQm835s5Q77CMQ3e+qzSot73e9xW1Do7EEbqrxHnits6Iwy4sZChdubsa/S2PNYfauDyiaYhgzpxVKmQO54NcrIi6sY0QbBoh30eq6raDJbzIB1XQ3Equ+POftvWbFfx1nR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cNLVywUz; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712871301; x=1744407301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XaR6izayf+bApbTlJcGRGbGWwmngR8CsVYhKssBMUnM=;
  b=cNLVywUz0FDeJlT4So52zq1cx34zPrR24ZUp3edIDu9qf2hAaQ9AD9Cj
   QukIw1owb1sZYPWBaWD8AhhWtFYpMGjM7qy7JCuuA4J95ZJwinr8Lb9n5
   6aCH5ZDQ0alKEsSgbalJZqzZ1omb5a41oUMGRqi/EH1tb4XUY3i3SCP9l
   4=;
X-IronPort-AV: E=Sophos;i="6.07,194,1708387200"; 
   d="scan'208";a="389127089"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 21:34:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41639]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.81:2525] with esmtp (Farcaster)
 id 2ee7c676-b9f7-456e-bac3-10cf2a0831cb; Thu, 11 Apr 2024 21:34:58 +0000 (UTC)
X-Farcaster-Flow-ID: 2ee7c676-b9f7-456e-bac3-10cf2a0831cb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 21:34:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 21:34:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<mhal@rbox.co>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net v2] af_unix: Fix garbage collector racing against connect()
Date: Thu, 11 Apr 2024 14:34:46 -0700
Message-ID: <20240411213446.94787-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411143035.737d2d33@kernel.org>
References: <20240411143035.737d2d33@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 11 Apr 2024 14:30:35 -0700
> On Tue, 9 Apr 2024 16:26:59 -0700 Kuniyuki Iwashima wrote:
> > > Fixes: 1fd05ba5a2f2 ("[AF_UNIX]: Rewrite garbage collector, fixes race.")
> > > Signed-off-by: Michal Luczaj <mhal@rbox.co>  
> > 
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Hi Kuniyuki! This problem goes away with your GC rework in net-next,
> right? I should keep the net-next code when merging?

Hi Jakub!  Yes, the issue doesn't exist in the new GC, so this change
should be removed when merging net-next.

