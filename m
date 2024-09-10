Return-Path: <netdev+bounces-126762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2682972651
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E56284F76
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7D1EA84;
	Tue, 10 Sep 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KyCJpDUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55D23AB;
	Tue, 10 Sep 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929326; cv=none; b=EQF9NlVTAEkXJm/1ZTbesKaE5eFU6DgHiwAyDlFTuUkzRwMLydETiIMPcSFgNverX/J31VAp3KLruuESZlUSVYUqiyZTHKwa2C9ca90s55h+UFMsTHeMVUeg3gf1qzXOkS17JBszJz8w2B5446Ykn5eybtWv5PH1a70+AF8SglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929326; c=relaxed/simple;
	bh=48LqUnlveeKws5INMRkRdQ0zAZs9FCjCeB1ES5t8XxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r19UdTT7FKPttLxf0kBJB3zyRno4k8T9lNVypIZRgJt+XM3FU9St4EQ7mhy11Dq2r8pyItCnOiOZAnifvb3/0jLIXiSJagFz6CpkOBOrAfZw58ENOyHqixlQPT37b0zp1aUriCKtyKjMIMeOKAthlmVBjmRjlXK1gbPoXVw4tEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KyCJpDUO; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725929325; x=1757465325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Y/as7NM5A/YC0hwcOIyH/PqCpBCUn17L7+PjNvM+84=;
  b=KyCJpDUOw8wj4+i/AtuygW62RDMlEj6mPxjU6iyq0ZPRZglCsJndXRRT
   ndVlkjn687Eh/QAz4+kSTNEsNmPfxn2nJh+YzNB9O3cPM6rVt/ogcx/P9
   nNMIP3oL40hpTW4SvaOwBQx7PVbISlKgESSzHZvdaTIPrdKBOioTqNMQj
   o=;
X-IronPort-AV: E=Sophos;i="6.10,215,1719878400"; 
   d="scan'208";a="230762294"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:48:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:64334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.247:2525] with esmtp (Farcaster)
 id 3520f5f3-71f7-4eda-8088-d62542c3ca1b; Tue, 10 Sep 2024 00:48:41 +0000 (UTC)
X-Farcaster-Flow-ID: 3520f5f3-71f7-4eda-8088-d62542c3ca1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 00:48:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 00:48:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Mon, 9 Sep 2024 17:48:29 -0700
Message-ID: <20240910004829.38680-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2dd7aea9-93a1-4fbb-91a8-b7f3acd02a60@oracle.com>
References: <2dd7aea9-93a1-4fbb-91a8-b7f3acd02a60@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Mon, 9 Sep 2024 17:29:04 -0700
> I have some more time investigating the issue. The sequence of packet 
> arrival and consumption definitely points to an issue with OOB handling 
> and I will be submitting a patch for that.

It seems a bit late.
My patches were applied few minutes before this mail was sent.
https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/


> 
> kasan does not report any issue because there are none. While the 
> handling is incorrect, at no point freed memory is accessed. EFAULT 
> error code is returned from __skb_datagram_iter()
> 
> /* This is not really a user copy fault, but rather someone 
> 
>   * gave us a bogus length on the skb.  We should probably 
> 
>   * print a warning here as it may indicate a kernel bug. 
> 
>   */ 
> 
> 
> fault: 
> 
>      iov_iter_revert(to, offset - start_off); 
> 
>      return -EFAULT;
> 
> As the comment says, the issue is that the skb in question has a bogus 
> length. Due to the bug in handling, the OOB byte has already been read 
> as a regular byte, but oob pointer is not cleared, So when a read with 
> OOB flag is issued, the code calls __skb_datagram_iter with the skb 
> pointer which has a length of zero. The code detects it and returns the 
> error. Any doubts can be verified by checking the refcnt on the skb.
> 
> My conclusion is that the bug report by syzbot is not caused by the 
> mishandling of OOB,

It _is_ caused by mishandling of OOB as you wrote in your patch.

  ---8<---
  Send OOB
  Read OOB
  Send OOB
  Read (Without OOB flag)

  The last read returns the OOB byte, which is incorrect.
  ---8<---


> unless there was code added to disregard the skb 
> length and read a byte.
> 
> The error being returned is confusing. The callers should not pass this 
> error to the application. They should process the error.

