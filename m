Return-Path: <netdev+bounces-86403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91EC89EA43
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268371C22553
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0431CA80;
	Wed, 10 Apr 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n6t2+hmA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9C1BF3D
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728890; cv=none; b=aPaE8/byCIakWFbGOw1B7IdciQyKms3u11S3MRSLvtododGIISqQVpet9GCEc9koTMRRSuv9WrdbxnbIilZ31wS0+dSl15NZbFaylHv1irOF9l8ipbFoYkXZhTHLxxQbfEKYCqdu11xtY7u2bpdrVSAHB8ljkiC20mLgSlJesaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728890; c=relaxed/simple;
	bh=8Xx8ZWgrcLJh8FLoGwi2ZDm8VztuEXOl/vfjDjr1j8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Si/KItS+zn7xpDdn1EdOYYjgSvwylB8R8hettlotMsU20GwlvBy1K5HZJKtlDgFgjvCpdieXTtwKnYfhrHe+lvhfCTzw+XO6eN0GH6tlkC7X8+Wx17qhz/fRKRPy0HpCceINsDyqjB6k7uESOWoDt9D2QY/8nMTBuFHUIrVw2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n6t2+hmA; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712728889; x=1744264889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9CZKHxDaxT7QcR3vVT97QpsH/F2zU4YpmixcA/IxSqY=;
  b=n6t2+hmARwfGbduiuaOKmEeqGur0tvZsldM+qJ1LU2PuI0P46oqKAaTu
   1mr+F+nYKXpak793Q3pFTCT3de0r5y43AZNzKwVlEFK/dMzIx598Z9YIK
   3jm9Zlz0bZOsMLV5IKfYq4E16P5C7uVLnJumgn4NX53RFzFDrdvTFO+t7
   c=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="410428778"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:01:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:32921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.249:2525] with esmtp (Farcaster)
 id afd76b59-5575-4163-980e-222f4192127c; Wed, 10 Apr 2024 06:01:22 +0000 (UTC)
X-Farcaster-Flow-ID: afd76b59-5575-4163-980e-222f4192127c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 06:01:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 06:01:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
Date: Tue, 9 Apr 2024 23:01:09 -0700
Message-ID: <20240410060109.96131-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <22994084-e0a2-4829-b759-73e98418b510@oracle.com>
References: <22994084-e0a2-4829-b759-73e98418b510@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 9 Apr 2024 17:48:37 -0700
> On 4/9/24 17:27, Kuniyuki Iwashima wrote:
> > From: Rao Shoaib <rao.shoaib@oracle.com>
> > Date: Tue, 9 Apr 2024 17:09:24 -0700
> >> This feature was added because it was needed by Oracle products.
> > 
> > I know.  What's about now ?

Why do you ingore this again ?

If it's really used in Oracle products, you can just say yes,
but it seems no ?


> > 
> > I just took the silence as no here.
> > https://urldefense.com/v3/__https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/__;!!ACWV5N9M2RV99hQ!Nk1WvCk4-rstASn7PUW4QiAejf0gQ7ktNz-AhuB2UHt9Vx7yUVcfcJ82f9XM3tsDanwnWusycGdUfF4$
> > 
> > As I noted in the cover letter, I'm fine to drop this patch if there's
> > a real user.
> > 
> > 
> >> The
> >> bugs found are corner cases and happen with new feature, at the time all
> >> tests passed.
> > 
> > Yes, but the test was not sufficient.
> > 
> 
> Yes they were not but we ran the tests that were required and available.
> If bugs are found later we are responsible for fixing them and we will.

This is nice,


> 
> > 
> >> If you do not feel like fixing these bugs that is fine,
> >> let me know and I will address them,
> > 
> > Please do even if I don't let you know.
> > 
> 
> The way we use it we have not run into these unusual test cases. If you 
> or anyone runs into any bugs please report and I personally will debug 
> and fix the issue, just like open source is suppose to work.

but why personally ?  because Oracle products no longer use it ?
If so, why do you want to keep the feature with no user ?


> > 
> >> but removing the feature completely
> >> should not be an option.
> >>
> >> Plus Amazon has it's own closed/proprietary distribution. If this is an
> >> issue please configure your repo to not include this feature. Many
> >> distributions choose not to include several features.
> > 
> > The problem is that the buggy feature risks many distributions.
> > If not-well-maintained feature is really needed only for a single
> > distro, it should be rather maintained as downstream patch.
> > 
> > If no one is using it, no reason to keep the attack sarface alive.
> 
> Tell me one feature in Linux that does not have bugs?

I'm not talking about features with no bug.  It's fine to have bugs
if it's maintained and fixed in timely manner.

I'm talking about a feature with bugs that seems not to be used by
anyone nor maintained.


> The feature if used normally works just fine, the bugs that have been 
> found do not cause any stability issue, may be functional issue at best.

It caused memory leaks in some ways easily without admin privilege.


> How many applications do you know use MSG_PEEK that these tests are 
> exploiting.

Security is not that way of thinking.  Even when the bug is triggered
with unusual sequence of calls, it must be fixed, especially on a host
that could execute untrusted code.


> 
> Plus if it is annoying to you just remove the feature from your private 
> distribution and let the others decide for them selves.

If no one uses the feature that has bugs without maintenance,
it's natural to deprecate it.  Then, no one need to be burdened
by unnecessary bug fixes.

