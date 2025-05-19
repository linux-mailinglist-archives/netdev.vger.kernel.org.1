Return-Path: <netdev+bounces-191587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A770ABC56A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09287ADC78
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2071DE2DF;
	Mon, 19 May 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="L86I0qm8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC4BA4A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675046; cv=none; b=n0N587b0eWPoqD/FszaRUrE0KNkTvP6TFDW1i9gENg4Bj2NP3OxzdtL1q3ruGp/LO59XrjcpnoKujUJe12PXRe0vNV8IftsUlCTKIA83btIv9rNVJ2VX3pFfWaTmBGt8GuaIDOmrH6DS2eL7CHwlJHT7TxY6CbRGFkMw4CgRjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675046; c=relaxed/simple;
	bh=T2AnFe7/icNWrH3hrLwdbdefJIvfcC13vLkNaU4xBMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujwE2jKg2c6gEJPxgAoqUpiY3SssqBk/Xhe8gaqku48GYQm1Vbe2hmDuHhxyrOU7VCNCYlrHuRwalep51rq3iJBksn65UIMp8Waqnm5/FN1HS0gXTih2gb4Hawy3bmPTGGpk0ABfFIksYZYT5niIUlUhMLuPagofMmt6hDyUyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=L86I0qm8; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747675045; x=1779211045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+sWlMHzLjiq5AdNyjTbEgsI6IWXEvx0ZtHDRRq4llX8=;
  b=L86I0qm8sVQtD0H2zOKjTm6sBcpu21v8ySOPdSerOemhh3ctsKBd92/8
   kpuSD93WTwi8cUxY9p4jSQrjcxvoXnSLKxWhuxlaxzGEC5leTCsL4yULo
   Di0oowK2C/vWvc9A9VKNkR+3TsVpW23WmZdAruQ7KMnuLm1TJztV9qbxo
   NQhbdAwjvoCQ4805ejQfolMuaST552Fvc+Rn6WT/0UQVlt96VekqHY4Bk
   oSCUoEtfEaADF+gQ+xBbLTUfIX96gkdXN8ksQY2SZUG/ViYnbOp4Sq6df
   435Qge3dgVtqNBlMc4ZCe7qD/UDUL5z/wXCrDflYsfhvW+iHnh2RNUQVT
   A==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="51587668"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:17:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:57735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.141:2525] with esmtp (Farcaster)
 id 1276ce3d-a322-4365-83cf-5b4872e3fdb8; Mon, 19 May 2025 17:17:11 +0000 (UTC)
X-Farcaster-Flow-ID: 1276ce3d-a322-4365-83cf-5b4872e3fdb8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:17:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:17:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.laight.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 1/6] socket: Un-export __sock_create().
Date: Mon, 19 May 2025 10:16:39 -0700
Message-ID: <20250519171700.38903-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519131619.21132b21@pumpkin>
References: <20250519131619.21132b21@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Laight <david.laight.linux@gmail.com>
Date: Mon, 19 May 2025 13:16:19 +0100
> On Fri, 16 May 2025 20:50:22 -0700
> Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> 
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> > 
> > Let's convert them and un-export __sock_create().
> 
> Don't you need to worry about whether 'net' should be held before doing
> this change?

No, this patch just removes one unnecessary syntactic sugar.

  * __sock_create(net, family, type, protocol, &sock, 1);
  * sock_create_kern(net, family, type, protocol, &sock);

Even if there is a caller who manages netns refcount by themselves,
this patch does not change anything.


> Then you can unexport __sock_create() at the end when there are no callers.
> 
> I'm surprised you haven't found any __sock_create(..., 0) calls that are
> used 'hold' 'net'.
> (I've got some 'out of tree'.)

I know you have such a module from the previous reply, but again,
we don't need to care about the out-of-tree module.

