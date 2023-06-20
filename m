Return-Path: <netdev+bounces-12340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D18737215
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AF3281322
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DF2AB2A;
	Tue, 20 Jun 2023 16:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5F1549D
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:49:59 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B11729
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687279798; x=1718815798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71oWwvTJJwt/pNK9IxoDk0kqt6GkRX+mWH3TgAjEGiU=;
  b=UGa4XdKaNKMZkX6NH7Hgb4tJKZOwstEcfNxUXmeEeGhfn8cFyCEdgofx
   GKWCuQuI8UH6K8NP8x7u3uqvLQN+Ucm+Ou+C8O0p3UgOQrr9IBGn7EkiU
   +gUVkdCLRsEqXtoWTT7dUnfY6n0wgO9om541+ovH0AKs05yzS3lWdu0aJ
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,257,1681171200"; 
   d="scan'208";a="335133285"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:49:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 176BF46859;
	Tue, 20 Jun 2023 16:49:53 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 16:49:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 16:49:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] af_unix: Call scm_recv() only after scm_set_cred().
Date: Tue, 20 Jun 2023 09:49:29 -0700
Message-ID: <20230620164929.60541-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620-geeignet-heimgeholt-28beb062e534@brauner>
References: <20230620-geeignet-heimgeholt-28beb062e534@brauner>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.48]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Christian Brauner <brauner@kernel.org>
Date: Tue, 20 Jun 2023 12:30:12 +0200
> On Mon, Jun 19, 2023 at 05:00:09PM -0700, Kuniyuki Iwashima wrote:
> > syzkaller hit a WARN_ON_ONCE(!scm->pid) in scm_pidfd_recv().
> > 
> > In unix_stream_read_generic(), some paths reach scm_recv() without calling
> > scm_set_cred().
> > 
> > Let's say unix_stream_read_generic() is blocked in unix_stream_data_wait().
> > If a concurrent thread calls shutdown(RCV_SHUTDOWN) for the socket itself
> > or its peer calls close(), we bail out the while loop without calling
> > scm_set_cred().
> > 
> > If the socket is configured with SO_PASSCRED or SO_PASSPIDFD, scm_recv()
> > would populate cmsg with garbage.
> > 
> > Let's not call scm_recv() unless scm_set_cred() is called.
> > 
> > WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_pidfd_recv include/net/scm.h:138 [inline]
> > WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177
> > Modules linked in:
> > CPU: 1 PID: 3245 Comm: syz-executor.1 Not tainted 6.4.0-rc5-01219-gfa0e21fa4443 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:scm_pidfd_recv include/net/scm.h:138 [inline]
> > RIP: 0010:scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177
> > Code: 67 fd e9 55 fd ff ff e8 4a 70 67 fd e9 7f fd ff ff e8 40 70 67 fd e9 3e fb ff ff e8 36 70 67 fd e9 02 fd ff ff e8 8c 3a 20 fd <0f> 0b e9 fe fb ff ff e8 50 70 67 fd e9 2e f9 ff ff e8 46 70 67 fd
> > RSP: 0018:ffffc90009af7660 EFLAGS: 00010216
> > RAX: 00000000000000a1 RBX: ffff888041e58a80 RCX: ffffc90003852000
> > RDX: 0000000000040000 RSI: ffffffff842675b4 RDI: 0000000000000007
> > RBP: ffffc90009af7810 R08: 0000000000000007 R09: 0000000000000013
> > R10: 00000000000000f8 R11: 0000000000000001 R12: ffffc90009af7db0
> > R13: 0000000000000000 R14: ffff888041e58a88 R15: 1ffff9200135eecc
> > FS:  00007f6b7113f640(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6b7111de38 CR3: 0000000012a6e002 CR4: 0000000000770ee0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  unix_stream_read_generic+0x5fe/0x1f50 net/unix/af_unix.c:2830
> >  unix_stream_recvmsg+0x194/0x1c0 net/unix/af_unix.c:2880
> >  sock_recvmsg_nosec net/socket.c:1019 [inline]
> >  sock_recvmsg+0x188/0x1d0 net/socket.c:1040
> >  ____sys_recvmsg+0x210/0x610 net/socket.c:2712
> >  ___sys_recvmsg+0xff/0x190 net/socket.c:2754
> >  do_recvmmsg+0x25d/0x6c0 net/socket.c:2848
> >  __sys_recvmmsg net/socket.c:2927 [inline]
> >  __do_sys_recvmmsg net/socket.c:2950 [inline]
> >  __se_sys_recvmmsg net/socket.c:2943 [inline]
> >  __x64_sys_recvmmsg+0x224/0x290 net/socket.c:2943
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > RIP: 0033:0x7f6b71da2e5d
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
> > RSP: 002b:00007f6b7113ecc8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> > RAX: ffffffffffffffda RBX: 00000000004bc050 RCX: 00007f6b71da2e5d
> > RDX: 0000000000000007 RSI: 0000000020006600 RDI: 000000000000000b
> > RBP: 00000000004bc050 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000120 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000006e R14: 00007f6b71e03530 R15: 0000000000000000
> >  </TASK>
> > 
> > Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index e7728b57a8c7..f1b76e0a8192 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2905,7 +2905,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >  	} while (size);
> >  
> >  	mutex_unlock(&u->iolock);
> > -	if (state->msg)
> > +	if (state->msg && check_creds)
> 
> I think you might need to handle this in scm_recv() as it looks like
> this would potentially lead to regressions for SOCK_PASSCRED if you skip
> this here. scm->creds.{gid,uid,pid} should all be set to 0 if
> scm_set_cred() hasn't been called and would be sent as such through
> SOCK_PASSCRED and they aren't pointers. Only scm->pid is...

The case where we don't call scm_set_cred() is like

  1. No skb in the queue (if skb == NULL scope)
  2. close() the peer
       - set SHUTDOWN_MASK to sk_shutdown
       - set ECONNRESET to sk_err
    or
     shutdown(RCV_SHUTDOWN) sk
    or
     timeout with -EAGAIN

Under this situation there must be nothing to receive, so I don't think
this change could cause regression.

If we have one skb at least in the queue, we will call scm_set_cred().

Thanks!

