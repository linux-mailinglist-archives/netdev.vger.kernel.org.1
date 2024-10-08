Return-Path: <netdev+bounces-133190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EB995440
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F52289253
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF21DF964;
	Tue,  8 Oct 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k02q1mBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074D38DF2
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404483; cv=none; b=LExNKz0e4hWm5102pRMjHNMVAQvHy2mPlLTQ5eMKiV8DKK9M4yYUHv54vRJeIBg2wdgOfi67Hi4h0zmffyoup18Rc+o8j/3CLOtXhCqllec4OppHbIuWmmoYsKSnyU9BlkzFQqQJGjOge42BwC4oixjaEmuFd0KmOhaGgV7pyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404483; c=relaxed/simple;
	bh=5+XoSyxkVxxvTW6ezmIZabUgV8bya1yToCqi5EkMC9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJBcFTtImU4lMsYptK1KVtDlqMZ4aL5+IAANuNa4y0Bz6zv2lXg4LxGZEq8gzI8Sg67zq4cKjbu7+BM+QqfvxxOFQnGbX7OZJJKN5jMb8DtVlJ/mIsVpy2DTAfpclgz3Rp+ICWOu9QZUrKCg837w7YXv1oBuL7PHto9myNxoa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k02q1mBf; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728404482; x=1759940482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gmgtlTiYXvQIpqAzgLXXJaYcdBXDLlUdBHIRT4nL3kY=;
  b=k02q1mBfeFvBOoIbxfuTMKPDkYag620YHR8DF0h6ZOjhTf+Ws1QBs0v3
   3GwldndIHu9rPp6YnQcU7ParVWvcnwhOMmWzMXOG/P+gOXo1AOF+KNklT
   iuEFCg7HtEPOs/o9hUqCnnUHQoS/1EZfHloUE3sCMba6ErMmsCNivDLcg
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="439210160"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:21:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:45944]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id a64ec248-3fd8-4fc0-ae73-4f67f4fa816e; Tue, 8 Oct 2024 16:21:17 +0000 (UTC)
X-Farcaster-Flow-ID: a64ec248-3fd8-4fc0-ae73-4f67f4fa816e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 16:21:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 16:21:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv6: switch inet6_addr_hash() to less predictable hash
Date: Tue, 8 Oct 2024 09:21:05 -0700
Message-ID: <20241008162105.94440-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008120101.734521-1-edumazet@google.com>
References: <20241008120101.734521-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  8 Oct 2024 12:01:01 +0000
> In commit 3f27fb23219e ("ipv6: addrconf: add per netns perturbation
> in inet6_addr_hash()"), I added net_hash_mix() in inet6_addr_hash()
> to get better hash dispersion, at a time all netns were sharing the
> hash table.
> 
> Since then, commit 21a216a8fc63 ("ipv6/addrconf: allocate a per
> netns hash table") made the hash table per netns.
> 
> We could remove the net_hash_mix() from inet6_addr_hash(), but
> there is still an issue with ipv6_addr_hash().
> 
> It is highly predictable and a malicious user can easily create
> thousands of IPv6 addresses all stored in the same hash bucket.
> 
> Switch to __ipv6_addr_jhash(). We could use a dedicated
> secret, or reuse net_hash_mix() as I did in this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

