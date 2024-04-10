Return-Path: <netdev+bounces-86347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3889E6D1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A2E1F21592
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ACA19F;
	Wed, 10 Apr 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X+78apKZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B77F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708844; cv=none; b=hVD/6JNsphmovrysxwnnOSuUSnaZSldiUfyrE+94iUAtFe8HBpU5iWKqJFi82bLCtw4n1fZ5r17iQLc/2s29QbGLHHLpFBo4LUsuuKB+E4PoKwqlLpTTc5ACdMtfVB53U6rH7kZHGQp8KC400+sis4rmAylywZEQmbc8jlc079A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708844; c=relaxed/simple;
	bh=Km5LYaJprbYIXsw/M2S7yakHi3ZAl6B1JgppZqA5zUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li1PzqLgAe5dkhtBuP81af23KaZxQrD7UuhEVZ7ao8oKQ22K+gPFCmooB+j2mp89AJVqQTkpmWXMBmDuO62iHozJBp39/4OoDsQfHypT9LiIwbGGeAd2l3HzBkAzd0nAL7CfvtYqTarsGIZBeKTKz/arSpuE/lVVIPONN1cauXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X+78apKZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712708843; x=1744244843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AA7WHuUuV+VGRb8O1840X5sUGV85+2yAJvqX00WgTes=;
  b=X+78apKZxKPbJchqLLUTPbXKqbXxMzPEbDQixAOjEoq+RppbiMuxXdUG
   woCzGNHQ5XUyV+hDXndN/rkkobXL6lyH+RpOPh5zcBCD4bQlxK2dQwz8W
   w3ryPWrir2Q1BxRcmQISjKj5BHr6A0fZSBFZb9XY8kfe7pZVCmvl5qnY4
   I=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="80031835"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 00:27:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:59094]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.105:2525] with esmtp (Farcaster)
 id cd436ae0-5d52-4a23-b3c1-f475bbc0171d; Wed, 10 Apr 2024 00:27:21 +0000 (UTC)
X-Farcaster-Flow-ID: cd436ae0-5d52-4a23-b3c1-f475bbc0171d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 00:27:20 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 00:27:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
Date: Tue, 9 Apr 2024 17:27:08 -0700
Message-ID: <20240410002708.66697-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bef45d8e-35b7-42e4-bf6c-768da5b6d8f2@oracle.com>
References: <bef45d8e-35b7-42e4-bf6c-768da5b6d8f2@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 9 Apr 2024 17:09:24 -0700
> This feature was added because it was needed by Oracle products.

I know.  What's about now ?

I just took the silence as no here.
https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/

As I noted in the cover letter, I'm fine to drop this patch if there's
a real user.


> The 
> bugs found are corner cases and happen with new feature, at the time all 
> tests passed.

Yes, but the test was not sufficient.


> If you do not feel like fixing these bugs that is fine, 
> let me know and I will address them,

Please do even if I don't let you know.


> but removing the feature completely 
> should not be an option.
> 
> Plus Amazon has it's own closed/proprietary distribution. If this is an 
> issue please configure your repo to not include this feature. Many 
> distributions choose not to include several features.

The problem is that the buggy feature risks many distributions.
If not-well-maintained feature is really needed only for a single
distro, it should be rather maintained as downstream patch.

If no one is using it, no reason to keep the attack sarface alive.

