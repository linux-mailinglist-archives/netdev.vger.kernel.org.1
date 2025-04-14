Return-Path: <netdev+bounces-182433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBFA88BA1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C0D189AAE5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363828DF06;
	Mon, 14 Apr 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iSQYpmVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04F28DEF6;
	Mon, 14 Apr 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656194; cv=none; b=sgmIOn8nKV/+M7QU+YVJlQnXwhvtStJY5mYOUz63QUjiIlhQKwH+LPj7GnjPYmrZTKVSpJZGzSUoDnMvTo7MvjuKCXcuGK4K/0i+ZdLQG/e/NoeTIUMx6FtisqluSHeuQJU/Fjt+K/A6VnCKQG5vnGGkWwIVR8GI6rGi8wApffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656194; c=relaxed/simple;
	bh=CNAcKEMoLHo5rUgoIFzXti24BJ8eYY521IhF/1qOoXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1maojDC5uS+j0uF86N3gfMo+StSadL1suuHtmovQ23dMVWsyYe57plh8nhw8/pBaC6MTTH5vLlSHsCoL+4db8seSL924CdE2ldAJgZrLXhiXJDcKv/B0DTnGionqHJxnEelcz/cYNO1KJUvW7aVVorHusz84kWORn7unBiTucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iSQYpmVd; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744656193; x=1776192193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3C/EUWugg8VrXEaYq0yJFAtr97plt9xfvTx4VUENKPU=;
  b=iSQYpmVdmvH0Ochoihd+fNWFYJ/pkGgLl5m+fmVpvRxCpHZX3IcysZAj
   xbZ6JYFv+P993b6KfQEPsL1NvJQ/dorkUhCeZONVXAKHr2RW1EL3j0X1u
   l4D5y/iNz6RgYx3XM7oWiXI051mIweUzWZIbvIctMwbs26QflYtQU49Ny
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="187307659"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:43:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:10738]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 1828d1ba-87ba-4c13-bfd9-558c14d8d136; Mon, 14 Apr 2025 18:43:11 +0000 (UTC)
X-Farcaster-Flow-ID: 1828d1ba-87ba-4c13-bfd9-558c14d8d136
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:43:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:43:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 10/10] net: fib_rules: Use nlmsg_payload in fib_{new,del}rule()
Date: Mon, 14 Apr 2025 11:42:52 -0700
Message-ID: <20250414184255.39609-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414-nlmsg-v2-10-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-10-3d90cb42c6af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:16 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

