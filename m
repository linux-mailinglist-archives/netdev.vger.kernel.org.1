Return-Path: <netdev+bounces-161813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F9A24293
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2713A843C
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A918CC1D;
	Fri, 31 Jan 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bobK7IIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE5381B9
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348215; cv=none; b=XwmoMY/YfukW680yLhE8aPebEq3JmkMirSIKf7rt9ApRNDAdhb/WTGHqadeclTt4Hv9jfdRD1IexykFDpUmpnMDh+2vdseaCWljy9le3D7kZx1z66AuUvnuqxdZpownh1il3ii14b9LlFHAaJM/sEvojijc9+dBx9bHcS8NEkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348215; c=relaxed/simple;
	bh=JTsiXL0lq1gD0HLiDA13koFwxzunrWl/6J5fpQArMGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq69cYwAEczfwX1UOgCNqEhkAqHvq+2Unn8RhdG3s1z5tKfP+fBbGkHDe/fJTHno2wAYnEiHxm47qrSlqyTgduCLhQtqRqUn+efJDimpVVZMstLEkOP4hy2a4ZJn6GirgA0T8wa/XK3yPK2jzjxSX3+ej53KawJVjkvKhxlgSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bobK7IIa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738348214; x=1769884214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGB7uQQwJ4DMhNVb9lBDBGpjTeeQOAIRpfIq+hwxMyA=;
  b=bobK7IIaRbn+CKdJzWTCIWBgEZpImJUzDWhlN/ksusIiceA68ZV+Vnyk
   pOD6EkhvWAGudNGDu1J9gDM+Zyxay2nTFl7DyUHXrUIVRv8G+3GuID5F2
   06D3yVGPxPkihlV8WcRM+hOeIk2MW2BwJMblw4OqUcveY61kWKujqa1Rz
   A=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="373506262"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 18:30:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:58296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id b43aa6d6-a55c-44b5-bd3b-0ff85ea2c0cb; Fri, 31 Jan 2025 18:30:11 +0000 (UTC)
X-Farcaster-Flow-ID: b43aa6d6-a55c-44b5-bd3b-0ff85ea2c0cb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:30:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:29:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 01/16] net: add dev_net_rcu() helper
Date: Fri, 31 Jan 2025 10:29:49 -0800
Message-ID: <20250131182949.90418-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-2-edumazet@google.com>
References: <20250131171334.1172661-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:19 +0000
> dev->nd_net can change, readers should either
> use rcu_read_lock() or RTNL.
> 
> We currently use a generic helper, dev_net() with
> no debugging support. We probably have many hidden bugs.
> 
> Add dev_net_rcu() helper for callers using rcu_read_lock()
> protection.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

