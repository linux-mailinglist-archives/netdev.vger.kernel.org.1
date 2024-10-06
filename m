Return-Path: <netdev+bounces-132504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C3991F5E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC391C21573
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D33A1A8;
	Sun,  6 Oct 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KasCQxuW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C4154C14
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228618; cv=none; b=C8r4aow3FblsT+dRHt4yFgCUULgCslRHQcjZW8UHcnb6cCINvJRnru6AIfmAlXGNGf0yI10YYSqvyiWOmH/T9uzhwZpO/pOjII0eY4Gf1Q8C+nnK0OU/HbEx4uNhQV5/OkaablO2hiYDG/CTvQeTgy2ocjhHxVaZco+VZ1d4iKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228618; c=relaxed/simple;
	bh=yqLNmQqQ2UTGzTeTFsCtJV2tnUOW+xaFEIYFi1sn+m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0CNXWldvpUAa1k1W5lJggSYG8tTzDatWuK2VH+cZd9/IqxSh0CvcUtnu+BG3Gh8fMfjGcF9x0S6XmA1ql98QjLfaMnj8K7yqzZUmjDieKa+d2fvNS2aV6eb3DnXUqgNeHBiIfU6uW8znzgAlqzGqCJ749bq8dhbaaL0OkDON/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KasCQxuW; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728228617; x=1759764617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYZykGSkhtQOFNvY9Bx/VjSd4orrKyCCbbjFn7vbq4A=;
  b=KasCQxuWZdJruhC7wRZDbU50NcD7fgZGMYzPwYtaPB5TUt4Q8Vph17Vs
   uohnQXm3JLaxi6BixX6Y/sKeOjdjlTtcgxUu8bHcuGEmHhpTKW85LJYzu
   pbihxY9ygdrYBk8rkFwavQSjwZSviffxS14BMh16zLnb2mDq5U+6hBQAB
   I=;
X-IronPort-AV: E=Sophos;i="6.11,182,1725321600"; 
   d="scan'208";a="432934907"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 15:30:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:9468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id ebf57cd5-b3c1-4e5e-8802-1934f02006e3; Sun, 6 Oct 2024 15:30:13 +0000 (UTC)
X-Farcaster-Flow-ID: ebf57cd5-b3c1-4e5e-8802-1934f02006e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 6 Oct 2024 15:30:13 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 6 Oct 2024 15:30:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kernelxing@tencent.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Sun, 6 Oct 2024 08:30:01 -0700
Message-ID: <20241006153001.56027-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241005222609.94980-1-kerneljasonxing@gmail.com>
References: <20241005222609.94980-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun,  6 Oct 2024 07:26:09 +0900
> From: Jason Xing <kernelxing@tencent.com>
> 
> Let it be tuned in per netns by admins.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

