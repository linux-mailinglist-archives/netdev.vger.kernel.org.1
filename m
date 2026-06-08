Return-Path: <netdev+bounces-296693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryaHBckNJ2qAqwIAu9opvQ
	(envelope-from <netdev+bounces-296693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13930659D59
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:45:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296693-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296693-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3D01308E807
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636153E4C72;
	Mon,  8 Jun 2026 18:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE93E5A1F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:34:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943691; cv=none; b=IE7vBOeuXtPPXVq4Ywog+blnAXB9O8PyKU1PcoRxkz3FWj7LWN7GQyRQKOaDahwfQxKZBSiGvvNKJx54Y6THFXiueH5yjWsO0KMiMumeZ7tsmyH3MtgeRTfJarzwEdiYJ8Jrt8SSkXosifcE5qGufdIkEKqsQnvnHExsaA9aonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943691; c=relaxed/simple;
	bh=VnSvoON/zgjYj8aIqQ3qub4+RamRKXvWg+FW0wH0eRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARiomnSJ5xV6MOkroZJIDYjT7pJru2nyvKAjdZzM/kDKVo/ZGG893c2RGPhD+ULvMZaSGPkzNyMnA6xLQYe6AuW1DZhxFRKIuHB1smUE6PDlsoFirBdmbChDzAgA6LDdRY0zPjfJItpIkmY+Edqsf63g7u6VJ9R484iscdBpPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sQ4CydqRBRuAA--.16762S3;
	Tue, 09 Jun 2026 02:34:33 +0800 (CST)
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
Subject: [PATCH net v2 1/2] selftests: tc-testing: cover malformed IFE decode frames
Date: Tue,  9 Jun 2026 02:34:22 +0800
Message-ID: <cf59defd97a1ad7aed813573a24bccfa3e265e61.1780901080.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780901080.git.edragain@163.com>
References: <cover.1780901080.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADH6sQ4CydqRBRuAA--.16762S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF15WF4kWFWUCrWUCr18Grg_yoWrGFW8p3
	yrGanFyry8tFy2yw18u3yUWF4Yga93ZrWxt3Wrt342v3W5uFyvqFWIkr40kr4DuryFvaya
	y3Z29F47uw4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAMCWome1AKEgAAs7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-296693-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:from_mime,lzu.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13930659D59

From: Yong Wang <edragain@163.com>

Add a tc-testing regression case for IFE decode with a malformed
ETH_P_IFE frame carrying only the minimal IFE metadata header followed
by a truncated inner Ethernet header.

The test installs an ingress flower rule with "action ife decode pipe"
and injects an IFE frame from scapy, then verifies packet accounting
through "tc -s -j filter show". Using JSON output makes the check less
sensitive to formatting differences in tc's text output.

To let the testcase send the larger frame shape it needs, extend
scapyPlugin with an optional "mtu" field and apply it to the transmit
interface before sendp(). This is needed because nsPlugin creates DEV0
in the root namespace, so testcase setup commands executed inside the
test namespace cannot adjust DEV0 directly.

Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- add a tc-testing regression case for the malformed IFE decode frame
- add an optional mtu field to scapyPlugin for the reproducer
- v1 link: https://lore.kernel.org/all/6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com/

 .../tc-testing/plugin-lib/scapyPlugin.py      |  6 ++
 .../tc-testing/tc-tests/actions/ife.json      | 62 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
index 254136e3da5a..e84b344dd1fa 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
@@ -50,5 +50,11 @@ class SubPlugin(TdcPlugin):
             if '$' in scapyinfo['iface']:
                 tpl = Template(scapyinfo['iface'])
                 scapyinfo['iface'] = tpl.safe_substitute(NAMES)
+            if 'mtu' in scapyinfo:
+                subprocess.run(
+                    [NAMES['IP'], 'link', 'set', 'dev',
+                     scapyinfo['iface'], 'mtu', str(scapyinfo['mtu'])],
+                    check=True, stdout=subprocess.DEVNULL,
+                    stderr=subprocess.DEVNULL, env=ENVIR)
             for count in range(scapyinfo['count']):
                 sendp(pkt, iface=scapyinfo['iface'])
diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
index 808aef4afe22..062efbe284dc 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
@@ -1378,5 +1378,67 @@
         "teardown": [
             "$TC actions flush action ife"
         ]
+    },
+    {
+        "id": "8a7c",
+        "name": "Decode malformed ife frame with truncated inner ethernet header",
+        "category": [
+            "actions",
+            "ife",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            [
+                "$TC actions flush action ife",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC qdisc del dev $DEV1 clsact",
+                0,
+                1,
+                2,
+                255
+            ],
+            "$IP link set dev $DEV1 mtu 65535",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol 0xed3e prio 1 flower action ife decode pipe"
+        ],
+        "cmdUnderTest": "$TC -s -j filter show dev $DEV1 ingress",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "mtu": 65535,
+            "packet": "Ether(dst='ff:ff:ff:ff:ff:ff', type=0xED3E)/Raw(b'\\x00\\x02' + b'\\xcc' * 14 + b'\\xdd' * (5000 - 16 - 14))"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s -j filter show dev $DEV1 ingress",
+        "matchJSON": [
+            {
+                "kind": "flower"
+            },
+            {
+                "options": {
+                    "actions": [
+                        {
+                            "kind": "ife",
+                            "stats": {
+                                "packets": 1
+                            }
+                        }
+                    ]
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
     }
 ]
-- 
2.34.1


