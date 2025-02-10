Return-Path: <netdev+bounces-164526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D3A2E1C1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C85162EB3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615E632;
	Mon, 10 Feb 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DTxSfRu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2936C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147448; cv=none; b=oLeH3GlC/3oDV2CoZJ3lOXJkn3LKfXeXDBKWjYb3CQHt8r+sbci3aIJevrh2FLn19n/rQ9GN0jklNXVCdugM6eEq3wDT1pNmmBVm46FsbusEdtT+hMQB2PK9Mq4Tu4M2/97IjJSe2KknQuTh77zsnEnD5DUiAHiV1/KFDnHrtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147448; c=relaxed/simple;
	bh=N9vSd0OKz664YvY+5t/jundbtwPa2Cs2BL5HQr3rG2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPoLMJnMUipB/dXBhhVSjpu/LCe01u+v/OwBwN72iKFhkVF4Hggj+dSdPE+7W2ejfgWurDU1awoNM6PSQk494Jwj//ZmXE0oQg4UdS648Gg5JCWJSMXSy6RCJsdzM9R7Ki4PbqE4WHPzzUACZYIv33hV+Uf+p9VjcAaIl6N9lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DTxSfRu6; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739147447; x=1770683447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qA5071tgua8JNuQTDUlcjz9LAU3GjB8IYTCm31f+RuY=;
  b=DTxSfRu6yqJcBZTEaNTv0CHB0GKZrESHZDC4G9U8nR6P/WhINR0vpLVB
   rsklMxwWHQ4akCv4woXT6a2WF+mt2V4MivlGQrFnPtFAAg3MBULGZ4rQF
   SWCsH9UpHsup9w0wjUsnTTXnc3vu66t7xU9i4YSNEQbaWrl06p0wIRxP7
   o=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="470732973"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:30:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:50620]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id 0323f3ad-6c0e-4e28-96ed-7a6e1282595f; Mon, 10 Feb 2025 00:30:42 +0000 (UTC)
X-Farcaster-Flow-ID: 0323f3ad-6c0e-4e28-96ed-7a6e1282595f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:30:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:30:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/5] tcp: remove tcp_reset_xmit_timer() @max_when argument
Date: Mon, 10 Feb 2025 09:30:27 +0900
Message-ID: <20250210003027.49540-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207152830.2527578-2-edumazet@google.com>
References: <20250207152830.2527578-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 15:28:26 +0000
> All callers use TCP_RTO_MAX, we can factorize this constant,
> becoming a variable soon.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

