Return-Path: <netdev+bounces-158435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E05A11D78
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C9D3AA572
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B36248184;
	Wed, 15 Jan 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fc4+5yK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45F248172
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932708; cv=none; b=Y/OPeqy2/sEc9WyCjwa155KLNQNIgMfJJrw6cpSGW1XqCdd3ChTiHc1sAt24pchZwfjP/5Nl1qIKYwpGY4wFbqB3XmQ1ojHo6pfg4W2WC8QDxGyHuzzqNxyep5Ucvwe7k8TF3fOthHJUdh6IKPNXlsNOT5e9glg6wNR1FumNU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932708; c=relaxed/simple;
	bh=s88hBHuYsIukHKLRa/7FjgFkPXufib6ylrVzvPXrWE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tG6bM1v+U+aqRgiNlNk/6SzQO2Hgqntceks8vnj/hC4eW3HHU/xQHtTJ9YOTkOCBU/vxf4e0ebw8Uog2NqGGhQ+LswmbMNZR/28WBQPNdxDKA+KaUIX3mU2lFdjK8MZPy68lBtunJs3CRCLyzSL2Tc6Num2DXmX038vseMd7Dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=fail smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fc4+5yK3; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736932706; x=1768468706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u5Qk9d2oNBg3qM/P68rU4ZCqHAPVutuRW2+5V5uFllY=;
  b=Fc4+5yK33cGMeGDewc0fIuHIqs8wamjDvqVqr7aiWDiTW+prXqUj8t8U
   kmvQsxtZ9xzcPQEXWnvF/fdR98KHLkA33Jr4jJ+7zUH2fcU/ttvsbpLku
   bcAmYh6BoWgLbD6csofkMI9AHfg6k2QqU75r6M4jZm+7zT5kMfoTIbtbN
   A=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="57849677"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:18:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:47428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id 3171b362-372c-4834-b661-7c4a7581f59a; Wed, 15 Jan 2025 09:18:17 +0000 (UTC)
X-Farcaster-Flow-ID: 3171b362-372c-4834-b661-7c4a7581f59a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:18:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:18:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 11/11] netdev-genl: remove rtnl_lock protection from NAPI ops
Date: Wed, 15 Jan 2025 18:18:03 +0900
Message-ID: <20250115091803.46869-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-12-kuba@kernel.org>
References: <20250115035319.559603-12-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:19 -0800
> NAPI lifetime, visibility and config are all fully under
> netdev_lock protection now.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks for the series!

