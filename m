Return-Path: <netdev+bounces-81859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804A88B5B5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A7F2E85DD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ABB2907;
	Tue, 26 Mar 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dMFF0Su0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD331865
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411312; cv=none; b=pob8xFobivtx2n1r3wbZnE5s9uWr7QSMK6jt7HEPYp3EX88M3weK37Fpauvm4il9JbPmyPXYk7L0VteibXQLBpGJRs6g/t79VxLUzGveaSn4begSc9qwrlh3gY66Sry0fVwNLPXvSdskpnQ2RXooCO3vyBgNpSfWQo70UXjrprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411312; c=relaxed/simple;
	bh=oAFxWJm7+VL4EUqj+AYP9xe3voW2g203ub6zxm+yhOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRw3V54NNPKibtVGxjPgkBDFWsYjre4mbDqho08bIijwtdLiWNl8k9WgVksoK0qnYkSvyVqS9v4szptp/9/TgoZA2moyKx0ULZJ38mySDrqz/EEKDyrIX9O/gNyWW5AMVQhkUDEIUsBUo/8vI1uTqdj50Te20fzzpG7ZyyA/d64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dMFF0Su0; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711411312; x=1742947312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdINsJ8cNjyHArxKDOxpB5ZlVjkqIRecBn2Wvi/5F9k=;
  b=dMFF0Su0h9l25QuMRuXSKRUAiL3uiefTMzp1+TFrvUR+A9ZmSUMkN0X3
   2OzFBQikKtE/hC6L2q97gJRXGRFc7aedUq9I5J3dOvWJcshhP2VOzWKI5
   XcFYuhvlbZasYgcFqi5cRZMjwe4ekdaNLuoDHbTZiAI+7Q/QqtWQ7dhEk
   o=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="647538206"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 00:01:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:18300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.115:2525] with esmtp (Farcaster)
 id e3992fe3-0710-41dd-855a-f72ce52372d5; Tue, 26 Mar 2024 00:01:47 +0000 (UTC)
X-Farcaster-Flow-ID: e3992fe3-0710-41dd-855a-f72ce52372d5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 00:01:43 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 00:01:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<joannelkoong@gmail.com>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <wujianguo106@163.com>
Subject: Re: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
Date: Mon, 25 Mar 2024 17:01:32 -0700
Message-ID: <20240326000132.83326-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325165633.0664c3f8@kernel.org>
References: <20240325165633.0664c3f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 25 Mar 2024 16:56:33 -0700
> On Mon, 25 Mar 2024 11:19:16 -0700 Kuniyuki Iwashima wrote:
> > -	if (sk->sk_family == AF_INET && ipv6_only_sock(sk2))
> > +	if (ipv6_only_sock(sk2) &&
> > +	    (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
> 
> breaks build for IPV6=n (i.e. TDC):
> 
> https://github.com/p4tc-dev/tc-executor/commit/ac16181d7589bdf29c7c3907243e829f6b954570#diff-0042f6af11ac801c4370fb95b8e4f0de734b793c9e23bff936a1bb03c63eb6f0R228

Oops, will fix it in v2.

Thanks!

