Return-Path: <netdev+bounces-127097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA306974168
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7866A2877E8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A451A3BCA;
	Tue, 10 Sep 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="shMg9m6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3C16DED5;
	Tue, 10 Sep 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991074; cv=none; b=r2rEzVfUdRrMTNOsKG0n1N/HI3/6mSwq48hyli4KvGpQuLwEuIpOrIYZpXrbK65KQ65Cj2uGfVt8OeC14GuC2fBZZm+DgXPWaadsmy+3ylZcysxBIC1ECWqJT9Pou+yEzYgmAg5m1O5t3u0wlrrrGCoJkI6168EV7g+oNGU3UxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991074; c=relaxed/simple;
	bh=rdRAE/ICr34khZmo66LD3I/QSBaBHEaIbem+AJltasQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzYjGjO8+Vf+Bw9B9xM5YG7tz1GYzzSrVJocNY1ScqqukvFQbMVAVzd2Gp2OlV0cs5zjlvhErCe73xxySHzV1q2Q0KyNE3KTfWV6njpf4V1TzVt6mLckAKBCBgNg0E2o/434wIS8NIRJ6+5IBPmk5dyWdhz/q6iSKKan3YBtmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=shMg9m6/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725991072; x=1757527072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y29GAMmX7rSiYp8XFiaq/GS0tAhPK0+7Ska+Uh/bulY=;
  b=shMg9m6/Nu3L/SJE6jCwcCUgOLacmvDbcKOZO9OS851tBkitE44OxqbA
   hajnUCjhMv6VcwhO+9CIOt1VMr+BeaaP+cucDep5o6sUZ6FmpvsVKtsk6
   yX49pecSRsKE6DqGe04GrQrRIMzlcQcCnbxRzQus06tSE0z2J7r2s2LSC
   U=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="124650064"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 17:57:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:62191]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.75:2525] with esmtp (Farcaster)
 id 3fe5cdd4-7827-4c44-aca2-9f2c9349c46b; Tue, 10 Sep 2024 17:57:48 +0000 (UTC)
X-Farcaster-Flow-ID: 3fe5cdd4-7827-4c44-aca2-9f2c9349c46b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 17:57:48 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 17:57:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 10:57:37 -0700
Message-ID: <20240910175737.78567-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <943f2045-a89e-4d00-958d-e27c22918820@oracle.com>
References: <943f2045-a89e-4d00-958d-e27c22918820@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 09:55:03 -0700
> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Mon, 9 Sep 2024 17:29:04 -0700
> >> I have some more time investigating the issue. The sequence of packet
> >> arrival and consumption definitely points to an issue with OOB handling
> >> and I will be submitting a patch for that.
> > 
> > It seems a bit late.
> > My patches were applied few minutes before this mail was sent.
> > https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
> > 
> 
> That is a subpar fix. I am not sure why the maintainers accepted the fix 
> when it was clear that I was still looking into the issue.

Just because it's not a subpar fix and you were slow and wrong,
clining to triggering the KASAN splat without thinking much.


> Plus the 
> claim that it fixes the panic is absolutely wrong.

The _root_ cause of the splat is mishandling of OOB in manage_oob()
which causes UAF later in another recvmsg().

Honestly your patch is rather a subpar fix to me, few points:

  1. The change conflicts with net-next as we have already removed
     the additional unnecessary refcnt for OOB skb that has caused
     so many issue reported by syzkaller

  2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
     but it's not mentioned; if merge was done wrongly, another UAF
     will be introduced in recvmsg()

  3. Even the removing logic is completely unnecessary if manage_oob()
     is changed

  4. The scan_again: label is misplaced; two consecutive empty OOB skbs
     never exist at the head of recvq

  5. ioctl() is not fixed

  6. No test added

  7. Fixes: tag is bogus

  8. Subject lacks target tree and af_unix prefix

