Return-Path: <netdev+bounces-135815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0799F43F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD9281A78
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C41FAEFA;
	Tue, 15 Oct 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iHj4qrE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171D1F6690
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014045; cv=none; b=u/LpZMhgYNbNrtk4IqNNRUPrkPHdI0TwLd0uMZ6FYe2ZfgSWkmu06FxbwagZTQHDyXEesGRSNeXUUNbH6R394Alnhtg5PmX0JnydEkj2tYfs3kekMTjZ8PUi+62XdQ3M0JuDwcFCmhb3OpCQLpS6LZDm7TeDTPuIjit+/Yd6tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014045; c=relaxed/simple;
	bh=vgCHjdInXnm7mkRRH2yPHfiBm7HzLHgLWsk6w0FoLi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9T0L5eA4mkmosVMw7O9JEyRjrx4K2F/ossCAIbdaaNibqbhlXs0prZFQKxY2frJXGxV7Zw8qYL+ymlYDOCemWmTtPa4HvZ5vHUM9AhGL4WnkqFg2XoXcpMQGnLNJOW+btFpPLZgTO67h5FoWSXORXe/s+lYkE/RKxfwq4Kevg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iHj4qrE2; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729014044; x=1760550044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtK5XM2O2/ds2G8NPR0MKlpAnS2cveLRZO/x/Ezp4ZM=;
  b=iHj4qrE2b1gC8nnmuHlV4JGmMepRkrXKzl1QApizPKVtbp7Palzcs405
   WDXDoG/szTFrBJOqy1zYnQTdhYeI/xD95+p6wfTjHJtPhUd0owKyQ70Pz
   ohYugHiTGJlI/NyI4J9Ur7dEIFyIdJogSF+Mwrn60YwVAV31SIoWNSOq/
   g=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="441016914"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:40:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:48518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id ca47f92b-3245-420f-9039-9cf2ca6ecadd; Tue, 15 Oct 2024 17:40:39 +0000 (UTC)
X-Farcaster-Flow-ID: ca47f92b-3245-420f-9039-9cf2ca6ecadd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:40:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 17:40:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mkl@pengutronix.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 net-next 10/11] can: gw: Use rtnl_register_many().
Date: Tue, 15 Oct 2024 10:40:31 -0700
Message-ID: <20241015174031.17958-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015-ochre-gaur-of-whirlwind-d6e892-mkl@pengutronix.de>
References: <20241015-ochre-gaur-of-whirlwind-d6e892-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 15 Oct 2024 08:23:27 +0200
> On 14.10.2024 13:18:27, Kuniyuki Iwashima wrote:
> > We will remove rtnl_register_module() in favour of rtnl_register_many().
> > 
> > rtnl_register_many() will unwind the previous successful registrations
> > on failure and simplify module error handling.
> > 
> > Let's use rtnl_register_many() instead.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Who is going to take this patch?

It will be netdev maintainers because the last patch in this series
depends on this change.

I'll add a note below "---" next time for such a case.

Thanks!

