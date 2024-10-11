Return-Path: <netdev+bounces-134742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7999AF6E
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0928A3C6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A171E0B6D;
	Fri, 11 Oct 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f0gMZqLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A19FA9D
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689553; cv=none; b=g5QOzBvQlj/5mCjG2imKd5vPH9PZpv3zV3ZF+D4Xkns+r2l+A+zQzHZm40s21CUvwZwRAwZIznLiTBKc/huSKs9kRklHHvROkuumQQavso40h5LImvi5UrVQw/TfcoRvI5pU+EVNEJ5wDJimMsQeMikFCtipGUggqBrRjZsfeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689553; c=relaxed/simple;
	bh=c+43XaY99vf0NaQ6G0JDSKvIAVF50buufdx6tRkJfGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTweGYLSvptspf9BuCvKxkKR2ZfrsAErC5pbb9uyNPnRu16lbpW/KlCRiw1oiZyee6tyex5nCyE6Fji212lwYuUqPNv5jS0iIsuDGc24V9pfTpr4G4YEsE65yF58bq7DfuQTsXw5GDb1n40yNauFRhsLQQVYmn6ngQ2j0lQJa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f0gMZqLT; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728689552; x=1760225552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SG2Plwc9G3X0HHH0DUw7NEknvLnKuy8PQYiQCNLxVA=;
  b=f0gMZqLTyu5C1oLf3w/6vgCb7gabOA9I0tftojQjuTKT2IRSThHXIsFf
   pHgGmImt5pFRAvH9lvgrWcMWIgFVn2ai0lXWIMGfzgG+RdzK82+JjBsk3
   3QgnrAcEdziI1cuKiw7r72H19w58SeI7pTnzjR3j/p1HijsVRmSrNxoAB
   8=;
X-IronPort-AV: E=Sophos;i="6.11,197,1725321600"; 
   d="scan'208";a="342396253"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:32:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:10709]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id b8081d95-b7ca-42c5-92ee-bb38b4b19660; Fri, 11 Oct 2024 23:32:30 +0000 (UTC)
X-Farcaster-Flow-ID: b8081d95-b7ca-42c5-92ee-bb38b4b19660
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 23:32:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 23:32:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
Date: Fri, 11 Oct 2024 16:32:23 -0700
Message-ID: <20241011233223.53340-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010174817.1543642-5-edumazet@google.com>
References: <20241010174817.1543642-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:48:16 +0000
> tcp_v6_send_response() send orphaned 'control packets'.
> 
> These are RST packets and also ACK packets sent from TIME_WAIT.
> 
> Some eBPF programs would prefer to have a meaningful skb->sk
> pointer as much as possible.
> 
> This means that TCP can now attach TIME_WAIT sockets to outgoing
> skbs.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

