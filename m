Return-Path: <netdev+bounces-169634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79207A44EA9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD2A17D4E0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7F1A23BD;
	Tue, 25 Feb 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BiNly+uQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A418FDAA;
	Tue, 25 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518213; cv=none; b=SNN/5Hzg03GFCwOt6V5o19+5YXztJSii/txNq5xKitxn8ft6bn63t1GUU7dH7XHb2ZSYediUwEjB6ivsr3SQQ7gLK65CGh6Ki0vM9/c9KuVqwj1JNYMHKxjK8U64TSHXWcwgAIqHEBs8xxRxRdonc6QimxEMB2Xhua5TJRwUVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518213; c=relaxed/simple;
	bh=4kRPWlClDYOUSoAHc2QVT1gZywE1fbr7r4UHSBjdXVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4tR/4yavrTF1KGezdMf/FiCmZ5u8LC/WO8nk69nAubYMYVnRjtBL6A5gcfc6rlneUWRB3lgIv6FO/QFcwgRqDtnHSlj6+H/kI1F9/r01b28z6Wc3+uSIGsQ/kBiE+KaOpXCvrRMJpk+IToJmPHC1xtPshrTT/zf9m+AvsnQXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=fail smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BiNly+uQ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740518212; x=1772054212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTbIfOI1pwPLKR/Xg2D9C9fx1fVIbzOlXdU2l6tT3ew=;
  b=BiNly+uQ9W6BfwzyL3zB409pHhSvAC60uLooAFqx5k8fd60u2dHOhVNf
   h5b65KnjtnEVlxEx6FZyD4uo7yGFn0DctkP9WPz0LU6WE9QpwodQ1tkVR
   HVyrcZOtcfW/93Ln6pQRhtcAxbReuqkchFsK5ggCPRiDfqBFEY3jLTdsx
   I=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="274300763"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:16:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:47411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.32:2525] with esmtp (Farcaster)
 id cc5325a5-0b44-4c0f-aa1d-6f3fa40d5ce9; Tue, 25 Feb 2025 21:16:45 +0000 (UTC)
X-Farcaster-Flow-ID: cc5325a5-0b44-4c0f-aa1d-6f3fa40d5ce9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 21:16:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 21:16:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wanghai38@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <liujian56@huawei.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
Subject: Re: [PATCH v3 net] tcp: Defer ts_recent changes until req is owned
Date: Tue, 25 Feb 2025 13:16:31 -0800
Message-ID: <20250225211631.97380-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224090047.50748-1-wanghai38@huawei.com>
References: <20250224090047.50748-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Wang Hai <wanghai38@huawei.com>
Date: Mon, 24 Feb 2025 17:00:47 +0800
> Recently a bug was discovered where the server had entered TCP_ESTABLISHED
> state, but the upper layers were not notified.
> 
> The same 5-tuple packet may be processed by different CPUSs, so two
> CPUs may receive different ack packets at the same time when the
> state is TCP_NEW_SYN_RECV.
> 
> In that case, req->ts_recent in tcp_check_req may be changed concurrently,
> which will probably cause the newsk's ts_recent to be incorrectly large.
> So that tcp_validate_incoming will fail. At this point, newsk will not be
> able to enter the TCP_ESTABLISHED.
> 
> cpu1                                    cpu2
> tcp_check_req
>                                         tcp_check_req
>  req->ts_recent = rcv_tsval = t1
>                                          req->ts_recent = rcv_tsval = t2
> 
>  syn_recv_sock
>   tcp_sk(child)->rx_opt.ts_recent = req->ts_recent = t2 // t1 < t2
> tcp_child_process
>  tcp_rcv_state_process
>   tcp_validate_incoming
>    tcp_paws_check
>     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
>         // t2 - t1 > paws_win, failed
>                                         tcp_v4_do_rcv
>                                          tcp_rcv_state_process
>                                          // TCP_ESTABLISHED
> 
> The cpu2's skb or a newly received skb will call tcp_v4_do_rcv to get
> the newsk into the TCP_ESTABLISHED state, but at this point it is no
> longer possible to notify the upper layer application. A notification
> mechanism could be added here, but the fix is more complex, so the
> current fix is used.
> 
> In tcp_check_req, req->ts_recent is used to assign a value to
> tcp_sk(child)->rx_opt.ts_recent, so removing the change in req->ts_recent
> and changing tcp_sk(child)->rx_opt.ts_recent directly after owning the
> req fixes this bug.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

