Return-Path: <netdev+bounces-181807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBCCA867F6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0715E7AF1DC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F929AB0D;
	Fri, 11 Apr 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HeRROX2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9A28CF6D;
	Fri, 11 Apr 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405992; cv=none; b=gDODlywrhEvUfxBbKW5ynvxw3hs2YdnmzBAUCCu6m2oOmGIUlSy+dyya6H7RPJTYKe4lglbfrjBut/0yw7pmy50ZtgkcHp8lxxr9719/UrBvNseU3BPiNPQIzKvDoKOXDQ8grYYP69fSGWKQcVVvlVrJNh6qVlVz/B+vkvP7sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405992; c=relaxed/simple;
	bh=NRkDqumSgo/9HhILfW9lGyWhEr1E9q1qj1B95xNuaYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JduOK/krg47OrXD+Sgx2GMVLRsmKxFvkY8Mzt+sPhdRPC01x6LUAXts0p/jH9PAnJlwemFbmoUfy0hRgUEN4d6bkcAdiVmnb42/Qh85akqnEky7AYLqUt7/sy6lqKmqRTRE5gzVxS+3cPbtPQvTU32Npx5jdZ+AE6MjAMG9JY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HeRROX2V; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405991; x=1775941991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDhN1VOGH+I8Rlo9rRLYrkMggVE6r+x9PJBzAF+gl80=;
  b=HeRROX2VzJnENuujDoi3NluZAMGYdh6v0Vg6FbhIkN+4KOpim/WVRwO3
   o5md9PsrixZ0iFOvtIT15Sc50MckgwMqkFs4Ymk0qozMxj8DxFE3RK2Rr
   YwO+cpDOU855ssXFH1tfCInbvTc+9FzUoHoxxhIm4DIVWAFWTD6KJCXm2
   k=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="482424616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:13:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:1138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 5eef3590-ca5d-4af3-aae1-d604fd014dff; Fri, 11 Apr 2025 21:13:08 +0000 (UTC)
X-Farcaster-Flow-ID: 5eef3590-ca5d-4af3-aae1-d604fd014dff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:13:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:13:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/9] netlink: Introduce nlmsg_payload helper
Date: Fri, 11 Apr 2025 14:12:49 -0700
Message-ID: <20250411211253.66030-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-1-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-1-ddd4e065cb15@debian.org>
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

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:48 -0700
> Create a new helper function, nlmsg_payload(), to simplify checking and
> retrieving Netlink message payloads.
> 
> This reduces boilerplate code for users who need to verify the message
> length before accessing its data.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

