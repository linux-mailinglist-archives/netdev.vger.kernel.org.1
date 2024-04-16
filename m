Return-Path: <netdev+bounces-88487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A798A76FE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C00B23C5E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02896BB4B;
	Tue, 16 Apr 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GwkAjU7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CB5A0FE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304086; cv=none; b=bQhU8oCTgyrheC6Fg0igBCTZliV1hOV3rKVCe9AwHKRDREWHACjnlaalkV0K36Q6eP8xrXnmNNWuWK5WRHpkClHtQoYz6MZOCEeq4dsnFg+vHtJ0uaI8MRgUopjcX8y5kg+GG/vbYIeepOg8XC/owltfKuFSaspqUhFblUosF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304086; c=relaxed/simple;
	bh=d6niF+sgipG4o6Ff7645XIDKtkx4zw6l9sMfFLS+H1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHUx3hGVuMaEECsAT1FO90bW00z4fBRWPhEV+PBTComgIM8CAUEtkcZAAWgZALFMIoh53b1UFGvcZioJ/BPZBW95rKequpGLHaVz1mZCt+oZ2EaM5f/EWIhO3VjlY/7sWrhnOIb4iEtpnZaCtOXSmzfVohE/EF75cQzEK/i55H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GwkAjU7l; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713304085; x=1744840085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sk06AbukxPZ0nuylpfRyHUEtqWgbWjvDqPuo0FPIV2U=;
  b=GwkAjU7liJGir4OGTVwOblX2Y2JA7BEHl0c/SiThWhLQPgx9Mow+f5Rb
   VcWb1yzcLokFDKNOC3HE8uOdYmV2dE+7ujk57zxxzSVr7oPJM9qm8zpzZ
   UkDY/e5M6ehpOXiXvsFKCS2ZWnjKPx0KWuJaS60GrPWaMAW9l7+h/YZYb
   s=;
X-IronPort-AV: E=Sophos;i="6.07,207,1708387200"; 
   d="scan'208";a="390204608"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 21:48:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:65388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.136:2525] with esmtp (Farcaster)
 id 0843cf85-1889-456c-9e43-78270767514d; Tue, 16 Apr 2024 21:48:01 +0000 (UTC)
X-Farcaster-Flow-ID: 0843cf85-1889-456c-9e43-78270767514d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 21:48:00 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 21:47:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
Date: Tue, 16 Apr 2024 14:47:50 -0700
Message-ID: <20240416214750.29461-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a7fe079c-5ed7-4ff6-a127-adb34b2246f5@oracle.com>
References: <a7fe079c-5ed7-4ff6-a127-adb34b2246f5@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 16 Apr 2024 14:34:20 -0700
> On 4/16/24 13:51, Kuniyuki Iwashima wrote:
> > From: Rao Shoaib <rao.shoaib@oracle.com>
> > Date: Tue, 16 Apr 2024 13:11:09 -0700
> >> The proposed fix is not the correct fix as among other things it does
> >> not allow going pass the OOB if data is present. TCP allows that.
> > 
> > Ugh, exactly.
> > 
> > But the behaviour was broken initially, so the tag is
> > 
> > Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> > 
> 
> Where is this requirement listed?

Please start with these docs.
https://docs.kernel.org/process/submitting-patches.html
https://docs.kernel.org/process/maintainer-netdev.html


> 
> 
> > Could you post patches formally on top of the latest net.git ?
> > It seems one of my patch is squashed.
> 
> I pulled in last night, your last fix has not yet made it (I think)
> 
> [rshoaib@turbo-2 linux_oob]$ git describe
> v6.9-rc4-32-gbf541423b785

Probably you are using another git tree or branch.

Networking subsystem uses net.git for fixes and net-next.git for new
features as written in the 2nd doc above.

My patch landed on 4 days ago at least.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=283454c8a123072e5c386a5a2b5fc576aa455b6f

Also you should receive this email.
https://lore.kernel.org/netdev/171297422982.31124.3409808601326947596.git-patchwork-notify@kernel.org/


> 
> > 
> > Also, please note that one patch should fix one issue.
> > The change in queue_oob() should be another patch.
> > 
> 
> I was just responding to your email. I was not sure if you wanted to 
> modify your fix. If you prefer I submit the patches, I will later.

As I said, my fix is already in net.git, so you can post a separte
patch based on net.git/main.

