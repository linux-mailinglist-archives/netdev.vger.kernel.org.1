Return-Path: <netdev+bounces-158417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBDA11C39
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A707A0618
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C41DE3D9;
	Wed, 15 Jan 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KUtGpucj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65661DB145
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930495; cv=none; b=TcfbY714Ljzlfatcvck34lbLL8Xc0Xd+evsqfQ7XN2vmqAF6E58Ep4lJxdJN7ZMf944RjISVmjXoTGfK2Wkb/7k2s6FfgighXthIBlsz9E/zYfLWmPHcTD721phiAfCiMkYs1egXYBsast/w9c6OF+rzY9fv6FxAHKAPHMTQHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930495; c=relaxed/simple;
	bh=2XYMju3faSmsIXAAWwOXMnTGJut7/Crkd1/4/7jB0OU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYY/VH+RdFZjDAhfw0rVyXXFlT/KvrvZmDmGlcgPtltpyGu8sQO7w4tLOw/7zqt1/vh70PGf6lHyYnvA1+bCkZ5NCS+St4eZezz/sCP7Rb44bHwKJ2emzIw7RTHWa9reyIFNtj7mIvn6VDlWw/DqyMjbpUcWB0Cptagzrroru+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KUtGpucj; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736930494; x=1768466494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUqxH/cT10QRSF8W5HTSR8pOZexQI+lZshrJmNQ0zbw=;
  b=KUtGpucjD0kc9IX7URiUaLgSZbeUZv2P+4NMfbrb/i9WVNzAp15N9VZQ
   bcVSA8DWf/zjD6r7jwOqYVsUbmxFOjWB8Q9NxurEFCDkhMK7ycPlmXgVH
   lLJATGgx0jA45ViUofRq02zss0ZiMZRldoS2pG3CrwrtrfHtsvWWqFRo8
   8=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="57838729"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:41:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.5:2525] with esmtp (Farcaster)
 id c397cb78-3d4c-41cc-8635-57bbc4394e53; Wed, 15 Jan 2025 08:41:30 +0000 (UTC)
X-Farcaster-Flow-ID: c397cb78-3d4c-41cc-8635-57bbc4394e53
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:41:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:41:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 03/11] net: add helpers for lookup and walking netdevs under netdev_lock()
Date: Wed, 15 Jan 2025 17:41:15 +0900
Message-ID: <20250115084115.37616-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-4-kuba@kernel.org>
References: <20250115035319.559603-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:11 -0800
> Add helpers for accessing netdevs under netdev_lock().
> There's some careful handling needed to find the device and lock it
> safely, without it getting unregistered, and without taking rtnl_lock
> (the latter being the whole point of the new locking, after all).
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

