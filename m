Return-Path: <netdev+bounces-62549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8F827CAC
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A361C2323E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 02:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639BC17F4;
	Tue,  9 Jan 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DA2p6uhz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0821C2F
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704765718; x=1736301718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hg3BbBfsjE6GK8/SPPbj0QX2HlpfOk7ZmPAIZ9DnZNw=;
  b=DA2p6uhzDcl+9xjPGm3dx60qw8b5Y5iDiM7WdwStKl8x/2BI/jw38v/Z
   QnPDvf4TMGQPbFvXHcsEIHkMW3etF5eE/PHQBcdBgqIlvdK1kHM+YETH5
   rXbYau4qPszbiTsIlC7U4LcveiAYPAOO7pEBLFt6I1fSukQ8Oi7wcIGX7
   4=;
X-IronPort-AV: E=Sophos;i="6.04,181,1695686400"; 
   d="scan'208";a="265398985"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 02:01:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id E67B98A883;
	Tue,  9 Jan 2024 02:01:53 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:55789]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.178:2525] with esmtp (Farcaster)
 id ae2addfa-9ca8-4589-aea3-ddb46f8a66ec; Tue, 9 Jan 2024 02:01:53 +0000 (UTC)
X-Farcaster-Flow-ID: ae2addfa-9ca8-4589-aea3-ddb46f8a66ec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 02:01:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 02:01:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <ivan@cloudflare.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v4 net-next 0/4] af_unix: Random improvements for GC.
Date: Mon, 8 Jan 2024 18:01:41 -0800
Message-ID: <20240109020141.42967-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240102152911.20171dee@kernel.org>
References: <20240102152911.20171dee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 2 Jan 2024 15:29:11 -0800
> On Tue, 19 Dec 2023 12:00:58 +0900 Kuniyuki Iwashima wrote:
> > If more than 16000 inflight AF_UNIX sockets exist on a host, each
> > sendmsg() will be forced to wait for unix_gc() even if a process
> > is not sending any FD.
> > 
> > This series tries not to impose such a penalty on sane users who
> > do not send AF_UNIX FDs or do not have inflight sockets more than
> > SCM_MAX_FD * 8.
> > 
> > Cleanup patches for commit 69db702c8387 ("io_uring/af_unix: disable
> > sending io_uring over sockets") will be posted later as noted in [0].
> 
> Could you repost? I tried to revive it in patchwork but I think 
> it keeps getting Archived because it's more than 2 weeks old :(

Sure, will repost it.

Thanks! and happy new year!

