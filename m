Return-Path: <netdev+bounces-64909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9083767F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8F1F27DFD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D851095B;
	Mon, 22 Jan 2024 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YnNmq4Ez"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65915AF5
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963698; cv=none; b=Ksbc/l1c5T/hCdImWSiiGLTlotSrzsqc3IFe3cBplLt3Q4+mXCLQzj1KGdInLGus7nmpces2i71VGZ0ny5SsiQ7E/ByUjgxkjj5WE7sxiTgmKWOp+efaC/HfUiW6B5kXD8HgkjZ9wWHNSGhLhUf3RFlZBSTvS4OyfJgYsAbxRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963698; c=relaxed/simple;
	bh=7JWtywd50hciMSIejBOS8t6oEOk7c/P+a3TBbxmhkM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWhRfiACdrrfqkwAXdsqexqBxuLhu0UXA9ZMxuaC4ccmw5jajtGRLnCUe8HVtPOo6N1bEvKLIOjUQOzgRq7/i7xfQzer3hn5zPA1HA9yLXYoAGdJn1ZSvrD1S6tcNCh9Jv5dKjkn4QJFulI3rkbrVbojqVOtaO2WP3oSKdq12Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YnNmq4Ez; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963696; x=1737499696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWTvXJ966LJa0cutfUVrx8E1VGxoBqmqv/vXVTvM690=;
  b=YnNmq4EzP+RvV82kuO/DoqSp3iTxe8cvpP/Wx5J9SerjxQBEeh9bbrNU
   T6jCtmHzUTNDv0P3SRWh4TYuO27hWeKSCY6wngIxKvCxsycJjO4lpFS1j
   iGWuSr/sVe3PstpsGcOWVq/hnMg8YI+GqXYJWAUsxJxEqO527SqP93pNv
   A=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="179762412"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:48:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id CA90C40D4A;
	Mon, 22 Jan 2024 22:48:12 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:28503]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.5:2525] with esmtp (Farcaster)
 id 5b5f845d-26ad-48ca-b258-5d661d2acc23; Mon, 22 Jan 2024 22:48:12 +0000 (UTC)
X-Farcaster-Flow-ID: 5b5f845d-26ad-48ca-b258-5d661d2acc23
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:48:12 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:48:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/9] sock_diag: allow concurrent operations
Date: Mon, 22 Jan 2024 14:47:59 -0800
Message-ID: <20240122224759.20804-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-7-edumazet@google.com>
References: <20240122112603.3270097-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:26:00 +0000
> sock_diag_broadcast_destroy_work() and __sock_diag_cmd()
> are currently using sock_diag_table_mutex to protect
> against concurrent sock_diag_handlers[] changes.
> 
> This makes inet_diag dump serialized, thus less scalable
> than legacy /proc files.
> 
> It is time to switch to full RCU protection.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

