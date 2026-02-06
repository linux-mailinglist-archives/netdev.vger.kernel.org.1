Return-Path: <netdev+bounces-257475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMXXGI+BhWnpCgQAu9opvQ
	(envelope-from <netdev+bounces-257475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:52:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEFBFA776
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E63C301B924
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AA2E22B5;
	Fri,  6 Feb 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SM7XOpYD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B02298CAB;
	Fri,  6 Feb 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357113; cv=none; b=Hu/2evFYmXnIrysqRE6+ESk3hsRoNQA+gDNAuxTRRIFkaxINKz8JnSFdF9kmcaVcroT2P5L634GsZ1PMmhYnVXSAM/RjrSit8al/NFwPoK9gFGqsTTlOpZ9nLM2phLJgecHGCoKT/HMyHAt43oRi4Fgjrb1u+HR1gQPTg81iFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357113; c=relaxed/simple;
	bh=RYqdXloqrTVpQ6/Ha38EU1AdCzc9YMGAl4I1Kgwk9IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFo8677yqM2Z2qO4AYOkdMaaq6iD0bLPBqijdEH1onKsUG1XkRU+TvdTFTdugoG6/FATvP51rK+begL36bEPpobOrsXKu+C/OX/izjnRdfrvPViUx1kn2NFUft4OgMjAzqslpF8kgdY7L+Tmag5PeMp2LE7tii6mBgRJGETC+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SM7XOpYD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dA
	4zof/j+V7ltXHiN5KBnBwB+kE4YImgeqEqw3BtgqM=; b=SM7XOpYDqJIY7aFGlX
	Y+4jGtIKtC9VsmWFmDN13t2jGP958FmLaP63/EA2Qtr3EU7J+tsuZYPuT5ghRTg6
	G6PCzpxnvO2919r3mxHigkTLHgEz2XuexBz11IM8IMQJFsxaiavKDQtQW8CGXAlN
	g+WqNmDanRw/o1gZ+seD/hlnM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDX3KtRgYVp1VXIOA--.82S2;
	Fri, 06 Feb 2026 13:51:16 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri,  6 Feb 2026 13:51:13 +0800
Message-Id: <20260206055113.63476-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDX3KtRgYVp1VXIOA--.82S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4UWFy5ZF1Utr1UWryfZwb_yoWrZFyxpF
	WUtrW0kF4kJ340qF48Jr4UJ3WYqFWqvF45Wr1Svw1jqF1jqryxXr1SyF4jqrZ8Ar4rur47
	J34UtFn7tw1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYfOwUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hUxqWmFgVXFJQAA3n
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257475-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[163.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hust.edu.cn:email,bpf_test_run_lwt_xmit_dst.dev:url,kylinos.cn:email]
X-Rspamd-Queue-Id: ABEFBFA776
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

Temporarily add the setting of skb->_skb_refdst before bpf_test_run to resolve the issue.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v3:
- use dst_init
- Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
Changes in v2:
- Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/ 
---
 net/bpf/test_run.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..3e1c47d53b82 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -989,6 +989,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
+	struct dst_entry bpf_test_run_lwt_xmit_dst;
 	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
 	u32 linear_sz = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
@@ -1156,6 +1157,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 
+	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
+		dst_init(&bpf_test_run_lwt_xmit_dst, NULL, NULL,
+			 DST_OBSOLETE_NONE, DST_NOCOUNT);
+		bpf_test_run_lwt_xmit_dst.dev = dev;
+		skb_dst_set_noref(skb, &bpf_test_run_lwt_xmit_dst);
+	}
 	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
 	if (ret)
 		goto out;
-- 
2.43.0


