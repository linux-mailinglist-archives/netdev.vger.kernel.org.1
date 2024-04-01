Return-Path: <netdev+bounces-83816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5C894655
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 22:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDAE1F219DE
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAF53380;
	Mon,  1 Apr 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s1PEhFtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7052A1BF
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005130; cv=none; b=RVgLTFZ66IMn5tewRshmnLAypmjdw9/hyzSzBe1Yjk4kJP6VwKlfGw+qoJra5yweECSZI+DyI6Zr5b4uyV1y0JE4P2SG39OfUtNuCg0caEcQscf2k0/XYewiB0mx7AhTd3+Js6eyjTq7OilcNV4zUAwQtqExKV0QpQarYAWwqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005130; c=relaxed/simple;
	bh=tm0ihtpT7JdCGYsFAL2ij6dWDkdYuibpAtA1aETmL0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1RJ+fWtnpssoWiTyieEb955Ug2OIw7+YT/btobx+SYhR0geRDPoXJtuwrnkjNaB254pvC+RTCuh0vbztxcQr2mafYtQbQy38PpUs3puoEz8HGusNu3ZgvJ3S8ZNEg7nD8SPpib5obmcG9Lt4ev77EZY91IzxmaI/3N/9/wjreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s1PEhFtq; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712005130; x=1743541130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSMcnavmO6fs5Ka2AW0Ckm+qtB9y3ISSaTTEB2dqYZY=;
  b=s1PEhFtqdxVywjQFF0ZCIm0ASlG8MDB9VFWCis6vSQBJFPEgRvP/EnXb
   Gz+4xfek2zMBI31QYml8OxTBGkH1E7rSMh8QCrI9brC3bl0JUDlFYVeL3
   biumu93Z5ITrYNwUEGlDm2ToOY5KG1pMpzD4M2Yq4UjFSEhLpcxybA2S4
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="284398715"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 20:58:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:43913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.0:2525] with esmtp (Farcaster)
 id 8936919c-629b-4db5-abca-b5c51f9c77af; Mon, 1 Apr 2024 20:58:44 +0000 (UTC)
X-Farcaster-Flow-ID: 8936919c-629b-4db5-abca-b5c51f9c77af
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 20:58:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 20:58:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] ipv6: Fix infinite recursion in fib6_dump_done().
Date: Mon, 1 Apr 2024 13:58:31 -0700
Message-ID: <20240401205831.23407-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240401205020.22723-1-kuniyu@amazon.com>
References: <20240401205020.22723-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 1 Apr 2024 13:50:20 -0700
> 1;95;0csyzkaller reported infinite recursive calls of fib6_dump_done() during

Ugh, a garbage was inserted while editing description...

I'll send v2.  Sorry for the noise.

