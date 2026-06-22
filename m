Return-Path: <netdev+bounces-301194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bo6EKWWOOWpHvAcAu9opvQ
	(envelope-from <netdev+bounces-301194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:35:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D926B2118
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rcpassos.me header.s=purelymail1 header.b="T6m/C7En";
	dkim=pass header.d=purelymail.com header.s=purelymail1 header.b=nU3CWbKX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301194-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301194-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rcpassos.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD15302DB5F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0AA347BA7;
	Mon, 22 Jun 2026 19:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F817347BD9
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156891; cv=none; b=UOX5uq+FdoLlh2uF8lzxRtzta1gQcF33cgT43f9ItWZlLayLP02eN1oeEx/qfv+8NuxqEx9OQUMZWrOVseld92kxibsDrfqURPSvn/aXLXPWNgYBUK26DeyLjy2GedpzwQ+3e0/NLcAlXhCL893orOfbrm8P5iyq4z28GOPKMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156891; c=relaxed/simple;
	bh=VQKtJkkEsax0s8nQV8C6c5S66vPEhwny0vyW6W7sYEo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Giv+ZwabpHTTOqkaq596n3nqSW+7GuIqojiri0bpjpxqt0QzpZSXe6KaLXBPaOLIU0wNyME+yIIvzfVMqRy4nYSFQ4ompFp0e/Uk1qorRvdhqi47WCHoA18MYPP4YDNFQ160d8OMelNCazWMAUCZPa0p+iR4i5jk/E+vbG1WQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=T6m/C7En; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nU3CWbKX; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=T6m/C7En0hnNaKXDbFC9xFrB0WCEmrxA+Aj7cdIDRL9ulAFh2bJjlgHuR5ElSOLQfFc+m5XYzQiIEbhaR1PJapiZNyWPzU5b55QKScHdvYY3FbBzgZ3YKEqHAWqcAQC9Hp7ZpK+AIRSDCL3AMnWSPxcdky1oeLDxUd6d1q1vtcUZhSvFdf/JvrKWWayrRkTLeiKQUC1SKXGzgmw38u+eQ8ur3GfeIudFwdkZ4YloheucB6zT+gmDn2gG275UYNyO1/4BwP8XgkTBuMfot5vww0H//JEdtdrM2VDqPn6FuCz/c4cNLU2vT70DvHINY4axKwdiq2z9wZMY4Ak7UNUPtw==; s=purelymail1; d=rcpassos.me; v=1; bh=VQKtJkkEsax0s8nQV8C6c5S66vPEhwny0vyW6W7sYEo=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=nU3CWbKXFX0sXVdNteVleVU7L5fQur84nLtF4o8NVWE5yX2t1NT8R16nWP7MBaryuDNmNQvYD0fPSl9LxE+0ow+pxrvITymzKRIYxzMLwv3/+mgpEMREtY2VLmi+LbKnCwCoe7z+ydN8sHPJYyAswxp0sdNGXp/Lda5qkgF+wf8+PRaRFddmth76oKW7BTszEILTfGcI29NHDyCLkcU9f0a9CrMMx+XaGvOzi4fD43vSrly8JytzhTXFOO7zORV9Tges4XYb2wnsF6lllFfn/bkOylPlsqQmVXBtGTjQGhi2ua5aKG4yyKP1vd1TcMyf8Fj6cZ7+aE+pvtRoWWb/5Q==; s=purelymail1; d=purelymail.com; v=1; bh=VQKtJkkEsax0s8nQV8C6c5S66vPEhwny0vyW6W7sYEo=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1158097400;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 22 Jun 2026 19:34:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:34:33 -0300
Message-Id: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
Subject: Re: [syzbot] [wireguard?] KCSAN: data-race in
 wg_socket_send_skb_to_peer / wg_socket_send_skb_to_peer (9)
From: "Rafael Passos" <rafael@rcpassos.me>
To: <Jason@zx2c4.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzkaller-bugs@googlegroups.com>, <wireguard@lists.zx2c4.com>, "syzbot"
 <syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com>
X-Mailer: aerc 0.21.0
References: <6a1d983b.b111c304.35cd64.0028.GAE@google.com>
In-Reply-To: <6a1d983b.b111c304.35cd64.0028.GAE@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rcpassos.me,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[rcpassos.me:s=purelymail1,purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301194-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Jason@zx2c4.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rcpassos.me:+,purelymail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08D926B2118

Hi,

I started investigating this KCSAN warning by syzbot, and would like to
ask a few questions.

On Mon Jun 1, 2026 at 11:33 AM -03, syzbot wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in wg_socket_send_skb_to_peer / wg_socket_send_skb_=
to_peer
>
> read-write to 0xffff88811af99028 of 8 bytes by task 310 on cpu 1:
>  wg_socket_send_skb_to_peer+0xe8/0x130 drivers/net/wireguard/socket.c:182
>  wg_socket_send_buffer_to_peer+0xf1/0x120 drivers/net/wireguard/socket.c:=
199
>  wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inl=
ine]
>  wg_packet_handshake_send_worker+0x10d/0x160 drivers/net/wireguard/send.c=
:51
>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3397
>  worker_thread+0x58a/0x780 kernel/workqueue.c:3478
>  kthread+0x22a/0x280 kernel/kthread.c:436
>  ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> read-write to 0xffff88811af99028 of 8 bytes by task 15360 on cpu 0:
>  wg_socket_send_skb_to_peer+0xe8/0x130 drivers/net/wireguard/socket.c:182
>  wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>  wg_packet_tx_worker+0x12d/0x330 drivers/net/wireguard/send.c:276
>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3397
>  worker_thread+0x58a/0x780 kernel/workqueue.c:3478
>  kthread+0x22a/0x280 kernel/kthread.c:436
>  ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> value changed: 0x0000000000000a2c -> 0x0000000000000ac0
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 15360 Comm: kworker/0:2 Tainted: G        W           =
syzkaller #0 PREEMPT(lazy)=20
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/18/2026
> Workqueue: wg-crypt-wg2 wg_packet_tx_worker

I tracked the change to this counter increment in `wg_socket_send_skb_to_pe=
er`

+++ b/drivers/net/wireguard/socket.c
@@ -179,7 +179,8 @@ int wg_socket_send_skb_to_peer(struct wg_peer *peer, st=
ruct sk_buff *skb, u8 ds)
 	else
 		dev_kfree_skb(skb);
 	if (likely(!ret))
->		peer->tx_bytes +=3D skb_len;  <- protected by a read_lock_bh only
 	read_unlock_bh(&peer->endpoint_lock);

It is protected by the read-part of a rwlock.
However, if the stack trace makes sense, this `wg_socket_send_skb_to_peer`
is being called after a handshake (wg_packet_send_handshake_initiation) and
a send worker call (wg_packet_tx_worker).

Does this make sense ? Are such calls possible to really hapen outside of f=
uzzing ?

Out of curiosity, I changed `tx_bytes` and `rx_bytes` from u64 to atomic64_=
t
in peer.h, and also the r/w ops in netlink.c, receive.c and socket.c files.
I ran the wireguard kselftest suite with and without this patch, and it
worked fine. Iperf results seem sine (on amd64).
I'm not sure if this should be the solution, or if this is even a real issu=
e in the first place.

Any comments ?

Eager to learn.
Thanks,

Rafael Passos

