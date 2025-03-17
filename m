Return-Path: <netdev+bounces-175432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8636CA65E8C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71CD16D5EE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6671DE89E;
	Mon, 17 Mar 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pnhlwah4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6B3D6A
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241482; cv=none; b=nrUWUNzHpsEnjvWwSDUe5sifGkY24LLYZWMRmyM+OxhhFDR/dze5sTfepLcw85sXEdO921sXQhlPpPWpkVQCX2n6aXPxySmdeVMgxom3oaEfO6BactDnPgGTzToFbvzOhfmMNl0MmDUL7ASiqH9Zn0WB2qHYncp8eQXvVCpu3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241482; c=relaxed/simple;
	bh=SZMOCdz359nw8K9zz5oy/oTqOCVZkrnKGyD0kiy8sIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVcd/I52dzncQd6SMyNulGaidKCHNS/WCaN8JLxqD1DCx/hJ37oO2cNeK+CH0uyD1Dsaxvg/Euec7h3424GGpa4VfF3ofCMo5HyRjmT2gsx4PKhDZd173qc53reb+5R2PgTcXxsNofaIcUKWpv3pJimFByjRla4O5SI3umTs/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pnhlwah4; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742241481; x=1773777481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hnys+4w7JaDZJoiSNzga74MhFr+o06T6yF/smS2bTaA=;
  b=Pnhlwah4Hz6d+2t6k5wPeo5b5fwHONcx5NNOSverDXZbssGjJVxt0T7K
   1Ryb48+SDL6YAx9X+joRr8oMBGBmaKnHbe2Td+cLArBCixegy459lc7Ik
   YMHCFptxbnH2040QAfoRAXmHC/+w0u92tl2UopF92AJhwqM2r5638Qoeo
   w=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; 
   d="scan'208";a="481155938"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 19:57:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:34560]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 96c03ca4-7198-452a-8448-dacf3cc818da; Mon, 17 Mar 2025 19:57:57 +0000 (UTC)
X-Farcaster-Flow-ID: 96c03ca4-7198-452a-8448-dacf3cc818da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 19:57:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 19:57:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
Date: Mon, 17 Mar 2025 12:57:28 -0700
Message-ID: <20250317195741.21337-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312083907.1931644-1-edumazet@google.com>
References: <20250312083907.1931644-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Mar 2025 08:39:07 +0000
> tcp_in_quickack_mode() is called from input path for small packets.
> 
> It calls __sk_dst_get() which reads sk->sk_dst_cache which has been
> put in sock_read_tx group (for good reasons).
> 
> Then dst_metric(dst, RTAX_QUICKACK) also needs extra cache line misses.
> 
> Cache RTAX_QUICKACK in icsk->icsk_ack.dst_quick_ack to no longer pull
> these cache lines for the cases a delayed ACK is scheduled.
> 
> After this patch TCP receive path does not longer access sock_read_tx
> group.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

