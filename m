Return-Path: <netdev+bounces-119090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1A953FFA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF61282CC7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19614F20E;
	Fri, 16 Aug 2024 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pX+ixSSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB753804
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777718; cv=none; b=YVXGB1asMTYjaufqz6C03aZMN76SsIl08b8abg/CBDS4qomn38wuqTsgQLZGDrdpMJpdnubcSeVFjTIeF8p0Cdhyig/LC6hVemYt6v46GDVVv6tsy9KUC6niGvuaP0JMjfuvpmQ2DnSTJZDztffCRPWORXrwhABjO6wV6xG7uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777718; c=relaxed/simple;
	bh=6u878L3hzLIM7HDEY+MiFdJPc8wUWL8KPFilWyrmMeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgPYs9ettEbEPTlsl31Gxl0dEnetH69wI3ufzGj9WSln49gTodIHEDYjCwvWuxzRz3ELbC/mApeK0GMG/r423yMVKgBKIJTXYdKENAg69WYYP1MWJpMd5YpBKyXla7CrSSL4Ujie1TbW2nOKgxuCFgKf9zsX5HQCIgxBd0y3P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pX+ixSSY; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723777717; x=1755313717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=djRmBjIlS2XMa7j57ThZl8X6SsB3FSk/FU87VG4sC/k=;
  b=pX+ixSSYQUZ/ueJSRwucrNnoQUpgwyUJfi88E4a4d6wSGe6JJFAO+lTS
   exi5XMNxj935W+KR2V6IPmI4WmSgSt62Ke5Y8jBuy3nrWerA0c0SqwW5a
   iaNFl2ahTZ3JKmzr9C/tyffoKB/9qxg8jJb/x/KyTMlpTdvSa/fDCXZ/+
   8=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="362559952"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 03:08:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:24131]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.187:2525] with esmtp (Farcaster)
 id 993d76c3-95ee-4bd7-946d-edf8a570647d; Fri, 16 Aug 2024 03:08:30 +0000 (UTC)
X-Farcaster-Flow-ID: 993d76c3-95ee-4bd7-946d-edf8a570647d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:08:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 03:08:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jk@codeconstruct.com.au>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <matt@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] mctp: Use __mctp_dev_get() in mctp_fill_link_af().
Date: Thu, 15 Aug 2024 20:08:18 -0700
Message-ID: <20240816030818.15677-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815183946.342e9952@kernel.org>
References: <20240815183946.342e9952@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 15 Aug 2024 18:39:46 -0700
> On Thu, 15 Aug 2024 13:42:54 -0700 Kuniyuki Iwashima wrote:
> > Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
> > af_ops->fill_link_af() is called under RCU.
> > 
> > mctp_fill_link_af() calls mctp_dev_get_rtnl() that uses
> > rtnl_dereference(), so lockdep should complain about it.
> > 
> > Let's use __mctp_dev_get() instead.
> 
> And this is what crashes kunit tests, I reckon.

Exactly, I missed that the helper increments the dev refcnt.
I'll use bare rcu_dereference().

Thanks!

