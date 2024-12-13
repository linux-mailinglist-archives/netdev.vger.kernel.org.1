Return-Path: <netdev+bounces-151635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE29F0654
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BA2165CAC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301571A7ADE;
	Fri, 13 Dec 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oDR3qk08"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D2186607
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078418; cv=none; b=urdl127hUnQc30ofyVYqAJ4m+Pem6/fu1egDAIYc2y+pVrV6ghlNcWZDpjnMN0X5mtx+yg356rFR9IwYm+kpZuFYcMAmxKd0l+VRcZaWkt9DLfJHrRkkYD+ncQX+tJzzZX9PJ3Oil2uKOc2J+n6Xku/70voVbhybW1krD5kfA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078418; c=relaxed/simple;
	bh=g4ZjHgb6qRx2hgQvpSYhqwqC7d8FhiX2QBdaokGdL5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbzb5+SxsHRhPnwYOkXyllswAKXA7MSGTYtOxiiOKYRGWnyKe9+0nbzyEce5P+PjkqZ7CxhYhFwn+LYMyrDfWPVCif9eb8tinGKNNSjbISrV+i9UOepoGC9PuRepPxCb3AaE/TwEFAKXB72QVJv58XxmtoAPXmPljCn/WahJW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oDR3qk08; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734078418; x=1765614418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMxQ4x3EdXtmTfI2bbfnv5IQEjgtPKDf2Bd4Nd8CiLk=;
  b=oDR3qk08UhVm0c0X9DWH8ocHhG/go/3M9NV7ystxe/dyVK7rTVowKZ0x
   d/7pbU4cl2tbgIt8ZMnIpylhrfU/o6JWTCzlREf1RL3PusfF2U6DWnGzT
   awiUS1G5m8n1G9OWDpeq2BgtEFDWWYXXdIYYqIzR6/gqSUzurlKccZFc7
   E=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="783103476"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:26:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:27191]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.250:2525] with esmtp (Farcaster)
 id 04bb1600-e318-4f74-a1dd-729597a9e6af; Fri, 13 Dec 2024 08:26:49 +0000 (UTC)
X-Farcaster-Flow-ID: 04bb1600-e318-4f74-a1dd-729597a9e6af
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:26:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:26:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 14/15] af_unix: Remove sk_locked logic in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 17:26:42 +0900
Message-ID: <20241213082642.7931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f2b838e4-1911-48c1-9a7e-fe476f763def@redhat.com>
References: <f2b838e4-1911-48c1-9a7e-fe476f763def@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 10 Dec 2024 12:42:04 +0100
> On 12/6/24 06:26, Kuniyuki Iwashima wrote:
> > @@ -2136,27 +2133,21 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> >  			goto restart;
> >  		}
> >  
> > -		if (!sk_locked) {
> > -			unix_state_unlock(other);
> > -			unix_state_double_lock(sk, other);
> > -		}
> > +		unix_state_unlock(other);
> > +		unix_state_double_lock(sk, other);
> >  
> >  		if (unix_peer(sk) != other ||
> > -		    unix_dgram_peer_wake_me(sk, other)) {
> > +		    unix_dgram_peer_wake_me(sk, other))
> >  			err = -EAGAIN;
> > -			sk_locked = 1;
> > +
> > +		unix_state_unlock(sk);
> > +
> > +		if (err)
> >  			goto out_unlock;
> > -		}
> >  
> > -		if (!sk_locked) {
> > -			sk_locked = 1;
> > -			goto restart_locked;
> > -		}
> > +		goto restart_locked;
> 
> I'm likely lost, but AFAICS the old code ensured that 'restart_locked'
> was attempted at most once, while now there is no such constraint. Can
> this loop forever under some not trivial condition?!?

Sorry, I forgot to restore if (!timeo) condition.

The at-most-once-loop was introduced by 7d267278a9ec that allows
us to queue skb for SOCK_DEAD socket..

I think this patch should be separated from this cleanup series.
Will drop this in v2.

Thanks!


