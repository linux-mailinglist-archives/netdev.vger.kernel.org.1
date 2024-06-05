Return-Path: <netdev+bounces-101103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4618FD5C4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED011F24664
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D113A3F1;
	Wed,  5 Jun 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BeHTZDLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E82F2B
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612254; cv=none; b=M9lVl8Fo0GnDO/p/pCexd+nF/vBKUtMYGNDbeqlSPs11tIzAQYPN/xrkL+/loYQjUwHvLReCNE6ODD94ra/3ngwjgnqzGTerUwgSszPEZpwtmSiVxRtTQoDEvBQ9PyKMwkV6S4vp689nBL0m3hpgYiUiq1sYXekbvAdWa0qN23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612254; c=relaxed/simple;
	bh=9dqdD7OIr4wbbuMV7JMC/4dryUBh1+FwAsSYoo4wtqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgGSA3KCHGi3w3npBnMDjygwQrJ73VUyaEERGmBV8Iq2FlDMVYtI1nb6cBIHxPlVdzH84BYjVsQsSfcktSuaORZnkt1ly83b/oTy9VsxeyxxBmy0+KFYVZVKSbh2qWiboQeFPM6C5ofWlU7j9sv9SaLiXUwCZ7CJ2+23t6ZFhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BeHTZDLC; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717612252; x=1749148252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3zz4GbL//QBImxox8rQOR/xZR42naLa/TtV658udBQ=;
  b=BeHTZDLClhr5DnWy4s3TXUzqPJzPkhxq3xufGyUDiChRKTAux5LtJfyZ
   +ArCfeCrOmPm5m0h5K2K3hkS3euGXypSKX8LM9UHUEVU6H3zqyXZv8PKO
   Y7F6Wv2cwoe7i+ej2rkLjjya3SakGcWxvAlLXg1AT8KXJlbZrxS/RAGXG
   4=;
X-IronPort-AV: E=Sophos;i="6.08,217,1712620800"; 
   d="scan'208";a="94593264"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:30:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.252:2525] with esmtp (Farcaster)
 id bb192775-6d35-4dea-a5ad-6415888b1575; Wed, 5 Jun 2024 18:30:50 +0000 (UTC)
X-Farcaster-Flow-ID: bb192775-6d35-4dea-a5ad-6415888b1575
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:30:49 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:30:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 2/3] tcp: move inet_reqsk_alloc() close to inet_reqsk_clone()
Date: Wed, 5 Jun 2024 11:30:37 -0700
Message-ID: <20240605183037.27898-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240605071553.1365557-3-edumazet@google.com>
References: <20240605071553.1365557-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Date: Wed,  5 Jun 2024 07:15:52 +0000
From: Eric Dumazet <edumazet@google.com>
> inet_reqsk_alloc() does not belong to tcp_input.c,
> move it to inet_connection_sock.c instead.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

