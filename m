Return-Path: <netdev+bounces-163459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3899DA2A4D9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551CD3A994B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C456215778;
	Thu,  6 Feb 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Eay8klC/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0022616E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834862; cv=none; b=T4EShQn7XGNf065RmiD+uBp4qZ76q3oqlpcWKT+omrCqlncA6UNDrQeYy+4+/jzmPN69wATVTSzVnDmjHSicHsKcV/r7G8Z8QvFLrN3q6P22PNVSF3SYqUoXXYtwSCB59MyOnZ1JawgdGp/sEk6Ldq1lg9BGq0knkPWbAnh3BIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834862; c=relaxed/simple;
	bh=evSSaLcgUdzNGH2Amg5t0lbpXdvG/1l405nHefQRuVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA/2D1pxOojfxZHsodZyUNGWjjHCBJaMOW5GvQ1088G5vcSmyp87LNhYQN9GJTzavsG4yIHvqqyqvZU5i3axALu4dgZzT2jWK7IJ/MijLW5EPXSP8lNzaRBZE8TysqbQHHClYbeuqH/NkXwLS4klNfNKkQQzqsgjvdMs2GuW4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Eay8klC/; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738834861; x=1770370861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YduTw2VNWzCoU/ALkH9zCZrn80YnH1jBgs9xyZ9lWWs=;
  b=Eay8klC/4nUDKk5eTRMWuUMOSiNYYlm93J5zpzN9zLnvQXLg3cxKjU8j
   MYihoWcHHYOtAhJHNZExEoWPt8yP6sn9b7vvP8ZjUTT533grnh13/dfyS
   W2CTz4TUFGGd8HknTZGsnebugWi4VRS77DyNK3qPcHUlXTOiFMn4DsxvZ
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="716522230"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:40:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:41403]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id a06045ed-add3-4765-a9f8-3813822abb6f; Thu, 6 Feb 2025 09:40:55 +0000 (UTC)
X-Farcaster-Flow-ID: a06045ed-add3-4765-a9f8-3813822abb6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 09:40:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 09:40:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net] net: fib_rules: annotate data-races around rule->[io]ifindex
Date: Thu, 6 Feb 2025 18:40:42 +0900
Message-ID: <20250206094042.23391-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206083051.2494877-1-edumazet@google.com>
References: <20250206083051.2494877-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu,  6 Feb 2025 08:30:51 +0000
> rule->iifindex and rule->oifindex can be read without holding RTNL.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations where needed.
> 
> Fixes: 32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

