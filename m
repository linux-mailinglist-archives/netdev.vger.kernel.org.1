Return-Path: <netdev+bounces-174064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B154FA5D44D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 03:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D267A97F7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740D142900;
	Wed, 12 Mar 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mJs0u3xq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA95684;
	Wed, 12 Mar 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745526; cv=none; b=Y79DDr7xdzYdt0R7UXvS2CieNXogLzyUVrKfMBAAdkU73I6mbz4NfkV7N6Bkt19u+I4GFhfGT3Ct+R39CBvx/q05ck2KR7dLSA33GJosqzmgxT2MqzZVGYJJk7gPvaRoZB3cCQh7z/8QyDiL8mcQEPufACw1kUGDvg+x80IXAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745526; c=relaxed/simple;
	bh=O1t0kUfVf1QEEZlCW3IidoNDhNzv46REJhQ+EHZryOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0D+J9N//Lo8WZGEfDFFRCFCbIYMBx0b07KX/XkZJaFCUFUMLkzjPB53N7DVVoQnIqoeRT/1TWPjW6FDaHruXNWEesq9BxmerXwkhrYsY+D90fTz+XnenVt+FKBywH5Tm19FfdHfPstIsIi/l25ibXZlUeGqXuAeJ5Dr8jvUiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mJs0u3xq; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741745525; x=1773281525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3FdalRKSCzSajNKmtX7qfcS3nzwOkzonbmTCjzMdxk=;
  b=mJs0u3xq5/6AXZv456kRRmi4sZXcUF4g7zQRjQrTGEktOmW4nBiBhaqA
   EU8lwZqQhdC9L8GxtygK0UsdoOL9p4zhwEL0cMXjQ279OCsjFgoNROPpF
   fa1Ru7fS/2AkbkNOtza8DWmcpqD5FH/BoguSpBv5K2v0+tSMzekj1LOE2
   k=;
X-IronPort-AV: E=Sophos;i="6.14,240,1736812800"; 
   d="scan'208";a="461581"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:11:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:29701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id f8d252d4-acfb-4b47-bc23-3448d579610a; Wed, 12 Mar 2025 02:11:58 +0000 (UTC)
X-Farcaster-Flow-ID: f8d252d4-acfb-4b47-bc23-3448d579610a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 02:11:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.160.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 02:11:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sdf@fomichev.me>
CC: <andrew+netdev@lunn.ch>, <atenart@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jasowang@redhat.com>, <jdamato@fastly.com>, <kory.maincent@bootlin.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 1/2] Revert "net: replace dev_addr_sem with netdev instance lock"
Date: Tue, 11 Mar 2025 19:11:30 -0700
Message-ID: <20250312021132.67611-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311084507.3978048-2-sdf@fomichev.me>
References: <20250311084507.3978048-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <sdf@fomichev.me>
Date: Tue, 11 Mar 2025 01:45:06 -0700
> This reverts commit df43d8bf10316a7c3b1e47e3cc0057a54df4a5b8.
> 
> Cc: Kohei Enju <enjuk@amazon.com>
> Fixes: df43d8bf1031 ("net: replace dev_addr_sem with netdev instance lock")
>

nit: no newline :)

> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

