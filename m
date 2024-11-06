Return-Path: <netdev+bounces-142562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29F9BF9D3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7261C217E1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7871DFD83;
	Wed,  6 Nov 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YAaiq/M6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B721917D7
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934955; cv=none; b=Vzh22wMgAFYng5cNWQfz9yc6Wt4At/Djog69pV7MbJefxKkAx+UmyoONPyGSQJnif2UwwonV4wro5JM3SPrP1yHwRaWKadRlFgD3vAy3ofjdm15xwjvOU5/i/cQW9R304IRHfAPqJVpMM+4bmqp6C2d+J/cUP3v0RPR/FFXvcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934955; c=relaxed/simple;
	bh=h28pP+bl6J1vvSbb/bqsvafDcKj3uFGIb6YcbrPTz6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWMfQOh26mU6yk0RnUH4hSx5gtAv1SGsfPlERbh6o9xm70Fy56jURzmkdqaK/EtMNfaJ6mIBRuTBhLweyXJhmYtjbe1ersCz5EMEqvaT33D4iZXMrOGwND4YTUwFtnOCtKAtUSItuNNOP+OZFem1xo3DRdexGMykuO28xc9uE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YAaiq/M6; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730934954; x=1762470954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcFcwoWcqzJsNFApYRR3u6dPxB17m2CYt3gH2zQ4+gs=;
  b=YAaiq/M68+ibBauIY94shkYO4Hh3vuAPkpuUuxUiAmqpnKeQXq5dhBgj
   0ULTy0ZUziAtNoU0NSBMbPNlBDkAgbHFMr+uxQ6HuFFKx1ZWEAUjQ+7jV
   re65bQBsHc3g2NpKGIstc5Ikm8cR299vMfkmdDmHF/6prADzdmZRh9Qto
   w=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="773381994"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:15:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:17334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id 3620c940-a14b-4e60-af51-2db1f31a040a; Wed, 6 Nov 2024 23:15:47 +0000 (UTC)
X-Farcaster-Flow-ID: 3620c940-a14b-4e60-af51-2db1f31a040a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 23:15:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 23:15:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 5/6] neighbour: Remove bare neighbour::next pointer
Date: Wed, 6 Nov 2024 15:15:40 -0800
Message-ID: <20241106231540.49433-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-6-gnaaman@drivenets.com>
References: <20241104080437.103-6-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:33 +0000
> Remove the now-unused neighbour::next pointer, leaving struct neighbour
> solely with the hlist_node implementation.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

