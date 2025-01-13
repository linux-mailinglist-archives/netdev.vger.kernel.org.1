Return-Path: <netdev+bounces-157592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F911A0AF24
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DADA16551B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F810231A5A;
	Mon, 13 Jan 2025 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z7EiozYE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEF21D003;
	Mon, 13 Jan 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748811; cv=none; b=cWOj2ELt/AdcvIId0Tc6UzA+/7DuM6rchHGmi8YPG/iBcQiDbPKrzNjF/JcoBre5q1i4AXYtYhqSHUMrthpo1NQeuv64tMGPGzR9GMTpLQ1abgiNP41pla7HR/YDciQIg8zvWk18O6MPzVlAqvFL9wntJvYV9W+gSSKP7a31GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748811; c=relaxed/simple;
	bh=vhT+W612852YEkpN3zMeLxLG8BTvo+8Dpqis5mGEkco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2Q8dur62sDe+Wr3ppBvUmsFuQ8tvGIBNaG/t/RFFlMUO7mySwKFl+SAt6i9erxEHHwzFYIqMyM4gNUTIGKwqVZ4sRGDLcqouM+1+PFs77eWwRRGRx+TAOJmft26k0u5TE7f/COUT2vaflom2qYgHTIEKYvgc3xm7MxZvoVSyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z7EiozYE; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736748810; x=1768284810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwQQhT8TKdrFwfHIH+1a6dAYFxtn7BMuoDwoQKVwo14=;
  b=Z7EiozYEwZwH5CV5WuWnSI2MZwI4IAcLLZf41bvHoCULyAKkKJk7Mf9h
   COjhIbg6RKyLyOtddhtWfGO9A5DLzV8+0Al9LG2ymCyAnFT9fHElNOH6R
   UfGVsRrEPArHvAvxVfqpB8k6mWEsaKDDaLnJdGowTc9y9HWCSi2lutP9p
   k=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728950400"; 
   d="scan'208";a="262566139"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:13:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:24051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.174:2525] with esmtp (Farcaster)
 id 3d367e53-0364-40ab-90f4-2c1e6201ab17; Mon, 13 Jan 2025 06:13:13 +0000 (UTC)
X-Farcaster-Flow-ID: 3d367e53-0364-40ab-90f4-2c1e6201ab17
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 06:13:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 06:13:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <linux@treblig.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] socket: Remove unused kernel_sendmsg_locked
Date: Mon, 13 Jan 2025 15:12:58 +0900
Message-ID: <20250113061258.56524-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112131318.63753-1-linux@treblig.org>
References: <20250112131318.63753-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: linux@treblig.org
Date: Sun, 12 Jan 2025 13:13:18 +0000
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of kernel_sendmsg_locked() was removed in 2023 by
> commit dc97391e6610 ("sock: Remove ->sendpage*() in favour of
> sendmsg(MSG_SPLICE_PAGES)")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

