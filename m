Return-Path: <netdev+bounces-151634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90A9F0634
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A125F285641
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DB1A8F68;
	Fri, 13 Dec 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KolUmjig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6031A76BC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077910; cv=none; b=tBhOVnQPqzBjs3bF8lVkosRgtU7ekoz9LLwfeogQvlz6mZqGvGSydgP6PbphdtoBGxRGadjbw+mQtK9nJVsCImbZJYq0V7COZUEfUl3KDAOGiHhNC7oltLEf9VDttW/qaowOVMz8/tb/6DeBBbkj+BQP8VjpV2BtdDLFAZLC314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077910; c=relaxed/simple;
	bh=l1AI4VAYv2gvmERbK8QURAx9QS6GUfp09l1ZeL8ACBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1CqVraVAAPJeFEPH/CANUWqw3lXbJxp/5FVfPHo4w7FvqRFHnprsp+LNJEVAkpo7Bg7iNAmhK/XuZ1J8JhvQRKVfpeD1XwryME2SLDoqlqdtHV9azUQjbiu7/rNCpEqFhldqkCFezmSBb24qqVX9/VxKYGfSi8f8WCtwa5uYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KolUmjig; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734077909; x=1765613909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tU6BWDG+UdjUIAy5oemTiCfMwjHoC/Qaz97DVeQ/3I=;
  b=KolUmjigzbWNPkFUkEEHq9Dn1CBx+yMKewZJFRSh5Gjpc0vq6P3M3kOZ
   a+TJS8uN8TFl0yIQzmPrZyjMiMgpO7N7vEN8oVVkKJ2ZZb7Qs3yhzxgn4
   3wQaIvHWD1Kbf5RjdVnnAr9qyrocQes/05y+/m1V2nG7cAUxJ0WqP80W0
   w=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="155540592"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:18:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:5042]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.254:2525] with esmtp (Farcaster)
 id 1dd9789e-3de7-42e0-8e45-239fb0db5076; Fri, 13 Dec 2024 08:18:23 +0000 (UTC)
X-Farcaster-Flow-ID: 1dd9789e-3de7-42e0-8e45-239fb0db5076
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:18:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:18:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 04/15] af_unix: Remove redundant SEND_SHUTDOWN check in unix_stream_sendmsg().
Date: Fri, 13 Dec 2024 17:18:17 +0900
Message-ID: <20241213081817.6524-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f5076560-07c1-4fc8-93f8-df19b3568927@redhat.com>
References: <f5076560-07c1-4fc8-93f8-df19b3568927@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Sorry for the delay!

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 10 Dec 2024 12:48:53 +0100
> On 12/6/24 06:25, Kuniyuki Iwashima wrote:
> > sock_alloc_send_pskb() in the following while loop checks if
> > SEND_SHUTDOWN is set to sk->sk_shutdown.
> > 
> > Let's remove the redundant check in unix_stream_sendmsg().
> 
> If socket error is != 0, the user shutsdown for write and than does a
> (stream) sendmsg, AFAICS prior to this patch it will get a piper error,
> but now it will get the socket error.
> 
> I'm unsure if we should preserve the old behavior, weird applications
> could rely on that ?!? usually there are more weird applications around
> that what I suspect.

Ah, you're right.

When the peer is closed, -ECONNRESET is set to sk_err.
Then, sendmsg() will return it, but even in that case,
we currently return -EPIPE for the peer's SOCK_DEAD.

So the current app can live without -ECONNRESET :)


> 
> At least the behavior change should be noted. If it does not impact too
> much the series and drop reasons addition, perhaps just drop this
> cleanup? (Assuming my initial statement is correct).

Will drop this patch, thanks!

