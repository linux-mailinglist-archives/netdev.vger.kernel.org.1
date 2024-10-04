Return-Path: <netdev+bounces-132219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA0991006
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35521281BC5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF41E0E1B;
	Fri,  4 Oct 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MwSabDE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1A1E0E0D
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071406; cv=none; b=Mbuv9FC7ix/9t1k1A1RHY54P4vYTAlODg66zznGqcGeNkU/CiUSYP8yV6l9hWoSBznX1u+LlgpLkCyFDwHtoiull/9Y0uXldZiYzZm9GKn/grx+3fJkeJA3FzsvAbsGIkXpIqvPXw3ZmvmwnV1Nm9FK4f0DgttBOVLYMGueQTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071406; c=relaxed/simple;
	bh=eQ8qSH5pC6YPCKLHRoga4/WtOvfifhAW9DKiT5a4HjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eczC4XsJOHjTsPqRj+hCUFsMazTmrvJzMcqP8G4w8QsP7GN2yPz2PrmZLEeRLnh/E9+NQ68qER49+kw8mxa2Iy+hWmHcR0JePtDnYpQ9+hS3qc03Jrg99lQJEZ1RyxZJ9u/jpEeaRNOYEEwTzW8WBs9KRfkvrLDiURe2Qakl28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MwSabDE8; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728071405; x=1759607405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMi1LWrWymPz2BDO+9GqZMu78pC6KEnki7BNzfQa51E=;
  b=MwSabDE8U8BRfGWs4jIpYhGO1RHSXhp3EgZCkAzjA18vO3QY7uk+RQAD
   DUIADvS6uyJWZqw/Q60BsU/aD9p2kJW8HbdCBTfYxVLJOiOK42Yl1wFwE
   4CDfAOhgCxDEXTs3U48fEQ3RjOMgRZ0EV+Z86cV2KKxL6mkKnHN12+xJo
   A=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="339857342"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 19:50:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:16984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id 6f05aaeb-6203-482c-b912-20007d7b305b; Fri, 4 Oct 2024 19:50:02 +0000 (UTC)
X-Farcaster-Flow-ID: 6f05aaeb-6203-482c-b912-20007d7b305b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 19:50:01 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 19:49:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jk@codeconstruct.com.au>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <matt@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 12:49:51 -0700
Message-ID: <20241004194951.63498-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004090608.50f9f765@kernel.org>
References: <20241004090608.50f9f765@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 4 Oct 2024 09:06:08 -0700
> On Thu, 3 Oct 2024 18:00:48 -0700 Kuniyuki Iwashima wrote:
> > BTW what option is needed to reproduce it ?
> > I tried W=1 C=1 but didn't see that warning.
> 
> Are you doing allmodconfig?
> I think it may be a Kconfig option. DEBUG_SECTION_MISMATCH ?

TIL DEBUG_SECTION_MISMATCH :)

now I see the warning, thanks !

