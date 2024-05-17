Return-Path: <netdev+bounces-96921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1D8C8371
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A6F281D05
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78947200A9;
	Fri, 17 May 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cQ87vlEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB602375B;
	Fri, 17 May 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938071; cv=none; b=hRTN8wvPBAuIF4avvP90B/JIlsSwHZ8bOU8rfn172AD9bScxHUxz32dCKWXrY3YSj+4F9KL+/F0mhpNQTwFUfgaxAQXD3TqhshOqG3zDCRWBWU6qgKofmzeuT3ijjMvO0cUdNNuPQhMfMOfbI7EtbHxCuQ5YNNtdhf6/H1QpgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938071; c=relaxed/simple;
	bh=QEFcnNgSW7VFtUZqNDydUFcpK6MlFDy6iAS+JARgbiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4XwOMxShV2/i4h1PsHnD3aY2DcGUCAbp0RD4EzR8PEMlLLuWMsPs93cX0bFAvDPrtSHntLqzykPqTd+ffk/++QhFkogGUo/2/bndUwsHWg3ZdCKis4f8/Y7KqsqGk0ycaBHt5QoZ/yq9YAqzU4SjC7jg9jg3F7ZncaxVXd6uNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cQ87vlEp; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715938070; x=1747474070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qyol9/0fjUwTBCD/lu/C9S5eG6ZgCLgdeBC9QyKdG8E=;
  b=cQ87vlEpylFBo2562e+4PY3LRBChwOKpdzOdmzpar47O/fs72i/vH6LB
   9zryhUMKNt2koINo5iKs2PHPVa2rXVu9xsjN5bP8b2SA0WS8DLydtW4dO
   wXlSQpZOi3wj6tFr/xpQ5crk6CT9Onvr6RfBB4Bm8CEGwrSr9nF/ICTNO
   U=;
X-IronPort-AV: E=Sophos;i="6.08,167,1712620800"; 
   d="scan'208";a="401796677"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 09:27:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:5031]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.175:2525] with esmtp (Farcaster)
 id 2f9ded0c-3c22-44e3-8595-2cae7b44526a; Fri, 17 May 2024 09:27:45 +0000 (UTC)
X-Farcaster-Flow-ID: 2f9ded0c-3c22-44e3-8595-2cae7b44526a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:27:43 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.241) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:27:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <samsun1006219@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>,
	<xrivendell7@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [Linux kernel bug] UBSAN: shift-out-of-bounds in dctcp_update_alpha
Date: Fri, 17 May 2024 18:27:30 +0900
Message-ID: <20240517092730.34061-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEkJfYNJM=cw-8x7_Vmj1J6uYVCWMbbvD=EFmDPVBGpTsqOxEA@mail.gmail.com>
References: <CAEkJfYNJM=cw-8x7_Vmj1J6uYVCWMbbvD=EFmDPVBGpTsqOxEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 17 May 2024 13:03:18 +0800
> Dear developers and maintainers,
> 
> We encountered a shift-out-of-bounds bug while using our modified
> syzkaller. It was tested against the latest upstream kernel (6.9). The
> kernel was compiled by clang 14.0.0, and kernel config and C repro are
> attached to this email. Kernel crash log is listed below.
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in net/ipv4/tcp_dctcp.c:143:12

Just for the record, I posted a patch:

https://lore.kernel.org/netdev/20240517091626.32772-1-kuniyu@amazon.com/

