Return-Path: <netdev+bounces-164541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6FA2E204
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926FE1887870
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2EA179A7;
	Mon, 10 Feb 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d/ZJ9X/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81A35957
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150875; cv=none; b=dWpBr1Fm4dKvJhJoh3R4k+GhhLdtewL109MTmThwPhUl2ptfF+SHpp+P9TvPaZTOyLxMNa/haUy61y8bX54VvSB1G4KNV1HF37TYXCtsbet4WVHpUnVPWlJeu6P5fBfYjibsvfST7EEbtZPXxMQYqZ6529cQev1QdZxb58pOx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150875; c=relaxed/simple;
	bh=eORGB4pj9pmH8oOiMF7XOWKvjamJNry6ZmEW3I0HDDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRb2wJ82zsqY1m1o2zZ0LyoxaXknrIgG4hQtKAg6+bWr3LaaFPArPlNK+yeRaOyFJtvyUDxIEUzDId/Y6wwGieg73i3ZedJqZk1HJaKHPaf+Wmc42Y7hVlgtF/39FL3mRQegp7GGhkqA69fkqInQB6BmQHG2VUY264OChHCdWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d/ZJ9X/G; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739150875; x=1770686875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qAqP71V34sg69bsAqbsmmhMCgOWNvVoRXOmdch4PcTE=;
  b=d/ZJ9X/Gb0wgA9dQkp48I2AzxOjy/qmIproQ/AmlouC7hQRQWYj+mcy4
   2GgHOzwPIvX0Fn0wphRsvS4SK5Hy3jmLzC+Arw1JS723igSq11BRCTlYb
   ntRNydOf5XG1Li57p2nOlftMzVtAS3LQEQy7dasf7PMykxfNI3IgJA7uH
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="797420502"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:27:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:48105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id fac5c9da-0514-4763-8ec5-0c704b59b772; Mon, 10 Feb 2025 01:27:47 +0000 (UTC)
X-Farcaster-Flow-ID: fac5c9da-0514-4763-8ec5-0c704b59b772
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:27:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:27:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 6/8] vrf: use RCU protection in l3mdev_l3_out()
Date: Mon, 10 Feb 2025 10:27:35 +0900
Message-ID: <20250210012735.55713-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-7-edumazet@google.com>
References: <20250207135841.1948589-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:38 +0000
> l3mdev_l3_out() can be called without RCU being held:
> 
> raw_sendmsg()
>  ip_push_pending_frames()
>   ip_send_skb()
>    ip_local_out()
>     __ip_local_out()
>      l3mdev_ip_out()
> 
> Add rcu_read_lock() / rcu_read_unlock() pair to avoid
> a potential UAF.
> 
> Fixes: a8e3e1a9f020 ("net: l3mdev: Add hook to output path")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I wondered why syzbot didn't notice this and I confirmed that
list_first_or_null_rcu() doesn't have RCU annotation.

