Return-Path: <netdev+bounces-297241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X9ODCNxiKGpgDAMAu9opvQ
	(envelope-from <netdev+bounces-297241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:00:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE66637A5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=P78xY7aM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65C5E305748C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DE4CA268;
	Tue,  9 Jun 2026 18:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8D4CA276
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:56:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031416; cv=none; b=u84Z3jVilYbjDoW3mt3NjKnzMNTKjuO0J90b5EkD+JKf2yFSo740r3DPyEscQS9Id4mSVls/5IeP7H0d1vA5EqxZi7id31AJSMEyVmVdFoJZHkaIqh25Ldu56xowq4c3uGfaOT+oPsOXGQj9/JEsDjtWG0GhWB7OhSrhpp9Lvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031416; c=relaxed/simple;
	bh=eJrryJR7FC2wXcvBjW9Isaw+U5WrFzf+qgsOKVPU91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6c29+VoYA/VA9czPz6JkXwNoRp9422HWyXTqhE2TohOYjayQnzVsuYN5d/tIlFDJjf+ZGHwU61JOrLrvDchoVYxlmswPMyJ38vZUFQr7zpWeze5V7jO5G8dzDQ4+AcfrNG0kD34idEop9U8lm4jV3eiZ5C3BndsQuqPU1mey/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P78xY7aM; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91578c374ecso493691185a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781031413; x=1781636213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPa3Agakguu+yTP7S/VS7Anopqh6DOy/a2ofAVBPmuM=;
        b=P78xY7aMkl6+MYCnczOaIpAE/cmZfFqoGhah1y438V0079ncGNixFJgybKVAKJsbzB
         PBhvZZxgFxTTqz1knJ+2Y77dpA0lDvUuiNWFXQE4ZGBIwmx3HPgIcy4mc0mdExzfFU9X
         f4w5zQcNXlO2zXogSgyEBzzfoVQI8Eo2Kog4hMXWPUcGq4FqtURTaD1ew65JqOJkq+e1
         CK2wPLwB/Cw2ILrQhBudsNHEMpeQgYvZK2C7v5TuJxuep6uV+eu1GmiVwAiwrg77W9gY
         uajf0F8V1puv1nmWz3e6C4B8B/yOJOCFNkfw961pKCo/t0tPNWy3QsaLmE1TLXxO/24C
         nvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031413; x=1781636213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPa3Agakguu+yTP7S/VS7Anopqh6DOy/a2ofAVBPmuM=;
        b=MxLszuVze91cjq6DdK6vnDq0y92cikJ7a/eZ1Ov0Q5tF8+mbSzJCMhqNDn3w+LmKAW
         qtJzcMm+Z37+8y5/fYnw5bH9FRYq1hqN+43pYnNbp4s3XxkP2jk1JlTKY55vHWPb9vCY
         1Oh7Z9yRuWZPbLaPc8oX9WKqGV+sqCGHEuc4n8g3xNbgi1+piSE4EHkMqL90PHBSBlvD
         mGH9MJLVEfBZ6vUig4oeEZ8tiPrx+n8+cRYjkbLnLJkcMKXSfXnWeNcq99JfXjWADM/z
         Uwgemriknd6O574E8FnP+/qFNFawPChdzwidGijcndxYACef86KiIv5YFXLdt+nsN0qR
         NH5g==
X-Forwarded-Encrypted: i=1; AFNElJ/RBY1BhDdDIf30GeZkPuv/cVGkV/M4fS+lW/SLpuuHLSZJoRwrVp0oLsBlHh5Thgwm42XmvZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EHaohdZrUP9WK0gq9M2txGRp4QoNPNnlOlsIA/NYRszmjLZu
	UKeyZthLgqKOofC32krtI8bfCOlCMIZrXsWFb/KqnEPiNk5qOmaL8pKINeZK4OB17x6Ofb8XfL7
	vO/MPkMw=
X-Gm-Gg: Acq92OESqys1uexyxLClTdbDQx8KcYf+YPyEp1RUkIlPiQoom6qkvcaGstlDRolvHEy
	QVw8TzS937FhwBkvKlSwH12aAkmJp0x5ECa/frU0xerP5RKSUJZbDdgbgXawbahpUjJZMgmW1Il
	35jm+TNddTLmw6/2Ar3gKoLStJ8PL21zdwEjhI1gfQh9MPTdIl5m6dmS9iuhE8RD/ZLYnYuUDK+
	cJOikF0Ca8/QiHokn8cxsFaygVu9lSvyIKYJ+vQj8i980uJojcdXNOXp400Av7LLjyP8SP2iZN/
	yYNTJx9y470WaYaAoHqcntQNZcZ/xSX470Idx+M7LxBAgDvftbY1IJCZgeYudaJKWQdGa7E5dAr
	zS57QU7kkWjcVL2lYPMLRDZkWe6Y72j/2lDxJbfaaeACbxLIMYs22XotuOogQpGqdLef2Dar1uk
	41PS24ed7KEM6AAxtkrswKfv6Crd63cVkshIM1yQ==
X-Received: by 2002:a05:620a:a29b:20b0:90d:501c:50 with SMTP id af79cd13be357-915a9c75e55mr2470804085a.26.1781031413022;
        Tue, 09 Jun 2026 11:56:53 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a00a4f4sm2355139185a.3.2026.06.09.11.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:56:52 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] net/sched: act_pedit: require matching IPv4 L4 protocol
Date: Tue,  9 Jun 2026 18:56:35 +0000
Message-ID: <20260609185636.1599359-3-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609185636.1599359-1-sam.moelius@trailofbits.com>
References: <20260609185636.1599359-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:victor@mojatatu.com,m:jiri@resnulli.us,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,trailofbits.com:dkim,trailofbits.com:mid,trailofbits.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4EE66637A5

From: Victor Nogueira <victor@mojatatu.com>

Add a tdc test that checks the act_pedit extended L4 header mode does not
edit a packet whose IPv4 protocol does not match the selected transport
header.

The test installs an ingress pedit rule that sets the UDP destination
port, then injects a TCP packet with dport 2222. The UDP and TCP
destination ports sit at the same L4 offset, so a buggy kernel rewrites
the TCP dport. A second flower filter matches TCP dport 2222 and drops
the packet through an indexed gact action; the test then verifies via
JSON that this action saw exactly one packet, i.e. the dport was left
untouched and still matched 2222.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
Changes in v3:
  - Add test

 .../tc-testing/tc-tests/actions/pedit.json    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json b/tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json
index 37c4103321749..d8b685cfc62de 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/pedit.json
@@ -1920,5 +1920,54 @@
         "teardown": [
             "$TC actions flush action pedit"
         ]
+    },
+    {
+        "id": "1a4f",
+        "name": "Pedit udp dport should not mangle TCP packet dport",
+        "category": [
+            "actions",
+            "pedit"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip pref 1 matchall action pedit ex munge udp dport set 18053 continue"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip pref 2 flower ip_proto tcp dst_port 2222 action drop index 1",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether()/IP(dst='10.10.10.1')/TCP(dport=2222)"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action gact index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "gact",
+                        "control_action": {
+                            "type": "drop"
+                        },
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
     }
 ]
-- 
2.54.0


