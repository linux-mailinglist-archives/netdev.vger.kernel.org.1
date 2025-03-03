Return-Path: <netdev+bounces-171417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA5A4CF2C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E8F171C9B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161722E405;
	Mon,  3 Mar 2025 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lLh0ogq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB201F1303
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044109; cv=none; b=H+gw8IKcAofbZRLnpsExwqFDl5ZGsjlz89ri4bGelN2LSst6WQXyWs5kE28l/cxbnSTpkb4rwksXisomfCLU+g/AcZUYi7e0GmeEWVHrqZ5tgZ7zlBxGKLYxKMWjlsUXay8mhQqy+O4iLVaYgvOZDKlznkV1ulqzZExO3nRCRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044109; c=relaxed/simple;
	bh=E17GU2+bxWbgpdNZdPw4/5uKtp+MSp6+FJg++KZbeV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2qjULy0xvArAwjXd4BBJFxC/u/xc38oE7Li6iPK/8D2zOJCbYMPHWy/r8V9Lfo+KNiQRTzhJZQ1AD/EIWU68yeHOIzreTPPtiySkL8nz8MhrtiolFq5qZWRJ+OiAU6GU4hocb736lBifqWX57eitSTbY0LW+TwKitcoCkqKgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lLh0ogq6; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741044107; x=1772580107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cU8KMZ1Or+GU2Xah4wt8Whlut4UJ2GmsRb3CQkFpLKA=;
  b=lLh0ogq6wRbZkiudzxOIAUtqnkPPwjf/ilvTsFGr5hPy3DxclNc1HO0s
   PEcD1a8M82wVs+z1wsBuF2IzN4R7J+kVleHEybHqw9dK8EaHqYuDrb5z2
   KFCKIxKm2BXiYZt+4EYa6guSRS2V8I2sJYErsrA3TjUFmgK7e9slncYbo
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="467553890"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:21:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:34585]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.107:2525] with esmtp (Farcaster)
 id ee41a43e-6b1e-4ab4-bf24-fd5ec67befe2; Mon, 3 Mar 2025 23:21:42 +0000 (UTC)
X-Farcaster-Flow-ID: ee41a43e-6b1e-4ab4-bf24-fd5ec67befe2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:21:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:21:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 1/6] tcp: add a drop_reason pointer to tcp_check_req()
Date: Mon, 3 Mar 2025 15:21:29 -0800
Message-ID: <20250303232129.52876-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250301201424.2046477-2-edumazet@google.com>
References: <20250301201424.2046477-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  1 Mar 2025 20:14:19 +0000
> We want to add new drop reasons for packets dropped in 3WHS in the
> following patches.
> 
> tcp_rcv_state_process() has to set reason to TCP_FASTOPEN,
> because tcp_check_req() will conditionally overwrite the drop_reason.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

