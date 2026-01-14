Return-Path: <netdev+bounces-249879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E6D20160
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C28130ABC41
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2225639E6CB;
	Wed, 14 Jan 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hOtt5b8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87D3A1E71
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406588; cv=none; b=gpIlfJMrudyoIRy5uMnm8mkbniA03cSGkERfSrgroSipI63SKV0WzDcDoXS71CNtuen0RZlCdPenU+HtWvKjL2M3+ZDn3pPZI1ORZGLJ+t42z/gZYu8QpR3Ct2E7M3B7xvkQRG823MVQXACV9rYcIyivjHKniZgGgtx6Zbuwgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406588; c=relaxed/simple;
	bh=2tLkH0/iG6vO8WMAh6IKcIXI07RsHDeTkCcM+lNhgkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhbH22dK01P7ckgvc6a/0oN8QqBu7jJGeHzkdsjde5B5X9W4T4s8o7edMVXZPycQ9R9P1NMDlzZu78eCVNn+UQJYk/QzbziGOSERDce4SMGi7BBxaGgBck8anH1W7n8OkkTvJuDlqecT6ZY59k9dTdMYvkkFG6OsUmoLWVMuuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hOtt5b8F; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50145cede6eso11388501cf.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768406585; x=1769011385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXy1jVjtlrtpHWoi7g7zkT2DTX6xQ93Wmc+QVAORp88=;
        b=hOtt5b8FKspBFExrv0R52+y1wO7iWgUT2ALXrthbacvIxE8E8rm0Jqgzfk86PKiJVi
         r7octe8BkGL+kA58kU1zaOFgzgVjfHOMMX9e1M8Jox9Jhiq0vVu1kOyifeg+N9sQmQm1
         p+IkFLn74I4DbXNqaicLuizalc+YT54+chnIW1D3+26G0irVe2JtZFxsA4nC3j1FzxDL
         wxCT3EZelv3SKPkrI/8NYA4b0S8pwi709WxOQ7GQRhrKbuEigohPbvbK9RsDQJZD7bUM
         /3u34IgFlgWk+3jf+NBbuyCKPRpYBO15jsfyb99ZlcZ3WGu2MMtgDIYWZ8O2UulbgGu9
         vGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406585; x=1769011385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXy1jVjtlrtpHWoi7g7zkT2DTX6xQ93Wmc+QVAORp88=;
        b=B9sM1a4ktdZrR81G2AhYYuZpLtsxFiTadFT18f1fLScx2uwLkQ/sI2nrweEaRx5kVJ
         AmtFB82WK4dGHRT9EWXpgWmeJlOKaizf26Ui/Fe76zbZaiODLt8gUAyanz0VQ+k/nGPF
         b4z8djU2pMzNgePOxQVHdCz7XiGCOI35s+7KdRaHZMMbccem9JDrBbI2ZaM5hxoKEnbZ
         E7TYWFKrSL4kZjAJPVZ2FGyHi0VqDmrHyKlaBDIDiihU1EwM1PcilkJS9bUcimk+khfr
         gjnTIhg2Ti3lRGPX+LolgSrbco4lM606ZcY2e0SIYJoI1l1Mbzc8xToKptQCUefJT8rS
         sW6g==
X-Gm-Message-State: AOJu0Yx7RHYy2dV6hwzHnL8/mVZZCIUoDWr8dzp8d4ueTgwOZ5z3A1Fu
	C1wgSEit3I6e5+t8hGoyCTgH0qux/nPnKT0CdB8Dpc3UntXIndd8xFrORIbe/LuD2g==
X-Gm-Gg: AY/fxX6hZ323MyNfwEzUkUyxDin4ugQ3Z7chQJqUPZClWgtXgHqo3lWQvdg1LsChXaH
	aC3sJo/pGv32es0/Y8IERsUXaarykyuAWsRzOL89vus58wyd8ni3jcIIDUzAwRqy1DFU5/c9O8b
	a6W61DR3kbJD2Oml1IiD+SkeopDLiMAyryLU8cbegLV+IdT0+5Rx0hw+s+uKAHeMipjHN3E8wG7
	ZGQ2DO8ZMhe2vEu8he8zPxJ925z4z4X3KCDRSAH96E/9bsMVyiLuQ+JpsC0yj3GdYfrKtMItCK7
	Bl0cYs6Fi8kA8dTx43AhzaA5tANsyMpD4TCVk20f1enoF3DPj0kkKclItuA9FNFRf926AMFnY2E
	E7mCnaNYv9yzKq6ted6HvArZgZu/JyYOpqw9tMEIObJTqSjPgqEp2AFkEkiH+N3yH6N5rEBlkMi
	xdg3SGiFv/GCA=
X-Received: by 2002:a05:622a:4d44:b0:4eb:9d04:bc4b with SMTP id d75a77b69052e-5014821c51dmr40868601cf.31.1768406584486;
        Wed, 14 Jan 2026 08:03:04 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc0e4sm15543451cf.23.2026.01.14.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:03:03 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	km.kim1503@gmail.com,
	security@kernel.org
Subject: [PATCH net 3/3] selftests/tc-testing: Try to add teql as a child qdisc
Date: Wed, 14 Jan 2026 11:02:43 -0500
Message-Id: <20260114160243.913069-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114160243.913069-1-jhs@mojatatu.com>
References: <20260114160243.913069-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add a selftest that attempts to add a teql qdisc as a qfq child.
Since teql _must_ be added as a root qdisc, the kernel should reject
this.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/teql.json      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
index e5cc31f265f8..0179c57104ad 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
@@ -81,5 +81,30 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP link del dev $DUMMY"
         ]
+    },
+    {
+        "id": "124e",
+        "name": "Try to add teql as a child qdisc",
+        "category": [
+            "qdisc",
+            "ets",
+            "tbf"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 15 maxpkt 16384"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 2:1 teql0",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1:"
+        ]
     }
 ]
-- 
2.34.1


