Return-Path: <netdev+bounces-299002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6RqBMeWLWoEhwQAu9opvQ
	(envelope-from <netdev+bounces-299002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609867F332
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:43:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299002-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299002-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5F4300E240
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9F37FF7F;
	Sat, 13 Jun 2026 17:43:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86B26F29C;
	Sat, 13 Jun 2026 17:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372609; cv=none; b=FdnyVMJFVWIR4LcmPFtFa780ZdA5iP2HDInqHBuFhSuIN+dlLoMFzDIiPv/eq5WT/J76r0/u9aAUP/a67njHt+XS392nzqWwM2Oh2zvgB4xwUUmyQStGiq78Bb11neotYUhZRJlABjna6JeHIt4RaQSpesQyi/EOJKGY/Wh+YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372609; c=relaxed/simple;
	bh=JPw+VsGU1KSWz84l1kioCdI3opQPfaN8V534we2oXUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJA6Qohp7CNOQE+6RWYVc03r6dPtz68Gom1p9+TjWZcRwW9Yh1DLu9pb38xKfTtvSC2tNbnK4ShDvNYUPVHDlxi0x4Ir4lY4fAkV/LR3Zg84GjZ9fqjWkBm1bRgNbR7MIvzwyktGYk20dhFXEjhLLWIJbVNYQTEg9ODQTW3SC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAAnZv6xli1ql2MiAA--.37844S2;
	Sun, 14 Jun 2026 01:43:14 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	paulb@nvidia.com,
	victor@mojatatu.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	xizh2024@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 0/2] net/sched: act_ct: preserve tc_skb_cb across defragmentation
Date: Sun, 14 Jun 2026 01:42:38 +0800
Message-ID: <cover.1781358691.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAAnZv6xli1ql2MiAA--.37844S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DZF1DWFW5tF1UWr1kuFg_yoWrJw43pa
	y5KF4jyF18AF43A3W8CF1jga1rCFs8ZrWj9rZ7trWfC3WY9a4SqryIqw1xuFy0kryfZ343
	X34UWay3uan5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQERCWotEtIA3AACsB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:paulb@nvidia.com,m:victor@mojatatu.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:xizh2024@lzu.edu.cn,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,kernel.org,nvidia.com,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,lzu.edu.cn:mid,lzu.edu.cn:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6609867F332

From: Zihan Xi <xizh2024@lzu.edu.cn>

Hi Linux kernel maintainers,

We found and validated an issue in net/sched/act_ct.c. The bug is
reachable when configuring TC with act_ct on a netdev (requires
CAP_NET_ADMIN). We have tested it, and the fix should not affect
other functionality.

We provide bug details, a PoC, and a crash log below.

v2 adds a tc-testing (TDC) selftest case in patch 2, per maintainer
feedback.

---- details below ----

Bug details:

tcf_ct_handle_fragments() calls nf_ct_handle_fragments() without
saving and restoring skb->cb. The defrag helper clears IPCB/IP6CB,
which aliases the tc_skb_cb/qdisc_skb_cb control buffer in
include/net/sch_generic.h. Fragmented traffic through act_ct
therefore loses qdisc metadata such as pkt_segs.

Later qdisc dequeue paths call qdisc_bstats_update() ->
qdisc_pkt_segs(). For a non-GSO skb, clobbered pkt_segs == 0 trips
DEBUG_NET_WARN_ON_ONCE() in qdisc_pkt_segs(). With panic_on_warn=1
the kernel panics.

Unlike ovs_ct_handle_fragments() in net/openvswitch/conntrack.c, the
act_ct caller only restored mru after defrag, not the full control
buffer. The attached patch saves and restores struct tc_skb_cb around
nf_ct_handle_fragments(), matching the OVS pattern.

Reproducer:

Run as root in the guest (QEMU bullseye image, eth0):

    chmod +x ./poc.sh
    ./poc.sh eth0 10.0.2.2 100

The script installs a root prio qdisc, clsact egress with "action ct",
then sends oversized UDP datagrams with PMTUD disabled to force IPv4
fragmentation through the act_ct defrag path.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

IFACE="${1:-eth0}"
DST="${2:-10.0.2.2}"
COUNT="${3:-100}"

sysctl -w kernel.panic_on_warn=1 >/dev/null

tc qdisc del dev "$IFACE" clsact 2>/dev/null || true
tc qdisc del dev "$IFACE" root 2>/dev/null || true

tc qdisc add dev "$IFACE" root handle 1: prio
tc qdisc add dev "$IFACE" clsact
tc filter add dev "$IFACE" egress protocol ip pref 1 u32 \
	match u32 0 0 action ct zone 1 pipe

python3 - "$DST" "$COUNT" <<'PY'
import socket
import sys
import time

dst = sys.argv[1]
count = int(sys.argv[2])

IP_MTU_DISCOVER = 10
IP_PMTUDISC_DONT = 0

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.setsockopt(socket.IPPROTO_IP, IP_MTU_DISCOVER, IP_PMTUDISC_DONT)
payload = b"A" * 4000

for _ in range(count):
    s.sendto(payload, (dst, 9))
    time.sleep(0.01)
PY

------END poc.sh------

----BEGIN crash log----

[  549.900801][T10210] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  549.901406][T10210] CPU: 2 UID: 0 PID: 10210 Comm: python3 Not tainted 7.1.0-rc1 #2 PREEMPT(full)
[  549.902720][T10210] Call Trace:
[  549.903756][T10210]  ? qdisc_dequeue_head+0x287/0x370
[  549.904713][T10210]  check_panic_on_warn+0x61/0x80
[  549.905053][T10210]  __warn+0xe8/0x330
[  549.905345][T10210]  ? qdisc_dequeue_head+0x287/0x370
[  549.909442][T10210] RIP: 0010:qdisc_dequeue_head+0x287/0x370
[  549.914217][T10210]  prio_dequeue+0x40c/0x6a0
[  549.914539][T10210]  __qdisc_run+0x170/0x1b30
[  549.915561][T10210]  __dev_queue_xmit+0x25e6/0x3ac0
[  549.920352][T10210]  ip_do_fragment+0x1188/0x19a0
[  549.924214][T10210]  udp_send_skb+0x885/0x1270
[  549.924556][T10210]  udp_sendmsg+0x13f3/0x20a0

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (2):
  net/sched: act_ct: preserve tc_skb_cb across defragmentation
  selftests/tc-testing: act_ct: add TDC test for skb cb preservation
    across defrag

 net/sched/act_ct.c                            |  7 ++--
 .../tc-testing/tc-tests/actions/ct.json       | 38 +++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.43.0


