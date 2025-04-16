Return-Path: <netdev+bounces-183089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D9A8AD72
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A611904296
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084C2080F1;
	Wed, 16 Apr 2025 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vXEczkxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEE2080DB;
	Wed, 16 Apr 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744766028; cv=none; b=m65n/5aN0YEe4mP0xXCyImVZsi1xJmUvMHbladTkhF6jjOtDxwZt2QJz4WWCn3gjVyWqCP+c9uf6P4SQJLGZgSoaO6djwpG2igQgeFmPZ2nZNjbXHJGitsR7AkO/a4Hug4hncYcV71VDv9cRwBjPVxbLR9mf15EjKTzN+KbppdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744766028; c=relaxed/simple;
	bh=JoPYWWPa2DNwCyDTmm1BS1g4Zann8CufrVgna3Al8Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyaPJG8h1T4Ek93zi96WCixUnKl2LA1hCcwqF/RbA5A1vrRo9m+D1bgyaJ4TSbQLvk+aoM3TyLa0OkGckN5MQyB0W0OkE2rMInsQESEO39kbQDgHHEDbxnr/z+L4DapP+hb8KFIUrotFR3eRXeSBM9oLXxdRXIdX40O3Pmb1Jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vXEczkxq; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744766028; x=1776302028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3+Ct1QjC4kdlOu204uS/KsVInjQELkb+Uc11zdAdVY=;
  b=vXEczkxqDUZfDOmcyqsSlwNLk15n3xRsmAqquiVUeKb9Xp/fIrQxq5u1
   fbqqZ9kINGBFRWUdDgfSQh/veZrCcEifvrmolcjfIdzspWCS8L1cnNfXj
   Co+9/Jzt7IHa/3gqut6USYZCirWY3djALtWH6GxRmghXIXipMBzgd1hYa
   A=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="396203603"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:13:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:25647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id 332b8a37-a213-40cf-9d71-765706300097; Wed, 16 Apr 2025 01:13:46 +0000 (UTC)
X-Farcaster-Flow-ID: 332b8a37-a213-40cf-9d71-765706300097
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:13:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 01:13:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 8/8] vxlan: Use nlmsg_payload in vxlan_vnifilter_dump
Date: Tue, 15 Apr 2025 18:13:23 -0700
Message-ID: <20250416011333.25090-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-nlmsg_v2-v1-8-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-8-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:59 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


Just grepped nlmsg_msg_size() and looks like the next series is last :)

neigh_valid_dump_req
rtnl_valid_dump_ifinfo_req
rtnl_valid_getlink_req
valid_fdb_get_strict
valid_bridge_getlink_req
rtnl_valid_stats_req
rtnl_mdb_valid_dump_req

