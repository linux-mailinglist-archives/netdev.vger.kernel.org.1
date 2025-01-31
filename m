Return-Path: <netdev+bounces-161851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DFA24389
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83318160F93
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266A1EB9E3;
	Fri, 31 Jan 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iL/BkTew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14218E25
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352801; cv=none; b=opOCSB6Lq4tbrLLPHCAEo9aKBZ8s5XlATlSvCGY8Wsgo1PxO++54JAre2ea1y4Ym2/hIPCdrQpZAr4KG8mSriXJ1g1+RG26yAEt8Po5PDiaA++Phqndi6IvzO/plde8AR32QKgtoi66buRibKeoP00JZTU3+Ic3jM75J5YM/o/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352801; c=relaxed/simple;
	bh=Bm+pHmE+f8fQlKDzP7H11DlNwLMgrawOgAyLQ/uxNTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNt1rAx0E8XXD0myli28pjf8CgOIleM2SofSEOUhWKmFCHe99C7jPCFxB7abJ1HevF9Uuzd7zQE4kUVv0LzguKjyX4TrYJzRQV/KsaBH3E3kjsxQdmCdzLoC8tUpIFYapnUHwe4kFV1B6TpOus4skzLTuZNQWqiD4kAwhNVtXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iL/BkTew; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738352800; x=1769888800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ptg3SUPk1vSJz3uuU/UpDewb+ykZ00kUGvnj/bQSVUo=;
  b=iL/BkTewKyiy/p8cmka8PBkmb1wbCpdNgpHPkt0XIEjumvUGZXf/rTzL
   i6cL5kJ5B/Pue6VZkkSpexRMHzxfC2skAOKEauo1GW6LzcrHzSwZ0N41t
   TfbYUInhcoi1kXdL7rx0xFdAcrSTETPkwIYQ1JL7LV1C4Ak+7X4IlevBV
   o=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="62169030"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:46:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:58368]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id dac0c295-abfc-4d87-a120-e76659fa81b0; Fri, 31 Jan 2025 19:46:35 +0000 (UTC)
X-Farcaster-Flow-ID: dac0c295-abfc-4d87-a120-e76659fa81b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:46:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:46:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 15/16] flow_dissector: use rcu protection to fetch dev_net()
Date: Fri, 31 Jan 2025 11:46:23 -0800
Message-ID: <20250131194623.187-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-16-edumazet@google.com>
References: <20250131171334.1172661-16-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:33 +0000
> __skb_flow_dissect() can be called from arbitrary contexts.
> 
> It must extend its rcu protection section to include
> the call to dev_net(), which can become dev_net_rcu().
> 
> This makes sure the net structure can not disappear under us.
> 
> Fixes: 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")

The correct tag seems to be

  Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")

, which moves dev_net() out of rcu_read_lock().

otherwise looks good to me

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


