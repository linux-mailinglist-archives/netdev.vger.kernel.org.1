Return-Path: <netdev+bounces-167467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57311A3A5E3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD4218989FB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3B1F5839;
	Tue, 18 Feb 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oDovy6Oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB91EB5CF;
	Tue, 18 Feb 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904001; cv=none; b=krP1nCM5Y3TyQVB2vj6MbMod4uFIYKqGUqPDUDJbrcYVduu12SmK4hTu1xRP0gspx02inXELn/TE5nB//JirHzhZKeT27rC7af7m3rEm8RUILLFm6IhkZjlGJ5OyJ/EtLISjiz9eKQAJeKqhFxy4n5X92ml2XluYvTKEuIP1O5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904001; c=relaxed/simple;
	bh=HNdgRxifz8YMGcx60trEWb6XMRQ2yH9UIRf2R3QL4p4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1xC7mhcphHzHtGE70dAkg7w8RZBtnT4RpYMLGrgfrO+sofJQUacpmdzjKDBhSCE8a83dn5b21BF9dPgTgOgKh5yptsBA99MpzYiO1WG86GclrhsuZDP8Vum/bOQx0gpL8rYoPRugiFYNdXGn3U/OlkKxxdhWIfghRsvoHbP9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oDovy6Oz; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739904000; x=1771440000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7m8oAaXCTKe270hEAyxF+vZafTCm9qe7mOPUC/9oyo=;
  b=oDovy6Ozpvath61E8CcvbcCWFZHLccAMCGB42+1L3ckqgYr5ePUm/65M
   sRMAVw8VYo7nRjpiLT5k0/LVYfgHxrraRaXbRPFoe0554tRnQTN+9LGa3
   bLgRJblw15JRtm7yexbADGHEzdweaNwLuiWEkWnhBmEobFaDTALYiF0bp
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="409672751"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:39:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:33463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id 44be82b4-125d-4530-bf06-4ad7690a1e7a; Tue, 18 Feb 2025 18:39:36 +0000 (UTC)
X-Farcaster-Flow-ID: 44be82b4-125d-4530-bf06-4ad7690a1e7a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 18:39:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 18:39:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <purvayeshi550@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <skhan@linuxfoundation.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v3] af_unix: Fix undefined 'other' error
Date: Tue, 18 Feb 2025 10:39:22 -0800
Message-ID: <20250218183922.25318-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250218141045.38947-1-purvayeshi550@gmail.com>
References: <20250218141045.38947-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Purva Yeshi <purvayeshi550@gmail.com>
Date: Tue, 18 Feb 2025 19:40:45 +0530
> Fix an issue detected by the Smatch static analysis tool where an
> "undefined 'other'" error occurs due to `__releases(&unix_sk(other)->lock)`
> being placed before 'other' is in scope.

I don't care much, but according to Dan, this is Sparse error due to
const unix_sk() ?

https://lore.kernel.org/all/bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain/

> 
> Remove the `__releases()` annotation from the `unix_wait_for_peer()`
> function to eliminate the Smatch warning. The annotation references `other`

Same here ?


> before it is declared, leading to a false positive error during static
> analysis.
> 
> Since AF_UNIX does not use Sparse annotations, this annotation is
> unnecessary and does not impact functionality.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

Anyway,

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Also, I think you can carry over Joe and Simon's tags as the change is
trivial.

