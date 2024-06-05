Return-Path: <netdev+bounces-101104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFB8FD5CE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F76284E04
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5581482C3;
	Wed,  5 Jun 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JI/5z64p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863862F2B
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612421; cv=none; b=kFWEjNHRUyrVr+wCbZMwI7PHpcNIKk08QS8zBp2nO9vWdyl4KvMwRjuKptC98mkkiszE+KpR/4Goop9fzsTfURnaAqvhIKl7OguuFpz3saN4jJcqZ21Y2NrPVsigMfcV9Y/TJIHRSY0ZmTiqD0pXLo73DjBdkEAGNeWqQYnOVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612421; c=relaxed/simple;
	bh=lwE4QAyKMN1unc1NeXZWilsAffXJ1VSKXDM/s2DDIus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H25F7GM5ESSjBf9nBCip5YI0k80sOcNQ3rWrybdTYLn7TlQuvyhhJPXO06/QsF3DUMRl/a451AXIvIx3ixnWuxAE7Qdble+tNyTmETgVHiqteY5joXs2lzgh4wT5dUXBMZdLfhJ0JinM+7Ai3FCAvtmrQOGrlD/VF2dVu/5rXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JI/5z64p; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717612420; x=1749148420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGFqC01waQFAQmoh45LPJp7FEunRUKP/Q/SqQALcA4A=;
  b=JI/5z64pQAXQGma6vNgt14UGLcdn31+/y2dvoKE6m+zqClAkb8OXRc0x
   Lu+4rUNgdODbzag+bRiJU6mz8SYJG19v5KYpEv9h1svHM6y3xNAcGYT2/
   TEUgOutJedaDGQfcEuFv4ezYWckUyw7Ohp90rJ35iDK5XG4vbzth5yklT
   E=;
X-IronPort-AV: E=Sophos;i="6.08,217,1712620800"; 
   d="scan'208";a="94629378"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:33:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:64856]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.213:2525] with esmtp (Farcaster)
 id 14f810a3-b235-44cc-828e-91c768ddb2f5; Wed, 5 Jun 2024 18:33:38 +0000 (UTC)
X-Farcaster-Flow-ID: 14f810a3-b235-44cc-828e-91c768ddb2f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:33:32 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Jun 2024 18:33:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 3/3] tcp: move reqsk_alloc() to inet_connection_sock.c
Date: Wed, 5 Jun 2024 11:33:21 -0700
Message-ID: <20240605183321.28679-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240605071553.1365557-4-edumazet@google.com>
References: <20240605071553.1365557-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  5 Jun 2024 07:15:53 +0000
> reqsk_alloc() has a single caller, no need to expose it
> in include/net/request_sock.h.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

