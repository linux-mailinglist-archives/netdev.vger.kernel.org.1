Return-Path: <netdev+bounces-161166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F39A1DBA2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FFB3A34A9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918B186E26;
	Mon, 27 Jan 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VUyE09O6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6417BA1
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000476; cv=none; b=J8/VCdhQ/OC3Cg6qC+78LGqFKAvePocZ79Bm+He1skvReALTBYYLy/WAQe1cnZcoSWR2qZkxv0g3jJ3a7Vq+1HIpKVkfYMHlG6LG54ph8amRsOc3Dp2q4OqkLtoSFsOBCWVxDJ3iIVKtoqQBOFFsD3JXLPX6dUBs7gWDc+Z0N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000476; c=relaxed/simple;
	bh=hrWenp+UqDyTNYl8StSQU6wk8j0ODxzhh1VFrkkwd6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKud4vAXsHr9BzbcILG3VT7lrJZKevmASkQklUULndxZF+KPVls+2tGV419Uh4l0XRN/x/PP8itwKm5bXucF2rayvRIzB3ZqiucTy7VF7WouaiQ9oHKKJG5NcvvgIex0zMFMG6V9Zl7F942pvv0GsdAXVauPWD1QGMrFdxZYA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VUyE09O6; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738000475; x=1769536475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EzWFc+XKR+fEku7HtDHWF4Ily9pkjKHqCjRg97L90kc=;
  b=VUyE09O6sg4D6EDcTXrchZK9Po2MG2IDhFNMB/PVHrr/6ItYWCYHf4cB
   l0fSkrLZS9s+5zU9/E0VOc0XMNgkFFHmqwrK4lY9UxbV9pFthhOnHoJRM
   cVnIgcrUqsZ25EkotbFtMmAJuzd9uRcjTZZ+JNg6PTdSq6pqQQTJE7Sgp
   c=;
X-IronPort-AV: E=Sophos;i="6.13,239,1732579200"; 
   d="scan'208";a="461929231"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 17:54:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.178:2525] with esmtp (Farcaster)
 id c9e2fce2-eb6c-42e6-b5cd-44f01e057f8f; Mon, 27 Jan 2025 17:54:30 +0000 (UTC)
X-Farcaster-Flow-ID: c9e2fce2-eb6c-42e6-b5cd-44f01e057f8f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 17:54:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 17:54:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ychemla@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Mon, 27 Jan 2025 09:54:19 -0800
Message-ID: <20250127175419.50613-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <e2164d2e-10dc-4990-9c1b-70667a594fd1@nvidia.com>
References: <e2164d2e-10dc-4990-9c1b-70667a594fd1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yael Chemla <ychemla@nvidia.com>
Date: Mon, 27 Jan 2025 19:26:34 +0200
> Hi Kuniyuki,
> 
> any update on this?
> do you need further info?

Sorry, I was busy as on-call last week.
I'll investigate it this week.

Thanks!

