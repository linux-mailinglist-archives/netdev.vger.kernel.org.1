Return-Path: <netdev+bounces-261767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DXuA89VoWk+sQQAu9opvQ
	(envelope-from <netdev+bounces-261767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB571B48BF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11DA430E443B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF689389E18;
	Fri, 27 Feb 2026 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XtST389P"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E23290AB;
	Fri, 27 Feb 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180559; cv=none; b=Czet4/5iRwUoS3VD4pnmXG9j59EWxG7iWfkSixymRIFJ/ccsa36e9jZ5bhoqLjihSFhkqBhd/2uq6Ox2TawPIo18usDUSNoEmWrllyVnSLukHcTYCgEUOOvZGWqCNMgwODy/4CCtcZTuUncX5E2ZCa/rfrLIGVBZuS8E6oi6ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180559; c=relaxed/simple;
	bh=HobaWZBtFXByN9gP8NEOawHf34z8YkPHliY4yHEOq30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urx5KbFhW1WXOGFbAms1mZKsAOsV912SSo1jPSSjovGJzmytsil3hxMymxpQeEh6wQGONIxSP93RrV957QtgtLcDE5JQgSaDZJDJRPKIfJdbcD/bJFhtBsVmGNnqVXjfNkwWVJyIUHVRAy8nxduS8vgsLsSg+ciUGMfxjrECvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XtST389P; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bv
	0bnnWfTqafl/AhgDRRaz8W+cZTA5rN1wg4PeCIa3M=; b=XtST389P5lEWcycBM4
	2/WkqCRkSHxsNgo/ku8d40xg2bO1MGjKha6WLZXkZ0eWh5tFMhAXtvqKqPNFMvl0
	X3DwlbaNeQ3bj4FIEiZLktwYEzUzEXBp8ijQANwS6ggSHvQKcpDqKt/ACHAVBqVd
	zbfk92rH6Vp+3vNRKSoaz/DjY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXP+oOVKFpNzWPNg--.30755S3;
	Fri, 27 Feb 2026 16:21:36 +0800 (CST)
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
Subject: [PATCH v8 bpf-next 1/2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri, 27 Feb 2026 16:21:32 +0800
Message-Id: <20260227082133.96951-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260227082133.96951-1-yangfeng59949@163.com>
References: <20260227082133.96951-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP+oOVKFpNzWPNg--.30755S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4UWFy5ZF1Utr1UWryfZwb_yoWrWr1xpF
	4UtrWFgrs5t340qF48Jr4UJw15XFWqyFW5Xr1Svw1jqF1jqr17Xr1ftF4jqrZ8Ar45uFW7
	J348twn7tr1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyrWrUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RHbVGmhVBHNGwAA30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EB571B48BF
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
Closes: https://groups.google.com/g/hust-os-kernel-patches/c/8-a0kPpBW2s
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 net/bpf/test_run.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..54dbda2f6329 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1156,6 +1156,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 
+	if (prog->type == BPF_PROG_TYPE_LWT_XMIT && !skb_dst(skb)) {
+		if (!ipv6_bpf_stub) {
+			pr_warn_once("Please test this program with the IPv6 module enabled\n");
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+#if IS_ENABLED(CONFIG_IPV6)
+		rcu_read_lock();
+		skb_dst_set_noref(skb, &net->ipv6.ip6_null_entry->dst);
+		rcu_read_unlock();
+#endif
+	}
+
 	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
 	if (ret)
 		goto out;
-- 
2.43.0


