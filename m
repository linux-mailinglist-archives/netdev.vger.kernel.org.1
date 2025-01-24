Return-Path: <netdev+bounces-160735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BAA1B036
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEF8188DEE6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6571D9A7D;
	Fri, 24 Jan 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqE0D/X8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB51D88D0
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698878; cv=none; b=EztVhGjZg54u/qzWO68kAIy4CzfIVnTJ9IFrB3JBOiQgEnMCbnx4D8wxGhXiir1kiRTGYrvhRaONCEHVnR0NX2ydnPzv7ta7u2GhEnopDt5KXBrdj6Tpg7Hm6VaMjCPos+L/eglyGLYh4c11XYAGXEUU5fzqJYaqvnxRI7aGQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698878; c=relaxed/simple;
	bh=s09RJo1RT+XRG8IJUOSGZgPHnEjHIZWDwG1VTYBb0tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqUj4mIiygIcXoFXGK64vpe2l1YfXdOWTPuGcIieDXf6jkdxIbzJStC64hAI01TlJPIvmKo70XbTSh4XrtKSfgKqcKoEnVOf55IzF7HC/7mi/713zy/362K51/apgm8I/cbAvJQOxDWWOsbtAohP9abg2oVz+sVfhOJ213wZiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqE0D/X8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165cb60719so29785815ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698875; x=1738303675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoUzGSYmiYSloM+1el6iuUFqrJByiFgt+WfH0LvnyYQ=;
        b=YqE0D/X8xMfmFtPFdAGKCzk/IE7vai8LgfsM4YoQRwdWTveyXmmhqs0gBEgKaveu8T
         psn+J2E7xV80NR1By0IV0+oTQ9ciMCeQWgm/FQmqMsc4DuEzDTCfLiAGcVjhcQM/bMty
         jL6WthKCcL7WR1LPsrhRT5047kVTrqQYTy+829KiyVSrE5jONDWiIVVj5A4dYcz9aebo
         9G1oYq7qt44OaZvsoCvDB/xzr26KLMOl1qgqBvv5ad649he64p0+Ouao113zlK74258L
         x/FGehbFJC/tZ7LQcKnErnAtNxUwMlItrITiXMpuOy6+i+WsyBt3JjvcJ2kVsNg2Evl9
         3RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698875; x=1738303675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoUzGSYmiYSloM+1el6iuUFqrJByiFgt+WfH0LvnyYQ=;
        b=TvY+NkkK7E1v1Bn9Sya5EV5ripekugU13UL5Ld4QPGU0KeUGXcMpK3CtwvneJp7yNT
         AmnRQKQJCCsUnl9T93GwMrduWYhrgflhEycjNgOWF5/CyT3vkfhklPM/1OUNMYVCVoxc
         J3KpIpSF/9foLgUoD6aY6TTPVlemGghiWzM6qgg6tgIflNXsC/OkF/HTx789d+hSpbpS
         +/pKpSrrLVdDf8UYu5ONZW1P4z0KWLy2Tw2OZPIbI0WPPrZ4iynLFeQ7HhqVKjb6T4RA
         RdlaOf5D7SdDc7FMi/dsOWdjCuBSYFlN5CxnnFMWPjv/XNpaSiMEsM2A10J1T7/3Ablq
         yaew==
X-Gm-Message-State: AOJu0YxEHYZfNLCEvKZNDSlVVpa2+zrW0DriuOqVDup9LqKFW/QnLQSz
	hz9PHp1up86U2AvGrvTSVUBjyr7l446G0DfmEWnFyOKfgNLj3MnC4CsJtg==
X-Gm-Gg: ASbGncvIq7JNXttUdZZazZlTD1bEeZIUZcSYBeKxI7z+wU31dHoLDt085dHK6IzkdyF
	I7/9AOYWU7A6F8R0CA6ZWhzqzmJJXCfobR3vLyc5390lZdfvXrFfIoSjNEXhMZr3Gt1I0ze+klr
	myK5lUZibAk8AQ7i2+Z5qw8+TI5O90vaXXJI4nL09Gahx7rlCQ8HtWazgyud8sxrSebas0KZh0/
	09yXgs0/aKpGpnvMWrLR+CCaVBALOwC4lR7+GXqDKyj5HM0YZ7C136vzxql+d7gJLib1hPNDFfd
	s64LiV4Yj37sBHaq2zAkVQE7uZOIIWnm
X-Google-Smtp-Source: AGHT+IEJfqeJWBP9YscXCjoTwvtRfgyJV0ErH6T8I/bpKT5QFstZPW9C8rY3HDbtMv9y5EQoKfIYvQ==
X-Received: by 2002:a17:903:988:b0:216:7ee9:220b with SMTP id d9443c01a7336-21c35530048mr492643395ad.22.1737698873794;
        Thu, 23 Jan 2025 22:07:53 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2d85:604b:726:74b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea55dasm8696095ad.101.2025.01.23.22.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:07:53 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net 2/4] Add test case to check for pfifo_tail_enqueue() behaviour when limit == 0
Date: Thu, 23 Jan 2025 22:07:38 -0800
Message-Id: <20250124060740.356527-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quang Le <quanglex97@gmail.com>

When limit == 0, pfifo_tail_enqueue() must drop new packet and
increase dropped packets count of scheduler.

Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
index ae3d286a32b2..f5e08ae9bb7d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
@@ -313,6 +313,31 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "0",
         "teardown": [
+	]
+    },
+    {
+        "id": "d774",
+        "name": "Check pfifo_head_drop qdisc enqueue behaviour when limit == 0",
+        "category": [
+            "qdisc",
+            "pfifo_head_drop"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev dummy2 mtu 1279 type dummy || true",
+            "$IP addr add 10.10.10.10/24 dev dummy2 || true",
+            "$TC qdisc add dev dummy2 root handle 1: pfifo_head_drop limit 0",
+            "$IP link set dev dummy2 up || true"
+        ],
+        "cmdUnderTest": "ping -c10 -W0.01 -I dummy2 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev dummy2",
+        "matchPattern": "dropped 10",
+        "matchCount": "1",
+        "teardown": [
+            "$IP link del dev dummy2"
         ]
     }
 ]
-- 
2.34.1


