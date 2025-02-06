Return-Path: <netdev+bounces-163433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2AA2A3B6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A363A2649
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0D225796;
	Thu,  6 Feb 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SgUtMWTp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20A212FA0;
	Thu,  6 Feb 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832335; cv=none; b=nKwfHIqL/O28QfF2vPawhXxb2aNd2WG/4wHMH9GBGym/lhJlrpQRPSS+66NIkLIu3DKUXqewR3J+NuBOlNiR2IUYqdIasHixhJtBIUcY64zupf1ipix8udHXAMisvqvRhuCk+5jYGoMg+pSw4YuBx1z4yHXVMc8sgpTU59gzltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832335; c=relaxed/simple;
	bh=wc25hk7ga8HNa/hd937ioU1n3Sb48Rm4X3Z+j+Vgt3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqwDXQhnvRXBOVwtdzYAPvn34DuAB66IxyPfIn+/Aj230vW2QipqvBvtTPXHNqGy5naKg2xaupzycqiVCY57Bb0wc8NC5tCDR6Taefi6VgyriWO/E4kEDxT1yZ2+QWV3suPXyXC3cJOYJjV5EJLyUI327vYtLhLkm05aB8UTPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SgUtMWTp; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738832334; x=1770368334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uctEa20dgAyfV1SyZYhSpI/JU/RXiENHuerKkT/i5xY=;
  b=SgUtMWTpJ8gWJIVoy7iKK/vmpZ7JG8kBjw8izfuaxZTQpf18N69FyXL0
   D3mZ6gLXVuuyHQBc42eEqq4YDv8Tk9VicO358f+TsKuDC6giBFw6nDxwv
   CHvtba3cTWATahbv4f6+YmbJUOWeR6uCp7pH3KA0dXUslU9j7B92NUONg
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="491616971"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:58:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:19887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id ba81d3cd-c3f8-44d0-851b-f600cabb34ff; Thu, 6 Feb 2025 08:58:47 +0000 (UTC)
X-Farcaster-Flow-ID: ba81d3cd-c3f8-44d0-851b-f600cabb34ff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:58:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:58:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <buaajxlj@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <liangjie@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
Date: Thu, 6 Feb 2025 17:58:34 +0900
Message-ID: <20250206085834.17590-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206081905.83029-1-buaajxlj@163.com>
References: <20250206081905.83029-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liang Jie <buaajxlj@163.com>
Date: Thu,  6 Feb 2025 16:19:05 +0800
> Hi Kuniyuki,
> 
> The logs from 'netdev/build_allmodconfig_warn' is as follows:
>   ../net/unix/af_unix.c: In function ‘unix_autobind’:
>   ../net/unix/af_unix.c:1222:52: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
>    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
>         |                                                    ^
>   ../net/unix/af_unix.c:1222:9: note: ‘snprintf’ output 6 bytes into a destination of size 5
>    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> snprintf() also append a trailing '\0' at the end of the sun_path.

I didn't say snprintf() would work rather we need a variant of it that
does not terminate string with \0.


> 
> Now, I think of three options. Which one do you think we should choose?
> 
> 1. Allocate an additional byte during the kzalloc phase.
> 	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
> 		       UNIX_AUTOBIND_LEN + 1, GFP_KERNEL);
> 
> 2. Use temp buffer and memcpy() for handling.
> 
> 3. Keep the current code as it is.
> 
> Do you have any other suggestions?

I'd choose 3. as said in v1 thread.  We can't avoid hard-coding and
adjustment like +1 and -1 here.

