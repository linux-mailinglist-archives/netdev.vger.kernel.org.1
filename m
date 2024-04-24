Return-Path: <netdev+bounces-90747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD88AFE50
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50F41F23576
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19509C13D;
	Wed, 24 Apr 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NcZsiPc3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103BBE4F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925311; cv=none; b=alpuJ/8RGkrQar80Bq0fjqJHZI597O5tWMMQmoH041APEC+YprcjnPOhe72Ln0Z/J6fPjGXzgFq8XXReM2xYj2EYyVJxLwTAMYXZDMO6MxcO92399foSfhkIcm23fwC7NEVaXtm1F42TjXCkDd54gGs25s/5ByDCGZu8EvQBkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925311; c=relaxed/simple;
	bh=y9XjZwK78IAYlNgNxrJv6/YNw9YQFDwZdXgrLxxJf2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsSrgLogC4npD+TwDPl6WcnMu9hjWg8zIl5LvvvBlNHH7CaPWT5AnGuz9h9hPXxzbC6t+JdsFpEs++cWNEmmis2K8byfjqsGkYiGum+3dUCrftgOHQyWO3EjcWF0Wdpz29aA6N6ksuAuSr8pLYWhrOWKub+RwSEJHVdZ0MjolUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NcZsiPc3; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713925310; x=1745461310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t13F33zq7BP3xMD0eOHg9cV1QMB9y1VusQpUD4KEweQ=;
  b=NcZsiPc3k9wapYdu4LQJKYqA7Lz/k/C+r3qgS+BmolnQSP86868UsNvy
   YyWIpqd4EBdRdtdRJyYiGmAr2o+8DeGqCP06kPAfCyfYctbkEf08lMsbE
   Ejv9uF7zzw6H+8noW/OxJFboCYZczE1g2KhDmFvsWj4K72DAdejWoiZnz
   o=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="291338877"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:21:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:11084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.104:2525] with esmtp (Farcaster)
 id d9e822c2-83cc-4cbf-afd7-f842f863edbd; Wed, 24 Apr 2024 02:21:47 +0000 (UTC)
X-Farcaster-Flow-ID: d9e822c2-83cc-4cbf-afd7-f842f863edbd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 02:21:46 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 02:21:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net-next] af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
Date: Tue, 23 Apr 2024 19:21:36 -0700
Message-ID: <20240424022136.20484-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424012648.15553-1-kuniyu@amazon.com>
References: <20240424012648.15553-1-kuniyu@amazon.com>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 23 Apr 2024 18:26:48 -0700
> syzbot reported a lockdep splat regarding unix_gc_lock() and
> unix_state_lock().
> 
> One is called from recvmsg() for a connected socket, and another
> is called from GC for TCP_LISTEN socket.
> 
> So, the splat is false-positive.
> 
> Let's add a dedicated lock class for the latter to suppress the splat.
> 
> Note that this change is not necessary for net-next.git as the issue
> is only applied to the old GC impl.
> 

Sorry, I wrongly tagged net-next..

will resend v2.

pw-bot: cr

