Return-Path: <netdev+bounces-171418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F8A4CF33
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11EF189580F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C922FF4F;
	Mon,  3 Mar 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QRzDkZMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D521EA7D7
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044386; cv=none; b=TLJAK/mKJpkJ9fybACocwpxqdqJUCUpFWRWxz0LiQ18ZF/SV1bRH4hZ8R+APg8zZ0NGLWXNvvJDNbxPcHvO4l/DIc1R+yd36juM8XTDhjTIiEAAyCcY7FSIW9L66KaEH0BngSHa6JNfwn319h1KF4NPu6HTgeekJuxihxTQt/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044386; c=relaxed/simple;
	bh=V5hnl7vXEZTSPF8h1yurietvfz/OLZya7sEwkONHItg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF4IlzN6SaceogQVh7mxtUIdHX0YnrN7UYrdR7S0q0wx5WRfSQO6OVdZ/Qfb66utqrS84rLxPFbArzdTWcfHpEYnPxQssfArVL7NzDrXYWnPf5KLxDxye2v6oE9JlKi4TjoC1tXbPnLXdEzdX7iEuirdbDwOd+KP+mWuxrf5hf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QRzDkZMX; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741044385; x=1772580385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cWnkHeuLYyWzZ3FwFMF81nR6fnYdrpp1Vp5WId2JhU=;
  b=QRzDkZMXZbf5nebMhHx8Zqp6uaAySzxmm+9tobODfjZlqkVzk+CDpSte
   xiMBqyRG+THH3cznTRdD+qcvKKbjTLlWGr6VdT6MQ53bCgFir5/cub9eA
   Ew1CLAIOsV3iFXM6k1PwUogA75y7pOf9Jx8wpLhbnIdyEsbsA1rgynCtn
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="70962752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:26:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:34240]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.238:2525] with esmtp (Farcaster)
 id 7ade6233-563f-4ee4-9f65-7573058170c3; Mon, 3 Mar 2025 23:26:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7ade6233-563f-4ee4-9f65-7573058170c3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:26:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:26:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/6] tcp: add four drop reasons to tcp_check_req()
Date: Mon, 3 Mar 2025 15:26:07 -0800
Message-ID: <20250303232607.53581-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250301201424.2046477-3-edumazet@google.com>
References: <20250301201424.2046477-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  1 Mar 2025 20:14:20 +0000
> Use two existing drop reasons in tcp_check_req():
> 
> - TCP_RFC7323_PAWS
> 
> - TCP_OVERWINDOW
> 
> Add two new ones:
> 
> - TCP_RFC7323_TSECR (corresponds to LINUX_MIB_TSECRREJECTED)
> 
> - TCP_LISTEN_OVERFLOW (when a listener accept queue is full)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

