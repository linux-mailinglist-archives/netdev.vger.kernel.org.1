Return-Path: <netdev+bounces-168387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79955A3EBDE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13DC7A8B1F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5021CAA90;
	Fri, 21 Feb 2025 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UtK6GBaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E892594
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112468; cv=none; b=bbHlWncE01jr5X28kMjujj4mxNgz6ckm9MEWx8EoVZgz1tiUUxKYnBiodyALvhAlvEhQlZREJ++Sc3hqfesqePSqALYmdz/g9Xtbi6/63dCzqXgdG0Aq8opgpM1/7+zGFy/zulZcKZdV5bF4e8DFwvaKughjWMt+mlTQa21P8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112468; c=relaxed/simple;
	bh=7ldpYifthQP1rD2QV0Vflausx5IzdTBaOobQA4qJSpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQeI/7WgPfH1zn19BYjKlSKReWWZ3TRpM++FYNKnwbq7Yf1hVKs/lD5b7E517fmL1tAw86bQ08EypqXYetJPbXTth1VLG51YofYxg+KTNwoGb5pUiHuExdIPM3GFDLPWop1P6XQ9E92hr4bNcdpaPyaji5FYqSORVc981dW8jiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UtK6GBaY; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740112467; x=1771648467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DOZZ7VPDKnm1TPnv/K4YcgL7J4nMfoFiqREOgS1y6DQ=;
  b=UtK6GBaYFwPQ9hN7jD1v5dSDMDbt7tRRXZCqNjC4fC8pmWuRaRO+MblQ
   W6InF5j8k2Q37x7u+EHGo4pN3C/CJFQN6diyCdgpiswsyh6/dytFHIa5O
   fEFQRWJpJfXgbU/CWUk/mohyOEEaaSfbayTrPUpl2puTEfUPyd8kQ3PY9
   c=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="67978249"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:34:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:12899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 3572ab02-30df-415b-abba-93c080a7cdfb; Fri, 21 Feb 2025 04:34:24 +0000 (UTC)
X-Farcaster-Flow-ID: 3572ab02-30df-415b-abba-93c080a7cdfb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:34:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:34:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <aleksander.lobakin@intel.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <idosch@idosch.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] net: plumb extack in __dev_change_net_namespace()
Date: Thu, 20 Feb 2025 20:34:13 -0800
Message-ID: <20250221043413.81592-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <99d50d07-34af-4413-9748-5a286e430a3c@6wind.com>
References: <99d50d07-34af-4413-9748-5a286e430a3c@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 20 Feb 2025 16:11:43 +0100
> Le 20/02/2025 à 14:24, Eric Dumazet a écrit :
> > On Thu, Feb 20, 2025 at 2:22 PM Nicolas Dichtel
> > <nicolas.dichtel@6wind.com> wrote:
> >>
> >> Le 20/02/2025 à 14:17, Eric Dumazet a écrit :
> >>> On Thu, Feb 20, 2025 at 2:03 PM Nicolas Dichtel
> >>> <nicolas.dichtel@6wind.com> wrote:
> >>>>
> >>>> It could be hard to understand why the netlink command fails. For example,
> >>>> if dev->netns_local is set, the error is "Invalid argument".
> >>>>
> >>>
> >>> After your patch, a new message is : "  "The interface has the 'netns
> >>> local' property""
> >>>
> >>> Honestly, I am not sure we export to user space the concept of 'netns local'
> >>>
> >>> "This interface netns is not allowed to be changed" or something like that ?
> >> Frankly, I was hesitating. I used 'netns local' to ease the link with the new
> >> netlink attribute, and with what was displayed by ethtool for a long time.
> >> I don't have a strong opinion about this.
> > 
> > No strong opinion either, I always have been confused by NETNS_LOCAL choice.
> Yes, it's not obvious. Maybe it could be renamed before exposing it to userspace
> via netlink.
> What about 'netns-locked'? Does someone have a better proposal?

Maybe NETNS_IMMUTABLE and netns-immutable ?
Then we can say "The interface netns is immutable" in extack.

