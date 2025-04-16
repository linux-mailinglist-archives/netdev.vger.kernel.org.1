Return-Path: <netdev+bounces-183078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2907A8AD1A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409CF189D3B2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B851FC7D2;
	Wed, 16 Apr 2025 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tEiRFiui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181E1FBEA4;
	Wed, 16 Apr 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765036; cv=none; b=EhbISgtgmpBJ7r2Kc/xVDL6WLYXYyTI3lZpoD+o3zqzg+lmeLFlVQbflW3eSU8GsvsLKrSr2suydv+dT2YJVFWqQLHrD3H+qzvHsU7k3oGo2kILYoKU5j+BZ/IVPxdyd6BplEi8Ujvd/pMMyPdRy7J0oA9ycrA2gDNPT381/Jkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765036; c=relaxed/simple;
	bh=zZFPGfsc//NRWuZDZlLrSUrUXHq3y4H4Y7BgpiLI22k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEtZtXCnV0QFqxX7YU1xTX2EwGR/fzcsUPAWmtsGH1YEZIVeG6fm5teFijDuK+uUFbdOPvoQ1ez8fJE7ZV5k09zGbdO/SGJq88ccmdaiaadU+G30g7+UMD6+VikJxSN+wM455QWXUw6rzl5nZ9NBuZmUQtDivceWXZ7nwHdrGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tEiRFiui; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744765034; x=1776301034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpbT/RExLtbxnvfHDc23jyzlTtaFl9juJsFsutLQ0hA=;
  b=tEiRFiuiJVrDTMehiBjMS7vzRypCmgdWA6MHDtmXqjyfdLi05ck4SGDk
   VGASoWPK9AY6wDR4Txzk4V0seppp4BSNQYS0Ez4zmF5arujGMAYB2QLmA
   FeuutFkl2sgqNpgaRV57gEawSIg6DyTAaKJX3sEGywySwCImaX8gbJTcH
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="714143491"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:57:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21743]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 6eeade8f-f4b7-40cf-8960-7eb52489d252; Wed, 16 Apr 2025 00:57:12 +0000 (UTC)
X-Farcaster-Flow-ID: 6eeade8f-f4b7-40cf-8960-7eb52489d252
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:57:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:57:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/8] ipv6: Use nlmsg_payload in addrconf file
Date: Tue, 15 Apr 2025 17:56:57 -0700
Message-ID: <20250416005659.22629-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-nlmsg_v2-v1-2-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-2-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:53 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

