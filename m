Return-Path: <netdev+bounces-175444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FEA65F31
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067FF17B9D6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BD1624E9;
	Mon, 17 Mar 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cx8MjLIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DF372
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243432; cv=none; b=mEZaKejG5C4hC930rntsxOC0eQDgsA8lZJmlsd+zFCCqhKTnxPaOEXdfIhHAxQwySfmdp4LzTjq47dUerHixaaBT0A5KIArx4pNmTlUTplh0nnmaVKJngDxRHJs1VXlONWPAU1Znrl5ao7ZL5kvK2Ps5YCNRXoWBGKtGGoH+jZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243432; c=relaxed/simple;
	bh=Dk2s9zkp0phvrjXm1GzsOZTSSpQcVAeGzjNS4zplz/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlyz05/N8+Z2pY/IdxenRjCyUWJ5QtBdaBBX/8moUH3Tx9Sd7bC9Gjms2gW+YLLMs1OmGUhg+HJ4MZGbghutp+cojxCrFpLa1Z31IYmMEmt1SKsOre8qNQSTXNie+cMaWIkC1u2IYVw4q/wCt6jTpOBs0SAaUxuUkSOoE41iZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cx8MjLIM; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742243430; x=1773779430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxfaXJyver6ncOHLyyu/dxXYss9FHbj3chmZ7+n8FF4=;
  b=cx8MjLIMpRtlYR9vEOi99Yn0Tt/SG04I+vmPQkhJ8TkIMXIVN3vBZlyV
   hGY1+fogKflDFsRXwKa+or7KusyoPR6jGKtJj1Sha9+aAQGKekKiMv9OQ
   E2M9/5g/FjuM+L0IJRFb3yP8Pllg7Ako5HlvPNjpNtP+JzCD5DxOlNRpB
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; 
   d="scan'208";a="705793036"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:30:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:29062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id 2c5e9fe6-fd47-44dc-89de-45dc6173caf0; Mon, 17 Mar 2025 20:30:24 +0000 (UTC)
X-Farcaster-Flow-ID: 2c5e9fe6-fd47-44dc-89de-45dc6173caf0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:30:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:30:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <borisp@nvidia.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: move icsk_clean_acked to a better location
Date: Mon, 17 Mar 2025 13:30:06 -0700
Message-ID: <20250317203011.25239-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317085313.2023214-1-edumazet@google.com>
References: <20250317085313.2023214-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 08:53:13 +0000
> As a followup of my presentation in Zagreb for netdev 0x19:
> 
> icsk_clean_acked is only used by TCP when/if CONFIG_TLS_DEVICE
> is enabled from tcp_ack().
> 
> Rename it to tcp_clean_acked, move it to tcp_sock structure
> in the tcp_sock_read_rx for better cache locality in TCP
> fast path.
> 
> Define this field only when CONFIG_TLS_DEVICE is enabled
> saving 8 bytes on configs not using it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

