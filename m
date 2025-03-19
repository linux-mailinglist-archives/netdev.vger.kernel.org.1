Return-Path: <netdev+bounces-176244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD5A697DC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9827425CEB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8201E5214;
	Wed, 19 Mar 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="apLVMCIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B91DC9A7
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408358; cv=none; b=CjRGBTpFyMU/fLrxsMaRk0Xs96kMYykpTjVH6LdtyzPGPfzNKU266Qz7vEtiS498JWqw4zzxd+yXtU7G+6w/GWDc/3lG8pfO9dAobs+IHA1ApfbcvBOrtFQBkiu4CoLxVSrLWier7nF31xexhsL1a+Z/alzXfipya61FIPRWrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408358; c=relaxed/simple;
	bh=4SgvABaq6fuxY1Xr3kWRrrX4hTl6Z/qczvdO+T0YKKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeBOZe34vFpkwNCWLMZImtoygqIlDo1xPY7QQsgwEI8cKFpzdwkBvnfzmtRnjWwS+wZxKW2z/wZBUcpyGm0KpZYNg6DfAqvYPbk7OxLoy9I3rEtIO5hOGzX2X8k4u/rdBn+Up59igNX3KEN+5Z1BYJBBv82yNCUn7gHFXJBoGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=apLVMCIp; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742408357; x=1773944357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+PY4HOzdIKy7VAdAqY0HRRSozDqDdjJwRsSe7nzeVI8=;
  b=apLVMCIpCPTBDuiGZ27G0NYpJ5NHMhUv4MLgQvr6hsJAht9bGQLkzG/d
   URcihSL6QRHKW7axdBVOxks0hiGjd6xuDyYgm+jgEGXQHRm6gbmSv/MLq
   MUzxBzKE0WYnDuB4H34n4mdyVmcZE7aa+PC9AwI/l4VKrhgocFFLz5sZ6
   4=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="476457980"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:19:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.7:2525] with esmtp (Farcaster)
 id 1498306c-20b8-458f-8966-a66781477fda; Wed, 19 Mar 2025 18:19:12 +0000 (UTC)
X-Farcaster-Flow-ID: 1498306c-20b8-458f-8966-a66781477fda
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 18:19:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 18:18:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 2/4] af_unix: Move internal definitions to net/unix/.
Date: Wed, 19 Mar 2025 11:15:06 -0700
Message-ID: <20250319181821.17223-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67db03aba87a1_1367b29420@willemb.c.googlers.com.notmuch>
References: <67db03aba87a1_1367b29420@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 19 Mar 2025 13:49:31 -0400
> Kuniyuki Iwashima wrote:
> > net/af_unix.h is included by core and some LSMs, but most definitions
> > need not be.
> > 
> > Let's move struct unix_{vertex,edge} to net/unix/garbage.c and other
> > definitions to net/unix/af_unix.h.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> One trade-off with these kinds of refactors is that it adds an
> indirection in git history: a git blame on a line no longer points to
> the relevant commit.

Right, and git has a useful option for that.


> 
> Whether the trade-off is worth it is subjective, your call. Just
> making it explicit.
> 
> I still manually check out pre UDP/UDPLite split often to go back in
> udp history, for instance.

I often use -C5 (track 5 times for line/file moves) and hope this
helps you :)

$ git blame -C1 net/unix/af_unix.h 
Blaming lines: 100% (75/75), done.
b24413180f5600 include/net/af_unix.h               (Greg Kroah-Hartman       2017-11-01 15:07:57 +0100  1) /* SPDX-License-Identifier: GPL-2.0 */
d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  2) #ifndef __AF_UNIX_H
d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  3) #define __AF_UNIX_H
d48846033064e3 net/unix/af_unix.h                  (Kuniyuki Iwashima        2025-03-15 00:54:46 +0000  4) 
cae9910e73446c net/unix/diag.c                     (Felipe Gasper            2019-05-20 19:43:51 -0500  5) #include <linux/uidgid.h>
^1da177e4c3f41 include/net/af_unix.h               (Linus Torvalds           2005-04-16 15:20:36 -0700  6) 

Thanks!

