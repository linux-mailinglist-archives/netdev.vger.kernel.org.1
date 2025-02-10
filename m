Return-Path: <netdev+bounces-164528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6300A2E1C7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2103A3324
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A89460;
	Mon, 10 Feb 2025 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CQ1m0dYK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45097522F
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147615; cv=none; b=H/ag8L5GHDzI0xHSxq2Xrd2zTDvU530ZmnOUifYipPreJVUYmW3zcoxisP23qN92Eqq9fOlVHosHlwspHfuZhQ7NOEzR1ydoJFui+J1B9FHit9di1jFFPX1PvwXu+bOJbaIJvEj6a39BBEUKWkzS4lfsRbk06d3LHgZEEn/RWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147615; c=relaxed/simple;
	bh=yCd/A1yr7QJyEKmhs032Tca/I49MIejDjBkLGQKLMXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heTDxm/798AogoFqXwOadM4VjZ2sCHigRZ07IuWIUMUbRBv8ka4M8EPwWl1lnsIwXpk3vyS5UmgIQyLE3AL4f4vJGVzzj0iSQKUPoIfIqz3+8nhxyhQw/VVpkc7H5tIRnyKYp1pmlQ2prDwyYOSG2ld2B4LrvX8cteDmZohGeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CQ1m0dYK; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739147615; x=1770683615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6mAtu8JpSntRxs1o4fFNZTNcocJKfeGwCKLXw+JcHw=;
  b=CQ1m0dYK0rQENK+C9O8pGpL/y37pEmrmWlXk800gf+JGHAsTCQCUS+G+
   6P/HpO7jln4cELn8jbqLppbJ2N5JB4g3Q5cNquZ/L9cHoUGsRkS6Fi/gW
   sg67peSkN9waQj8S4o73ML9GpAimlnzluYxGaJvWMHrglSnmwT7rTWYWK
   I=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="717380616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:33:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:34470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id a06edc3e-66f3-46ab-ba2c-33ab0485b924; Mon, 10 Feb 2025 00:33:30 +0000 (UTC)
X-Farcaster-Flow-ID: a06edc3e-66f3-46ab-ba2c-33ab0485b924
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:33:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:33:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/5] tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
Date: Mon, 10 Feb 2025 09:32:58 +0900
Message-ID: <20250210003258.49725-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207152830.2527578-3-edumazet@google.com>
References: <20250207152830.2527578-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 15:28:27 +0000
> We want to factorize calls to inet_csk_reset_xmit_timer(),
> to ease TCP_RTO_MAX change.
> 
> Current users want to add tcp_pacing_delay(sk)
> to the timeout.
> 
> Remaining calls to inet_csk_reset_xmit_timer()
> do not add the pacing delay. Following patch
> will convert them, passing false for @pace_delay.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

