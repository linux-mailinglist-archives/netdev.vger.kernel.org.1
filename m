Return-Path: <netdev+bounces-293410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGiGBwwHGqDLQkAu9opvQ
	(envelope-from <netdev+bounces-293410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF8E616307
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1913030297
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30336655D;
	Sun, 31 May 2026 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKtgVfW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5F243951
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780232113; cv=none; b=BQh1HowCqa97rwB54O+fm6uPrG9r6kkH1ZMw6+MJ4t+gydmDS/I1nMYURq+16KkNLS74W5RRZjvZRBTd8ZSdVqU9rFtujI0EKHbYSQ516kBEqwWKxn4ebS156dS5dM4uwT88G/ll085CHPH6thhN2mu2iz3WVb/7dZs7bUg8EMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780232113; c=relaxed/simple;
	bh=8k0HUUGrKQdbm2dXES9LOTuJCiHdtOvz6RVV14YqWAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdlGXTeoKPx/l96lq02w6sffGwz9PzWWQgpxEXv+vi4Kgdcwxd3pSM3yySFzxZfCNlzdhZKCAnI2CV7nL0iRes6RwJlqbkxk6jxFgI545INhnrIufdH6STXwrOdjavniLT7tcjoGprOZh9U5GNQVI+SWdlfoOtI0UHOx7qrnSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKtgVfW9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2985062a91.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780232112; x=1780836912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jvjYYorspJJuCQZSL29dgMwijPlrOWsuologm7lz9E=;
        b=fKtgVfW9i+MlSfvJRHfHTgJEPEM+j3X7T75A4dt4fnwoBHTA/3BXxs7F8RmckvjNZm
         5tOcMeT5UtJcgI/hD3Iww+2KAglh1Xqqy0II9bq1n1GMXv9vx4d9Akd01vfSj9+Flvqk
         a5q6P1RI+r+27wazP3EUMWQY8PozZsgvWC9iP5nQaKVEIjyrVcEanGzYcsWkunvWeUQG
         jJR0DulX1/vXwm+D3hFD75hJ3AOR+Z4rKTVJHZwpNCPkN0rwEvFIapzIZ7LiPWkJ6ON+
         ZlEswBVSkswPOb9+e9VOWvJcVxU7PQm/rRk6fcLkXEPK0oJD8jYcpN/aj0DDaEhFULqZ
         of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780232112; x=1780836912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jvjYYorspJJuCQZSL29dgMwijPlrOWsuologm7lz9E=;
        b=jK+XLZeEa6paeLxEYpEs3YPX2Cwz/9ko5YTYHkSSgigZE4XNKBYzg2s6EEoY+xqx8c
         H8WhKUGI8s8CPYhnVtxlqP1fCtIyKmyH1vfcCUaYIdc03Bi234X0rdqYBtQsQW9qtzEn
         3qOcx0OGctpOlGEVo3yXg5ucb/N+kL0h8UPYM//lFRZk4xwfAVXAAB4BEapDvzQ5PDqL
         2VlmpGw/eNsUf7XVSlhRxmhkhX8rD2xoDVhP6J1INRl9ljZv0w4KTYzgcR/dgWf3FfHs
         IjfvuG+evYYfIfsNjMKGZYjTYXlTvtELWPgMWY/oFDPTugQIeW0r/CFUO9biXu222yNw
         eusw==
X-Gm-Message-State: AOJu0YyroAg6y049ghyMjbuMMYOwdaCZ4gVH2N2Tvz0IcK3ulZBKef1o
	/FquSlqAmuZ0GVJvkpUNLlpVB2EYaw8FggcZPGCgjkudNjWVkB6/5MU3esnSDhZD7DY=
X-Gm-Gg: Acq92OHdQwBPBCBFshFA7liYMmdgXLBybHTFsQzqPOHh3kQMCeazVerjrPgDh04pzOs
	mKq37ZepokppHyW6iMZPkzqbWxhkg2Itt4yTlA3zSoX+j7AvUGIl471zhFkXsy8epHYifKbgIUm
	Co6QoxoijlVxBCJKbOrbJ5TBVl4A5SJJ6KQV4otCyPCv7cWEPPm03Wd2QyrdRaetH9Xf6H+fe8C
	c9wHHLhwq6b535tfdl9AkubSSijHMsdzbBXXD++n4KSwygG6KEHB1CcG3siCrq1UYJ5uL/oqsPa
	pYTT43T2hIeGbG85Ii2tbbNBTQ0wJgAwN0Rn2Cx/idAQ6xstVsrL/5LsWvBBE5dkrfeNS99MDtB
	zPSJXr6tB/0Ee1HhgsyTvWA7fGeNaBDNzTF+uPV6X/LbHFhZSrnXhG+m3IOsgpJYzIEErR3+ZTS
	QJUGFLF3pqYnC4U3464TqEfi/h64A/zPhjVoLdxgEsCqx0rxSaumed7TVwRCea
X-Received: by 2002:a17:90b:57e7:b0:36d:70c8:3a3 with SMTP id 98e67ed59e1d1-36d70c80687mr5091181a91.15.1780232111729;
        Sun, 31 May 2026 05:55:11 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:7f12:602a:a4c6:2b38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfec391bsm7766670a91.2.2026.05.31.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:55:11 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next 2/2] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Sun, 31 May 2026 18:23:14 +0530
Message-Id: <20260531125314.22492-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531125314.22492-1-hemendranaik@gmail.com>
References: <20260531125314.22492-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	TAGGED_FROM(0.00)[bounces-293410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nitk.edu.in:email]
X-Rspamd-Queue-Id: 0EF8E616307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a tc-testing entry (id: 83c0) to verify the fq_pie class ops
wired up in the previous patch do not crash and integrate cleanly
with the tc class show path.

The test creates an fq_pie root qdisc on a dummy interface and runs
'tc -s class show'.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index 229fe1bf4a90..3ef2fafa52b8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -40,5 +40,27 @@
         "matchPattern": "qdisc fq_pie 1: root refcnt [0-9]+ limit 1p",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "83c0",
+        "name": "FQ-PIE class stats accessible via tc class show",
+        "category": [
+            "qdisc",
+            "fq_pie"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle 1: root fq_pie"
+        ],
+        "cmdUnderTest": "$TC -s class show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev $DUMMY",
+        "matchPattern": "class fq_pie",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.34.1


