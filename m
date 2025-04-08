Return-Path: <netdev+bounces-180478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3975A81733
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F498882799
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560FC253333;
	Tue,  8 Apr 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tUx2zsvI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CF2500DE;
	Tue,  8 Apr 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145678; cv=none; b=XYSBD0h45vBuehaRbV5FVjju0bx6nEBGXnFUUdIeGlBnpbXtu0r37/9GJFPW/XSCmxYhBsHepXUoA0m/Hju3KV69xZno+8WT4kjuhX2EW4esbQhkmH83i6qClOEZ189sav8AYjrjrQtoVRPODjOHdKkyjNsr+pWArfJmk5m9v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145678; c=relaxed/simple;
	bh=draSekVRrKC87FpGV0FSHqnUcDGLKadJ0kmEvf3/eJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpYDv0n+vKaOWUinnXBltepUCoVEZg6VtJqQ+ISUBVQRuHAwP/zQqgofEk73QIZHYosM7xoKSMVfA5qltb/kcxAaCHynsOHhs6zrCGBk33r/tOhEHbedqooA5eyKAuOjk1fBCFMvUMp8fIuoGARHD+bdhSUVPHZIn2paBJoMRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tUx2zsvI; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744145677; x=1775681677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JOYQdAT9aHVDW60xlrEBrMfxxClVahQwTUxrVj9X9eo=;
  b=tUx2zsvInR6X1m36MSF8frosmvYtnS+b9LManc7RHUJT8/qhLbhHO6QI
   p4rRwyVItAueUxUX5KGOMvnpwYEjYiAwtRuXANCVhEpBClVw9yGk78AIs
   4DTFpAH4nuM8NLoqFxm7cbWL0/JuYSq6zKz76VZPyVIZEfOJz2F/tb3pL
   4=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="478673300"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:54:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:26062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 4872f542-0cb8-43af-aeea-9f5d1821a2f5; Tue, 8 Apr 2025 20:54:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4872f542-0cb8-43af-aeea-9f5d1821a2f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 20:54:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 20:54:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <mathieu.desnoyers@efficios.com>,
	<mhiramat@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <rostedt@goodmis.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next v3 2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
Date: Tue, 8 Apr 2025 13:54:13 -0700
Message-ID: <20250408205417.84283-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
References: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 08 Apr 2025 11:32:02 -0700
> Add a tracepoint to monitor TCP send operations, enabling detailed
> visibility into TCP message transmission.
> 
> Create a new tracepoint within the tcp_sendmsg_locked function,
> capturing traditional fields along with size_goal, which indicates the
> optimal data size for a single TCP segment. Additionally, a reference to
> the struct sock sk is passed, allowing direct access for BPF programs.
> The implementation is largely based on David's patch[1] and suggestions.
> 
> Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

