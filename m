Return-Path: <netdev+bounces-64305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F9832328
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 02:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B181C228EB
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA33ECE;
	Fri, 19 Jan 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D7EYvuM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B6EDF
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629117; cv=none; b=ECPJvP0LMN8V/KrJJN1Bti6qHpktU6KVrIEgYlDLfYzVF5RlRP90W4D/3yhYlYx6w9FqnJl/mbswwMgAtzM4DwUo6FBnXO+TtSqmf97k9KxnVSYlIXG/yHbgtNti8z+4y5V6rZYI5J139kVTA0YySFZuR6zaQtN53G+CS1qlkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629117; c=relaxed/simple;
	bh=k6xxsz7v/s73K4yECEmouBgGV6ursdmMD2QW8V7L6g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BofcSTpk5CjiEvfvbdqG/cYRQjCkhioNKQzBm9Z5zkunS3XaU+mgRZZwKlMG2lgXZAg6peTdeBRxpi1M9ijFmkeP4UrFekpyO3uAqa/zVNYOoAVd0VihrqwKs1BnSAOK5n2HXfewiEwsjqIoGsG70SbIeFVRP4P6/pos7HlLem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D7EYvuM/; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705629116; x=1737165116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6xxsz7v/s73K4yECEmouBgGV6ursdmMD2QW8V7L6g4=;
  b=D7EYvuM/ioSzW6LNC1AguBTby8UJ/xpERyUZ3Y89PSfEJ5oVQNREaLM0
   9YkqvT8wUTlTKQQPc9A1sPQ4hkg5SR8nj4/r9O23CXNNWl7oPOCtcdVCj
   akr+xLf1CJURzqT3VmDMQBkW9af8dNst654JTxHYpV/HgtsrkdsE3XhgO
   M=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="380753584"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 01:51:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id EF8C866E76;
	Fri, 19 Jan 2024 01:51:52 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:52817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id facefb15-06e8-469d-87f9-df3eb76fe4d3; Fri, 19 Jan 2024 01:51:52 +0000 (UTC)
X-Farcaster-Flow-ID: facefb15-06e8-469d-87f9-df3eb76fe4d3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:51:47 +0000
Received: from 88665a182662.ant.amazon.com (10.88.183.204) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:51:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<paul.gortmaker@windriver.com>,
	<syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] llc: Initialise addr before __llc_lookup().
Date: Thu, 18 Jan 2024 17:51:37 -0800
Message-ID: <20240119015137.61367-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240119014149.60438-1-kuniyu@amazon.com>
References: <20240119014149.60438-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

> llc: Initialise addr before __llc_lookup().

I just noticed after hitting Enter that I forgot to change Subject :/
I'll post v2, sorry for the noise.

pw-bot: cr

