Return-Path: <netdev+bounces-54743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B580809D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35722B20BC7
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E912E43;
	Thu,  7 Dec 2023 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sRT9geQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB7D5C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 22:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701930344; x=1733466344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2jReGGCyRp+y/k5FCZoNO3LYGHtipg7fhNZMQUxKZ74=;
  b=sRT9geQwO5H/ErVDilCTGWyf80Mw8JVE8mbMAxYJf5GM8Ad6Qj2cSHNP
   OSDv8puzq6+ojO5E83dbFIPAXpawDldhJ5tc2/noDquzms/6Bt0PBFUEC
   CV83Q56hlUjqgS/EaDZK9avj/Q2wzbEO42v92Yq+6snSmNE4QMzZ5ZDCO
   w=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="688864162"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:25:38 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id EB1BA40D52;
	Thu,  7 Dec 2023 06:25:35 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:2456]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.113:2525] with esmtp (Farcaster)
 id ed85839e-b64d-4a99-9727-ed1e02584826; Thu, 7 Dec 2023 06:25:35 +0000 (UTC)
X-Farcaster-Flow-ID: ed85839e-b64d-4a99-9727-ed1e02584826
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 06:25:34 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.249) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 7 Dec 2023 06:25:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.laight@aculab.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<jakub@cloudflare.com>, <kuba@kernel.org>, <martineau@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stephen@networkplumber.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP local_port_range.
Date: Thu, 7 Dec 2023 15:25:20 +0900
Message-ID: <20231207062520.21109-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
References: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 6 Dec 2023 13:44:20 +0000
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
> 
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
> 
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
> 
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
> 
> Signed-off-by: David Laight <david.laight@aculab.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

