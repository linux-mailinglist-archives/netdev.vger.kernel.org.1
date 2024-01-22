Return-Path: <netdev+bounces-64904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2E837669
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565DDB2516E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEB13FF4;
	Mon, 22 Jan 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UfrBKaS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9720134DD
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963022; cv=none; b=QuiRUuiel9Bnfsm5T/IXJz6d5mHKximKL9oBzQU6IhDG7mC5u0AYT2w/yQ0eShyP7xa8dEAOpSNChefmfuVYpI3D/eC2KqyptpREpRgGxjhAy9BDs4sScKc5IIUKfhRPWWO2QXKeOPXkOwjkakaMo6ac5OUdUrVJwBvNphOnTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963022; c=relaxed/simple;
	bh=p98ng1Z7mse9EuAY5oSySwN68S4Cs6zYlHSRoN0NSjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxeHI/2aF5ODLZPbqeYHQLm9Zmq8Xwa5AET6jPj3sArwwSn/PMXUcG1n7QaN2XJ2t44SvCKUA/SLcl8Rx2LQk0dK+wX0vu9cLsowZOdmaRC5vQpoLUeHTvDTGMPqJLHbpfchV1VPvH9g6F5EWmVh83W9sSkFDOcXmEwnSTuJpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UfrBKaS3; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963021; x=1737499021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmLLUIWNCqflOxHlRUUwPqcLityFtzVaJR9s/bWE1Zg=;
  b=UfrBKaS3Jh0fkELABXWKXHT7cmbPl7IOfNI2j7W3GdUYVAyLjoOf65oz
   2Xxog0qM1uJtoxxEUrjcoKolzbwTh4qhwIauqq+yiTTfzHwVxrksDh4Do
   qXDjEHyUTbTfC8FVq0lzHX8aeZHvsddtb3xa/mJWEUNCY4ggTzAvrDW8U
   k=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="699673006"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:36:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id B3DD9808A6;
	Mon, 22 Jan 2024 22:36:51 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:23747]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id 8ed1178a-f111-4ef3-b6b3-4fda5f7c922b; Mon, 22 Jan 2024 22:36:50 +0000 (UTC)
X-Farcaster-Flow-ID: 8ed1178a-f111-4ef3-b6b3-4fda5f7c922b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:36:50 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:36:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/9] sock_diag: annotate data-races around sock_diag_handlers[family]
Date: Mon, 22 Jan 2024 14:36:36 -0800
Message-ID: <20240122223636.19548-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-2-edumazet@google.com>
References: <20240122112603.3270097-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:25:55 +0000
> __sock_diag_cmd() and sock_diag_bind() read sock_diag_handlers[family]
> without a lock held.
> 
> Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.
> 
> Fixes: 8ef874bfc729 ("sock_diag: Move the sock_ code to net/core/")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

