Return-Path: <netdev+bounces-169950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119FAA469A1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708A03AA7F3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2523BD0F;
	Wed, 26 Feb 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eK22OXkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A53235BF4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594038; cv=none; b=I3avklvxb1DTC02dOQrnR+f+NYu9RFuSG23rwTDPjKTZymhw1MUrLyp8culgjigJtv7qLPk4oZWVEz2X852nOlL0tvRYxdyFGL9TN6RUnJDU/ofJa1kFZlUHLHWpkt74zYSljGGanOxNfTWmvNXfjrRB1/lWfiP65Qu9rapxnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594038; c=relaxed/simple;
	bh=nUQ9c80TjFr48x+NGZJsue8mvbNhfPvvBRrhyyXNoU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljC0VN0k17gwyRGlrzlQq8ytiH3FPHvrgjfSHEn47FFvAVxTZMHj9xKzYmOpx3YkQaVfoQVJvKLfnbljpBYCek2uVT+/JEumE5VFnhCySlCBY7hJaj73kaQ+VmZCxAlylhZWQBuYkHPCxCj9Ws3XEDMEUwybCFybE4dtMN1rPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eK22OXkf; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740594038; x=1772130038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMWjdFaQi1NSsZ9LRRZG8DFE4rt/dmdIfQqKEAysT1c=;
  b=eK22OXkf2IVt3SV2OVJ1u5tLhA0qAJkfrRAayX3yQWfc3D83s6Lu1vfW
   ulduLl1KE0VZEBx2/xK2AYWaShMTVgFwog5f2IGA96q9kAoxRSR1KOcCX
   WMCShd8Hv/AoYPmPGQMXTLs4UTD8UNelG8u+RapSthvE60Dq45vgQdR5W
   0=;
X-IronPort-AV: E=Sophos;i="6.13,317,1732579200"; 
   d="scan'208";a="700425409"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:20:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:48106]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id 94fe871c-879c-4337-b258-ab6e8075bd85; Wed, 26 Feb 2025 18:20:32 +0000 (UTC)
X-Farcaster-Flow-ID: 94fe871c-879c-4337-b258-ab6e8075bd85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 18:20:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 18:20:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
Date: Wed, 26 Feb 2025 10:20:19 -0800
Message-ID: <20250226182019.98268-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <a0a1ee91-b557-4721-9d35-a7914f75ed2b@kernel.org>
References: <a0a1ee91-b557-4721-9d35-a7914f75ed2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Ahern <dsahern@kernel.org>
Date: Wed, 26 Feb 2025 11:12:13 -0700
> On 2/26/25 11:09 AM, Eric Dumazet wrote:
> >>> @@ -1627,6 +1633,8 @@ static int __net_init fib_net_init(struct net *net)
> >>>  out_proc:
> >>>       nl_fib_lookup_exit(net);
> >>>  out_nlfl:
> >>> +     fib4_semantics_init(net);
> >>
> >> _exit?
> > 
> > Yes, this was mentioned yesterday.
> 
> not in this code path but rather fib_net_exit. Hence me pointing out
> this one only

Sorry, actually I realised the path and fixed just after sending the
diff yesterday.

Will send v2 shortly.

Thank you both for the review !

