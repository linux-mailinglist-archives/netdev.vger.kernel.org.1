Return-Path: <netdev+bounces-190842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3FAB90F3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6254F4A8370
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD7212FAA;
	Thu, 15 May 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hpl8gnEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073E1F9A8B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342237; cv=none; b=phCcuGvLG3O8mRuP52a63mgO7UiLqKk3VUCBZ5zX2bsuAJNfOQDkUjeCPu+WkRRRcfF55e6GyKfVZmGvsq347tMJwEyzPUtpEtc3WHJyapsxsFflYP4ZUYTx4FGVN0vrj0inYD0uYjsNkd0+9M4PI8xMuXRHwhENNzP3dF0/FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342237; c=relaxed/simple;
	bh=avsKp5uOY2zyX+tMIonJ9qGA1CWiEn8pjPgNT4c7Ol8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0PycldFggdY6bq/PM/RtB8rwmcr/fiXfMZATSaEnFHNHzv7tJVcgdbSakNO655SdhoIKq1MTayJ68yh5/qJ7Cp0TA3QgnMlPveGzMkaBixFPxkz2AQjf0ESsEEUaXpm052QcQb82cToSdfMzU/RKO4y8HSuyRkdZqoXcXEpa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hpl8gnEt; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747342237; x=1778878237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8WVyajH9ZdL6ShYY1kYCOWWdR5Q6+o96QLFXMb+Hx8=;
  b=hpl8gnEtRpTm9W+9TNdW0b6V8tfraJwWl1gTzRN0I3pQeN9hQ7UUYaj5
   Ue6ckwrE7ubB9YrLeWAJUoTVprPxP9Wp1iknTtZ1+uP7dDujZMW4GmIkf
   NpDi9zCksbMQDAwkTqjlkf/mvyo0vRfwP1Nj4Zf5QSY/SW37i5ZTUb5Ao
   57iHNU0l1Bfy7LOX5GuQlXO3NnVPWLzTdu7pXidkknJxZxTxz3J+Umcxg
   kkQ0dPnljmsV4dsABDWfjnFVKuJmGXt9dAVwAerVw/GyiB5E0VG9Zc3Wt
   tCUTO3FP4JLiAOzM5arA/R5L3Kcy7mJfjHzzVrSC+ET46n/PhTFEa0B8a
   w==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="20216963"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 20:50:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:6935]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id a404ff2a-0915-4870-a709-cd40a6c1c8c3; Thu, 15 May 2025 20:50:29 +0000 (UTC)
X-Farcaster-Flow-ID: a404ff2a-0915-4870-a709-cd40a6c1c8c3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:50:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:50:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v3 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Date: Thu, 15 May 2025 13:50:08 -0700
Message-ID: <20250515205016.90052-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6826401ac346c_25ebe5294c3@willemb.c.googlers.com.notmuch>
References: <6826401ac346c_25ebe5294c3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 15 May 2025 15:27:22 -0400
> > @@ -227,10 +297,18 @@ void __send_fd(struct __test_metadata *_metadata,
> >  		.msg_control = &cmsg,
> >  		.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd)),
> >  	};
> > -	int ret;
> > +	int ret, saved_errno;
> >  
> > +	errno = 0;
> >  	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
> > -	ASSERT_EQ(MSGLEN, ret);
> > +	saved_errno = errno;
> > +
> > +	if (variant->disabled) {
> > +		ASSERT_EQ(-1, ret);
> > +		ASSERT_EQ(-EPERM, -saved_errno);
> > +	} else {
> > +		ASSERT_EQ(MSGLEN, ret);
> > +	}
> 
> Why is this errno complexity needed?
> 
> It should never be needed to manually reset errno.
> 
> Is the saved_errno there because ASSERT_EQ on ret could call a libc
> function that resets errno?

I guess it's paranoid here.

When ASSERT_EQ() calls TH_LOG(), it always fails and does
not reach the 2nd ASSERT_EQ().

Will remove them.

Thanks!

