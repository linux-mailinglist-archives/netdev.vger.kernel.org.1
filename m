Return-Path: <netdev+bounces-161822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3274A2431F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37393A7C41
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D81F1512;
	Fri, 31 Jan 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZF8wK2BR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B821F0E53
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350238; cv=none; b=pu935yEMrDLZ765mPMux7QsF8i/Ae5wVtdKzCWqcies/kf/pkV6l0RnOksBfLKVWLFhw5LbULxLmwREd0NJuh+u00ZTfWCQtfI+kZKTcXIKZxcC79UL08B2YlizFpUbK/hAjbWfus+F72Da/7GZKdYbdAkvll5w0BZRA6uYYzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350238; c=relaxed/simple;
	bh=FqOmv/aT0CUl1QtuLHo7ddfwe1KjgmzhoUY4jWJJlC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXA5t77WEKddf4pdtICRt3D7T+7u98t+aXPQbWs5v2BD10v46jrM5aATLJb1GzWHTuUz2yBjr6IfdbSUyYE9BhTfqKAr4in6buVoR9WUcXej5ceTINCEsSjTruyYnhJk98DkB7jMUUOwR98qdfnJZbdYyX5FVSUYHeL8ukheLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZF8wK2BR; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350237; x=1769886237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFgcNC293X6xGpEn7OXHsP+Lnv6nIPMZE49eye8nRxU=;
  b=ZF8wK2BRnG0TFtA/qZq0yB8ZfxHyS0zLQqOgJuuhNancZyOXwZ/7yGEC
   vbD/Z/uRNpd7f6qtaRsvnUVNMIS9IFk00m0iaFWZu0xQrXJpY/2R6Ukt1
   /QBlEgT2WNvSpnDOWBy3hS487o/8ChVzu9L1pJmGQGnVhNk2+3IRkqn/C
   4=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="490223677"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:03:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:7328]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 99aad6da-e204-444a-b66e-884a4af0e5b2; Fri, 31 Jan 2025 19:03:46 +0000 (UTC)
X-Farcaster-Flow-ID: 99aad6da-e204-444a-b66e-884a4af0e5b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:03:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:03:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 06/16] tcp: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:03:33 -0800
Message-ID: <20250131190333.93989-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-7-edumazet@google.com>
References: <20250131171334.1172661-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:24 +0000
> TCP uses of dev_net() are safe, change them to dev_net_rcu()
> to get LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

