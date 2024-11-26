Return-Path: <netdev+bounces-147304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2429D9047
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5175B244E0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDA16415;
	Tue, 26 Nov 2024 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uN6rGID8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E814A85
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586945; cv=none; b=SHbtW4hz4X6juRolmPolk6yiI21UaTeIYRzl8oBCOwGf5J3tTBz4NFavJ6vMewPsuS/JC7huyWsKluemvygUyJv/NgzFF1RFDOMcIK+7SinP+SOX6KrkrKgHlzrhDz1h977EQ0TnVf5SWaaHXRuO9wdw5WNcD49eMc6aFYELyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586945; c=relaxed/simple;
	bh=O6i0P9JiTBq5EqyvftH6NnRX9k9tCh9RVUSl2CsA5oA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtS5omkPIZKra+QYhLqxNiIfX4WgWuItDnLjZF077ZSTRUWBT5uRbhwKok7zgTWJSJDqmVDI12uHxTTSOYO7TufhaPx2GFjIlfHF+/8ZERYNxjY7d5EbPnoZbRSe56oZu/aYY2pytUh8MisQABhMPrcFk2O7SJjrFpxKFKfKP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uN6rGID8; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732586938; x=1764122938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biUROtdtar+Sf9Ol7mM56F7n+rXeAnn3smyPvOLI4W0=;
  b=uN6rGID8EkhRZgrpAIagjCtHiRSx1dOpuuKc77XKgSqaHEMCg6ui8fom
   +sDFYT3mHOoixBOXWeDz3kiNox2XPIhbwMmA1PpR4u6PZ+1LZOHxpZ4u1
   VZozBUFbcS35zvrzWZ4lWH1tRLvu+2lSSkVhhKK6hXAhNhHdmCf3KxPcf
   A=;
X-IronPort-AV: E=Sophos;i="6.12,184,1728950400"; 
   d="scan'208";a="451304793"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 02:08:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:7038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 90ac187e-8678-4f34-af48-c538adfa4817; Tue, 26 Nov 2024 02:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: 90ac187e-8678-4f34-af48-c538adfa4817
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 26 Nov 2024 02:08:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.66) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 26 Nov 2024 02:08:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] tcp: populate XPS related fields of timewait sockets
Date: Tue, 26 Nov 2024 11:08:45 +0900
Message-ID: <20241126020845.35087-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241125093039.3095790-1-edumazet@google.com>
References: <20241125093039.3095790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Nov 2024 09:30:39 +0000
> syzbot reported that netdev_core_pick_tx() was reading an unitialized
> field [1].
> 
> This is indeed hapening for timewait sockets after recent commits.
> 
> We can copy the original established socket sk_tx_queue_mapping
> and sk_rx_queue_mapping fields, instead of adding more checks
> in fast paths.
> 
> As a bonus, packets will use the same transmit queue than
> prior ones, this potentially can avoid reordering.
[...]
> Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
> Fixes: 507a96737d99 ("ipv6: tcp: give socket pointer to control skbs")
> Reported-by: syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/netdev/674442bd.050a0220.1cc393.0072.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

