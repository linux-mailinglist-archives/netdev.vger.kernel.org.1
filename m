Return-Path: <netdev+bounces-161829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E12A2433A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34C31883838
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BA1F2369;
	Fri, 31 Jan 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aHGZ9Ws9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607B1547E4
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351626; cv=none; b=Jd8WHr4kJLF8OnszG5mTsXRKtJaKW1jK2IH3l5iSSNNgXIlz9TF6NQYz3WJJy/q4cN2dYfv/COFPaWKZs8WSrEZdtb4vGlwTVjstGeCrmJSV61nXiTyxE9tdjKu4LaX78LMU14mS07Nxfn45rbpgsCdAYoHmHUDcVXc3m1miQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351626; c=relaxed/simple;
	bh=eMJfi8pxGHenSMVwrCeCUHc0IjRJY3ulXoDFo2kYpF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoBuUp8vZQPu9amy/fJj62tYDqU/59UUZHV9aXqUnwDY/KGClrulfVCqcPPICVSB3TtKRKqXB7IMUIKJjVqc0s66KX9Rs/WdietCyMFE1fJDcSe8KC/x/smD14s8MVMM/7pbryw6PCEqAQCxKbhC6fp1NuB+MnE5l7B2c1Vj0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aHGZ9Ws9; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738351625; x=1769887625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YXlJ5SzzUBR13pOKo3SuTXH11iaDviTEjEW8ATSGs40=;
  b=aHGZ9Ws9FmdTT2MM1xd9cNPq/tloM/nSPBNZt72rmwUQu9YyP9j1JbBg
   lcvqdjaMIqLlHhj3QasEheXRXjjD8YcJ2teO/+y82cCkCI63W+Zvg117z
   U/PtUV5Tn3WrAQhQQwh3zrIm9fAqk8y36yZM+L5zZSElG/t3QciZ8NwNR
   w=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="405023753"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:26:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38799]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id b21f7b4e-c067-45ec-ad1b-ee891b4358d5; Fri, 31 Jan 2025 19:26:59 +0000 (UTC)
X-Farcaster-Flow-ID: b21f7b4e-c067-45ec-ad1b-ee891b4358d5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:26:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:26:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH net 12/16] ipv6: output: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:26:44 -0800
Message-ID: <20250131192644.98018-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-13-edumazet@google.com>
References: <20250131171334.1172661-13-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:30 +0000
> dev_net() calls from net/ipv6/ip6_output.c
> and net/ipv6/output_core.c are happening under RCU
> protection.
> 
> Convert them to dev_net_rcu() to ensure LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

