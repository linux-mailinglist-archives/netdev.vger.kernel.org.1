Return-Path: <netdev+bounces-165863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99714A338F6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF2F3A47C7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48920A5D3;
	Thu, 13 Feb 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CT1J+47Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE92080E0;
	Thu, 13 Feb 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432230; cv=none; b=r7ylCTODMdUFTViIYzDXSZDJ6qMCZLxuMLVHcM3GulDbXTJ6WuaZIsYBLFmjJx3OBzHYjFP2AvqhJKtlvmiU5L1VL4xuA50whTh0seKo1IdheQtUhD6wm/xsRRdBLMLmoZh2MDgqMzmfRWaNHTkMwlyusbgIhOFgNiU6nXoLxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432230; c=relaxed/simple;
	bh=k/s/blXMTPACoapYpKXgCGTKo9aQe999PkUXre5nUcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDuaq9dsjDOunMIA45qdoXUnMmIRt+9zdrWChc+pzfgkWGxcN+sJqGBBUYP3b+18US6k4d7lQM5oB8d9eiRQRYAuwwFoTp/aQm1oq6adOr08H/KXCgbsl3d91Cg+AigL6yQ8FhdbT20R3YvFXZDY1PRn8O4igkJtTU+LuRqrwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CT1J+47Z; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739432228; x=1770968228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ru75CHptJLbrNWfq0dXvP+XPh1CZ4Ep9tB4CcYplcjY=;
  b=CT1J+47Z7eEhstWRqPHwNlR+Aa6lNdT1h9o5DbSAYOmLnKkILk36LKXx
   ocJliOd6fJZ2pKPLHrvvxFJMp9nfPjbMmPMjahJsAZ4iNI+IJFxRH1uzw
   4iLYCnmmQk6NaIy5nvCMih/b0oulIT4g0f9CgZtH+EN3zHriIlg40p27R
   g=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="376947896"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:37:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:24729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id 84cc2de9-53bd-4327-a127-c9735fbdf4bd; Thu, 13 Feb 2025 07:37:06 +0000 (UTC)
X-Farcaster-Flow-ID: 84cc2de9-53bd-4327-a127-c9735fbdf4bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:36:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:36:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 1/3] net: document return value of dev_getbyhwaddr_rcu()
Date: Thu, 13 Feb 2025 16:36:46 +0900
Message-ID: <20250213073646.14847-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212-arm_fix_selftest-v3-1-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-1-72596cb77e44@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:24 -0800
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..0b3480a125fcaa6f036ddf219c29fa362ea0cb29 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1134,8 +1134,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
>   *	The returned device has not had its ref count increased
>   *	and the caller must therefore be careful about locking
>   *
> + *	Return: pointer to the net_device, or NULL if not found
>   */

I noticed here we still mention RTNL and it should be removed.

Could you update the comment like this to remove RTNL and fix
mis-aligned notes ?

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318e..c0d6017a3840 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1123,17 +1123,17 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 }
 
 /**
- *	dev_getbyhwaddr_rcu - find a device by its hardware address
- *	@net: the applicable net namespace
- *	@type: media type of device
- *	@ha: hardware address
+ * dev_getbyhwaddr_rcu - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
  *
- *	Search for an interface by MAC address. Returns NULL if the device
- *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
- *	The returned device has not had its ref count increased
- *	and the caller must therefore be careful about locking
+ * Search for an interface by MAC address.  The returned device has
+ * not had its ref count increased and the caller must therefore be
+ * careful about locking
  *
+ * Context: The caller must hold RCU.
+ * Return: pointer to the net_device, or NULL if not found
  */
 
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
---8<---

Thanks!

