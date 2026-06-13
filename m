Return-Path: <netdev+bounces-299004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aTpzONiWLWoGhwQAu9opvQ
	(envelope-from <netdev+bounces-299004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4A67F33E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299004-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299004-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C95F730058E6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248033845BC;
	Sat, 13 Jun 2026 17:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA8937F8A5;
	Sat, 13 Jun 2026 17:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372619; cv=none; b=CZhkETT61Jm96omNzLyMIy/W+zzSWBUgTIZGyuq+fedAD/HiqYk5qbSf/iUIvVHja90RCb2/5gekk+L6Y09GkwMdcIFT5yNU6f69Egb3GVyyVK5WNsLNfQJuCkI+BlAtncRQH9vO/DNaoSI8UjLVxnbVnQDwFfzzGLu6tqg9L3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372619; c=relaxed/simple;
	bh=sSQKr7Q9ONNhA76/XdrxKkC9L3yoDSOG2MUWRHM8UZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0mdYgOKymgxKWPWuCpjKpFPXt55deV6DLtzO1T9UV71mJYWJjTW8qqU5N5KxpzpvfuDgW0pYtItGcIL+DdHwd4bvkf2w7ZDJSIA45MnVTw5ElBXd4w2ASWKpPe4VJWE3l2XlpAHbMZjsiedIrQfoaWbthR1nAkhFAG1LhLLRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAAnZv6xli1ql2MiAA--.37844S4;
	Sun, 14 Jun 2026 01:43:31 +0800 (CST)
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
Subject: [PATCH net v2 2/2] selftests/tc-testing: act_ct: add TDC test for skb cb preservation across defrag
Date: Sun, 14 Jun 2026 01:42:40 +0800
Message-ID: <53493549fdbcb2de25788b7894c56baadbc5fede.1781358692.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781358691.git.xizh2024@lzu.edu.cn>
References: <cover.1781358691.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAAnZv6xli1ql2MiAA--.37844S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF48ZrWDKFWDWFWfXFyfXrb_yoW8tw45pa
	48CF42yF48Ar17Cw4Uuw1Yga1rW3Z5ur4Yqr13X347uw1rC3ZYqa1xKw48uF4DGrWrXr4S
	yw1qg342kFs3AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQERCWotEtIDpwAAs7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:paulb@nvidia.com,m:victor@mojatatu.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:xizh2024@lzu.edu.cn,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,kernel.org,nvidia.com,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,lzu.edu.cn:mid,lzu.edu.cn:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82B4A67F33E

From: Zihan Xi <xizh2024@lzu.edu.cn>

Add a tc-testing case that sends IPv4 fragments through act_ct on clsact
egress while a root prio qdisc is present on the transmit path.

The test verifies that packet processing and qdisc accounting continue
to work after conntrack defragmentation, covering tc_skb_cb preservation
across defragmentation.

Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
changes in v2:
  - Add tc-testing case 9c2a for skb cb preservation across defrag
  - v1 Link: https://lore.kernel.org/all/20260611154939.2615919-1-n05ec@lzu.edu.cn/
 .../tc-testing/tc-tests/actions/ct.json       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
index 33bb8f3ff8ed..da65f838bd52 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
@@ -664,5 +664,43 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress_block 21 clsact"
         ]
+    },
+    {
+        "id": "9c2a",
+        "name": "Act_ct preserves skb cb across defrag before prio dequeue",
+        "category": [
+            "actions",
+            "ct",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: prio",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 1 matchall action mirred egress redirect dev $DUMMY"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 1 matchall action ct zone 1 pipe",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "[Ether()/frag for frag in fragment(IP(src='10.0.0.10', dst='10.0.0.1', id=1)/UDP(sport=12345, dport=9)/Raw(b'A' * 4000), fragsize=1400)]"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 1 '^qdisc prio 1:'",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DUMMY root handle 1:"
+        ]
     }
 ]
-- 
2.43.0


