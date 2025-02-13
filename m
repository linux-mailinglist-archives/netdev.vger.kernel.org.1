Return-Path: <netdev+bounces-165789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85625A3366A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD1167F6F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01249204F74;
	Thu, 13 Feb 2025 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mWZmD0xv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603B2063D9
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418690; cv=none; b=C02qsl8ddLIAbQbKzIV5b4Ckk1MRe8SoOEDDDIMX7/WhuZpIl3QPekn1VhrPzJIMsc86SxiUUxGUjqD249LWMzIxNMGSlTda6aJqfOXMtkwZLyOl1jErFoD6rVdgch53bdwQzb0FCxr3PabgESj54HLBe34vwxx+qB9jj/ks8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418690; c=relaxed/simple;
	bh=GOw8f+Fq5ipJWBcHvIZl5AnVrW3E8wJno8X/mXJPOoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSFqS4IPZMSFMaKcM5uXrg3wgIWBC4kv95acwpQ0RQh7ADUEhbeU+ER9x9W5fzuuw8DClOm74ydw3AZs9WNooUFt7qZ2/m3ilZIa45p60zyDzCT8PBSIhL/koaQi/1hGTAo3067Zn8aV2XfCcDJ3VyarjCcm2YgKS/CbUAxnmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mWZmD0xv; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739418689; x=1770954689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43FG5R2Q6qRF+I76yCOlZcLzur4MwUQfLclhBpXbQcs=;
  b=mWZmD0xvSrLAvH6sK90YR0Z/UC28ngEaRKXbTwqZuDUXtcDgIZ8x/jc/
   qdNw8v9xF8WmL5iLoAVpHfwKXxHMJ+UVDLI2s+gphZF/LePP+GSVpWkPM
   XyVKyss761fjQ039NqGFTDcefWpFqv+CL5X/9eTzSxS9X+3a2BxnFUqZe
   s=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="493475787"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:51:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:10543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.133:2525] with esmtp (Farcaster)
 id aea4f1be-046a-4566-81c8-a2cde139c126; Thu, 13 Feb 2025 03:51:23 +0000 (UTC)
X-Farcaster-Flow-ID: aea4f1be-046a-4566-81c8-a2cde139c126
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 03:51:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 03:51:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mateusz.polchlopek@intel.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sd@queasysnail.net>, <willemb@google.com>
Subject: Re: [PATCH v2 net-next 1/4] net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
Date: Thu, 13 Feb 2025 12:51:08 +0900
Message-ID: <20250213035108.85647-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212132418.1524422-2-edumazet@google.com>
References: <20250212132418.1524422-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 13:24:15 +0000
> We have many EXPORT_SYMBOL(x) in networking tree because IPv6
> can be built as a module.
> 
> CONFIG_IPV6=y is becoming the norm.
> 
> Define a EXPORT_IPV6_MOD(x) which only exports x
> for modular IPv6.
> 
> Same principle applies to EXPORT_IPV6_MOD_GPL()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

