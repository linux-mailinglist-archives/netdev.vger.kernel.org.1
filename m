Return-Path: <netdev+bounces-92813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC618B8F2C
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C48D283852
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4C130AD9;
	Wed,  1 May 2024 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HjUViFaA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C3130487
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585467; cv=none; b=jRFSLjb2IzgLCv0CAcsMWBf+ugMafFiuJ5WBkpp6P7rxOvkygZcvzNblCvW0dAa4yZEmaL5PShhnS77paPu3XrMTxx5EAz9/ombqaAdJGdsw+M4b7Lclb/gt/5ohzEjgudwC8+UpfqcrfGhZ6ehpYJ76xFdnON/e1dF85HpM9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585467; c=relaxed/simple;
	bh=+jyiZfeDwRUopuXx+laeRcnHhvIH25Y903wg1qnk78s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdzIm6Lr2LfqxqRoZJGdhHBihgr21nkgWi6WFwEvGt8N52mU1JGclBvyYKcbeWQgedKeVEvMi8iZHDNctL2HFBQcUDPlqevNFcuTVkgW/3E/naj/5vFo1aBaILpyo3IHJAwWZSul2GEXKOTHwgfMCdRzuPAFmx3G6FNIz5Ab6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HjUViFaA; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714585466; x=1746121466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZXrSp7ZU0ulx0HiDCasbiZMOchJY6SmXssMy9xDJQw=;
  b=HjUViFaArPnnBxWcljolRW1fWumNe5ttskecmwmFkUh3trmoNRxjMZVx
   zHhiFQBS3Tt4peBnH7mmMlnGlksdxf+PlAnp1f3Yyy4y5lgO96CR6Ah1A
   or8tCp86YHw/8JKuq1cEgMu0VxjYyVxI7lOcguo51Ai7po3ufoW4CbILP
   A=;
X-IronPort-AV: E=Sophos;i="6.07,245,1708387200"; 
   d="scan'208";a="722801573"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 17:44:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:6727]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.142:2525] with esmtp (Farcaster)
 id 370236e8-9687-415c-aa8b-d868a1403eaa; Wed, 1 May 2024 17:44:20 +0000 (UTC)
X-Farcaster-Flow-ID: 370236e8-9687-415c-aa8b-d868a1403eaa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 17:44:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 1 May 2024 17:44:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <anderson@allelesecurity.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: use-after-free warnings in tcp_v4_connect() due to inet_twsk_hashdance() inserting the object into ehash table without initializing its reference counter
Date: Wed, 1 May 2024 10:44:08 -0700
Message-ID: <20240501174408.29678-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLSg8dwgbY6jAKUFyg7SbCcbmWOby3+evN3-5ONrMWEZw@mail.gmail.com>
References: <CANn89iLSg8dwgbY6jAKUFyg7SbCcbmWOby3+evN3-5ONrMWEZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 19:01:35 +0200
> On Wed, May 1, 2024 at 6:52 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > This looks good to me.
> >
> 
> Is it ok if you submit an official patch ? This is getting late here in France.

Sure thing, will do.

Thanks!

