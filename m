Return-Path: <netdev+bounces-163347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC649A29F88
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B593167440
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C17249E5;
	Thu,  6 Feb 2025 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mPyrtXhX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA315199B;
	Thu,  6 Feb 2025 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814497; cv=none; b=LM85b8aNPQkBrBj3NY5swPs+Nks9g4UyNPdlspvolETMnEI5O+ZuelNTrwkggrkZ13nVvqnCS9xySShJ75ieLtbYHqaGeR29BjU0gvqLSsGyuQpjeyCobOoB4KIODBLOOpDBngGfyeKHM3GwjQFtZhXHBwXhJjpLHEtIy+ffuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814497; c=relaxed/simple;
	bh=hYSddCZtH8T8rjaQx2PJ2jDZt4RdHTt6LhG4zQSBl44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOuXjKydzthpaAHbnKOpZPzNSdbWgFSMoyRCNuIjs9zYfDRKd+WYpISwbSwKTiS+SlpsQvBVfLOfOhwWm3zTOwdYi+kvQ65Oxe9chbpe8ZOE6UH6G3PeQUY5bR85gTidL6A0+xvZaX1FT0KXxhjyNHns36oUh58CKTDDfXMJpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mPyrtXhX; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738814497; x=1770350497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRvIjo1WEL8mKSMjR4n9GdLWbnVqLd4mvq/PW2nGwEQ=;
  b=mPyrtXhX/CEGqbltNrXkXrgwe2CcLPrmIZoovYwAKgpRYiTH+7WC88jr
   c/HfkTcXTKfS4SYaPS1b5GjujLz6gCPiOpy048W7B2w1OFPjy2fnDLuI0
   fvX1E5zkM7WJBcuASY6zzwE8GDYioS3/YIKoE+HWxnBJyq6jf5NeIeP/E
   E=;
X-IronPort-AV: E=Sophos;i="6.13,263,1732579200"; 
   d="scan'208";a="694787366"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 04:01:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:39315]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id 970b68e1-01c6-499f-9d06-ce978bf29ac2; Thu, 6 Feb 2025 04:01:32 +0000 (UTC)
X-Farcaster-Flow-ID: 970b68e1-01c6-499f-9d06-ce978bf29ac2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 04:01:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 04:01:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <buaajxlj@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <liangjie@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind identifier length
Date: Thu, 6 Feb 2025 13:01:18 +0900
Message-ID: <20250206040118.77016-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205100904.2534565-1-buaajxlj@163.com>
References: <20250205100904.2534565-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liang Jie <buaajxlj@163.com>
Date: Wed,  5 Feb 2025 18:09:04 +0800
> The logs from 'netdev/build_allmodconfig_warn' indicate that the patch has
> given rise to the following warning:
> 
>  - ../net/unix/af_unix.c: In function ‘unix_autobind’:
>  - ../net/unix/af_unix.c:1227:48: warning: ‘sprintf’ writing a terminating nul past the end of the destination [-Wformat-overflow=]
>  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
>  -       |                                                ^
>  - ../net/unix/af_unix.c:1227:9: note: ‘sprintf’ output 6 bytes into a destination of size 5
>  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
>  -       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It appears that the 'sprintf' call attempts to write a terminating null
> byte past the end of the 'sun_path' array, potentially causing an overflow.
> 
> To address this issue, I am considering the following approach:
> 
> 	char orderstring[6];
> 
> 	sprintf(orderstring, "%05x", ordernum);
> 	memcpy(addr->name->sun_path + 1, orderstring, 5);
> 
> This would prevent the buffer overflow by using 'memcpy' to safely copy the
> formatted string into 'sun_path'.

Finally new hard-coded values are introduced..

I'm not sure this is worth saving just 10 bytes, which is not excessive,
vs extra 5 bytes memcpy(), so I'd rather not touch here.


> 
> Before proceeding with a patch submission, I wanted to consult with you to
> see if you have any suggestions for a better or more elegant solution to
> this problem.

An elegant option might be add a variant of snprintf without terminating
string by \0 ?

