Return-Path: <netdev+bounces-183086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF8A8AD5C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62B6189FFAD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BF205AD2;
	Wed, 16 Apr 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gy6qtbrI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF17204C36;
	Wed, 16 Apr 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765619; cv=none; b=meQ3pUmnD2RXS6Cq3KaVve4UGQ65RQqM8BstntBXBpbP34tnWGCwzUrFFmoMBBH/sCQGJ9BGIz3X4KGShBCjCWvzWmEPlCdYno289DiFDyW6u3th9mYKB0jGLDXRcsTzrjoZxrRTSt+nKYOz9TISn/egpwaidkuY/UoCPS40Ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765619; c=relaxed/simple;
	bh=Mjjm6Mzqf4mF5cdpX26kfG0QtYpiA3cJIIijw5IrfHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+Kl20YK4IxSMdKie8mK96jU+p5z00FUu3OVBMkjs3nn8IS3TcpkOD5oF9RUU7FWL77cJiHFGTYWcBgLOqWC2MR5U/xhHAi9QkmDtIqEHcjKGvN4JKrn1pgabny1zh32EFfhXTIGn5QispQKgtHWH4iyKggyyOkrsV6SIyx1fnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gy6qtbrI; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744765618; x=1776301618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EELDPN3KWPUe2puUTTKzUEAFHJseIIQ+Xj/tNjNHJC8=;
  b=Gy6qtbrI0TcDaE08ZXMx8bmIwUPIw01P6Ex/NBDlhm3Yfw25uAltUgVL
   F2+jq1DUpChkHtZWpA3EGnD2MGYp4/Zm8wFWwyO+0aamEiWY38ynrV10/
   q6ByZwV/WiaGwGks9LPlARv5DsFlIoO6wqXdyelu2uUhNPUH5HL9L1266
   0=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="816357818"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:06:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:26034]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 4b446256-361e-4eee-b9d4-b68a544bc03a; Wed, 16 Apr 2025 01:06:51 +0000 (UTC)
X-Farcaster-Flow-ID: 4b446256-361e-4eee-b9d4-b68a544bc03a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:06:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:06:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 7/8] ipv4: Use nlmsg_payload in ipmr file
Date: Tue, 15 Apr 2025 18:06:38 -0700
Message-ID: <20250416010640.23879-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-nlmsg_v2-v1-7-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-7-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:58 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

