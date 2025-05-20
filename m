Return-Path: <netdev+bounces-191967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1B7ABE0AC
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997B84C4032
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A826D4D5;
	Tue, 20 May 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bP/4j0fM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03525261596;
	Tue, 20 May 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758392; cv=none; b=mwHrVdNsm2AXR12PrVCrmgYGpnYDNRYe1X16g1w528KIVqf2kCrXR0ve5GoI5/t/O3MuHDeR2zEobz9594tUTtUsoXQM8EbyTjLGPJKte3iTpoH1WcJfagHUqgoiTxxbSPbv09rDi0N6N1nksbkBcatGVnrAErAo3JOmhwTD33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758392; c=relaxed/simple;
	bh=Ib5B/7pcVMqvWpHr/zzN1BIvadjOCgi2tt0kDIw7mVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWoQAGWWHlc/LmeQCkeNUURxzbqLdKxxLm49DAjumqX0W0EH/euW9nACQVPgQBYOYxQqfedOpU/Fxt/qz6VSG4Pzjyaj0McL+clBW2eqUPFGYLE8JBrvTu7NWg453Lkb+BtHPozMtxpKuqFUuYGuxE7Cex7HK9R60gQYSjrrVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bP/4j0fM; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747758392; x=1779294392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJiYqRXCOqetaHWcsJobXQrQBOCA1K8P8rVvZNNtzm8=;
  b=bP/4j0fMCZRr6ZWOzvg8YpA5o64hpzgsGudv+maF7hIcV1o2sAhr/B2Y
   lOZcvBTrAmjq26P5OH5J1jCa62C9mN6dBm9L1+LlStOshdzkfN0bEuYv4
   0+x8BS9PxDQj5alLwIrcU37TGqMENIeAwvDHIKq21Xfef658ZIUBak1Ms
   ZwjY1R8pqgtWZSvfaOyf+o8CnIVad4KmZZoKDKUe+Oc8SL5hlx2By2k6J
   f3WOVUc+DNovmgw7gd44G1pOb5V060wBa/f3GAcgobYrBRe6IX3m2Enu4
   jPbegzWPHh42ib/h+HIErDyWZt5pLhMHXTZFKK/wfvZ24DREHC6RKnW/R
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,302,1739836800"; 
   d="scan'208";a="407271640"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 16:26:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:44274]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id c1eea27a-c960-4069-abd7-b1daf19b1ef9; Tue, 20 May 2025 16:26:28 +0000 (UTC)
X-Farcaster-Flow-ID: c1eea27a-c960-4069-abd7-b1daf19b1ef9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 16:26:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 16:26:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <y04609127@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [BUG] INFO: rcu detected stall in unix_seqpacket_sendmsg
Date: Tue, 20 May 2025 09:25:30 -0700
Message-ID: <20250520162617.35163-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAJNGr6s2u+8tUvHzNCWAqweHD23ijRQoFzJE4kR0xouAFsRj5A@mail.gmail.com>
References: <CAJNGr6s2u+8tUvHzNCWAqweHD23ijRQoFzJE4kR0xouAFsRj5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Guoyu Yin <y04609127@gmail.com>
Date: Mon, 19 May 2025 15:32:09 +0800
> Hi,
> 
> I found a crash related to unix_seqpacket_sendmsg. The kernel reports
> an RCU stall in unix_seqpacket_sendmsg.
> 
> From my analysis, the stall occurs when user space calls
> unix_seqpacket_sendmsg (via sendfile or similar syscalls) with crafted
> parameters, causing the kernel to enter unix_dgram_sendmsg and
> eventually get stuck in sock_alloc_send_pskb or related memory
> allocation routines. This leads to long-lasting blocking in memory
> allocation, triggering an RCU stall.
> 
> The root cause seems to be insufficient validation of the message
> length or socket state in unix_seqpacket_sendmsg/unix_dgram_sendmsg,
> allowing user space to trigger resource exhaustion or deadlock
> scenarios.
> 
> I recommend investigating:
> The behavior of Unix domain socket send logic (unix_dgram_sendmsg and
> unix_seqpacket_sendmsg) under abnormal conditions.
> 
> This can be reproduced on:
> 
> HEAD commit:
> 
> fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> 
> report: https://pastebin.com/raw/JJyvCmCn

I don't think this is related to AF_UNIX.


> 
> console output : https://pastebin.com/raw/TUPGLzqh
> 
> kernel config: https://pastebin.com/raw/zrj9jd1V
> 
> C reproducer : https://pastebin.com/raw/ZzAVZ1ua

You may want to slim this down to a minimal repro.

Also, please make sure you run syzkaller on the latest kernel or
the latest LTS kernel.

> [   67.058143] CPU: 2 UID: 0 PID: 4456 Comm: syz-executor.1 Not tainted 6.13.0-rc5-00012-g0bc21e701a6f #2

