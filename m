Return-Path: <netdev+bounces-107066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE17919A26
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AAB1C21706
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A818509A;
	Wed, 26 Jun 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m4n7OPXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F8433B3
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439031; cv=none; b=fTRQFLqrTpmcoWYNC+mtyXIucIcED+EsRcSY+5VoXgON4DSdbsfe4RbRBsWXzbCXH3KtVPcG79yOagP1It4KSsn/ngJ/pSn49f6WSSZnrMTxhNA5fOjL90ZyHoqGaUB960nzwKZxJPTe1VGVLXLgjc+vghsiG/+fp2MDihagE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439031; c=relaxed/simple;
	bh=WGkvkJ6efkLUW3mhH8PW9wQnhzsVmXML/DU0Mkg3z/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A768Hl75z76xxBG4QwF2Zf9BX2kTN6EsA9gX39ql5brouxqQByGW8b8xhJJXkR05L+fgzNZE1m4l44IZk4F+ZJ7gGpPIpMWKsQ16fTvc0nt2x54pZh7p2MFltvEzQGzkBgfmd+pxVYrcH89M5OHAzc5/E9wpSEAxSZ6eRxp5sog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m4n7OPXK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719439030; x=1750975030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=le9mNK2H74pEO5C5p74eYUCOzmcErorJ8F7HzxXzWfY=;
  b=m4n7OPXKLVpuEp2bHr85mnBgiJFjxoC7SjeLIlT0iA2yTz4PVLthz+yA
   6oBu1DpPZ0ndjdn4LFMe7jYkREygWYVv8IDfpb6CGxIRL3o4e1kHhGfXV
   LMv2LasuKgygCrR9cwR8Zjht4fv4JI8JgRn3YdRBCUjL8JZMvB8f+2lhB
   M=;
X-IronPort-AV: E=Sophos;i="6.08,268,1712620800"; 
   d="scan'208";a="410374494"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:57:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:32633]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.187:2525] with esmtp (Farcaster)
 id eda9c4fe-9a96-4df4-a423-3ceafa2a1d0f; Wed, 26 Jun 2024 21:57:05 +0000 (UTC)
X-Farcaster-Flow-ID: eda9c4fe-9a96-4df4-a423-3ceafa2a1d0f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 21:57:05 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 26 Jun 2024 21:57:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Wed, 26 Jun 2024 14:56:55 -0700
Message-ID: <20240626215655.6414-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c550e27c-6a45-4219-98d8-f6d237c0674e@rbox.co>
References: <c550e27c-6a45-4219-98d8-f6d237c0674e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 26 Jun 2024 12:48:27 +0200
> On 6/23/24 07:19, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Sun, 23 Jun 2024 00:43:27 +0200
> >> I gotta ask, is there a reason for unlinking an already consumed
> >> ('consumed' as in 'unix_skb_len(skb) == 0') skb so late, in manage_oob()?
> >> IOW, can't it be unlinked immediately once it's consumed in
> >> unix_stream_recv_urg()? I suppose that would simplify things.
> > 
> > I also thought that before, but we can't do that.
> > 
> > Even after reading OOB data, we need to remember the position
> > and break recv() at that point.  That's why the skb is unlinked
> > in manage_oob() rather than unix_stream_recv_urg().
> 
> Ahh, I see. Thanks for explaining.
> 
> One more thing about unix sockmap. AF_UNIX SOCK_DGRAM supports 0-length
> packets. But sockmap doesn't handle that; once a 0-length skb/msg is in the
> psock queue, unix_bpf_recvmsg() starts throwing -EFAULT. Sockmap'ed AF_INET
> SOCK_DGRAM does the same, so is this a bug or a feature?

I guess it's kind of safeguard.

The retval 0 has special meaning for SOCK_STREAM as EOF/shutdown().
If we bypass 0-byte dgram to SOCK_STREAM sk, the application will be
confused as if the original peer has disconnected.

At least, -EFAULT avoids such confusion so that can only the true
peer trigger 0-byte via the saved ->recvmsg().

So, the requirement would be similar to scm handling, we need to
recognize the sockmap verdict and destination to support full
features.

