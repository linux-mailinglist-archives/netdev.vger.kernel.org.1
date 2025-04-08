Return-Path: <netdev+bounces-180018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C95A7F1FC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B427A6022
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2061B414A;
	Tue,  8 Apr 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B4ZQdWid"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7735A47;
	Tue,  8 Apr 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074360; cv=none; b=SaFwV9akLjdZJ4rbnkGzfYNI39Ybb/MiUrZkhNOaUzjJUuQI3QHQUYIma0OlSW8U8xrAFYhKgup+YhTiyU+gkq8OGdPr4/t7g/lWNp7fK4VMG0psM6FlGrU5YHiG3+88BczulCLYb3WCarbNHYQUZyd+B3RdoFIp+gCj7aOvf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074360; c=relaxed/simple;
	bh=q7LpHDz5ZvEft7A4xiD0DEob3QBubJin0e+68DECao0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jd42VtiB7KywS3NJ4SQs5FSWepZZX87RV5kO3HpNbjNsIQUJKp+dIlkpOxPK40PMXmnuVcydyXzXEJLiOTiTYoa7DTFIdLQoQWyR2IgHgYRd1UXfs59H7K08/MGBHR3lul/sTOWYz98Znz/a25/W4E4B7bcllEZguyw7CG5+nXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B4ZQdWid; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744074356; x=1775610356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJJGSx7wJVFrRnUCVfUyyMkOWEby701Bmb0MsWWb2D8=;
  b=B4ZQdWidyZjXqg6qmmoihqUi+v5qGyFKPhPwmLkZQuO1r7FaENBaxFQe
   hkWwwf/MKS7+dVPcD+xoRLGjCXYuVTc0kHgcvTiDeWVvKydhivsF4d2gf
   TwXT1mG2qjnorpwoF8zdCsdgtXrbGPYTfIgKrpI+tLjt1q0G0HZ74IgNh
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="733685599"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:05:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:51235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id d1b2cf05-ebff-4015-b2d9-b4a1a4f09ab4; Tue, 8 Apr 2025 01:05:53 +0000 (UTC)
X-Farcaster-Flow-ID: d1b2cf05-ebff-4015-b2d9-b4a1a4f09ab4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 01:05:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 01:05:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <mathieu.desnoyers@efficios.com>,
	<mhiramat@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <rostedt@goodmis.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
Date: Mon, 7 Apr 2025 18:05:32 -0700
Message-ID: <20250408010540.12096-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
References: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 06:40:44 -0700
> +	TP_printk("skb_addr %p skb_len %d msg_left %d size_goal %d",
> +		__entry->skb_addr, __entry->skb_len, __entry->msg_left,
> +		__entry->size_goal));

Also could you align these two lines as other events ?

