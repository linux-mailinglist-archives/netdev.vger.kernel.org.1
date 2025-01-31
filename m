Return-Path: <netdev+bounces-161827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D8A24331
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843D73A7F5F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BB1F03C4;
	Fri, 31 Jan 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R3aYZ46P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABF1369BB
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351298; cv=none; b=a9xES1DOTyHrKEsO5CeMBDqOS9NQRqNGp1zNW9ch9WuhWiDrq+teduG/Qm4r9D8ujzuikBtyVG2X37XbdDKc538W/NKGE31NavP/H8Xv7MiPX+eNtISYD8zqlP4VF0gwxNSLAIx2Jd6JtLKZh7EJdpO/btIzivsmif1Vjjgsfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351298; c=relaxed/simple;
	bh=MFujNyASwH2GJjgHGG3QFDocxOl0YjCPqiPhoIph2mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/8ZOqYEZE695l7J8v/o7rXrY297drNDf5VeKsJ3zwLH7aNjKdecBIy02gCfkzmruTciFuVVxxfKIrVKrix+jPifzbtcJr2157t6SFDq3L5iBu3MlXJxZ0vejsq9uCWlDgQxmUhKd2lZOI37s11P6xoc0uOd23U99Huf/yFaA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R3aYZ46P; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738351298; x=1769887298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4yZG/tdv12ElQV+ylOrMRBpcaw2HIhfWkB8XC76yhY=;
  b=R3aYZ46PlHxtXDhhA5DG56N6t+Zribnk9koL6/qTw4vEuosxEo3Gj7Sp
   SazbAM0vCNZnUdeQHegteT/HisuhvTRwF55vCYjeyyieJPpFeNROw5MTt
   WyaXRv5S557pNomSQWypyb3E+T2Qg9t2WW9jEKu9kEl1SJ2C5F/MSipMx
   I=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="795204546"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:21:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:41436]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 62046dfa-4cb8-462a-8e91-2b6833f991f3; Fri, 31 Jan 2025 19:21:36 +0000 (UTC)
X-Farcaster-Flow-ID: 62046dfa-4cb8-462a-8e91-2b6833f991f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:21:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:21:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 11/16] ipv6: input: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:21:24 -0800
Message-ID: <20250131192124.96238-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-12-edumazet@google.com>
References: <20250131171334.1172661-12-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:29 +0000
> dev_net() calls from net/ipv6/ip6_input.c seem to
> happen under RCU protection.
> 
> Convert them to dev_net_rcu() to ensure LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

