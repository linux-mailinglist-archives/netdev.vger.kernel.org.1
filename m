Return-Path: <netdev+bounces-158412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA19A11BBE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE67F166616
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C821FC0F1;
	Wed, 15 Jan 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tj6t4E/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C01EBFE8
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929308; cv=none; b=F2xpW+I38T8vi1hhtP5aAm1taqou+JdqS7gm8uSbbFH1/KpTEDOSKZ3MSQTe/QclpvlpXFf28jbNEo162LrB/eEZSfotZnYoyhRBpOc2I291t2GTYSnf4OCB231Wy5/q9ze0FyqFFLT8HDnhwaZqnxO1A6/akxfV04YPoiwTtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929308; c=relaxed/simple;
	bh=5IcX7jzmNL9dAu66oPRman0XnWUVNhSnaTzwhwcn84I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBBO0Npau5bsm8GwguvOONJFby139ot84mwCudK+fh98oTNy7EXuCbIUo5/LYWpMYg8tN6JAjOBe4DdmLUPPcQaytDlEUxdsQrtO7h/nx5RTlpHCXz02oWGqoqVbxN2xsZf1lokyHLilzC6xeYLZKFAnnzJtldmGHDoEzbTsoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tj6t4E/5; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736929307; x=1768465307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muT0EXyGO8JfV+fblEUhPM7XyfMdUKy61L6GnNZfuXQ=;
  b=Tj6t4E/5D9Cz7mZFyJFdvyct2fTNjNKIrf/5OFEJfYoMKx1552DwGIHi
   q+3fujwcEh2mnuB08VewqycYYrX3Q9l9t4Hnq2Crk7+EpjuCLCE6jnyg2
   gbVz+W7NpPPXjmGQh26zwFZwIEh8uJ+B9ixGsAkAmim6Khje8Y2OV7C9u
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="710982353"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:21:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:26734]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id 8cc1fd10-cbc0-43bf-95d8-0a1d3d87bdfb; Wed, 15 Jan 2025 08:21:42 +0000 (UTC)
X-Farcaster-Flow-ID: 8cc1fd10-cbc0-43bf-95d8-0a1d3d87bdfb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:21:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:21:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jdamato@fastly.com>, <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 01/11] net: add netdev_lock() / netdev_unlock() helpers
Date: Wed, 15 Jan 2025 17:21:26 +0900
Message-ID: <20250115082126.29802-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-2-kuba@kernel.org>
References: <20250115035319.559603-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:09 -0800
> Add helpers for locking the netdev instance, use it in drivers
> and the shaper code. This will make grepping for the lock usage
> much easier, as we extend the lock to cover more fields.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

