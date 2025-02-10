Return-Path: <netdev+bounces-164537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E35A2E1E9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A71E3A4B9B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135B8F7D;
	Mon, 10 Feb 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qhc4vpjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A46328B6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150099; cv=none; b=O4JdWK8+Rpwaom1pK52yDK7co7PDXHDWKsfd1ub102guzRY3jVVbrF41xlLzZ3D4O/4R/errjuHcApXC9EYcRoEjp9wjwUlE40yZX6n4aymauIZGjcCpkZqAoYBLCQqn0HsZJBHPQU7TXsE4IhGuEuyfVY9jKR9DAE+aLjy+tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150099; c=relaxed/simple;
	bh=ZxdeRtqiPGNhzoZI8xv1Grs+TSZQvw9Ejo4UMK9VMt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c45s7a8FUFiX2JR07zPpmCfbut8zhKQLYyuCk5rWprJoDPFW+CjuSMy+iFGqZCi4KKq7ZHH+Y2mJ3MaZjiuGeAeoPGo+S4hB6POGXR/CgbeGB3xJzO9Pp2aikSmh91oRlJDyapIEBdHppW5fXNDauVdUJarwGeEieZjkHEW+w3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qhc4vpjo; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739150098; x=1770686098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9O72E4ahy0BrM3p12UfnZHpd0FUgvaOjsQsfVhV4n0=;
  b=Qhc4vpjoCiXAoMm7sJ0pVMyuBm0zIVusyVjse21Ilc5qKtOGzf4kb71K
   34YmxpSVTHL1f9qC+lsY2UdnuOWZnFL4ZCo6wd7ZxgzymRGUXTW4JGVZg
   FPEkeLWqOBjGrMVK6StGV/sSN7ZrA/RG2FAWKBreda56KCyuAmBdM+coO
   s=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="461073566"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:14:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:18443]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 7e1e233f-adbf-4a20-9b42-20fcb7f7ffde; Mon, 10 Feb 2025 01:14:56 +0000 (UTC)
X-Farcaster-Flow-ID: 7e1e233f-adbf-4a20-9b42-20fcb7f7ffde
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:14:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:14:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 3/8] neighbour: use RCU protection in __neigh_notify()
Date: Mon, 10 Feb 2025 10:14:42 +0900
Message-ID: <20250210011442.54770-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-4-edumazet@google.com>
References: <20250207135841.1948589-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:35 +0000
> __neigh_notify() can be called without RTNL or RCU protection.
> 
> Use RCU protection to avoid potential UAF.
> 
> Fixes: 426b5303eb43 ("[NETNS]: Modify the neighbour table code so it handles multiple network namespaces")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

