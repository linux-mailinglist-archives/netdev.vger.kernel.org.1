Return-Path: <netdev+bounces-96878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAB8C81A3
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851421F21747
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93D21373;
	Fri, 17 May 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JlToIVMb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8A17C79
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932080; cv=none; b=GiLFRpH2dyJFeHHrKq7+/QbedA/2RlEd5YUavfAKVrTvCMsb2YXF1fYnje3baSjdsRT05vRHw+Z9J8HE/tAnKYWeZenwmnSDSZGnk40kCnf54sD8UrJ1rVw7W7ax8vavOCOfwDA1rCZAvETn/pO115bFa29LvLUvzhVQvgiXQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932080; c=relaxed/simple;
	bh=4+uzJOrqLMJHacaTpSYZHZhGqV00OelqoeynSgLRRTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IP93pdoL3iYF2P94q22JAKOg0i2asdyxS+gVdUqr+iwjnTJNMCYZpVHZW8wRcm+jCN34YPCozWvBMzkBLgcsKLt+ZG/Bdr2+ie+FYuK8RQXNPqv0LjrqxQeT8KZX2RNmKrDHbxRfux35nvTLLGdt+a7TbUyqRAHqeLgiobgO9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JlToIVMb; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715932079; x=1747468079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fw0faXPihlSe3H47ud51uu/Pq6QRMhUZa1EqaNZQLLM=;
  b=JlToIVMbR8BKfYXaaKMq+cFpqHqw20yP98+ZDJz9gtT+VBZ63HRnI5VV
   luoOjXvtQPKDRCDpBz7ZhJlG8kTye6CE8Z+7XHT4t2oo7puc29dm8ux41
   cPmZU9OahmqevDni6RNmMGqUtCvoMelRQQ5SUjmctNIafU8tqH8w1ww9F
   w=;
X-IronPort-AV: E=Sophos;i="6.08,167,1712620800"; 
   d="scan'208";a="633447247"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:47:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:14360]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.170:2525] with esmtp (Farcaster)
 id cc4711fa-cb92-41a6-b4f2-97d171f85921; Fri, 17 May 2024 07:47:55 +0000 (UTC)
X-Farcaster-Flow-ID: cc4711fa-cb92-41a6-b4f2-97d171f85921
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 07:47:55 +0000
Received: from 88665a182662.ant.amazon.com (10.119.6.241) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 07:47:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Fri, 17 May 2024 16:47:42 +0900
Message-ID: <20240517074742.24709-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
References: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 May 2024 07:59:16 +0200
> One question: git send-email automatically adds my Signed-off-by to your
> patch (patch 2/2 in this series). Should I leave it that way?

SOB is usually added by someone who changed the diff or merged it.

I think it would be better not to add it if not intended.  At least
on my laptop, it does not add SOB automatically.

FWIW, my command is like

  git send-email --annotate --cover-letter --thread --no-chain-reply-to \
  --subject-prefix "PATCH v1 net-next" \
  --to "" \
  --cc "" \
  --cc netdev@vger.kernel.org \
  --batch-size 1 --relogin-delay 15 --dry-run HEAD~10

Thanks!

