Return-Path: <netdev+bounces-150621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F369EAFF5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FC61882430
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8B78F57;
	Tue, 10 Dec 2024 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KboYVWmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598533C30
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830410; cv=none; b=r1Z5KLYeX+zl+aXIkemVDIG6XwGY30d5pCl0ETLSCkiVtf+0vDjWsAqUPVHIoCgzWRanVa95VskSdnlPhSgT6CmXTnyaIWestUp6F4xXGX8LX4UkShZB/MVWq/mZI/aAPy/K4bWpA3PhdV59sPSI8PtKEJU3pNd6YCuBl+DboFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830410; c=relaxed/simple;
	bh=pbzf/XDYb87DCPE0ANBdGs5nA9NG3F/Dam+OpqCUHFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J68ohjw7GTkuU0aj8aPd8zl/mUtcQgl75Ymn0HnkGk0GQUL6dMmVqBDU0MutXI1vY+Owj1zPbOW2UHKtbGx9JrPCqeizv31Sb9Sy8TkS4wWzxoXI3tfRnDQStsg2y9lsoqYFFcengho6ie1CY5bw/RewriVEKuwiFKwgTgu725I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KboYVWmp; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733830409; x=1765366409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXyRmOStfj7i3eQL0s4EDIys9+iQLfwGmtL8WHu+GL8=;
  b=KboYVWmpB5mD8oaMyFBlYt1978LMjmhFUZBXpggzZjuf89UX3pbB4V3P
   8z+TaL9T7Ub5KYxJbAiruMPWuGVweeh/r2hOrmLJUMGcls4ji9bJbBwgn
   H8vhYdSAGSMmNMtPiGMwOQwcdlXHRNTj5HDfbafUA/Q4z3hzxt7GF90VY
   w=;
X-IronPort-AV: E=Sophos;i="6.12,222,1728950400"; 
   d="scan'208";a="454747640"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 11:33:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:32579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.76:2525] with esmtp (Farcaster)
 id 3962c4eb-4beb-4f3c-8e57-17e1740442de; Tue, 10 Dec 2024 11:33:24 +0000 (UTC)
X-Farcaster-Flow-ID: 3962c4eb-4beb-4f3c-8e57-17e1740442de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 11:33:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.1.55) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 11:33:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 07/15] af_unix: Call unix_autobind() only when msg_namelen is specified in unix_dgram_sendmsg().
Date: Tue, 10 Dec 2024 20:33:14 +0900
Message-ID: <20241210113314.98142-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <ddb27716-f1cc-4b65-9cba-b8f502f747ce@redhat.com>
References: <ddb27716-f1cc-4b65-9cba-b8f502f747ce@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 10 Dec 2024 12:11:17 +0100
> On 12/6/24 06:25, Kuniyuki Iwashima wrote:
> > If unix_peer_get() returns non-NULL in unix_dgram_sendmsg(), the socket
> > have been already bound in unix_dgram_connect() or unix_bind().
> > 
> > Let's not call unix_autobind() in such a case in unix_dgram_sendmsg().
> 
> AFACS, socketpair() will create unbound sockets with peer != NULL. It
> looks like it break the above assumption?!?

Ah, I forgot about the case, thanks for catching!
I'll drop the patch in v2.

