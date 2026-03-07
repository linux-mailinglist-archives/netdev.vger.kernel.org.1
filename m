Return-Path: <netdev+bounces-265198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPcXGamhrGltrwEAu9opvQ
	(envelope-from <netdev+bounces-265198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:07:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1A22DCB3
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546163014666
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C902DECA0;
	Sat,  7 Mar 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AORSJa32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549A529AB15
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772921254; cv=none; b=Dv0pH0DCL9+RCSOntxU9n3fx9C2KeIk56BzGRr7LNKaFJiOKkmPSxdyzbzGweVW4k97PywFwOTPQ1WMEalKw60o2JtHctC2dM+W9cip4qRK1W2TheWEmZLODdRUzTGoBqNsKFpQXc5hpIrJ/MgcYmXHwpeVUlEPktOYFP8PtZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772921254; c=relaxed/simple;
	bh=Yj3aC6vEIqrdfZyuksAeHuXqNFgHbxk0dOi1aoUn39M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCaMHTrCMIypzaQKtSSGI3p5w/jKGeVMUps/rJKibAbkA8gxhqENi724mhTlesE9DU8ooBptNaEagoiXVi5tDUos5Iq5vg3ORX+EQGRgdGgyrncvLDuW0gpd7azc2SbhMDULrc0Y0zGpYIMDGyyPdIsDlE2TkZgXFkjzKjam784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AORSJa32; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56aff27dfebso2100371e0c.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 14:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772921252; x=1773526052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMD5IH+mzMKeuf+xZUNVj3sUh2VoOYCoBHjzSBgyOM=;
        b=AORSJa32T7M2fHG1wjRb2jRUKQk6YdkFSYADJKZqviOCZuewD2o2F9nIXeijIp4Ad/
         K98QRXyQYA6nOejczkRxgxmTA6sGeaWca8+qZpnLxmp+qCoztF2QTvhRDHWc5nPxMVfs
         P4AGTYssjDrKa6BiBwNgH+aA0TVC9B1tp7vovhu+CrJVRv7MrPOdc3k8qjD6uYz4f8ab
         jxQBBKpcmu9NmWoqF9XTTxE9WJ1Hz4yqyNTuAgMyYLAfXNqE6Hb318NWKvvLQcosa6rS
         LpC5qHE4DW9/h6YnBScr/VH5MCWwchnmVoUbdYTnEB6UfygdSF3wKcum04BX7gNYIsmg
         Nveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772921252; x=1773526052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnMD5IH+mzMKeuf+xZUNVj3sUh2VoOYCoBHjzSBgyOM=;
        b=acpfRp5IKJ6FDiBc1qUzJs9pL5geeHY9NH28tUvwDYa8nNgwud0fYTAgSbv4Dh3RET
         Urj8zBhxye4056IjTlMJ92wQjo4EAA2ympbV/WTTQ5qGz9DNEfzwWNZvoSihwfcur+aw
         daBRkOjLcLNyaPKPUgkH2Hk1j1Lu8jPEnlXsKpAWfhCQeknXbg+ULyFtEKaQSgtiIEiU
         DRxgRSTBmaNOYcwTCDAy9fMwCzzwvaZ8wQYg7ermGPjCXOnKXuKEnD1pLEijmlgkAck1
         SSHULiCo+vIq+Yoy1fi+Gsq147XUi/eHlBxdl74u3OQ9OuMLFMkpOZCu0A4btdxk0ZZ3
         yMzg==
X-Forwarded-Encrypted: i=1; AJvYcCXmbo80twjOK1PIjcIj/xQlOrwRi1qYe9PD/JWNayyWywcA88agiNHHovDJ+7Tu3km2rOdLoLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsPjkRw4L3VqxAVQNouUvpLIK85Tikmephum/KWyCfzPOzJPs
	M2OVdFcRj2dM8t+juUIctOCmrq1Y12eXYCLp/zoLuQvEH7/HZ1eK3PqBNNZWM6BT/A==
X-Gm-Gg: ATEYQzyRrcg0ew4ydhCwz4vxDLq5TGpbrVgrl+H9GeBLMAXgIaPcDMltqjqNp0Bi7xw
	h8x4dyKVpzxM16jq+HJsk+y2ozgJRDHGNDXrifDU41+sSo4ZpHQf3E+zoRw+SAMI5V8pt7zfwyz
	pVLVJShFhQ3ONfBg3XDAsPZN6q2JdjmE7Hf4UKqtnFdfK7UFylgfQiewtfEj1QE8FO7U63DFc3n
	Q8o+KV9n4UWBCA7ZBMNld+Ep5UpexHoltyN9doEGEZHwvRFyAyeFn0yPKYtVZImzM3AsLE7qX5c
	8pFeoIwC2as98ibgVLo5coVyp2AQHz5eREw3OpQlfqMWL/DgHE7fTwoemQneJdetmTtTCV7fnkc
	/CCiN1y0ghCPL+tImjO3x7jLsAMed3UbtTnKesPquG0sPBXTowuRARLo+K8bnwGMlLjYlvR1Am7
	iH3Vx3yyM=
X-Received: by 2002:a05:6122:3b10:b0:56a:fad9:a910 with SMTP id 71dfb90a1353d-56b07ea5bb0mr2244247e0c.15.1772921252186;
        Sat, 07 Mar 2026 14:07:32 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0f889ed2sm4242853e0c.13.2026.03.07.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 14:07:30 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next] selftests/tc-testing: Adapt test's output to HFSC's iproute2 printing changes
Date: Sat,  7 Mar 2026 19:07:24 -0300
Message-ID: <20260307220724.2501212-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BED1A22DCB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-265198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

To make the printing of HFSC's defcls consistent with HTB's,
iproute2 is now printing defcls prepended with "0x".

This commit adapts test a4c3 to this change.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6a39640aa2a8..ec0f85af6379 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -570,7 +570,7 @@
         "cmdUnderTest": "$TC class change dev $DUMMY parent 3:0 classid 3:1 hfsc sc m1 5Mbit d 10ms m2 10Mbit",
         "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc hfsc 3:.*parent 1:2.*default 1",
+        "matchPattern": "qdisc hfsc 3:.*parent 1:2.*default 0x1",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1:0 root",
-- 
2.53.0


