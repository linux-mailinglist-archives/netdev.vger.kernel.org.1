Return-Path: <netdev+bounces-72549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16F858822
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC3E1C21A59
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A4F1420DE;
	Fri, 16 Feb 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UP1ZaGDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA61420B8
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119749; cv=none; b=sfonCrt06o7qgx0Wt40Ig8+1s8kOnwDc05g5IJbQ3yoQ4uLFOQuy8nZ8XiEwdDZGxcYKAIBjsdAq/v/vrL/Po7ldUSXRLHjK7oetes+KfH5NDaqjR9A5Qv2MVSqQpP8wBZF70HgeRuUTbWQ8ZQpM7fANnrd5IqRmIYJcdnWNmJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119749; c=relaxed/simple;
	bh=rBzw8yAJBztTTmAlDVNzqyijNm4nd3oPLD+rvqYltUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATWKyxIAP5bauuL0aKSFuL9ReeMPlZtu1fz9NDMhGMiSsGFYfQHXlo+6iPjVMs/y/28/U5Zenoq27Pru1G/AYmpOcIab+8ZCIUVkECne+N0kWrvsT5pu4T3YUn651gE2Y+5EJRqHDKMLYPwiyhiefo/usn8zGVfCFp96Vujf3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UP1ZaGDn; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708119748; x=1739655748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JgN0y6hlHr04hRc83LW9k5TZF7Mr3hmwnzpPKJllOg=;
  b=UP1ZaGDnBvSMCEVQKRuOICLGr8VcYIqyR3aTMtSwvIEh1BXd0FMRsaq7
   i2/TDFvx6APvq77nU9IFEGiS0wPMtDOi5JkkdJMUC7cE23UHO7SxjMAAN
   X3be+gerK+DSRzuifzqlH5ogaa0ihsuuNwQ9fHJncbgQcTLgO3pdwLulo
   0=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="705476921"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:42:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:5138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.112:2525] with esmtp (Farcaster)
 id 42189fc3-b8ee-435c-b50c-e86f7c7808fd; Fri, 16 Feb 2024 21:42:21 +0000 (UTC)
X-Farcaster-Flow-ID: 42189fc3-b8ee-435c-b50c-e86f7c7808fd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:42:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:42:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 00/14] af_unix: Rework GC.
Date: Fri, 16 Feb 2024 13:42:09 -0800
Message-ID: <20240216214209.69408-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+oURrHhvODH0U9gzR869r_3EK5zuRBNYAV_Frrj_3GRA@mail.gmail.com>
References: <CANn89i+oURrHhvODH0U9gzR869r_3EK5zuRBNYAV_Frrj_3GRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 22:28:11 +0100
> On Fri, Feb 16, 2024 at 10:06 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
> > the underlying struct file of the inflight fd gets its refcount bumped.
> > If the fd is of an AF_UNIX socket, we need to track it in case it forms
> > cyclic references.
> >
> > Let's say we send a fd of AF_UNIX socket A to B and vice versa and
> > close() both sockets.
> >
> > When created, each socket's struct file initially has one reference.
> > After the fd exchange, both refcounts are bumped up to 2.  Then, close()
> > decreases both to 1.  From this point on, no one can touch the file/socket.
> 
> Note that I have pending syzbot reports about af_unix. (apparently
> syzbot found its way with SO_PEEK_OFF)

Interesting :)

> 
> I would prefer we wait a bit before reworking the whole thing.

Sure, I'll wait to avoid a sad situation that large refactoring
happens to fix the bug and we need to backport or cook another
fix for stable.

