Return-Path: <netdev+bounces-64910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8283768D
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBDEB22495
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AC610A04;
	Mon, 22 Jan 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BnKUDGoC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31710797
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963888; cv=none; b=ac+IS4ZEd3D8totBeo9/g4cXjTHIkCNBjUE1QOgFvAc/7vyJBSfBqg192/T0SCGufCcjfOZ3n1O/SYqDL7GYR/TYbQUhRX713+05ZDohGJxeRrsYeWd5Mn+tDKbVhF6+6WFAyd55Q6xWBA65qv1iFCX7tDMKraKPtl83XobVSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963888; c=relaxed/simple;
	bh=H59Y98d7yTFG+8p5VQYYNxRzSg0nGFBV9NzaDy8yJho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM5R9tFcI1cz+ztuH4t4hk3AKbVy1p9s6X+7fOILzlJye5STHR/Ydm0vbF0/6BXD+W/+DgopN1qY5JHk46JkjIK1yZJGHzVGdZBxdto9xDQ25zLjJmXzp1xqsEs1vdtq3D1q38j9pp51Hu9hB1GhFCw89GwWZSV/AZCr1sc1/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BnKUDGoC; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963886; x=1737499886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBQi+Er20KUplemcdMjRuEARG8WSPbe1P2gqt+KNj2E=;
  b=BnKUDGoCQVL3CGgfSvv+fGXD1GZc1ILMWFD6+qI3TnwrmN8i5/aASMCd
   +UHh4IUFDtcM0FrRHG1o0JhrMKFtYorSbL18B0OlHf/Q7kasaRXI0VKKS
   KaCVR5vmVpFyx05D+IjQnKal4x6cyaK4xi76vQmcGIhYwVcVb1sucNYCc
   0=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="608141899"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:51:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 2BEB88291C;
	Mon, 22 Jan 2024 22:51:21 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:13484]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.34:2525] with esmtp (Farcaster)
 id 21d58c4b-ab06-42db-a97c-a6fcb3949141; Mon, 22 Jan 2024 22:51:21 +0000 (UTC)
X-Farcaster-Flow-ID: 21d58c4b-ab06-42db-a97c-a6fcb3949141
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:51:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:51:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: [PATCH net-next 7/9] sock_diag: allow concurrent operation in sock_diag_rcv_msg()
Date: Mon, 22 Jan 2024 14:51:05 -0800
Message-ID: <20240122225105.20980-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-8-edumazet@google.com>
References: <20240122112603.3270097-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:26:01 +0000
> TCPDIAG_GETSOCK and DCCPDIAG_GETSOCK diag are serialized
> on sock_diag_table_mutex.
> 
> This is to make sure inet_diag module is not unloaded
> while diag was ongoing.
> 
> It is time to get rid of this mutex and use RCU protection,
> allowing full parallelism.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

