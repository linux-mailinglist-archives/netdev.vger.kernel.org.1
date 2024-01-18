Return-Path: <netdev+bounces-64294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46583219D
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660F4287833
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289E8F51;
	Thu, 18 Jan 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G2x06v1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38641D680
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617322; cv=none; b=lWsE+o40+2NUQhBa+EJRAnOI8F1jQnLzQt5FJH98NT3OYPocAhfO4gcX0EUyE6JXIJkqs/7fU0vA56dcHPTA4J6Ymo4nTwzbbSD0sS68Q0i3JE7NU/mHSpnwuvYV1YKDM+CQCjYd+RwXoK5yNU+84/tPw3f0ambN+xoQXl7X5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617322; c=relaxed/simple;
	bh=qwBgH1daIO4vJXxZr+A1UDEO+90gqlcK0MB7ZIezvXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSaQtLHqjr6zlYOV1UByf2W2zFUrP1dhmIxjWFPGL50poCgk/uokWtGGRkt5ZLBzoSUX+IYEcwN3O1kyQmAMQOoZeHiM2raY8gEhYnXXnLpJHc5dDIJC/Ya0mkze8yU0p32+Dd8DWVJuoHK3BFqPI2UtYrh1E4nOW+lXlBl9YYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G2x06v1a; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705617321; x=1737153321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDGjcFNfs1cZ9v1hGSCvLBMnHYdpC6dfoGrW56bqWm8=;
  b=G2x06v1a8WewUp1bWJU6mkmdpKVcIRZEP1AQGq47Mxv+X1Gt8vYmCG1J
   4T39yjKF6DYduihMseSExQbHgMVaIOSSxxO/vp6h+IQbXqpjlLKL5dnzl
   zNTbxax8+I7UdO6hWiKX8trnXWlySjK9DC27P7ZoUunO6m4xExNBefoSC
   0=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="380726474"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 22:35:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 0C1D535E175;
	Thu, 18 Jan 2024 22:35:15 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:33063]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id 4ceff773-06b7-4cc2-a9e1-8b3ed8d0ee88; Thu, 18 Jan 2024 22:35:14 +0000 (UTC)
X-Farcaster-Flow-ID: 4ceff773-06b7-4cc2-a9e1-8b3ed8d0ee88
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 22:35:13 +0000
Received: from 88665a182662.ant.amazon.com (10.88.183.204) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 22:35:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+2a7024e9502df538e8ef@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] llc: make llc_ui_sendmsg() more robust against bonding changes
Date: Thu, 18 Jan 2024 14:35:00 -0800
Message-ID: <20240118223500.44066-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+=WbG00Qo9mqk4GuJjv0T9fEkgoDUCOXKVue-=_LAEsQ@mail.gmail.com>
References: <CANn89i+=WbG00Qo9mqk4GuJjv0T9fEkgoDUCOXKVue-=_LAEsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 23:14:21 +0100
> On Thu, Jan 18, 2024 at 10:59 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> 
> > Probably we need not check SOCK_ZAPPED again after llc_ui_autobind() ?
> >
> 
> Possibly, I was not sure if the socket could be disconnected or not.
> 
> This would be a nop, or a correct check if disconnect is implemented.
> 
> Do you see a problem with a strict validation ?
> 
> I am tired of syzbot reports about llc, I want to add every possible checks.

Agreed, no problem.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

