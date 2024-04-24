Return-Path: <netdev+bounces-91029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB28B106A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4D1F21249
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CE16C6B7;
	Wed, 24 Apr 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WsD64OqG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049A15ECE4
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978005; cv=none; b=W+FkWphZzBmimhriSJLgo+yPTPy8yhrj8RSRaC+iEYZw3Y/uNfqMP83vYuOnH+04PbhjErBZ2tNaEMZIePPZsEPEMpK59OfXshvEwLPSBnaUI8C4u3On4Lw/kAanUji73LYWyqJddd2PySXoEYECuZC/0BbioAKbcOczpfkiTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978005; c=relaxed/simple;
	bh=UU/3kOGFF1LziGGpaxlW8cve/jwpT7dt7SNUndd2y0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6dPPJD/zX7pRNI4KX2NoM+SsvsbhA9ihBtxnr7AFU4oC59b0OAD4RfK97ZcvbCF00NziIzyJkxiQQS2jKRkHUWsgH385CZiv9mS86r9DYS8IYDIi19a8AYHOTPpZAb7RJHsJ+6it/WKUNDUcGPZ00teurr7gAjrHaTmBrur7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WsD64OqG; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713978004; x=1745514004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7SfLivKcz/7GgPwadZcrS5kG6BsdxqwDtkjjVZye0c=;
  b=WsD64OqGy0WJaK5qSOReRCKEUJLHYZuIwsrmR5yISfVwv3dle7bBA3GI
   +MAiQszbEWh4on1KBJVxrZWqxXyCPdwO7YXF8I9OcFzFf84k7fZm3OFJ1
   ZlbKOZOmqWOIilMRGlk8b3TOgP0H6nanBDn4tirUWTJuJtPjmBnJGxl4c
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,226,1708387200"; 
   d="scan'208";a="650081964"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 17:00:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.116:2525] with esmtp (Farcaster)
 id e3331994-df71-42b0-bf66-968b7d210062; Wed, 24 Apr 2024 16:59:59 +0000 (UTC)
X-Farcaster-Flow-ID: e3331994-df71-42b0-bf66-968b7d210062
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 16:59:59 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 24 Apr 2024 16:59:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 net] af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
Date: Wed, 24 Apr 2024 09:59:48 -0700
Message-ID: <20240424165948.9204-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <84d3a101-d961-4db3-acc2-23bc8bdc1fd9@rbox.co>
References: <84d3a101-d961-4db3-acc2-23bc8bdc1fd9@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Apr 2024 14:35:19 +0200
> On 4/24/24 04:23, Kuniyuki Iwashima wrote:
> > syzbot reported a lockdep splat regarding unix_gc_lock() and
> > unix_state_lock().
> 
> Just a nit: probably unix_gc_lock, without brackets?

Ah, nice catch :)

Will fix, thanks!

pw-bot: cr

