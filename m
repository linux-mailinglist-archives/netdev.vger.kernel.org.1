Return-Path: <netdev+bounces-115853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E97948163
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D2B256B7
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938E166F32;
	Mon,  5 Aug 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cO2crMxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187BD15B11E;
	Mon,  5 Aug 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881079; cv=none; b=h1CcDntq81vYdE3cPP0f4rwwOU36nIhJIHynBV+nuZ+Hx7qDVjm5oR6hBCtI9zmo2ky+nqiI9hzCUJZU7mWea0l/JWe5nj/q9eD7Hg4S26kFFzkLvCwJSM0E7P9e4Qkke2cxkzPrUHQG/SrAaU84zgIKGSzi6p6Cy8GEWXt7qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881079; c=relaxed/simple;
	bh=/Fm4WSux3jgOQkT8wpl2OCOo29ruZUYRzolSk0QRiJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p23GeM5tWZFeoswJArsDJtfZ+1NdGSK6XN4mahYHA0MTw+UwaqI8e0QDqXlLqk+C/syIBulnZbnRePMI4Ggqtl/j/fjtZQ6tXLEqBPhMjBvl9gQ8l5Mmp/lnH3yswk8cmVHkGQ+PGSPDZqGmqcv9VB/LIGBGb2sEyQRVlVmTd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cO2crMxU; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722881078; x=1754417078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7xpzuvKTfahjz278ShftZm85F/OTPTZmQRa/d7rdHo=;
  b=cO2crMxU8aaijIltbOrvnEUCV3t5cqtaMcHXKaGr37h1WN25MAojU+Hz
   b3tnqYzVXRpTBTBZoAZ2sIR8LCS722hvLx5Rzfisnby9vTmQR/2le+FYO
   etrv3vgCczL5CM9Iq5dKX1Mpz8fizwjioUH4l7oVuXRPlXzn0yv7GKbEs
   U=;
X-IronPort-AV: E=Sophos;i="6.09,265,1716249600"; 
   d="scan'208";a="747378270"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:04:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30996]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.228:2525] with esmtp (Farcaster)
 id 9903ace8-e52d-405c-9e46-020033e651f8; Mon, 5 Aug 2024 18:04:36 +0000 (UTC)
X-Farcaster-Flow-ID: 9903ace8-e52d-405c-9e46-020033e651f8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 18:04:33 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 18:04:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <0x7f454c46@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@kernel.org>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
Date: Mon, 5 Aug 2024 11:04:22 -0700
Message-ID: <20240805180422.71259-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAJwJo6ajnzqS0mNwEJNEYo5HBryRNJOtZeK7aRVGWCdu5ovc0A@mail.gmail.com>
References: <CAJwJo6ajnzqS0mNwEJNEYo5HBryRNJOtZeK7aRVGWCdu5ovc0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 2 Aug 2024 03:00:59 +0100
> On Fri, 2 Aug 2024 at 02:03, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > Date: Fri, 2 Aug 2024 01:37:28 +0100
> > > On Thu, 1 Aug 2024 at 01:13, Dmitry Safonov via B4 Relay
> > > <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > > [..]
> > > > Happened on netdev test-bot[1], so not a theoretical issue:
> > >
> > > Self-correction: I see a static_key fix in git.tip tree from a recent
> > > regression, which could lead to the same kind of failure. So, I'm not
> > > entirely sure the issue isn't theoretical.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=224fa3552029
> >
> > My syzkaller instances recently started to report similar splats over
> > different places (TCP-AO/MD5, fl6, netfilter, perf, etc), and I was
> > suspecting a bug in the jump label side.
> 
> I'm glad I dropped you a hint :-)
> 
> > report19:2:jump_label: Fatal kernel bug, unexpected op at fl6_sock_lookup include/net/ipv6.h:414 [inline] [000000001bd3e3db] (e9 ee 00 00 00 != 0f 1f 44 00 00)) size:5 type:1
> > report23:1:jump_label: Fatal kernel bug, unexpected op at nf_skip_egress include/linux/netfilter_netdev.h:136 [inline] [00000000c1241913] (e9 e9 0a 00 00 != 0f 1f 44 00 00)) size:5 type:1
> > report45:2:jump_label: Fatal kernel bug, unexpected op at tcp_ao_required include/net/tcp.h:2776 [inline] [000000009a4b37e9] (eb 5a e8 e1 57 != 66 90 0f 1f 00)) size:2 type:1
> > report49:3:jump_label: Fatal kernel bug, unexpected op at perf_sw_event include/linux/perf_event.h:1432 [inline] [00000000c1f7a26c] (eb 24 e9 63 fe != 66 90 0f 1f 00)) size:2 type:1
> > report58:2:jump_label: Fatal kernel bug, unexpected op at tcp_md5_do_lookup include/net/tcp.h:1852 [inline] [00000000fbd24b58] (e9 8d 01 00 00 != 0f 1f 44 00 00)) size:5 type:1
> >
> > I'll cherry-pick the patch and see if it fixes them altogether.
> > It will take few days.

I haven't seen the splat so far after applying 224fa3552029.
Before that, syzkaller reported jump_label splats 4~5 times
everyday, so I think 224fa3552029 fixed the regression.

Thanks!

