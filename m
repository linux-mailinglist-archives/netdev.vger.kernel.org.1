Return-Path: <netdev+bounces-173781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58FCA5BA9A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C59168B37
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E1190674;
	Tue, 11 Mar 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rW2WwEP2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621891F12F2
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680874; cv=none; b=uOP2m+XZzLWzXi6A11QKMeUyzl4z0m42reDBF7KCVrbFhMFHJMZ6wpXRy7NBLyjRacvUtzs4ZrfyQxbadGp7JwEmFoHyLIOYbmJAW1SQVRXPg6M5TRBvVtM+SFhSBBtYE+grxza8QtpqUhuDg5Gklqo7q8fkGlVV+lhaih57xFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680874; c=relaxed/simple;
	bh=LI/HiRuCho8Inj1g+9gGLUKdeTg27lb5O3fYFbQsb5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7MwrzXaQkfSoHgOo4JXk+ss0WEKa9U1ZI35zQNfUx9gr+/9Oqr9KgBgTKoFIJmb50JW1UXxiDiXeel/cX6w/RIgcFbcIzo6Y28yCtWR8fqEx85I1VcbLme54RkNc5sasnJzYcla9+GhBDWUbVm1TXe9C3UNiO6MgnADUZbRNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rW2WwEP2; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741680873; x=1773216873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVgCvbpZ5ncFb4vBfT1cqXVfgji/55MEwXqUkX61CTU=;
  b=rW2WwEP2BIFlWd+kL/spypzPVz5mWbleIqUEN5Ue8/TdYG7oeBln5sZm
   j7EYtX/4BU/tqhXR21FTIzidS4Xoi8gaW60WJU4qJqM47gCofU11HuoB6
   904g9fAVhOCbkN1LGhzYgUKvWpOYpcZ5SXXpgGNI+ugRhqT9GdllYWIIs
   c=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="473992062"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:14:30 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:15562]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id efe2c2f7-adb7-4cd2-aea4-0708d2ce2a52; Tue, 11 Mar 2025 08:14:29 +0000 (UTC)
X-Farcaster-Flow-ID: efe2c2f7-adb7-4cd2-aea4-0708d2ce2a52
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 08:14:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 08:14:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <amcohen@nvidia.com>
CC: <horms@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <olteanv@gmail.com>,
	<pabeni@redhat.com>, <petrm@nvidia.com>, <tobias@waldekranz.com>
Subject: Re: [PATCH net] net: switchdev: Convert blocking notification chain to a raw one
Date: Tue, 11 Mar 2025 01:12:50 -0700
Message-ID: <20250311081418.12713-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310061737.GA4159220@kernel.org>
References: <20250310061737.GA4159220@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Mon, 10 Mar 2025 06:17:37 +0000
> On Wed, Mar 05, 2025 at 02:15:09PM +0200, Amit Cohen wrote:
> > A blocking notification chain uses a read-write semaphore to protect the
> > integrity of the chain. The semaphore is acquired for writing when
> > adding / removing notifiers to / from the chain and acquired for reading
> > when traversing the chain and informing notifiers about an event.
> > 
> > In case of the blocking switchdev notification chain, recursive
> > notifications are possible which leads to the semaphore being acquired
> > twice for reading and to lockdep warnings being generated [1].
> > 
> > Specifically, this can happen when the bridge driver processes a
> > SWITCHDEV_BRPORT_UNOFFLOADED event which causes it to emit notifications
> > about deferred events when calling switchdev_deferred_process().
> > 
> > Fix this by converting the notification chain to a raw notification
> > chain in a similar fashion to the netdev notification chain. Protect
> > the chain using the RTNL mutex by acquiring it when modifying the chain.
> > Events are always informed under the RTNL mutex, but add an assertion in
> > call_switchdev_blocking_notifiers() to make sure this is not violated in
> > the future.
> 
> Hi Amit,
> 
> As you may be aware there is quite some activity to reduce the reliance on
> RTNL. However, as the events in question are already protected by RTNL
> I think the approach you have taken here is entirely reasonable.

It would be appreicated if Amit you can post a follow-up patch against
net-next.git to convert the rtnl_lock() to another lock or rtnl_net_lock().

Thanks!

p.s. thanks for ccing me, Vladimir!

