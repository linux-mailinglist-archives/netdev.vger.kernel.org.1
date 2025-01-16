Return-Path: <netdev+bounces-158745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDAA131F3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEAC3A368B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C51126C05;
	Thu, 16 Jan 2025 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZyHLGhAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D154414
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737001187; cv=none; b=lz9BcJrE0GBQhCaI6fnymLJOrSZ7zS2lL7QloSBw3picheB4mHk+z7JbfO7E6gueKQ1RczaApr2YgM8CPV3XD4Foqmf0jETCrDku7rioGjPMhEh5WwAhXxP7Al5M5U/eERSUXmd/L3RDq1F9sr4x3N7yWB0MniNd81VzOt6KBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737001187; c=relaxed/simple;
	bh=VkOIvHv5jZ3jVrT4mM0LLOO+5feGQ5Z/g6afce0j4gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St63OwgKrNiZ/ZZ9bP3quBdsIsyhpHj9Sk46d8xgymXEhNYH/NB/JKVn1Kmn39hVAi8JjR+a7hZsHgRbQPpgssXKnmdJ8ntVNf9dP4qrbZRLKjPilswCCe2loeoUfhWxXc7IXNpJ7hPO3qojW57LbyLOz88kLzVwaTVLP3dZ7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZyHLGhAU; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737001186; x=1768537186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6plv1QLb1+58mwiS+TwSTRGDr/06IgLPCmgiO1QaMlQ=;
  b=ZyHLGhAUHIjNCzHdsEPWsL30HQPT7iyXyF8zw3gnFH0gt3YWlJdqRV7U
   /OwbxoDBFAPeOYiluDHe4rbvxgs0FZ2Bv5eoumjRTupiOsgz1DvHobJIR
   yavjubqwdgBtQ0iG49dbTs/9ftILPYI64ToPRDeEIPyw+ML9VHywbEEPa
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="454606666"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:19:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:20398]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.193:2525] with esmtp (Farcaster)
 id 9f92ecd9-7167-4706-bfcd-8eea7236be0c; Thu, 16 Jan 2025 04:19:41 +0000 (UTC)
X-Farcaster-Flow-ID: 9f92ecd9-7167-4706-bfcd-8eea7236be0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 04:19:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 04:19:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jdamato@fastly.com>
CC: <davem@davemloft.net>, <donald.hunter@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 00/11] af_unix: Set skb drop reason in every kfree_skb() path.
Date: Thu, 16 Jan 2025 13:19:28 +0900
Message-ID: <20250116041928.97203-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z4fynNxk3FJ8BCWA@LQ3V64L9R2>
References: <Z4fynNxk3FJ8BCWA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joe Damato <jdamato@fastly.com>
Date: Wed, 15 Jan 2025 09:38:36 -0800
> On Sun, Jan 12, 2025 at 01:07:59PM +0900, Kuniyuki Iwashima wrote:
> > There is a potential user for skb drop reason for AF_UNIX.
> > 
> > This series sets skb drop reason for every kfree_skb() path
> > in AF_UNIX code.
> > 
> > Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/
> > 
> > 
> > Changes:
> >   v2:
> >     * Drop the old patch 6 to silence false-positive uninit warning
> > 
> >   v1: https://lore.kernel.org/netdev/20250110092641.85905-1-kuniyu@amazon.com/
> > 
> > 
> > Kuniyuki Iwashima (11):
> >   net: dropreason: Gather SOCKET_ drop reasons.
> >   af_unix: Set drop reason in unix_release_sock().
> >   af_unix: Set drop reason in unix_sock_destructor().
> >   af_unix: Set drop reason in __unix_gc().
> >   af_unix: Set drop reason in unix_stream_connect().
> >   af_unix: Set drop reason in unix_stream_sendmsg().
> >   af_unix: Set drop reason in queue_oob().
> >   af_unix: Set drop reason in manage_oob().
> >   af_unix: Set drop reason in unix_stream_read_skb().
> >   af_unix: Set drop reason in unix_dgram_disconnected().
> >   af_unix: Set drop reason in unix_dgram_sendmsg().
> > 
> >  include/net/dropreason-core.h |  46 ++++++++--
> >  net/unix/af_unix.c            | 153 +++++++++++++++++++++++++---------
> >  net/unix/garbage.c            |   2 +-
> >  3 files changed, 154 insertions(+), 47 deletions(-)
> 
> I know there's feedback from others on some parts of this series but
> I wanted to say thank you for the detailed commit messages that
> include python examples.
> 
> I found that very refreshing and helpful when attempting to review
> the code you've proposed; thanks for putting in the extra effort to
> include those examples in the commit messages.

Thanks, Joe.

The goal was to give full information in the commit message and
the drop reason comments so that user can reference it and will
never ask why skb was dropped.

Now I think the part of the effort should've put into man-pages
instead ;) (and will do)

