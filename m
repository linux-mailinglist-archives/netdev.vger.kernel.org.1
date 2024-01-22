Return-Path: <netdev+bounces-64912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77108837733
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 00:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2052878C7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0F376F0;
	Mon, 22 Jan 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XB36Qe4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B23381AE
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964311; cv=none; b=A0dFlSHhRq4MA+KKHyZurIADktuAyi501vODKydQzDNb+Zx1NWC2+JxtKnkAv4Qq9BhVYqwoQyKEAssQyxOWI4moTJJqVnN7zxiFY5BWWuYmvB2SBt99AwD8tswNRMf4RSQuQO1hvG76jOAARfYRnWaPeyStBw4y2j7Hs7Mb+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964311; c=relaxed/simple;
	bh=apxPQS/nTRgTdbDue99N0uuc/T8Q1Yvo+juRZTpZs+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsuF255rTiMgsqfcFoKdqvc5dlajg8BNS2cgDwG7sb4xBAR5p/DZYaETBz7l/RVy+mQGfa7WoOt1YGpZFHvFdJzNn/sXOgQCCcp3qFyZLhqkjmDrAQPJebdRnoBrZsywQuKW8yS2DrPfntRlVGcAKFqmc9E6ngvPpAuDK3gb5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XB36Qe4G; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705964308; x=1737500308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7qvwwcWU4bwExCmuc1ys/s6IbSr8vEp+sp3JrQ8DjQ=;
  b=XB36Qe4GwyJ1bNLtrBSGw8/VpoIC6ZMtiZPIz7gsEkNfRzvEpgIl7t3T
   7UFm2YjBooHWrAMTfVnw3coLn6lg8F7BbOHKvssEV5siosrj8Drw3CZeN
   0ejAFVfnfNXuAVfeJQmAJz8uTxa5DbM67ThBbhzC+xWOUO5XMFeaEVoBL
   g=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="322875881"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:58:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id BF87B4B00B;
	Mon, 22 Jan 2024 22:58:18 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:23136]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id 90279a09-eb66-431b-b86d-4e7676834a91; Mon, 22 Jan 2024 22:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: 90279a09-eb66-431b-b86d-4e7676834a91
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:58:17 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:58:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 9/9] inet_diag: skip over empty buckets
Date: Mon, 22 Jan 2024 14:58:04 -0800
Message-ID: <20240122225804.21656-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-10-edumazet@google.com>
References: <20240122112603.3270097-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:26:03 +0000
> After the removal of inet_diag_table_mutex, sock_diag_table_mutex
> and sock_diag_mutex, I was able so see spinlock contention from
> inet_diag_dump_icsk() when running 100 parallel invocations.
> 
> It is time to skip over empty buckets.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

