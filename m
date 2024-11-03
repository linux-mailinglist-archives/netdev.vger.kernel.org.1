Return-Path: <netdev+bounces-141312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F979BA73C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453681C20D50
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F1185B7B;
	Sun,  3 Nov 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3euWv7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796013049E;
	Sun,  3 Nov 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730655106; cv=none; b=Z77DikyqTs/vbFzrPDSIX6SE+kuKLzzgI8gQuQz9BhkgI+24Do3SBaw9ZrU3wufqSVK3LrhXplGZQzLdejHvpI6xD7mJ6pk2Zi2adIui2p8UnMG8cIKK3Y9uNX0Bl74F05/OkPwgOCBUrC+u6cmuAlLzoWJPeN//DCdyKoNvouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730655106; c=relaxed/simple;
	bh=wfk8qbaU9InKWpE0Acf8Uzes5W/S9r9BMEmsxCgbAhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeQ0H8bAcWrow4lg+0OvmrfnJtOlJ7wD2MCEP3fDQaQ8bydDl9TIrbwdiScYpTy+oBs5c1Lu+0h11NDey7JeTCFpH8afaQiN7lxW1OMpQ75Z9dRMleSeZoMkmDyPtNFezne3HUAMO6U13RHHJjes4GoskWQL7Ym0wvSUKHJw4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a3euWv7Y; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730655104; x=1762191104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VAq26ivGP6HWcypo61s63sxigrViuDKgoXzs5Trwx4=;
  b=a3euWv7Y2mFsY9nx/YbOyXETICJ8BwkiYXBMZCxS5GQ7eMEmkegGkd1F
   YdAYsdj0qzy6HFIpG+OD4zaX+IL8VsEIPS6kB99wCRpzXZDs5Rr1d8LmU
   N2VieYlRHbbsw/cT3d2DUE7ACQDL5smk0Abk29oj+5t++YGDY00fUFyPD
   A=;
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="scan'208";a="439899592"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:31:40 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:31684]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id 44ab26f6-929c-4ae1-870c-42e369fbe483; Sun, 3 Nov 2024 17:31:40 +0000 (UTC)
X-Farcaster-Flow-ID: 44ab26f6-929c-4ae1-870c-42e369fbe483
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 17:31:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 3 Nov 2024 17:31:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <markus.elfring@web.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jiri@resnulli.us>, <juntong.deng@outlook.com>,
	<kernel-janitors@vger.kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<nikolay@redhat.com>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<ruanjinjie@huawei.com>, <shaozhengchao@huawei.com>, <tgraf@suug.ch>
Subject: Re: [PATCH] netlink: Fix off-by-one error in netlink_proto_init()
Date: Sun, 3 Nov 2024 09:31:33 -0800
Message-ID: <20241103173133.96629-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <80516b25-a42d-48e1-bcf9-27efe58f44c6@web.de>
References: <80516b25-a42d-48e1-bcf9-27efe58f44c6@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Markus Elfring <Markus.Elfring@web.de>
Date: Sun, 3 Nov 2024 14:15:18 +0100
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 3 Nov 2024 14:01:26 +0100
> 
> Hash tables should be properly destroyed after a rhashtable_init() call
> failed in this function implementation.
> The corresponding exception handling was incomplete because of
> a questionable condition check.
> Thus use the comparison operator “>=” instead for the affected while loop.

This patch is already applied to net-next.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=bc74d329ceba

