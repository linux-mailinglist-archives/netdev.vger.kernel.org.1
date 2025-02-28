Return-Path: <netdev+bounces-170547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D79A48FE7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57AD3ACAF4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9328917A307;
	Fri, 28 Feb 2025 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="arL7HO2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584815A864
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715342; cv=none; b=LIasmS9rCHN6seUh8B/Rk4v/Z6ySC8fLqIxyJfb2EYA5jUxKrP54MCREtKoEVwFQZFmD5ixb2xOlXdTqdwlinCoWEyfk+VZ5fdQM4sTfCKZUxVghcwqgDKjBc3NuQouxRQ23qsFVFB++wxyQn5bPjk5jy06JqKTAXw1toeO2pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715342; c=relaxed/simple;
	bh=j++nHGrMJWsxk4w5hQ+xktvLxfFzZCX90SHmxhPx+7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jR2KRl+vB4rLk6nrQ5A1dtQfFt58DxpWcuXKdch42tl6A+Nm5dcY7d0I6Lbr6HCvtUfpxJHhwRb6YM10E5x25hLfXGdTqZgoZg/ekVQR7kDGGhXzFkctDiTd1U+DXTboWMloLpTKg6dB+wDaibKzHUvcrNJF+NENTyaYLnaB10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=arL7HO2/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740715341; x=1772251341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8q2bVhDYWAbEbIN9HzV28b8enHLX7UNsNGLVVJiBKQ=;
  b=arL7HO2/LScXSaMUFQwsl9TaHKQZS+WlUudKm9yJnCaCmrAVhQ3H5r8J
   Wkg0bdaYO8PSLHswb//SohtifONCSmnZFcatNPAd5i6Ae+cYXUjp3hlBv
   ZmC1rGL0q2UYDwlmFeLGimLRuOKsuYxOHR/yfikE3nM4RxQByBYIkzb3N
   A=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="497993310"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:02:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:47656]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id 45f9719c-7123-41f2-a7b3-d1f8affd52dd; Fri, 28 Feb 2025 04:02:14 +0000 (UTC)
X-Farcaster-Flow-ID: 45f9719c-7123-41f2-a7b3-d1f8affd52dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:02:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:02:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 02/12] ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by kvmalloc_array().
Date: Thu, 27 Feb 2025 20:02:00 -0800
Message-ID: <20250228040200.93325-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250227182256.73650a0e@kernel.org>
References: <20250227182256.73650a0e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 27 Feb 2025 18:22:56 -0800
> On Wed, 26 Feb 2025 11:25:46 -0800 Kuniyuki Iwashima wrote:
> > +	/* The second half is used for prefsrc */
> > +	return kvmalloc_array((1 << hash_bits) * 2,
> > +			      sizeof(struct hlist_head *),
> > +			      GFP_KERNEL | __GFP_ZERO);
> 
> Sorry for the nit but: kvmalloc_array(, GFP_ZERO) == kvcalloc(), right?

Aha, I forgot that and grepped kvzmalloc_array :)
Will use kvcalloc() in v3.

Thanks!

