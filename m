Return-Path: <netdev+bounces-189133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3EAB0938
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52E74A4311
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0742222BD;
	Fri,  9 May 2025 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UBhFuKjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C945038
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765256; cv=none; b=oqKxfvtT4otV9rJHOoK4lLl/2rI8sLtrxJq4SdrNXq9b5xTXQRsINfnwPrIVuTx7gi46vfdc6WQA6eXl4DbobyNBvDIeBqQ+LakBTvuzvg9Hg/oNWxCF9omfu8/kP1v8OPuHGFXhGsUWD1Sro4kOJBQP7MElGBt2dUKUGsXnboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765256; c=relaxed/simple;
	bh=lRXs+btgAF22JonG0WjXB55OVOTHb44eCwBIXnZLCis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc+Rjd3B2n6UR/dkNoRN7O9BiUbthdSAMfO79zeASB1YD5o5DZZKYTh7OQfe/SO9SIpE6kfis/D747nNuDkk1bYxfeMZf/W+qfNmLhhzRN7Deqmw+a7uJc8UCIWFu5yS1m6rmOuZBc/OKeQfgnFvSFgN4jF+03QhlObYxZxkjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UBhFuKjb; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746765255; x=1778301255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6sD3KzXBTVKLiEOAJd5UURlCNDdOQUIVJ6ZFaNdIis=;
  b=UBhFuKjbXam/7mkDTO7EJyv5jzI9meI47wqrkIUl3G0RvvhgPFdNu2Ko
   6Ww6NHylppalfgCs6UPM/Ff/egGqw5ZP5bUixoO4Zzvxs3V2mnn/ptZOq
   sPnbZrxmRnFWN8OdX5WHYy6qt0AqxY8JO1JjBvrEHpKS5mxxxZtgyMljB
   rFCkhUHtacbrwSv6MbibkkjlR+nMhT8lTQ5mqEmwMlfzI+2N86seDnn1+
   54C2HfS2XULQ5c4xmbSLk1uIEa9oX0ema5Ihqp9ITTzsL26ypWah/rXHp
   Q1hxsnfAq5N/u1cFRzIg6ngrdDXmuutK3U3Yz7f/BwFAg3VzW0/8/F+Oi
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,274,1739836800"; 
   d="scan'208";a="490559616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:34:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:63426]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 4bbedb25-dffc-4697-aba6-11367dc5370d; Fri, 9 May 2025 04:34:10 +0000 (UTC)
X-Farcaster-Flow-ID: 4bbedb25-dffc-4697-aba6-11367dc5370d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 9 May 2025 04:34:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 9 May 2025 04:34:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 4/7] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to sk->sk_flags.
Date: Thu, 8 May 2025 21:33:52 -0700
Message-ID: <20250509043358.14640-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508201502.5bbbc51e@kernel.org>
References: <20250508201502.5bbbc51e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 8 May 2025 20:15:02 -0700
> On Wed, 7 May 2025 18:29:16 -0700 Kuniyuki Iwashima wrote:
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index f0fabb9fd28a..48b8856e2615 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -964,6 +964,10 @@ enum sock_flags {
> >  	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
> >  	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
> >  	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> > +	SOCK_PASSCRED, /* Receive SCM_CREDENTIALS ancillary data with packet */
> > +	SOCK_PASSPIDFD, /* Receive SCM_PIDFD ancillary data with packet */
> > +	SOCK_PASSSEC, /* Receive SCM_SECURITY ancillary data with packet */
> > +	SOCK_FLAG_MAX,
> >  };
> 
> 32b builds break:
> 
> include/linux/compiler_types.h:557:45: error: call to ‘__compiletime_assert_809’ declared with attribute error: BUILD_BUG_ON failed: BYTES_TO_BITS(sizeof(sk->sk_flags)) <= SOCK_FLAG_MAX

Oops, thanks for catching!

Will create a space like this in v2.

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index 371053316d2c..59c077df9eb8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -521,8 +521,9 @@ struct sock {
 #if BITS_PER_LONG==32
 	seqlock_t		sk_stamp_seq;
 #endif
-	int			sk_disconnects;
+	u16			sk_disconnects;
 
+	u8			sk_csm_flags;
 	u8			sk_txrehash;
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
---8<---

