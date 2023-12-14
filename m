Return-Path: <netdev+bounces-57260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33078812A9D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03E61F211CA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72522F1C;
	Thu, 14 Dec 2023 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FlSTFDpt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B310B;
	Thu, 14 Dec 2023 00:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702543609; x=1734079609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b3Cx7C5Tc/CCSV7kbxf7MHrZB2cURq1RVAFdDuzLreA=;
  b=FlSTFDptGBOU7e6jAmEsSmaMUa7RYaxMvt0o/wMKFBLp0Gw6cDfviA5S
   g6fPHFwHA4XHLUIQzIZ4KBc+ZPGFz7PfkPkQKzQiz49uZtessmz882DPL
   87YXtmqnEfLrKQrUONNkXPxNbI5tp2LZ4Ztnjlu0E0Sx+F5e1SUW5TuZD
   A=;
X-IronPort-AV: E=Sophos;i="6.04,274,1695686400"; 
   d="scan'208";a="382882935"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:46:41 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id EE22A49041;
	Thu, 14 Dec 2023 08:46:38 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:5687]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id 9aa46150-e598-4bc7-8f19-0447a0efefca; Thu, 14 Dec 2023 08:46:37 +0000 (UTC)
X-Farcaster-Flow-ID: 9aa46150-e598-4bc7-8f19-0447a0efefca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 08:46:37 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 14 Dec 2023 08:46:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syoshida@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>,
	<syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if sk_wait_event() fails
Date: Thu, 14 Dec 2023 17:46:22 +0900
Message-ID: <20231214084622.15054-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214050922.3480023-1-syoshida@redhat.com>
References: <20231214050922.3480023-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Shigeru Yoshida <syoshida@redhat.com>
Date: Thu, 14 Dec 2023 14:09:22 +0900
> The following NULL pointer dereference issue occurred:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> <...>
> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
> <...>
> Call Trace:
>  <TASK>
>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>  __do_sys_sendmsg net/socket.c:2650 [inline]
>  __se_sys_sendmsg net/socket.c:2648 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
> socket waiting for the event. However, sk_stream_wait_connect() returns
> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
> that waits for a connection with sk_stream_wait_connect() may misbehave.
> 
> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
> connection. If disconnect() is called in concurrently, the above issue
> occurs.
> 
> This patch fixes the issue by returning error from sk_stream_wait_connect()
> if sk_wait_event() fails.
> 
> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I guess you picked this issue from syzbot's report.
https://lore.kernel.org/netdev/0000000000009e122006088a2b8d@google.com/

If so, let's give a proper credit to syzbot and its authors:

Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

Thanks!

> ---
>  net/core/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/stream.c b/net/core/stream.c
> index 96fbcb9bbb30..b16dfa568a2d 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -79,7 +79,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
>  		remove_wait_queue(sk_sleep(sk), &wait);
>  		sk->sk_write_pending--;
>  	} while (!done);
> -	return 0;
> +	return done < 0 ? done : 0;
>  }
>  EXPORT_SYMBOL(sk_stream_wait_connect);
>  
> -- 
> 2.41.0
> 

