Return-Path: <netdev+bounces-163379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6997A2A0DD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EBA164411
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4F22488B;
	Thu,  6 Feb 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DB3auvW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285E2561D;
	Thu,  6 Feb 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822958; cv=none; b=JvZuQo3lOEaW/KT/50H7bwmuNeB7daOnW+TDqANf47mmbq23GIcCUK6r8hmxjYFs38kV7AvJPf0w5NVGKn9lCME7GHdJ134NmdiBWR6tpmsp6wWWR7/otb8AKPHMuEAnPKBA2ufAUdI1IVJkSqnAjn3x1jRQXbUjZTreghea0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822958; c=relaxed/simple;
	bh=Ttbeuq4RpY+y9yjf/TK7FVUqR3Vrh8rL7ngUwSa+n98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2uDR5D0Si1R4UuBcV/90Bv5hgdsyQwgrlg2IKSGHaHnDw5c26PGneuO9u6wbGJrVq7fpRL8U46/T/BqOCAz/dbcgi9TLQZsAZm0dWKOmJfdrw9IPeY0d8A5+LrNKrdoE1h+2JZkY6pgME/G3pp+2lmVblz3QzYcYAn8Gq71MXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DB3auvW0; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738822956; x=1770358956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7lODT0rdAkUuR95gD53p0noLcySrQExYoGtTuaJkiU=;
  b=DB3auvW0jCAncVpxlzMBktQ/vtqWctNtcUYO5oOJol1hkvDLsq/3uGV8
   Yy4vxjK5wGmXcuIpcpKv4pjFtspY6pqCUEYXKXEDOTpajhRFaUDlNUfIV
   me7qUwpOeO+7f/xq+N13pOvUhOJ3qCkxP8QfxiQNPED8pIiFmmK+cfj7P
   o=;
X-IronPort-AV: E=Sophos;i="6.13,263,1732579200"; 
   d="scan'208";a="63573970"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:22:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:41725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id 98133ef0-9f04-44a4-947e-4b749013d6e0; Thu, 6 Feb 2025 06:22:31 +0000 (UTC)
X-Farcaster-Flow-ID: 98133ef0-9f04-44a4-947e-4b749013d6e0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 06:22:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 06:22:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <buaajxlj@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <liangjie@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
Date: Thu, 6 Feb 2025 15:22:17 +0900
Message-ID: <20250206062217.94843-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206054451.4070941-1-buaajxlj@163.com>
References: <20250206054451.4070941-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> Subject: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length

s/pathname/abstract/

In the v1 thread, I meant "filesystem-based sockets" is now called
pathname sockets.  sockets whose name starts with \0 are abstract
sockets.


From: Liang Jie <buaajxlj@163.com>
Date: Thu,  6 Feb 2025 13:44:51 +0800
> Refines autobind identifier length for UNIX pathname sockets, addressing

same here, abstract sockets.


> issues of memory waste and code readability.
> 
> The previous implementation in the unix_autobind function of UNIX pathname
> sockets used hardcoded values such as 16 and 6 for memory allocation and

nit: 6 isn't used for mem alloc.


> setting the length of the autobind identifier, which was not only
> inflexible but also led to reduced code clarity. Additionally, allocating

you need not mention inflexibility as the length are fixed and won't be
changed (it was changed once though)


> 16 bytes of memory for the autobind path was excessive, given that only 6
> bytes were ultimately used.
> 
> To mitigate these issues, introduces the following changes:
>  - A new macro UNIX_AUTOBIND_LEN is defined to clearly represent the total
>    length of the autobind identifier, which improves code readability and
>    maintainability. It is set to 6 bytes to accommodate the unique autobind
>    process identifier.
>  - Memory allocation for the autobind path is now precisely based on
>    UNIX_AUTOBIND_LEN, thereby preventing memory waste.
>  - To avoid buffer overflow and ensure that only the intended number of
>    bytes are written, sprintf is replaced by snprintf with the proper
>    buffer size set explicitly.
> 
> The modifications result in a leaner memory footprint and elevated code
> quality, ensuring that the functional aspect of autobind behavior in UNIX
> pathname sockets remains intact.

s/pathname/abstract/

Overall, the commit message is a bit wordy.  It can be simplified just like

  unix_autobind() allocates 16 bytes but uses 6 bytes only.

  Let's allocate 6 bytes only and use snprintf() to avoid
  unwanted null-termination.


> @@ -1203,12 +1205,12 @@ static int unix_autobind(struct sock *sk)
>  		goto out;
>  
>  	err = -ENOMEM;
> -	addr = kzalloc(sizeof(*addr) +
> -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> +	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
> +			UNIX_AUTOBIND_LEN, GFP_KERNEL);

nit: indent is wrong here.

If you are using emacs, add the following to your config:

(setq-default c-default-style "linux")

