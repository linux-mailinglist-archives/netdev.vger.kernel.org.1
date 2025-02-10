Return-Path: <netdev+bounces-164532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C3CA2E1CC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935C71887257
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE6BA45;
	Mon, 10 Feb 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CPjwGKom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E655258
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739148255; cv=none; b=cu2/silXSMUvtbh4XuDV02RLzBtg89SGsA/nfrrXukAxAiq702wStzmpXVu7UKOwIt4m2d/JhLAukVkNH4pRz28jh7HQaHTZNNrkv27MCmRy+bm5Bo4X6GjzWztsdRB+gL5BGsuXWVmx8z1WgQ2nw2f5pqGX3fk809lzlmwBHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739148255; c=relaxed/simple;
	bh=aEbwXwjDuTtzTMOz4sX+gh8JUuAjfDDuVZKlGotiAuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skyqbXGQA701DEAbt78MxMnkyBhV1Qiuv/ZPS+hNxQDnmyW/UXdvJs2OWUpgm5lCg5v+QJVtU6Bk55EaiWj1dxTiP/7pu8EEKbILZNozJVPgGXmyStTwAf8EAwVQLdS1rV2cA2Uxjp2jL7c8zNhEG6deTsEuWVzomaUpnZJ2Fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CPjwGKom; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739148255; x=1770684255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TU8esBFOkeifkG3/57o9v0/9/dykF3jeWjCmw3v8QIo=;
  b=CPjwGKomyT9ze9LbCGEjWpY5aiL45fZjm/ztp70b1HhdKgCUOwJhCm29
   eVO3VyfhiLmVCtkddTfA1PHlLfvHjcCilQnwGrb8MhD1aFRzPwhZ+8zXV
   c6uwosAsNQGl6byhNsNLvfzjPoTQNN9JfDR95Em6NfwTC4Hl5pTeSN4JP
   o=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="695718637"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:44:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:4132]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.236:2525] with esmtp (Farcaster)
 id a0ada915-8a5b-4825-808c-36f419224f3a; Mon, 10 Feb 2025 00:44:09 +0000 (UTC)
X-Farcaster-Flow-ID: a0ada915-8a5b-4825-808c-36f419224f3a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:44:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:43:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/5] tcp: add the ability to control max RTO
Date: Mon, 10 Feb 2025 09:43:46 +0900
Message-ID: <20250210004346.50931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207152830.2527578-5-edumazet@google.com>
References: <20250207152830.2527578-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 15:28:29 +0000
> Currently, TCP stack uses a constant (120 seconds)
> to limit the RTO value exponential growth.
> 
> Some applications want to set a lower value.
> 
> Add TCP_RTO_MAX_MS socket option to set a value (in ms)
> between 1 and 120 seconds.
> 
> It is discouraged to change the socket rto max on a live
> socket, as it might lead to unexpected disconnects.
> 
> Following patch is adding a netns sysctl to control the
> default value at socket creation time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

