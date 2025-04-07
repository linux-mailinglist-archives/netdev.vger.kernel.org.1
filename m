Return-Path: <netdev+bounces-179739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC54A7E658
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB00C4450EE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E720896A;
	Mon,  7 Apr 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dOL6fL8L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7D2066F9;
	Mon,  7 Apr 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042405; cv=none; b=Hbs99KXQ/GWGAzbj3qzqZdsJhMLRQcvcavdwFBCQEVgd7ehhnNEyvQr40KnCYT/Nt0w55dkHZg+AkfaIweK4lrA/A49EuNYX4/6LxreSYk0BfBr2xU5ffvUGniiSz4sXSFlSo91E8GgeEJ3lPgSFQbDAJLPz4/mKmY6aVlWRn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042405; c=relaxed/simple;
	bh=2KFVeKdPLKXBfR5EWHDbvkaoyV0vRqU2QFbIw5uPBQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0q2HiDestloDoEdACMyxpOyshNDncMCG7xctqBL7Dm9XQlcl48WA4yPI+1GsUP3laYFj/kJEZjIZpQapKkGzkt7a2MxKHOgO1fHdw/26GiAspDBrAJabmXJutP1/sp6C4hxCFtUCg/lo55XYv+7a+B56qp0+yryqZ0Ag/kBvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dOL6fL8L; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744042404; x=1775578404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ax3m+iIFkyYPhqmuuHtqTChmLOMPFAoAyAVCrfKI3uI=;
  b=dOL6fL8L8q3YIwxqQp/gFi4Mb4HOy9r7hHbjMlraGA07jE9LCsua4pkU
   bm0irU0Agfnuc5pNm94Mkgi3Qqnrv426N4FSnT+MHSjeOl0GiUQBxlV7s
   mmt2FPcnMzQ36jiII2FCPcuf4A8IVhOYTEkLBlFjV4C9Tv+RqK6sRYK9i
   o=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="38499040"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:13:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:1061]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 4e4911d2-5cb4-4150-b7fb-bb7ce2a6281e; Mon, 7 Apr 2025 16:13:21 +0000 (UTC)
X-Farcaster-Flow-ID: 4e4911d2-5cb4-4150-b7fb-bb7ce2a6281e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:13:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:13:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stfomichev@gmail.com>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>,
	<syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
Date: Mon, 7 Apr 2025 09:12:37 -0700
Message-ID: <20250407161308.19286-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z_PfCosPB7GS4DJl@mini-arch>
References: <Z_PfCosPB7GS4DJl@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Mon, 7 Apr 2025 07:19:54 -0700
> On 04/07, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > unregister_netdevice: waiting for DEV to become free
> > 
> > unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> So it does fix the lock unbalance issue, but now there is a hang?

I think this is an orthogonal issue.

I saw this in another report as well.
https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@google.com/

syzbot may want to find a better way to filter this kind of noise.

