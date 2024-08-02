Return-Path: <netdev+bounces-115175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23039455D6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC69DB217DA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62CA2D;
	Fri,  2 Aug 2024 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="flXP5mXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF742171BB;
	Fri,  2 Aug 2024 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560589; cv=none; b=u6Wbf+QQpkv3GTJG7OMMekUIGR6+Vw9G1hnxghK8qDZALCI16fvDX0OgqzzPlRAhbT6SZqkbS4tw35+YQ4nQ6muJPtO7Xsbk4Orto1yQvtaaGhCGGa+KSccL/VNimdrQJlEzcYg/jhWrV6XIpfd2NfsPnZ7pZ5ruoAcNHyEVbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560589; c=relaxed/simple;
	bh=dKJTM03keVfsRmbcnJBDmHSwgb9oVPMiUwVmGAsWZs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THiw+6WoLXv2uETv0BYIIH/eBIAcgAnmlE2YYti4GrgNfyuHFIRNhGQ2JX47kziRN/Fb2GtSLaZ1/0II2mR54ca97mHef2G/cvM4/aOfAhQKIgabeh1WPQnsPlM8jnhJ070WclWtzSo12c750mqHCTyZUDYEOTirmhyDIPJVKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=flXP5mXa; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722560588; x=1754096588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppqz0qBOe+1vbVD1zltSVM91NLyrfS7kjEtkva9EbhU=;
  b=flXP5mXaUFGHU7/7CM2Lka/klWsSzMMNW/YAU3PDtY3FB8pxJHa3RDpX
   jboMFcO2yKCSJoM7koMLLvLlM50mJqoEMo8RBlRRx4Ogd8N4Y43pVBRfd
   uVdQdD8sFZ1+63j/5Gf7ENnT88mTL9EWgi/LqUu11JhGpYLe3GD2QVqYm
   g=;
X-IronPort-AV: E=Sophos;i="6.09,256,1716249600"; 
   d="scan'208";a="746530064"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:03:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:32328]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.192:2525] with esmtp (Farcaster)
 id d5c455eb-1462-420f-8b74-c2cf7f601752; Fri, 2 Aug 2024 01:03:01 +0000 (UTC)
X-Farcaster-Flow-ID: d5c455eb-1462-420f-8b74-c2cf7f601752
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 2 Aug 2024 01:03:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 2 Aug 2024 01:02:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <0x7f454c46@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
Date: Thu, 1 Aug 2024 18:02:50 -0700
Message-ID: <20240802010250.82312-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAJwJo6Z-qsZ9ZLV7qHrc=ujYT0Q2Ayod_C6e9kM+2QH48z650w@mail.gmail.com>
References: <CAJwJo6Z-qsZ9ZLV7qHrc=ujYT0Q2Ayod_C6e9kM+2QH48z650w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 2 Aug 2024 01:37:28 +0100
> On Thu, 1 Aug 2024 at 01:13, Dmitry Safonov via B4 Relay
> <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> >
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> [..]
> > Happened on netdev test-bot[1], so not a theoretical issue:
> 
> Self-correction: I see a static_key fix in git.tip tree from a recent
> regression, which could lead to the same kind of failure. So, I'm not
> entirely sure the issue isn't theoretical.
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=224fa3552029

My syzkaller instances recently started to report similar splats over
different places (TCP-AO/MD5, fl6, netfilter, perf, etc), and I was
suspecting a bug in the jump label side.

report19:2:jump_label: Fatal kernel bug, unexpected op at fl6_sock_lookup include/net/ipv6.h:414 [inline] [000000001bd3e3db] (e9 ee 00 00 00 != 0f 1f 44 00 00)) size:5 type:1
report23:1:jump_label: Fatal kernel bug, unexpected op at nf_skip_egress include/linux/netfilter_netdev.h:136 [inline] [00000000c1241913] (e9 e9 0a 00 00 != 0f 1f 44 00 00)) size:5 type:1
report45:2:jump_label: Fatal kernel bug, unexpected op at tcp_ao_required include/net/tcp.h:2776 [inline] [000000009a4b37e9] (eb 5a e8 e1 57 != 66 90 0f 1f 00)) size:2 type:1
report49:3:jump_label: Fatal kernel bug, unexpected op at perf_sw_event include/linux/perf_event.h:1432 [inline] [00000000c1f7a26c] (eb 24 e9 63 fe != 66 90 0f 1f 00)) size:2 type:1
report58:2:jump_label: Fatal kernel bug, unexpected op at tcp_md5_do_lookup include/net/tcp.h:1852 [inline] [00000000fbd24b58] (e9 8d 01 00 00 != 0f 1f 44 00 00)) size:5 type:1

I'll cherry-pick the patch and see if it fixes them altogether.
It will take few days.

Thanks!

