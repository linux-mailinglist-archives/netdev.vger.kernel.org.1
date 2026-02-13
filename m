Return-Path: <netdev+bounces-258534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2yZFHmSQjmkvDAEAu9opvQ
	(envelope-from <netdev+bounces-258534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:45:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF51326DD
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE75304700F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21221F5846;
	Fri, 13 Feb 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xo7RwQAw"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE663EBF18;
	Fri, 13 Feb 2026 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950751; cv=none; b=hOliIDJosTmB87/wxsD/GH+CQ4YJtf/VNYtMwj4dBjxRvB/044iFOG+ibMpNZe1J8JiFGiVCC9hrge6zpQWMiTxJJR+QM1g9/Wq6dSY+Qo5qGjgbwYDioh4liIUTp5v1pjXoYhlNFaoOK4l+1HlVyzFkW2fN4F8eX2kmzgklsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950751; c=relaxed/simple;
	bh=e9CUNngpJYdidJ+bsQx/7bhJ5yO/Ae4YFVh8fTeAJBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piHILHbJYojSPP2ajoRwMsjJB2/KTGy3PTNdEO93LdJEoea2qTa25EaxidPuN7yPU3NdKihMTGBm4HCmyo/xmgNeJgWTH8hBStyHRdZHnDOgzByQxanJOcdA1npf6ugrfo4LT5XMm+lcnp+rBrL+0+hUgh65wxG9pnXUAOloqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xo7RwQAw; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ji
	z9hFkNYU1o3sH3lwWGbmOq3te50YRBL5Jaej3ysfw=; b=Xo7RwQAw0p5xitdrBh
	ynOAX/X8m3yjEo1OubHAxE9VEveistgccF8K+hPpdt9L0Pgc0e5zVD2H9EDeqOlH
	c3Os3zs7Y/+uXHmz2yM7qy2wcnLvQQcghzEQlPSQgLc2Oiapix7G04KCc0844ci0
	fK21ijcq5qMVWWSM5LEjfGZqQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnZNoNkI5pvhZSLw--.1343S3;
	Fri, 13 Feb 2026 10:44:31 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	posk@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangfeng59949@163.com
Subject: [PATCH v6 bpf-next 1/2] bpf: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri, 13 Feb 2026 10:44:28 +0800
Message-Id: <20260213024429.39972-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213024429.39972-1-yangfeng59949@163.com>
References: <20260213024429.39972-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnZNoNkI5pvhZSLw--.1343S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4UWFy5ZF1Utr1UWryfZwb_yoWrGF1Dpr
	1jyrW09r4kAry0yF48Jr4UJw129FZ2yFW5Xr1Svw1UXF1Utrn7Xr1SyF4jqrZ8Ar45CrW7
	t348t3Z7tr1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyrWrUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BAmnmmOkBAyNwAA3a
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258534-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hust.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: DEAF51326DD
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

The bpf_lwt_xmit_push_encap helper needs to access skb_dst(skb)->dev to
calculate the needed headroom:

	err = skb_cow_head(skb,
			   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));

But skb->_skb_refdst may not be initialized when the skb is set up by
bpf_prog_test_run_skb function. Executing bpf_lwt_push_ip_encap function
in this scenario will trigger null pointer dereference, causing a kernel
crash as Yinhao reported:

[  105.186365] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  105.186382] #PF: supervisor read access in kernel mode
[  105.186388] #PF: error_code(0x0000) - not-present page
[  105.186393] PGD 121d3d067 P4D 121d3d067 PUD 106c83067 PMD 0
[  105.186404] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  105.186412] CPU: 3 PID: 3250 Comm: poc Kdump: loaded Not tainted 6.19.0-rc5 #1
[  105.186423] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  105.186427] RIP: 0010:bpf_lwt_push_ip_encap+0x1eb/0x520
[  105.186443] Code: 0f 84 de 01 00 00 0f b7 4a 04 66 85 c9 0f 85 47 01 00 00 31 c0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8b 73 58 48 83 e6 fe <48> 8b 36 0f b7 be ec 00 00 00 0f b7 b6 e6 00 00 00 01 fe 83 e6 f0
[  105.186449] RSP: 0018:ffffbb0e0387bc50 EFLAGS: 00010246
[  105.186455] RAX: 000000000000004e RBX: ffff94c74e036500 RCX: ffff94c74874da00
[  105.186460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94c74e036500
[  105.186463] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000000
[  105.186467] R10: ffffbb0e0387bd50 R11: 0000000000000000 R12: ffffbb0e0387bc98
[  105.186471] R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000002
[  105.186484] FS:  00007f166aa4d680(0000) GS:ffff94c8b7780000(0000) knlGS:0000000000000000
[  105.186490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  105.186494] CR2: 0000000000000000 CR3: 000000015eade001 CR4: 0000000000770ee0
[  105.186499] PKRU: 55555554
[  105.186502] Call Trace:
[  105.186507]  <TASK>
[  105.186513]  bpf_lwt_xmit_push_encap+0x2b/0x40
[  105.186522]  bpf_prog_a75eaad51e517912+0x41/0x49
[  105.186536]  ? kvm_clock_get_cycles+0x18/0x30
[  105.186547]  ? ktime_get+0x3c/0xa0
[  105.186554]  bpf_test_run+0x195/0x320
[  105.186563]  ? bpf_test_run+0x10f/0x320
[  105.186579]  bpf_prog_test_run_skb+0x2f5/0x4f0
[  105.186590]  __sys_bpf+0x69c/0xa40
[  105.186603]  __x64_sys_bpf+0x1e/0x30
[  105.186611]  do_syscall_64+0x59/0x110
[  105.186620]  entry_SYSCALL_64_after_hwframe+0x76/0xe0
[  105.186649] RIP: 0033:0x7f166a97455d

Check the skb->_skb_refdst in bpf_lwt_push_ip_encap function, and return
-EINVAL if _skb_refdst is NULL.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://groups.google.com/g/hust-os-kernel-patches/c/8-a0kPpBW2s
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 net/core/lwt_bpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 9f40be0c3e71..374054e1a2c6 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -616,11 +616,14 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		return -EINVAL;
 	}
 
-	if (ingress)
+	if (ingress) {
 		err = skb_cow_head(skb, len + skb->mac_len);
-	else
+	} else {
+		if (unlikely(!skb_dst(skb)))
+			return -EINVAL;
 		err = skb_cow_head(skb,
 				   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));
+	}
 	if (unlikely(err))
 		return err;
 
-- 
2.43.0


