Return-Path: <netdev+bounces-246156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E4CE019F
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D685303C9E6
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CB328B52;
	Sat, 27 Dec 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHvl8o1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C094328B48
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864517; cv=none; b=rd5wrSQVqPegzrhHC6tM/ps/XqWYFGl0jWCQyWHqXB9F3hR7dJg7CV2d3/MZm+Qc1dbU69IfgQscjj6/sUBW8PupSaykse9TouldnPPwYQZfVL7LV638ZBibZ39po0unHRQ5JBjBCK7n7nmnrC4CthDOX8BHPM3O/6XxGSv19bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864517; c=relaxed/simple;
	bh=wHfxkzR0h3438LhGsyDy1mEIBWYx732C2BPFv47SFac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/Cg89X3grc6FxDKRbiUTyg+fMwQv5Lle1Cb6V9r1hSmZ0FphjvjoX15ppmum6I9RfEt3SH1R1/Gg6zWNc4ZmgtXsDJ3o1A9XV1AMEo/eMtr+ezsi0+d1TV4j3qUpHkmwOg7Dftvtk+OIsQKXXENU1hlw7+enetp5B7fEL9duB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHvl8o1F; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso7557537a12.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864515; x=1767469315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=gHvl8o1FYfl5t3pyQ52BTdI8qFB1hyS87bVu7iVqh9Fwg29sT/3Qw+bY2sxGRqtlPD
         nVX4GChfpeuy/9G/rxOHBLJaTR2708XFRD29sEjarz7OIJ9aCokWEOuU3ct+yhklQt7b
         IWWoclIxFPDrOGrqTSoIOCdCogi9Wiatt+X8H+RWg3NBMS08NdGcte4inM6lc5q/rLcZ
         0v+UkQU3AFIq5m3B+jfLtp4pC13rw8UM0sdBKMfVsimn1RIhstSH1SDr6OwfZSDUj/dX
         VgIQ0rYD0HL/CblATOUckEY9JHQNCBcA2tzrlFTXoeuFo/5+/ifsRlR+h79aFww/ylhc
         F1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864515; x=1767469315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=aSgFOhFdTNPSqPFDfPS6iSkxCp/fPdfCrtZ6Jr/g1i/BoRhsGm7wE7O1GRd2zLVjNt
         B0+4W1wMSiBdktjYgbx+ZfFMwLQK3KgbzJvyuYrIzhZB+lGCFA5lJpqTrP7o2+0zWXMu
         wWW2a0TNH9B6rV8b9bjYf2C3oVfPZJjKJiQ2jmrqm2gyCPrIHjtWdsjQ/A5QcQMVSUkY
         YPfA8p67qMJQCHAbgHx0v9UUXTLk3GPCaIH4I6ZPjIhTgTwX1UxEEL4HFRUS4H4Ji25Y
         M3nDsDUVUWzzhCilDAjoAuCHKvxVFd+HTJtAG4X5kMSpN1OO9GIHLP6nXL92wkIjGQzj
         88lA==
X-Gm-Message-State: AOJu0Yz6UCTEwnva0uOUZqORhVfiAsiurJhKiuu2/jms7RVOrEPW/rgN
	GTPSsUK0D8Z9c1lGBGPdzUIoPHICWGnF5KvAV2s6Sx6dvaWnjm0QkuTJtFHomg==
X-Gm-Gg: AY/fxX50r+xPZNDJQYbUMzgSUV/mZVS9hDTNnGIyqda2aT65klK6yz4jM5kUkCLL/vd
	VMX38pK5UXCFHS4H9lMSfqpQaaCcRPuGAi5n168U3aN8oVQlP477j2kr7InbmROLK3qniP1FQ7l
	LlBWIggP1MjJxshYdU91rs1maKEfwPNmZ3OdYT3J6XeTkRz9VTgajXdekrI0cadiXsY2y0C1qT0
	rrzAOUIr0TcsH9bkEuBetj+ZxjsORqjq/Sn/szoCbMyyhbwIyZqiyNEkIVBqBA8Cp2GTzrqkreE
	Tbu+LZoZQwoVKqbMYEhRrgdNIIR7LB4wAgTpWftxvn7VhzoW+rP678ekICGKrhucZIJn3S3IR2O
	C8GwpIlo/78YIjsMpnxTmIkOlijNElspMhkMNYJzliz1ZIfydDB2quAYXGkE3zdVBDYwjd/CchI
	o6qXFuS8CYTYd58pDeXm2nA8TnBM0=
X-Google-Smtp-Source: AGHT+IGVIpevql9TTyMOiX8Ici/pHnDFAhd7NHsmntlpPBw16O0rzX97AEzuyGwxS3oZzIlHrkNTaQ==
X-Received: by 2002:a05:693c:414d:10b0:2b0:5335:af9 with SMTP id 5a478bee46e88-2b05ec64e34mr21591805eec.41.1766864514704;
        Sat, 27 Dec 2025 11:41:54 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:53 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v6 7/8] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Sat, 27 Dec 2025 11:41:34 -0800
Message-Id: <20251227194135.1111972-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that multi-queue NICs are prevalent and the global spinlock issue with
single netem instances is a known performance limitation, the setup using
mq as a parent for netem is an excellent and highly reasonable pattern for
applying netem effects like 100% duplication efficiently on modern Linux
systems.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index b65fe669e00a..57e6b5f35070 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1141,5 +1141,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1:"
         ]
+    },
+    {
+        "id": "94a8",
+        "name": "Test MQ with NETEM duplication",
+        "category": [
+            "qdisc",
+            "mq",
+            "netem"
+        ],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$IP link set dev $DEV1 up",
+            "$TC qdisc add dev $DEV1 root handle 1: mq",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1:2 handle 20: netem duplicate 100%"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1 | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: mq"
+        ]
     }
 ]
-- 
2.34.1


