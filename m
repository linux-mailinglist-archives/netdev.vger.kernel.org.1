Return-Path: <netdev+bounces-155330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2194A01F86
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73DB1620AD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDD15C13F;
	Mon,  6 Jan 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NQqVn025"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E952D600
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147292; cv=none; b=c7u/cE37FoHV8zS6R7kVQ/ExvSy+Fs2HcA7kiuQY4TPZBVhMfc4dxbYptcZZdLUyKFo+sZQqjuUwjufUBagEHv00x6fW58f7rkW4CYVL7J0jk0cKGzuQl6asaAqoDTRYL+JwgzHyA1/NIlQxFer7U/3qnI//rLP+zSOo/Yoc6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147292; c=relaxed/simple;
	bh=wAYcCfs3gpa5A3uLbeFFmNHV71BxXHPSCMFqqGTWG3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGNY/SCtweJwGGqV1l4mX1z/69K+JzxnCUIE5kN71+bzf+0LfQB3IcOtX7FU79aPHSPS7206lxdR3z4I4ma58JS3AZa5u6rCE3v54vBbnUaFLjNjfJpAsGCVJBlMm13AZO0FRcd85YPdaxMbVrC7HwB5pvi+5zOX5Guh374eA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NQqVn025; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736147293; x=1767683293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wLHloDvsf27aFcG8L8Yk2qJce1OWy76ay8PJw4NVZec=;
  b=NQqVn025DBVujXhKvrNBHs9sYhvDMjhSRu9CGWFYO5/Arv3zve4fAiRh
   OA7iacMQ3iib3+slAjtZezS7cRKogVhl8+7E/R2cjVVn0Y8nWyMsruYVA
   gvwuXhWCSgu+CGSJYjg/Rw9eygY24Nia1Vq2bJcl9l3X9Ntr19sMJp70J
   U=;
X-IronPort-AV: E=Sophos;i="6.12,292,1728950400"; 
   d="scan'208";a="461911981"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 07:08:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:43611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.99:2525] with esmtp (Farcaster)
 id f5ca8b64-f847-4410-9e7b-3961300c3450; Mon, 6 Jan 2025 07:08:07 +0000 (UTC)
X-Farcaster-Flow-ID: f5ca8b64-f847-4410-9e7b-3961300c3450
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/3] net: Hold per-netns RTNL during netdev notifier registration.
Date: Mon, 6 Jan 2025 16:07:48 +0900
Message-ID: <20250106070751.63146-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series adds per-netns RTNL for registration of the global
and per-netns netdev notifiers.


Changes:
  v2:
    * Drop patch 1 (leave global netdev_chain raw_notifier as is)

  v1: https://lore.kernel.org/netdev/20250104063735.36945-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
  net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
  net: Hold rtnl_net_lock() in
    (un)?register_netdevice_notifier_dev_net().

 net/core/dev.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
2.39.5 (Apple Git-154)


