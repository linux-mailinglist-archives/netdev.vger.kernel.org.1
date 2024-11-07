Return-Path: <netdev+bounces-142588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4479BFABC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCA01C21539
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B723BB;
	Thu,  7 Nov 2024 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GcuEPhOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AA802;
	Thu,  7 Nov 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939171; cv=none; b=a+WGyOZSyDacFMQTSZLZUQ6zmcPMQ+aSEh9meoiSh3/oGO62g+GxZacdyKX3dvXwHm9v8f4ifNUzax6y3xsjs2zGyreV3VL7U6cpkgaKJcqRvBT5QwN88lj5aVAwJHgjt71ksJFG58Zdrc9wbquK3MZWh4BZyCAqboMMLLEHjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939171; c=relaxed/simple;
	bh=V24g0XjdSR3KmWIINIhNa7poMXefzESQmJIU/pn1fvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSIYmBbrMkN4QO9uflY+equv0IlKCV7erOFYrB1VUl5u6HptfsUtDo7lbXqGfVKOCHC2JzPtVgLySZH6KELbfLat+WcroPBE5XLPJ2/osW1RTZlcXiNRNZfTpFG5QfzCGzs1bSGExj4srP9C1Z5rwHHi5aEByckQ1G9GTowwqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GcuEPhOU; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730939167; x=1762475167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5X7qYpliwdH19RR4mFHMESmrmvrEXsbWaPIcg8nulk=;
  b=GcuEPhOUlgqTYMEgkC6e3DRWt+mnIrigSylhoH28864yaXWs73HzTf70
   AEo61eOWN6WejInQx8IDlPUTlNUyd0i8KhoPHluQj+d6tlwuKUCkQpuIW
   vpbA6eXeZ8I3VtAN932RXUBflUdBx6tc2Qe483/RkJ61qHD/LAswk8foP
   M=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="440863737"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:26:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:54833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id 0136e4bc-95e4-44c1-b368-efeaa6636554; Thu, 7 Nov 2024 00:26:02 +0000 (UTC)
X-Farcaster-Flow-ID: 0136e4bc-95e4-44c1-b368-efeaa6636554
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 00:26:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 00:25:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <devnull+0x7f454c46.gmail.com@kernel.org>
CC: <0x7f454c46@gmail.com>, <borisp@nvidia.com>, <colona@arista.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<geliang@kernel.org>, <horms@kernel.org>, <john.fastabend@gmail.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <martineau@kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 5/6] net/diag: Limit TCP-MD5-diag array by max attribute length
Date: Wed, 6 Nov 2024 16:25:55 -0800
Message-ID: <20241107002555.57247-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-5-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-5-d62debf3dded@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:18 +0000
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Currently TCP-MD5 keys are dumped as an array of
> (struct tcp_diag_md5sig). All the keys from a socket go
> into the same netlink attribute. The maximum amount of TCP-MD5 keys on
> any socket is limited by /proc/sys/net/core/optmem_max, which post
> commit 4944566706b2 ("net: increase optmem_max default value") is now by
> default 128 KB. With the help of selftest I've figured out that equals
> to 963 keys, without user having to increase optmem_max:
> > test_set_md5() [963/1024]: Cannot allocate memory
> 
> The maximum length of nlattr is limited by typeof(nlattr::nla_len),
> which is (U16_MAX - 1). When there are too many keys the array written
> overflows the netlink attribute. Here is what one can see on a test,
> with no adjustments to optmem_max defaults:
> 
> > recv() = 65180
> > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> >      family: 2 state: 10 timer: 0 retrans: 0
> >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> >              attr type: 8 (5)
> >              attr type: 15 (8)
> >              attr type: 21 (12)
> >              attr type: 22 (6)
> >              attr type: 2 (252)
> >              attr type: 18 (64804)
> > recv() = 130680
> > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> >      family: 2 state: 10 timer: 0 retrans: 0
> >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> >              attr type: 8 (5)
> >              attr type: 15 (8)
> >              attr type: 21 (12)
> >              attr type: 22 (6)
> >              attr type: 2 (252)
> >              attr type: 18 (64768)
> >              attr type: 29555 (25966)
> > recv() = 130680
> > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> >      family: 2 state: 10 timer: 0 retrans: 0
> >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> >              attr type: 8 (5)
> >              attr type: 15 (8)
> >              attr type: 21 (12)
> >              attr type: 22 (6)
> >              attr type: 2 (252)
> >              attr type: 18 (64768)
> >              attr type: 29555 (25966)
> >              attr type: 8265 (8236)
> 
> Here attribute type 18 is INET_DIAG_MD5SIG, the following nlattr types
> are junk made of tcp_diag_md5sig's content.
> 
> Here is the overflow of the nlattr size:
> >>> hex(64768)
> '0xfd00'
> >>> hex(130300)
> '0x1fcfc'
> 
> Limit the size of (struct tcp_diag_md5sig) array in the netlink reply by
> maximum attribute length. Not perfect as NLM_F_DUMP_INTR will be set on
> the netlink header flags, but the userspace can differ if it's due to
> inconsistency or due to maximum size of the netlink attribute.
> 
> In a following patch set, I'm planning to address this and re-introduce
> TCP-MD5-diag that actually works.

Given the issue has not been reported so far (I think), we can wait for
the series rather than backporting this.

