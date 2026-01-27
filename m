Return-Path: <netdev+bounces-253749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFShKq17eGkFqQEAu9opvQ
	(envelope-from <netdev+bounces-253749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:47:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB89140A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0FC9303BA46
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F02C2349;
	Tue, 27 Jan 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fER1/+px"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3582C0F7C;
	Tue, 27 Jan 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503585; cv=none; b=Q34AmLAN2ubI5C96tc89G7iqTNqiQZhb8NuMBETi4SQsjr8jBrIPKMhUab5g68dqhJDGFl/hAVIZFwT8p/o8Pb2XEbmlZ3z1JH5jsVx2JVdxv1Mo2ihWjKrtZXZkEia/gHo1Kr8Kr92Wr2t9LDdBVXi/8qxEpGrQITZANOEz0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503585; c=relaxed/simple;
	bh=OgC4zltAQ2UgG+McuW39REdXvyM9WQMgwxl9bs4bhAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QD2EDD2tzYD7TowI5ODWpLeYtMuzKZXHtXAIA8n2CO9VuvwxRX0r7UnJIx4Wh/np06AGk+HDwE4MvbMopBjJdhUkT6HZ//wXO+q6WNfFjVEEN6lP00AlagQDaEqUWH6ojrEaBynV1i3cm62zShy9nGMsd4SvsVG2wA5oloAcJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fER1/+px; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=uG
	4b+dZHUzCAbgnUzO/yyPQs0rN5orRXWFPlF45UOeY=; b=fER1/+pxeYQCqJ8tUx
	ipYSy5zoxZ17VJia5uvQwoG5iypAz46WQefwz1oyKHaDRaz22QYgCktWa/4kw1eO
	NtQWXlyrQOLN2h8i+uzpwdT+lL2M+JM54Tocy9vSt7RxDguXSXk1QFx0KaC2m9TD
	fjXUKfhjlfdsurTLwkLzaJz3o=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnG7kge3hpQDXBIQ--.36381S2;
	Tue, 27 Jan 2026 16:45:21 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: lwtunnel: Check skb->_skb_refdst in bpf_lwt_push_ip_encap
Date: Tue, 27 Jan 2026 16:45:20 +0800
Message-ID: <20260127084520.13890-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnG7kge3hpQDXBIQ--.36381S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr18tF1fJF4rXF47Jr4DCFg_yoW5KF45pr
	1jkrW09F4kAryFyF48Ar48Jw17ZFZFyFW5Xr1Svw1jqF1Utrn7Xr1SyF4jqrZ8Ar4rC3y7
	J34Utan2qr1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAwIkUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wJfLml4eyLwXwAA3-
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253749-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[163.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hust.edu.cn:email,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21CB89140A
X-Rspamd-Action: no action

From: Yun Lu <luyun@kylinos.cn>

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
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/core/lwt_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 9f40be0c3e71..5cebeb718ae0 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -618,9 +618,12 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 
 	if (ingress)
 		err = skb_cow_head(skb, len + skb->mac_len);
-	else
+	else {
+		if (unlikely(!skb_dst(skb)))
+			return -EINVAL;
 		err = skb_cow_head(skb,
 				   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));
+	}
 	if (unlikely(err))
 		return err;
 
-- 
2.43.0


