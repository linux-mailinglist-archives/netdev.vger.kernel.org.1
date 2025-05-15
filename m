Return-Path: <netdev+bounces-190840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF1AB90D7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC5A02B17
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511928642D;
	Thu, 15 May 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LNaKvDNq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D81F3FE3
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341511; cv=none; b=tdEnpZ8jV5f6J9sRzLNV0+DaEU9Hf5igukzlcc5+c1HcwbV9+0+0+aysHdm/MVjTHonkIOxgPfTpEQDcLKbdlXMizmyPkY9Ks203mRT7UA9lRWUaMRbNglQp8fDvhNVlTt+6vMxs65uBzOs0eIZAlvsCMKv91xf7rfVvY52Uy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341511; c=relaxed/simple;
	bh=qGHx+y5lTQrcY6thgJO78xCvieCZ7juvBHTG0i2sIXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2UG0c/LVlgKSc5flyV0XASxHPFXEzW8ek4PmCvSxlh68tVYcnbZHmaKgIvD2rzUUlBB/zHjOV5Cpb02BA+Lugda8ZGvdlWfK9/eYFxBrjNH+k7GoNh/14YTTjT+ahwWZ8EnFOSpRirdMVN2GyhrrtbLIaAUTqBoT2hrbqWBDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LNaKvDNq; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747341510; x=1778877510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZzSjesrmJZeuTjOHZY8dkv0Ifm9toFdmTztRgiapKY=;
  b=LNaKvDNqMD1qnzIOLoHQ80M3qLmfBpeCqoH/mWatLtC21i1fUlPyH6dM
   tTgDI6krmstaPllk9uRX1J/FNy8zPH5ZIS7RvTQYlkMBf+Enf/+X6qz+7
   +//TbQswVOpIUajUMLwMh4eTj9orzsJRTNKKjIMp4wolAmL+30DsQW2LX
   hRP47yRR4hM/3WHGGc8tP98TkeESYkPQLEwTp3yzB4e5vWvTU35wqatM7
   uQ5Qzx10H3z8Do9yUZxIb63EDsos4kApJkJTSMsVD4xCHMrMUL5DRZlkx
   hlkXQ4/nNH7kSKJ/yZVK8GX8ElYDxqHReLo8D6oT7uXWixbewqoQqvOXi
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="492701896"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 20:38:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:57419]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id c8f70682-ff50-4e82-9071-494eae0bde36; Thu, 15 May 2025 20:38:24 +0000 (UTC)
X-Farcaster-Flow-ID: c8f70682-ff50-4e82-9071-494eae0bde36
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:38:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:38:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v3 net-next 8/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Thu, 15 May 2025 13:38:09 -0700
Message-ID: <20250515203813.86670-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68263fc569b91_25ebe529448@willemb.c.googlers.com.notmuch>
References: <68263fc569b91_25ebe529448@willemb.c.googlers.com.notmuch>
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

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 15 May 2025 15:25:57 -0400
> > @@ -1879,6 +1886,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> >  		v.val = sk->sk_scm_pidfd;
> >  		break;
> >  
> > +	case SO_PASSRIGHTS:
> > +		if (!sk_is_unix(sk))
> > +			return -EOPNOTSUPP;
> > +
> > +		v.val = sk->sk_scm_rights;
> 
> Same question about lockless reading of the field.

Same applied here and in other places, but all readers in sendmsg()
is under lock_sock().

