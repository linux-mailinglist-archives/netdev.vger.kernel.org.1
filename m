Return-Path: <netdev+bounces-124479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C478C969A88
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27680B2395D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662641C62CE;
	Tue,  3 Sep 2024 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="VWlh31re"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C919CC27
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360422; cv=none; b=Id8sMDO+UeME0PVomFHvYvt+w00iVJsOJs4N4IAuqYQzckesr9KSXXI4vP4i0ukSqhwxX2BoecREXNyTyesEMZ3OHg617XW9gmeeIOWCL6MyCe+cNX+zIiseRlA/Xdd2TtvDamHbSyY7SwEnmVLF/UNONQ1C2w1rK9cp6LCQitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360422; c=relaxed/simple;
	bh=D3pK/xIDd4gN73xR2IAKuIfQBHRY4tf7Zw38vyUW1ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9h0B/CftghVQ/W19pi83h0TQo95HwkDdQY/SG7QkOBeXZ79WVSd/2RrLFsxMhernbK3evgyFCybtvQ9ejdZ3uCZcoUqe/EECucOWJ2ZFpnbgC1355J0OivO4iIJ5n0CCGfiL0mVjO+swUGX3ZsW8YC3i/ZoW4dcGU+X8US1w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=VWlh31re; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1725360420; x=1756896420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3pK/xIDd4gN73xR2IAKuIfQBHRY4tf7Zw38vyUW1ow=;
  b=VWlh31reB49mK/cEsVbc19C+7Juml32VLQkSwYeKQlMxXOvUHmw8GlsT
   ExVENxrM4CiJu10v4ZacI7cRVGTnbRWJh2+oAAbEMLzi8lisED1+qoiu4
   OaWxEZeGVTvNfvosOI2eQ7dqNK+sBkV6Gzjsm85xyZRLoUBWZFunhg0IG
   A=;
X-IronPort-AV: E=Sophos;i="6.10,198,1719878400"; 
   d="scan'208";a="121943980"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:46:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:14951]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.188:2525] with esmtp (Farcaster)
 id 3b7296b2-e8e6-4804-8ef1-7ed099bb915d; Tue, 3 Sep 2024 10:46:54 +0000 (UTC)
X-Farcaster-Flow-ID: 3b7296b2-e8e6-4804-8ef1-7ed099bb915d
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Sep 2024 10:46:54 +0000
Received: from 682f678c4465.ant.amazon.com.com (10.118.248.122) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 3 Sep 2024 10:46:50 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <andrew@lunn.ch>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <takamitz@amazon.co.jp>
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Tue, 3 Sep 2024 19:46:42 +0900
Message-ID: <20240903104642.75303-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <87af1b9e-21c3-4c22-861a-b917b5cd82c2@lunn.ch>
References: <87af1b9e-21c3-4c22-861a-b917b5cd82c2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

> Did the same sequence of read/writes happen before 0845d45e900c? Or
> did 0845d45e900c add additional writes, not just move them around?

The sequence of read/writes happened before 0845d45e900c because the similar
writel() exists in ew32() above the writel() moved by 0845d45e900c.

The commit 0845d45e900c moved writel() in e1000_clean_tx/rx_ring() to
e1000_configure_tx/rx() to avoid null pointer dereference. But since the same
writel() exists in e1000_configure_tx/rx(), we just needed to remove writel()
from e1000_clean_rx/tx_ring().


