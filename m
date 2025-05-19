Return-Path: <netdev+bounces-191589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F6ABC5A6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C7C7AEBB5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D3288C23;
	Mon, 19 May 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ow5UG4jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA78288518
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675852; cv=none; b=e5vMpMBqJsXyaClDEcC5htTtgF2EMnk/5D+66Kr5T+XhG3v5laxB31v0uJJu4d7SeDSjcdGGM1ZqjJZSLSWYQCKv6i98u7nIbBJhEU62I+AQmSJSisLaZmfwdDFm5JIlZ6qD7YuCZQUzegnQxBbEnmufxJNi8r0T3+06xM7RThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675852; c=relaxed/simple;
	bh=dyqrCNo9CXtfevjUxnwpsgNqT9cBOHHMn/D91RI7oTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fm4qiJ9Ks2PIYx2kmYiJsyEIMMR78umD7FdMIShmMGp14WXi5CYbFZadz4q/Ipzt9OR+gpAZuYchQ610aknCVPqapiLIjiDpHXYbNcoiXUX3PkywJIVU2qwIJBQHICT52hQSg/jWHL4WwafEtFTwNrqJKCZtgseEoAwIlY8tfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ow5UG4jx; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747675851; x=1779211851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=seZWFjglv4Jt7ef2m/LSBQbrctE5lgBHmK9DnE+8Kas=;
  b=ow5UG4jxovNoI4qvEfDKB6S2h+6+CUz2/f7RFuiNGExJ/4e7uiAvKiQg
   V/spbVbvopoexZJpKJPASnSr+NVRmdB4eZxswe4kEBvm0RrJQdcF04h5d
   ch9DXEqiNH/KKCmeMSlS+r09P2B/351dTxSmGbl7QkCnM/jQ5FEBHPpsy
   b8CATcVMtlYURIYJc4lpZ3hxM7wAMhnEKQ8waC5stMAhYsP1Sk9Gj+OMv
   jPfqoXGaPfKgnmmFh3FYV8M+g1WWlzTvdDhq0XF5ZMnQD1YFBca9NdNBL
   54zP9H3NagIlF+quxdbv3/zd5KNmKNJ5NliQzoUBmWvdOOnTw4LwGht7B
   A==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="406879687"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:30:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:63966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.47:2525] with esmtp (Farcaster)
 id 5a794e2d-a3d4-4c67-86a3-c961fbb706d8; Mon, 19 May 2025 17:30:41 +0000 (UTC)
X-Farcaster-Flow-ID: 5a794e2d-a3d4-4c67-86a3-c961fbb706d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:30:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:30:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.laight.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 6/6] socket: Clean up kdoc for sock_create() and sock_create_lite().
Date: Mon, 19 May 2025 10:28:25 -0700
Message-ID: <20250519173030.40491-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519134309.35b1e007@pumpkin>
References: <20250519134309.35b1e007@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Laight <david.laight.linux@gmail.com>
Date: Mon, 19 May 2025 13:43:09 +0100
> On Fri, 16 May 2025 20:50:27 -0700
> Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> 
> > __sock_create() is now static and the same doc exists on sock_create()
> > and sock_create_kern().
> > 
> > Also, __sock_create() says "On failure @res is set to %NULL.", but
> > this is always false.
> > 
> > In addition, the old style kdoc is a bit corrupted and we can't see the
> > DESCRIPTION section:
> > 
> >   $ scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
> >   $ man /tmp/man/sock_create.9
> > 
> > Let's clean them up.
> 
> I think you need to absolutely explicit about which calls hold a reference
> to 'net' and which don't.

I don't think so regarding sock_create() and sock_create_lite() because

  1) sock_create() is only used for userspace, and we always
     use current->nsproxy->net_ns, which must exist

  2) sock_create_lite() does not create struct sock by itself, and
     sock_create_lite() must be used with an already-created socket
     by other sock_create() helpers, where kdoc says when you need netns ref:

---8<---
/**
 * __sock_create_kern - creates a socket for kernel space
...
 * @net MUST be alive as of calling __sock_create_kern().
...
/**
 * sock_create_kern - creates a socket for kernel space
...
 * This MUST NOT be called from the __net_init path and @net MUST
 * be alive as of calling sock_create_net().
---8<---


> 
> This is separate from any user/kernel flag - and may need a second flag
> (although there are probably only 3 options).
> 
> IIRC some sockets are created internally within the protocol code
> and don't want to stop the 'net' being deleted.
> Such code has to have a callback from the 'net delete' path to tidy up.
> 
> OTOH it is not unreasonable for other kernel activities (perhaps file
> system mounts) to hold a ref count to stop the net being deleted.

It's written in patch 2 and kdoc in patch 3.

