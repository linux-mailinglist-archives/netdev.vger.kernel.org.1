Return-Path: <netdev+bounces-155016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2FA00AE0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11747A16A0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED231B415D;
	Fri,  3 Jan 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gays3/Qe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEECEEBB
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915946; cv=none; b=ktXp4yamvSftcGbBlgmN9K/Dk83T7PVfmeF/mPrVjuaAbi8JUTCc8qOnRqw2spgKdLYDvFuUYi7+efmm8I9iHXLchciC9R583stVlOPxxFD9/8bexyFkqpQPlTMokOrXFqSnBQ4LCieCRqpBXW1ENuQoD5yDiuSjRK/6jcf1NUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915946; c=relaxed/simple;
	bh=3wsYkt0/QafGudXpoakG8WF2RHZKu8CxicKFTWcEopA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTFq+oxlqCghy1rpJqmLBQIvSCmORiHErjQ0tr6dmB+cQpOwyx5LKqVqckuct871bWyejpETCrDeN7MyxubmSk06Ug0LzLmexa9k5m1JZuIFp+zhRa/J2CyyTX4+MDpT7rDT/ObNyiykup9aFcS1+BY3m4YEKK4FsT/FVRIhQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gays3/Qe; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735915946; x=1767451946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03fkXbSOkK6xEmb0sDZg8XkEuI3HhuFMjezGJIatRfA=;
  b=Gays3/QebNIO/DF3BGm5dCX6HKtyU7/ZYdHCTXZPsJPZCP+fMt3dEkpr
   piC8JT0pEPf/oS97Yd/Nc9aGHwUVcKS8RpsOsr1yAUF2YOpCHF37fui+3
   3Ev7AwMkdcs3uQri9Y6Rn/i+jvX75l1rpTSXiQvjneFpZQH5FcARWd7Pl
   A=;
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="366386707"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 14:52:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:23195]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.34:2525] with esmtp (Farcaster)
 id 86b587ef-2f72-452e-9786-c4759a71537d; Fri, 3 Jan 2025 14:52:23 +0000 (UTC)
X-Farcaster-Flow-ID: 86b587ef-2f72-452e-9786-c4759a71537d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 3 Jan 2025 14:52:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 3 Jan 2025 14:52:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dzq.aishenghu0@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kerneljasonxing@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH] tcp/dccp: allow a connection when sk_max_ack_backlog is zero
Date: Fri, 3 Jan 2025 23:52:10 +0900
Message-ID: <20250103145210.84506-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
References: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Thu,  2 Jan 2025 17:14:26 +0000
> If the backlog of listen() is set to zero, sk_acceptq_is_full() allows
> one connection to be made, but inet_csk_reqsk_queue_is_full() does not.
> When the net.ipv4.tcp_syncookies is zero, inet_csk_reqsk_queue_is_full()
> will cause an immediate drop before the sk_acceptq_is_full() check in
> tcp_conn_request(), resulting in no connection can be made.
> 
> This patch tries to keep consistent with 64a146513f8f ("[NET]: Revert
> incorrect accept queue backlog changes.").
> 
> Link: https://lore.kernel.org/netdev/20250102080258.53858-1-kuniyu@amazon.com/
> Fixes: ef547f2ac16b ("tcp: remove max_qlen_log")
> Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/inet_connection_sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index 3c82fad904d4..c7f42844c79a 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -282,7 +282,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
>  
>  static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
>  {
> -	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
> +	return inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog);
>  }
>  
>  bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
> -- 
> 2.34.1
> 

