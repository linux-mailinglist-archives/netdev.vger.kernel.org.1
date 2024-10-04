Return-Path: <netdev+bounces-132278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB399126F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFD81F221DB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA861B4F11;
	Fri,  4 Oct 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H+uZK4KJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7F140E34
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081711; cv=none; b=LWdVjnDFzUa4chqswtugp0XBgFgaXKssIDoT165Q7tLxhSP4p74O3JXQlqJUupBnbxGEyQ2J7GfOrCsw1x0ANHV2GtSHqAIAYauXu8l+o5WQ2Gv5JAeTDGGSMD+u9nKXGbzWi6MDkT3j6a9lTie4npPn6Enogjmo1E8gpvZxxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081711; c=relaxed/simple;
	bh=OZ7ARwyvWLs3BAjODsWn6DJ03hWAaAYBaGflqoYzly0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBdEQZcRXxvDGxoqRd9PP3sDvioCeVPNLDD+0qDFhyQeEK4lvgGadnMQXYQErwiIrvJPX8HqxJbb3dA8Cr6rz3ZqkPoHQLNwOfyMQWiWLv5oAcZBkwtkSHAE6Hco6UtHO7t+/bka/FugkElvEJPRDSFNutg6ZnS4PV/j7YxAEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H+uZK4KJ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728081709; x=1759617709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxsyhVn+SeBNvweqiFpLxtCD9rGpJMcDn1Udt1I9Rg4=;
  b=H+uZK4KJZgsmdCb4g4H8Ht9V4TwEsLqxB60EB1ru6SoZV9d3ontPw+W0
   RYPghieZIEpGCuVBmRzIvwm8fDs+SFkzuTRGdMLtswxV0NY4nPtajO3hI
   b8TZ/RZUe1FOezL/iy+2rTq+HczqgT8TqpYQvFDAjBl4Q4ihsIbk65GJL
   k=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663833945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:41:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:47701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id 2710b1e0-5b67-445d-a9b9-67cb9cf70f4b; Fri, 4 Oct 2024 22:41:47 +0000 (UTC)
X-Farcaster-Flow-ID: 2710b1e0-5b67-445d-a9b9-67cb9cf70f4b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:41:46 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:41:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alexandre.ferrieux@orange.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/4] ipv4: remove fib_info_lock
Date: Fri, 4 Oct 2024 15:41:35 -0700
Message-ID: <20241004224135.81826-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004134720.579244-4-edumazet@google.com>
References: <20241004134720.579244-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  4 Oct 2024 13:47:19 +0000
> After the prior patch, fib_info_lock became redundant
> because all of its users are holding RTNL.
> 
> BH protection is not needed.
> 
> Remove the READ_ONCE()/WRITE_ONCE() annotations around fib_info_cnt,
> since it is protected by RTNL.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

