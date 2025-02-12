Return-Path: <netdev+bounces-165432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9805A32016
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412F31888EBC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537492045B9;
	Wed, 12 Feb 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D1JxIgDm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA021DACB1
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346023; cv=none; b=PR0S0J2EV/qe8+k0pW8akJWCI/GX2r5TEkrWjMHAWS99eis+vlfGeA3jy9RVPmePikc1edQJR7ERLUXIzqGDD7Qk42p2ARKSY5stAx++6CvnJDMbUg3erjJ44jxfvysx/cQcz0+v9/xZktnHneHLALtQYnv5dHi4cZ6l7QDhbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346023; c=relaxed/simple;
	bh=hs6BY2QISLEAveo5AmnXRiOaxnhIetTdLDHToyO7fjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5ZozBkQy9LK6WJkj9uXRjFlWa9PgMRfSIBtAni7D3BA9nSpd9pM3Uwe4DXns5dAuQo96inWibzfim+P8DDzT+z4N65T4pGnI3rQ2oj0BAQiEwJhVb3t6wVQ+UYDaDW+m+x2bkmP1KlFHkMRVma1r6KDOdYVaxXRIdCM/+xoVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D1JxIgDm; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739346021; x=1770882021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yd+aBZwAY3LPD+fJ7tXuheB0NRV0BlVs5v2fSEAqLak=;
  b=D1JxIgDmVdVDBJ8eVt3pb1LlZxh/sjvG/KntsgQDwcXodYR902gAL4BZ
   5hcmhuaEklDpXlsAKCuexVpGo/ked3d0Xv16SLnh6/l6/XqTM9GUnXIFa
   5NeVxut4wdqsdk9PPi1vn4W2X5NV7Q9gEh+h0p5QKRVnnxam/UFcbGHqs
   o=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="270468140"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:40:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:50360]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id caa8fb00-1bc1-4266-b6d6-65264d534716; Wed, 12 Feb 2025 07:40:17 +0000 (UTC)
X-Farcaster-Flow-ID: caa8fb00-1bc1-4266-b6d6-65264d534716
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 07:40:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 07:40:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<willemb@google.com>
Subject: Re: [PATCH net-next] net: avoid unconditionally touching sk_tsflags on RX
Date: Wed, 12 Feb 2025 16:39:55 +0900
Message-ID: <20250212073955.25603-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
References: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 11 Feb 2025 18:17:31 +0100
> After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
> the sk_tsflags field shares the same cacheline with sk_forward_alloc.
> 
> The UDP protocol does not acquire the sock lock in the RX path;
> forward allocations are protected via the receive queue spinlock;
> additionally udp_recvmsg() calls sock_recv_cmsgs() unconditionally
> touching sk_tsflags on each packet reception.
> 
> Due to the above, under high packet rate traffic, when the BH and the
> user-space process run on different CPUs, UDP packet reception
> experiences a cache miss while accessing sk_tsflags.
> 
> The receive path doesn't strictly need to access the problematic field;
> change sock_set_timestamping() to maintain the relevant information
> in a newly allocated sk_flags bit, so that sock_recv_cmsgs() can
> take decisions accessing the latter field only.
> 
> With this patch applied, on an AMD epic server with i40e NICs, I
> measured a 10% performance improvement for small packets UDP flood
> performance tests - possibly a larger delta could be observed with more
> recent H/W.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

