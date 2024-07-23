Return-Path: <netdev+bounces-112655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911F93A66B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1881C22248
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB908158A04;
	Tue, 23 Jul 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TChd5gYW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CE13D896
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759694; cv=none; b=mChRERdi3gpY6+wzNSwsVtf4hu2srbXF9nMjoaDytkp5l1eS+ykUFT7b8mFeTC21vWhF+6O5+N/9/SaLsL29GC7/L/A2xm69ZzNKyLMNmcR6YjlVhk8MqZIngwg2djpSPO/xdfwhAdlpZjwvuZJ6ZIyBtV6y0n9uWr9MxD5atKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759694; c=relaxed/simple;
	bh=vzUFlaUZin2aijik5iDReXwa+SpYfQhyGs6oYIzgqmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd/a1gz/z/IEpiK8KrKDdZ8TIG6IQt5A09g+roWafd7ME1LpEqlhqxpQ/xq5CdRhR2I/2dBq9Cq8oUL1WwXwbOZK1NUcuiX2LpbKbLtVMoeX02qY+3YhxSPXajg0t5PPid5ewo5ASqrgjdW87PDTgoN4U8xjZsTKc3Nm/DsK+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TChd5gYW; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721759694; x=1753295694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nnO9+8kcjZSGTIjm42lhcscJNkY/C9ePEQBRp0QsBQ=;
  b=TChd5gYW8Yv6XOVXF1bdxTTat/PMHuBDWqWPV74IyfR9tvkeP+F6nFnC
   +4kOMKLiZ2Odfdquss8xulcAMiIvWbc8G/LX6yoofi/rTlD0M9YJM7gF5
   ttfkjEaGrWsjRwuToJIsBnH9nHi9n9s7MXk57KBSM9FmbaFpE3Yf9i7W6
   I=;
X-IronPort-AV: E=Sophos;i="6.09,231,1716249600"; 
   d="scan'208";a="14495033"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 18:34:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:40679]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.144:2525] with esmtp (Farcaster)
 id 95229f46-34c3-4cb4-8b74-a22720d37ecc; Tue, 23 Jul 2024 18:34:49 +0000 (UTC)
X-Farcaster-Flow-ID: 95229f46-34c3-4cb4-8b74-a22720d37ecc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 18:34:36 +0000
Received: from 88665a182662.ant.amazon.com (10.88.135.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 18:34:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jchapman@katalix.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
Date: Tue, 23 Jul 2024 11:34:25 -0700
Message-ID: <20240723183425.30788-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240723085023.GA24657@kernel.org>
References: <20240723085023.GA24657@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Jul 2024 09:50:23 +0100
> On Mon, Jul 22, 2024 at 12:15:56PM -0700, Kuniyuki Iwashima wrote:
> > Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
> > ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
> > net->gen->ptr[l2tp_net_id] in l2tp_core.c.
> > 
> > Now the leftover wastes one entry of net->gen->ptr[] in each netns.
> > 
> > Let's avoid the unwanted allocation.
> > 
> > Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Hi Iwashima-san,
> 
> It looks like this problem is a resource overuse that has been present
> since 2010. So I lean towards it being a clean-up for net-next rather than
> a fix.
> 
> That notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks, Simon.

Will post this next week in a seris.

