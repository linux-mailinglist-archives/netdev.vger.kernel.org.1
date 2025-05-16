Return-Path: <netdev+bounces-191165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D958ABA4DE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2965081A6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780ED22D7A5;
	Fri, 16 May 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P9/piWYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26E22D782
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428890; cv=none; b=gK3xE+vSwUdwraTcQsM4kXOZWtZ0IGAKT0DOuBPPAn1l4PaYbcE8Um3e5Ig8B90WIlf8RL+z80IaM+vmt/XuuUi8ErC9hZzTiFxBQFP/WzSisKlic6gu8NMEgyBgFK2osV3mc8xTLKPeWXkgHGvMVRh3eXRlUZ5+KuoXIJwPCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428890; c=relaxed/simple;
	bh=ZBkQInfwDPAcB/eUZFsP14msaxnFxALtlLVl697ilLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAJyRU+W+asm7SCb2mqsbukL0u2qXBj/+qtBkqR/7bXTpFaV0P0mH7wpD9VxJWRARVAcFrVsHIvTpj2Lebw1wpb3WTodCx1IL5rqz3a72vZkJ0w33asaqbMlKp3c53NJ8HtLpIidMq+4ouFPrzVYGE8xkbi2dQa3QKNprURfMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P9/piWYO; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747428888; x=1778964888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vIsQ8EF2sHKzScsCURUbKxEboYa5uS5BB65yCSuoUQ=;
  b=P9/piWYOPwZrX2zv3QGs6ko3GDJaZU08Iju3AhXMoE2ZJax9ERI2daiJ
   OsD+vXE47bVkKQnZAozA1KjgmjAQq06HIBKKVGgg+tnwlFxJhQZEAaWra
   dqJA5IejcbjAOQ7H9nO6mfg4/INDTcip9gwl0YgwKs0NPhAHFxjyKi2PD
   oB2dkyJjvpup7x/0+eh20vWWmYPfcF39lFwdhLerQLYFfkk9HnetT6FTX
   b8cojLfnN0+xj13e23d9k3MnvO034xJ4RZmFS0OUdNT37J6n2KXHlMl7s
   RGdEGosFhl24kwUagj3m0kLM599Q27WzUDDnNLCNiowPQceMy1mNutHKR
   A==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="521392430"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 20:54:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:43370]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id 6ff3b93f-cb6b-4bad-80ce-9c5055c6a8ba; Fri, 16 May 2025 20:54:42 +0000 (UTC)
X-Farcaster-Flow-ID: 6ff3b93f-cb6b-4bad-80ce-9c5055c6a8ba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 20:54:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 20:54:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Fri, 16 May 2025 13:54:21 -0700
Message-ID: <20250516205430.93517-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <682791b4dd9a1_2cca52294bd@willemb.c.googlers.com.notmuch>
References: <682791b4dd9a1_2cca52294bd@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 16 May 2025 15:27:48 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Fri, 16 May 2025 12:47:13 -0400
> > > Kuniyuki Iwashima wrote:
> > > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > > > are inherited from the parent listen()ing socket.
> > > > 
> > > > Currently, this inheritance happens at accept(), because these
> > > > attributes were stored in sk->sk_socket->flags and the struct socket
> > > > is not allocated until accept().
> > > > 
> > > > This leads to unintentional behaviour.
> > > > 
> > > > When a peer sends data to an embryo socket in the accept() queue,
> > > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > > neither the peer nor the listener has enabled these options.
> > > > 
> > > > If the option is enabled, the embryo socket receives the ancillary
> > > > data after accept().  If not, the data is silently discarded.
> > > > 
> > > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> > > > would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> > > > descriptor was sent, it'd be game over.
> > > 
> > > Code LGTM, hence my Reviewed-by.
> > > 
> > > Just curious: could this case be handled in a way that does not
> > > require receivers explicitly disabling a dangerous default mode?
> > > 
> > > IIUC the issue is the receiver taking a file reference using fget_raw
> > > in scm_fp_copy from __scm_send, and if that is the last ref, it now
> > > will hang the receiver process waiting to close this last ref?
> > > 
> > > If so, could the unwelcome ref be detected at accept, and taken from
> > > the responsibility of this process? Worst case, assigned to some
> > > zombie process.
> > 
> > I had the same idea and I think it's doable but complicated.
> > 
> > We can't detect such a hung fd until we actually do close() it (*), so
> > the workaround at recvmsg() would be always call an extra fget_raw()
> > and queue the fd to another task (kthread or workqueue?).
> > 
> > The task can't release the ref until it can ensure that the receiver
> > of fd has close()d it, so the task will need to check ref == 1
> > preodically.
> > 
> > But, once the task gets stuck, we need to add another task, or all
> > fds will be leaked for a while.
> > 
> > 
> > (*) With bpf lsm, we will be able to inspect such fd at sendmsg() but
> > still can't know if it will really hang at close() especially if it's of
> > NFS.
> > https://github.com/q2ven/linux/commit/a9f03f88430242d231682bfe7c19623b7584505a
> 
> Thanks. Yeah, I had not thought it through as much, but this is
> definitely complex. Not sure even what the is_hung condition would be
> exactly.
> 
> Given that not wanting to receive untrusted FDs from untrusted peers
> is quite common, perhaps a likely eventual follow-on to this series is
> a per-netns sysctl to change the default.

Makes sense, I'll add a follow-up patch in the LSM series.

