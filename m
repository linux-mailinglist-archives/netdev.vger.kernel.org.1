Return-Path: <netdev+bounces-157938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695ECA0FE28
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CCF16962A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BF7446A1;
	Tue, 14 Jan 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EvvYJnYM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098935965
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818455; cv=none; b=UJmrATELWuZPJLeoD6c2M4jaMKdNG6az9p/Q+eHUR6IVRbzX3xONrqR3isldJLDKiztnfB/qsWXk7qIZD1COEkY8l8S/Khl0bTT9Rl30aUrQYWkozifJ2aRxLAN5Y19xN+/t9NhCVFzi8J1oKYn2XfVkn46SWS7zt7pdW/Yc2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818455; c=relaxed/simple;
	bh=FM61hRwmjcUCRzH2disZyvjfxbGXUZXe2TQvJWKaUyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmgPSlv+t6dZ1P7WjPDUuhnp8C+3hHmKsOXBELTw23bUqambzD56XEwfbCAVUXyVRJfUnlF76wEQgZmQvd/3uj/BPQega4Y6s5n1/nPJZWzxMm2dFFu29od7OXDsOXDlBnESMszYSVvjRuDJ44HtKUPxAU5FpIi4flCLVPg1m6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EvvYJnYM; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736818454; x=1768354454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGFPVm9bL6M9lB9bgVcmreWkKfBlGI70dhq3IdYFqbc=;
  b=EvvYJnYME0inztYy4I2WyHp6MLKfzKwN/DZSV6tZo+Kn9DaUSLhTyjkZ
   MR7ry9MlhteUwSg5/4V1St/8AOs+kant5Hyai9fSmCtUQXcZV7JCUQrsS
   yfaZS/AViQfnIIDr4sIeXrc2VP0f6Well6853JisCQCP3IvCbwWkggMV+
   8=;
X-IronPort-AV: E=Sophos;i="6.12,312,1728950400"; 
   d="scan'208";a="463868369"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:34:10 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:53912]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.28:2525] with esmtp (Farcaster)
 id 6b2f9eb8-16be-487c-9f81-c46a50a8c123; Tue, 14 Jan 2025 01:34:09 +0000 (UTC)
X-Farcaster-Flow-ID: 6b2f9eb8-16be-487c-9f81-c46a50a8c123
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:34:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 01:34:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
Date: Tue, 14 Jan 2025 10:33:50 +0900
Message-ID: <20250114013350.6468-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250113135558.3180360-4-edumazet@google.com>
References: <20250113135558.3180360-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 13:55:58 +0000
> Prior patch in the series added TCP_RFC7323_PAWS_ACK drop reason.
> 
> This patch adds the corresponding SNMP counter, for folks
> using nstat instead of tracing for TCP diagnostics.
> 
> nstat -az | grep PAWSOldAck
> 
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

