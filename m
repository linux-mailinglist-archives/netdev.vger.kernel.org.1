Return-Path: <netdev+bounces-185772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48492A9BB19
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932CA4A8156
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207321B908;
	Thu, 24 Apr 2025 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lsycXQgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3B28DEE5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536276; cv=none; b=mrlVe+ue5sz4EgLpCLQK64OwzEfkt5jSW3bTTgD6PhwOwtxvkmOIaQ6pnWbydbh3moMk6WDNjeImB4sXFdrAR0SJHMI7L49wwoEyglTS4Tp44Zf+bxEr//GeQtNEnXWvO5vcqLLinj1ETXdPRYlVVBBep4Tz/IMpoUOB1cdIz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536276; c=relaxed/simple;
	bh=xPKGcgj1aneBqH5sDyxG924hsvE464fXN8ww28047t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/ZXnfLuFa+5uYiWESSmKCY6LW7tHQ6OQNC/FR5fhPWt5Us5tYauhZRrcsajkhrOLuLPKuLIOGQO5NqKtLb3KQJn+f7Kpo46q/u/+TiFk7iXSD2c6IOqR7Q6v1vMAdqDCepnR9sWY0WHErmnNjydAYo+fI3utgScpiBN+Omvqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lsycXQgG; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745536275; x=1777072275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM7LQO51LkELec3mppE0uqceiNEnpXIwVrMiO8t0mQA=;
  b=lsycXQgGjPjjscPAglbd/69YWQSdk8qgdXat3uFMY4s3e6DLavjW/LF2
   G7VG/Mu7ygJpidreTSokmAuXQ37N6KYAKIYnqEfdru2MVSw3hyGZIERqj
   cKxlAJVwAErBuw9Bd5IRqSEvsryTSpB7VOM0h6nmn+ThkQKslYEb1onZk
   4=;
X-IronPort-AV: E=Sophos;i="6.15,237,1739836800"; 
   d="scan'208";a="492415802"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:11:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:44513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.110:2525] with esmtp (Farcaster)
 id 87fe79df-9856-4a35-811e-5513dd26f9c7; Thu, 24 Apr 2025 23:11:10 +0000 (UTC)
X-Farcaster-Flow-ID: 87fe79df-9856-4a35-811e-5513dd26f9c7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:11:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Apr 2025 23:11:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 3/7] neighbour: Allocate skb in neigh_get().
Date: Thu, 24 Apr 2025 16:10:57 -0700
Message-ID: <20250424231059.70667-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c932825f-6249-48c0-bb10-8c5754e01f8e@redhat.com>
References: <c932825f-6249-48c0-bb10-8c5754e01f8e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 24 Apr 2025 10:29:19 +0200
> On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> > @@ -3013,23 +2982,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
> >  		pn = pneigh_lookup(tbl, net, dst, dev, 0);
> 
> pneigh_lookup() can create the neighbor when the last argument is 1, and
> contains an ASSERT_RTNL() on such code path that may confuse the casual
> reader.

Agree, I didn't like the ASSERT_RTNL() in the middle of the function...


> I think here you could use __pneigh_lookup().

read_lock_bh() is needed, but yes.

Only one caller passes 1 to pneigh_lookup(), and only pndisc_is_router()
calls __pneigh_lookup().

I'll clean them up in v3 too.

Thanks!

