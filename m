Return-Path: <netdev+bounces-180495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EEBA817AF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313BE46324B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF8254AFB;
	Tue,  8 Apr 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rs0nXpYI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362F1388
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148251; cv=none; b=BF4AkRxDKp2zuRsCJS3D0ijAlwQoFdy3jJqaamUq0YLDFsOuwCPUQ8OkCXudx26s+FUWP/+tU3KLehf/5Pf5XKuJxYRGYETH66DMd7rs0g88W4exIzW8EGss5z9BUaOubSp/d3/kdXSRqIfMFdykjdij+PiH6ypi/Td7R6kZ104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148251; c=relaxed/simple;
	bh=26G3GyD/hU3RRx0zLMFUduFZb4Y2oV/qLTuJWjWyjxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvP6cygS3hfu1Og0V/v+AmS4WmVb5+/4Pq76b/zcnxIejkJi81Alm2pT6lbWUfptTeaOD0SSXefd9pgB4puL7QchMKyqk6x+Bv27bdT1BmX5jBqn/xwBVVfoJoC93Hl9LRIRdoYPWzcqPgtOISbQtGcTmZRmkOM2Zx51nnFTlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rs0nXpYI; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744148250; x=1775684250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2D2lIW+W9pDbZ7M7+ICQku8v17daM/4/leCag0uVw8=;
  b=Rs0nXpYI4aQ3yh1+bDC60wsjb21YcQlgv9XFBfa7NIyYKKQm0xu+T8s8
   CEz7GPXqld51NlUayAaXKXkrn/+i/1afKtbbu8pMwxQ6tl9e3Zz0uwBsu
   z8sBqGED+h6WYKCx6l7mGTJT1GC7XRwN7P3KrIrX+7RoN35ONXL5+TCq+
   M=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="733990441"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:37:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:47418]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 78588507-697c-4f5b-a73c-e8ec97811e23; Tue, 8 Apr 2025 21:37:25 +0000 (UTC)
X-Farcaster-Flow-ID: 78588507-697c-4f5b-a73c-e8ec97811e23
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 21:37:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 21:37:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH iproute2-next] ss: remove support for DCCP
Date: Tue, 8 Apr 2025 14:37:07 -0700
Message-ID: <20250408213710.90791-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408185134.92749-1-stephen@networkplumber.org>
References: <20250408185134.92749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue,  8 Apr 2025 11:51:26 -0700
> Since DCCP is going away in future kernel, remove the decode
> logic in ss command. Keep the display of protocol number.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

