Return-Path: <netdev+bounces-161849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B841A2436A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E49B3A1E62
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78610143888;
	Fri, 31 Jan 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MkyrVzbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047E1369BB
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352137; cv=none; b=ohL10uTb4LO58Fk27B/K52q0Hi6blOn3zeHqjFDthxbq/1WAyWaI359xjrYkX/MPN1iUr26+nhcL67mVxGwsSXAAevxF5RDKLFpTGEojJECp7e/OlgBhL2tZC4bSJrsDLIGB46sCkhHn/IhG6LnKo2PPniSdHrYJq5bec8JkQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352137; c=relaxed/simple;
	bh=qJFaG3PTW8x/zOVsLQdZQK3TChbVc5Iwt4mwBsgdHn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhhW28IroBlZQMZAi8DHwnpIsAfhxkxcVjlhjpCMM0vax08lV87lQy889R0VWSxMLi87Di3MIOwXUYGDQ/prUx5+pzblR199WTxoVK4Bye4ND8ud9dQoxghwSXUzvcblWsbJLf693DJ6DYEj9ZYjP9aICo0nKnaTMwGMX9F+FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MkyrVzbT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738352136; x=1769888136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYntOiU1diLlRopWwPpKtlWQglpDQ8rBSKjPNPpNX1s=;
  b=MkyrVzbTpuzR6ZSJI1+2gJI35kesWjPDi8IwMBNvnTl8iVtffejKecCP
   PN52d2JVjFBdoKVrQfvthmjyng7qSW2R0v3oSk7l3ArvSrpF48b9m6pN7
   TQjWkttEFSx6+4P5OmG6UsSRcGDtY5GKT5/rLZYtyDyYdTbptoO0Y5kTq
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="468434245"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:35:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:2044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id 87e8cf03-1445-4a60-9013-4a060a645f57; Fri, 31 Jan 2025 19:35:31 +0000 (UTC)
X-Farcaster-Flow-ID: 87e8cf03-1445-4a60-9013-4a060a645f57
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:35:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:35:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 13/16] ipv6: use RCU protection in ip6_default_advmss()
Date: Fri, 31 Jan 2025 11:35:18 -0800
Message-ID: <20250131193518.98994-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-14-edumazet@google.com>
References: <20250131171334.1172661-14-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:31 +0000
> ip6_default_advmss() needs rcu protection to make
> sure the net structure it reads does not disappear.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

