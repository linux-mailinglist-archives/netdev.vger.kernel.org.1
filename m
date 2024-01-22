Return-Path: <netdev+bounces-64906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6A83766B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB38285618
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E4FC14;
	Mon, 22 Jan 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CbU58a6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F6F4F9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963104; cv=none; b=jRZz01v5bU7NIAeaUtfRjwjix75fdMZpT9BN8luO+cg3aVT0YHvsINFrUUc0XCRWCt82Q3zZL+lQ2CTHeV+MdqiyVaMftAK3ZejOyk3fOsaF/snMwNeVkUt1JFw1hfqI5bIDlDd8+mJ5oubWZiGPVTc6j/soLF4jm1FqxspMIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963104; c=relaxed/simple;
	bh=hoSOxRT6AxiGF0UO/bd6ut05oqL5jWpx8x4SdOEplHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufS3Pu4s+lYfs761fj0vGcVY1KZZ45qYtz8ZiAgtegsu8RiquR1w3EXWRGvG/kx3oGH1do0vRTVTVfYzpuDeyE2boHjoVe5QbxtcTFEcVhXQCabkatLgKF44e7dihvTC1QyIWfgBrVJCqrwkKqEYaGeFB5UAz5BL+kCzTLB9wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CbU58a6V; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963103; x=1737499103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZmkOpASJtFFxcUuMhcBGHvJ/HaHLFmrp/XwzkXcVu8=;
  b=CbU58a6Vv89Ir1W4T/ZZuZe0YHDRQbYWUuD8pgtS+WVZLjJN2y+sdk0l
   a5C6+WmIe/AUCRTa7hDAl7eZ5zbeHCiHRaU77FTPPUXRAqv65nCilN++5
   e9k0dZ9PwcU6MC7x8vfxo0ydbXrAWfMSeKYuUJdNAhU1OMaS7Iqt4r1P3
   o=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="699673245"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:38:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 9BBAE40D80;
	Mon, 22 Jan 2024 22:38:21 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:36972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id 016b792f-8e31-499a-9bd0-72926eddd74c; Mon, 22 Jan 2024 22:38:21 +0000 (UTC)
X-Farcaster-Flow-ID: 016b792f-8e31-499a-9bd0-72926eddd74c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:38:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 22 Jan 2024 22:38:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/9] inet_diag: add module pointer to "struct inet_diag_handler"
Date: Mon, 22 Jan 2024 14:38:07 -0800
Message-ID: <20240122223807.19806-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-4-edumazet@google.com>
References: <20240122112603.3270097-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:25:57 +0000
> Following patch is going to use RCU instead of
> inet_diag_table_mutex acquisition.
> 
> This patch is a preparation, no change of behavior yet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

