Return-Path: <netdev+bounces-161815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33580A242F1
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B2F164F73
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2C1898F2;
	Fri, 31 Jan 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PqTyP+xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36421F94A
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349302; cv=none; b=SN8pG5Q8JB3M9OMlu8FFKcGcOIaAlhX/2j5E9NPzdTlVKDZzNt2kgCdZRKPkWgISCVk7tY0WZSL7p3M4hUSlLVbn0pDWqi1Orq5N31dcPRaKAw4WaPXoqvkHiTCpMzKmgm9O4eEEe03ATTt4wtce04B2ycUaad9FcWTzm6dMszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349302; c=relaxed/simple;
	bh=LNOr1WoJBuZ7vNkCwMAlb01SIWUCdc79SVimcKJC1eE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn227i7ibO3FnoH+xr3uWrQWYFi9mycJSynrn6edo+ZLvc8C8ezPO9d4bpyFph8u8BrJUTCej8Er5N/HOZLqx//YxvWDfi/xES5SX+waHCkykzdOaN9Jl41PuvPbDPE9cRB+mF+LYzxYD6ZWls8nCnZGmUAtzOyECEU6ZrMARns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PqTyP+xb; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738349301; x=1769885301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aXv77KnBFicQZGfgnhMd11XVuL63xkTzeekZdrffixc=;
  b=PqTyP+xbCIVb1UQUw9BYK4buw8hMloQQlnN2gS3ojSNF7pEwILatPNXE
   LP9aVsGlT9/A8ELZc9/gsHu/X+YK3Oxsf77rMy3qTuA7u3dJExLQIcccb
   ypATOQUrXsu5RYm0D7vn8VKhvqs7qddSQqM1b4zBuzD0tVx+VSzM/VI7r
   s=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="795196712"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 18:48:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:12594]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 82c222c5-5eed-4899-b1d3-d207e438e50a; Fri, 31 Jan 2025 18:48:13 +0000 (UTC)
X-Farcaster-Flow-ID: 82c222c5-5eed-4899-b1d3-d207e438e50a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:48:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:48:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 03/16] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
Date: Fri, 31 Jan 2025 10:47:50 -0800
Message-ID: <20250131184750.92414-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-4-edumazet@google.com>
References: <20250131171334.1172661-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:21 +0000
> ip_dst_mtu_maybe_forward() must use RCU protection to make
> sure the net structure it reads does not disappear.
> 
> Fixes: f87c10a8aa1e8 ("ipv4: introduce ip_dst_mtu_maybe_forward and protect forwarding path against pmtu spoofing")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

