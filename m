Return-Path: <netdev+bounces-181810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F4A8681B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E79A1767E6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127029616A;
	Fri, 11 Apr 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vrj+g3UF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74D2900B5;
	Fri, 11 Apr 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406539; cv=none; b=TJJn86VaRiv8tD/rnw4YWYmK9hGutkhT9g1hlOJmOJl2FKP9T8m5Z+XLCvkwOZD0frodqGgS4ERx5c796rVV1VOMfgkV1q1Y00S4mvVl77neThlODCwQjStCWspUs4t3t+EDm1nKsIFPfzHc+U0r7rQ+mKp8mFrPql2o4CQ2MbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406539; c=relaxed/simple;
	bh=ePCmxxtBAD+3oU9ozdDlC9rhlhORzN41yd5Nj7ytW/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxmm2goXEKe7mEtS/rnASO0P8qI/bU7XzRH8pTZxpG3L6FglH8PqUusZg/XUecZN0XBjKj2UwPwn/kATA7TYJHT4JX4S4DfeJ8r3AeGrtYR5m94WHPfN1Kw0PQf/B6tG5lw+buM1FxWiJ6fQsZ2SbffmTpIipqURRS6k6KlFnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vrj+g3UF; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744406538; x=1775942538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7e0SLfRq2Ba9KBj40Jessiml3hk/TB2pnnWqM89Gg9o=;
  b=vrj+g3UFhMB+vKG1s0VgLPWge1PxIxQy1Bi5gR5wiyRHNXjOHpFk+0nz
   XR1dZHvWmNXuGNDmAqa3dxY+zm7BTk6VXLDP1YZScxX+5mNo2rfz4lI/0
   F4G+lc6i5HCCsnRswZ+Cl6vgWEpIC3VowcMSpxdOSicwsxWHIuw0jlgqP
   o=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="39952625"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:22:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 2a254558-e4fe-4af1-a523-66a61b6e120f; Fri, 11 Apr 2025 21:22:17 +0000 (UTC)
X-Farcaster-Flow-ID: 2a254558-e4fe-4af1-a523-66a61b6e120f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:22:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:22:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 3/9] neighbour: Use nlmsg_payload in neigh_valid_get_req
Date: Fri, 11 Apr 2025 14:22:01 -0700
Message-ID: <20250411212204.67458-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-3-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-3-ddd4e065cb15@debian.org>
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

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:50 -0700
> Update neigh_valid_get_req function to utilize the new nlmsg_payload()
> helper function.
> 
> This change improves code clarity and safety by ensuring that the
> Netlink message payload is properly validated before accessing its data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

