Return-Path: <netdev+bounces-157194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05521A09509
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB11B188B175
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BE211473;
	Fri, 10 Jan 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gXAyPwNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BA211466
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522571; cv=none; b=WLwRrBl4hwwzFtDxA0INCI7lAfZY1D6BJPX6X9CTswdwYKsrhJ7IWEJZXrobDfCQV0wmScsAm4Wfv4rfo0j1BYziuDc5mbUxEPQKsfgwHwdyJhrO2tH50mZuC93B7En+sRpCSlhf4hFB4vOUxU9fQCb4bAQ0tH6hoStf0bc+hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522571; c=relaxed/simple;
	bh=QIjRhOyApHpX7F86Ny7bX200ViZx1QInc3zvK/EFakc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz2viOIW9odZXlKhOaOmE5t94I3abY9bvFyBlM+nyAyOiwgNwt0iv0syFCGC9oTFaDpJc7GxFd/47KLzf4ImQbYthwzcXaiqimn16Kyh2CU+mI782eOZUUkn0nRuF/TCxPWVjU048AfwC+ApZVgHGLdmrUML1MOxr46YZks4SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gXAyPwNT; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736522570; x=1768058570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPawQPWM87TRkkWFDw4x5GLY47H+yk/ZM+19Hqs0rDQ=;
  b=gXAyPwNT/ARDMcHrvq0h2+Ka3ebV2f7EXndTiLP/m30lKEiAKQVknLrs
   92H6YkzLOCV+96In465ue6sdlNptPIL9l3Lc0/9MNs6wkktmj5UpCmcDI
   iQmip0WmeDGMRtim7qZ0vUryv+tpt5C/HudTuCdVn2ezN+WuwhgapOkLx
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="453283103"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:22:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:5855]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.114:2525] with esmtp (Farcaster)
 id 559f8995-577e-4f36-b85e-8f4ecc4089e9; Fri, 10 Jan 2025 15:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: 559f8995-577e-4f36-b85e-8f4ecc4089e9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:22:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:22:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <donald.hunter@redhat.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 06/12] af_unix: Reuse out_pipe label in unix_stream_sendmsg().
Date: Sat, 11 Jan 2025 00:22:31 +0900
Message-ID: <20250110152231.38703-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110114344.GA7706@kernel.org>
References: <20250110114344.GA7706@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Fri, 10 Jan 2025 11:43:44 +0000
> On Fri, Jan 10, 2025 at 06:26:35PM +0900, Kuniyuki Iwashima wrote:
> > This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
> > error paths in unix_stream_sendmsg().").
> > 
> > If we initialise skb with NULL in unix_stream_sendmsg(), we can
> > reuse the existing out_pipe label for the SEND_SHUTDOWN check.
> > 
> > Let's rename do it and adjust the existing label as out_pipe_lock.
> > 
> > While at it, size and data_len are moved to the while loop scope.
> > 
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index b190ea8b8e9d..6505eeab9957 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> 
> ...
> 
> > @@ -2285,16 +2283,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >  		}
> >  	}
> >  
> > -	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
> > -		if (!(msg->msg_flags & MSG_NOSIGNAL))
> > -			send_sig(SIGPIPE, current, 0);
> > -
> > -		err = -EPIPE;
> > -		goto out_err;
> > -	}
> > +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
> 
> Hi Iwashima-san,
> 
> I think you need to set reason here.
> 
> Flagged by W=1 builds with clang-19.

Hi Simon,

I didn't set it here because skb == NULL and kfree_skb()
doesn't touch reason, and KMSAN won't complain about uninit.

Should I use SKB_NOT_DROPPED_YET or drop patch 6 or leave
it as is ?

What do you think ?

Thanks!

