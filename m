Return-Path: <netdev+bounces-64907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263583766F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF519283BD9
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751CFC19;
	Mon, 22 Jan 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l9KmKkNh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6690FC14
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963239; cv=none; b=bpigGExqCuLN0J/dzxj5jBI2k3Q0djQk9g7MYIpDL8sMoRNUbrV+qL+hZbGnbFhTqKXKdAmSSiPcItmgT7aqQME9CSugphM2dzaFT06Mubs24YAJ0USVqDYCWiPlI5++bChNOChS4Dct9Gyn6xSEewTX5bvo0TGvp+PVrP17YLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963239; c=relaxed/simple;
	bh=XBKr7byk/R6TNadC5jtrLtUk4cU3Hx1FzeA21D3Nthc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5BU4Jg4Vi8exVgoNEjeVg4XprpBHFZl1zQlgk+2HUVT3i6lm2omPrk9g0hZ7qbcC7pcDn/pblSIBQeDCDxtoqXgfo58QKUiEeutGHb9J0ih1h5nIQgzUf5Hvs9uQmgsxL6PqVs+kby4fPN+9y3umbYBmFXctLGtTg0N7evKibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l9KmKkNh; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963237; x=1737499237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzIyDd+8pkQgVr7H47btTAEarQJO3dFWzV6ck479fw4=;
  b=l9KmKkNhs75VPRf1i5wfMUwNTSt+oGeIKVJKVxal1jzV9arRDQt9YSQR
   7UcZDtEgjr6P4Vv5PSSTS+mTqcgj27A8YyUbfxekZzUdBIWys+6zevTy3
   LsCpsCxjocCJBYDrWPrAgISxLT7RyYuMoKFhOOCJ9BrawLCLzmp7YvJ7g
   4=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="60347015"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:40:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 6A88EA0C19;
	Mon, 22 Jan 2024 22:40:31 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:48376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id 86873c05-ec1b-4fe6-956b-0cf490f9c166; Mon, 22 Jan 2024 22:40:30 +0000 (UTC)
X-Farcaster-Flow-ID: 86873c05-ec1b-4fe6-956b-0cf490f9c166
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:40:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:40:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/9] inet_diag: allow concurrent operations
Date: Mon, 22 Jan 2024 14:40:16 -0800
Message-ID: <20240122224016.19917-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-5-edumazet@google.com>
References: <20240122112603.3270097-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:25:58 +0000
> inet_diag_lock_handler() current implementation uses a mutex
> to protect inet_diag_table[] array against concurrent changes.
> 
> This makes inet_diag dump serialized, thus less scalable
> than legacy /proc files.
> 
> It is time to switch to full RCU protection.
> 
> As a bonus, if a target is statically linked instead of being
> modular, inet_diag_lock_handler() & inet_diag_unlock_handler()
> reduce to reads only.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

