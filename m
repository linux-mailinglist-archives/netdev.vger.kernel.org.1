Return-Path: <netdev+bounces-228880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D77BD5729
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107234F33DF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878A2C08B1;
	Mon, 13 Oct 2025 17:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31C23D7F4
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375371; cv=none; b=eY+N9xOZiLQ7PGZzZo1GZ24dVSYdmVPWQSPufyyGiSFkQ0CJ1ER1U9+vqXlJJtbIAsLCe/QGlbndtfjKcDrbuzxbVB9gUUUciV/k8/kSBHYdOPdHmPoSahDNJOTLWEJQnw+DSGmS/FICR29U95A7QxMkf8FB15/wJPvPCF7+o0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375371; c=relaxed/simple;
	bh=GcsJsmNR66TkTqTz1B+6YFyl+EAGJv7TFYbWgcNErZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bU+bIHdIQ/+ajFO/dI/5rAkpNa0RBwlo6gSaTcjMrVrzsCZ9DKoOPFsqprUKHYlI7IKA33jhz1cOuxhbJR1Te+3lhdcLpw87yRMDkk/h95pdYW1COhxhE+Eb8mnkoh/LPQ3s1PGmcTkfTaQAU157297UDRaWOYrW6S1+xIXWWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so637718866b.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 10:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375365; x=1760980165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzbk+4Totk/9NHbsfjmJ9rzLfO5PvmO39iyLAhqUy/w=;
        b=uept10Ydm1qg7IwS3107hVtjQzUYU+EjURXzCJB02UUbJEV0G8dZtWF/q+4fDWV1vu
         /Q6hgoIimn3wBEcgp2E+B0ujUkEz0kjDEn6yULwx2QQb4FrC3tcDY9gcRiJEwV2CKZN3
         lpzHB9LD/pPyP89YtFyjZfkK0Hn4mJjG/aHAxjITbAni7uXcmavWtYZHSL5U1MzjlTrh
         FT5fDrl7FErXInM/fjNiSTMlkc6678PjCdTHrI18ZMupHa34cM+14/KbfjBq9u5/aor1
         Ts8xkGXSXEFdJsKd1LHI7+OTbb+/IGYLXUKlCiyKAE0xPyBHSACS4uTPahSEbY9EDSqr
         3vhg==
X-Gm-Message-State: AOJu0YwgGtfzCcY2oaItvPEG7uk21f5UFbcexVYm52XTa1nu0muA0lXH
	0m5/O2p0a2H+Hxj3nhxPPxabDZrBxd7lqLSGHGFHxARFbSPm7pepAAe2
X-Gm-Gg: ASbGncv9etmRnN204GBYYuwkY8z0Oma1DYfadGKja5Md273lrsZDNNujtHSZog1bfO+
	Jb0Q8Zc0CxX8QrnWRVvFATu2hbmopFxLWRhqQVqq3GwX1t7/h5IPUrz5PVeEH4xatVeq+N2AVMz
	MoBgC1uxFpftbQi9W1nPk5O96RE0jDe/3zgEcL+laoURQ3yfF0o2QEb+bd88WUMfuj6lMAaaUEa
	ufVPo9qvhoDZRGj9pq18JCGJjgbM5JMmJppGKmIcOJbgGj2Hrq2yn65timMF2k9JlR/gX5k722M
	wMkezy6tnM6r0t1HEfdZna5Hq37auzV2kMRFDZxQD9N25Atmg2GW3i9UuDXIYHiHJ11v/wc9FQ/
	6lMv3xFl9tdaEKfWlxBXq8MEu4L7ivcYVR/ZkAriRryZTuVA=
X-Google-Smtp-Source: AGHT+IGt5kR5F8pvKrJpygfr2pjUntgvPJaB47lL0nD0FC9FyzJ3Jztqt6mIq5PEXkSvc0BpQWVJcw==
X-Received: by 2002:a17:907:2da9:b0:b4f:e357:78f8 with SMTP id a640c23a62f3a-b50ac7eb031mr2337168066b.52.1760375364369;
        Mon, 13 Oct 2025 10:09:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61d04dfsm968072966b.22.2025.10.13.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:09:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Oct 2025 10:09:22 -0700
Subject: [PATCH net] netdevsim: set the carrier when the device goes up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>
X-B4-Tracking: v=1; b=H4sIAEEy7WgC/x3MWwqAIBAF0K0M9ztBe1FuJSKsxpqPLDQiiPYed
 BZwHiSOwgmWHkS+JMkeYMlkhGl1YWElMywh13lltClU4HPmK8k2eLnV2LrGVboufeOREY7IXu7
 /6xD4RP++H+ng1TtkAAAA
X-Change-ID: 20251013-netdevsim_fix-b9a8a5064f8f
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=leitao@debian.org;
 h=from:subject:message-id; bh=GcsJsmNR66TkTqTz1B+6YFyl+EAGJv7TFYbWgcNErZA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7TJDW761SlNjpZNmbozNyChyMxtw+94H7IFC4
 YVqbKWDUeCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaO0yQwAKCRA1o5Of/Hh3
 bWtOEACdABdg97kR6gRbybCU2xqATK1KstssSfsOUrtyJ1FRnjIzSVX7e/gF7GVdfFmtyJzqD7t
 QO0+vcYxeGIW42+omO2ALE9lNopeK3EPhi/X5bvypiqLqSRaFBqNidiA2ZS4K4OZLDVBUrxoFRG
 slHsLHOqf0+GgDGvoF4WhM+4hNBsdn2UiTx77peuPME/QJsqkBtOAEars11h4sYYipFE01vOwTO
 u4wwHyeTRSu6oc2SsA4b8u0XRyejsQIRix75bJsjmnoRZoV68XqD7gmp3bbnzsBuvynq8ZF49Ez
 kNmx7KuK3GvVlRUjFpnd+pD/u9ZeK2aBawj11oTWKJne5j61Hwn4979RLM5zvfQ1iYTLgTVmwZV
 fJZWInQRX5+FDf/qhwDONGroVCpt4IoHcRZ75mDGKTHbFrJpEmtRbUu4+p6IXu7RzhToatBzUtj
 WmrKUiUYA4xIqKbjkkHWstGMfU/kK/CzXtWnmNJ5sRMuVhlrrmLQc8wO7FgWK8G6BhtJkELmn0Z
 ZCrlIxUAn16LKYT4IKCW0P+SDWnRodLAKfkwns7Zv/qDoxDNUaYXTfkNnjwSLOezO6Oa6doOEmF
 MNvYMWTCQhhJMrXs8diQ7oAW2z6FOaYMuOiLsrSEW0OqXZX5cIdEqkn46+yhgT7JxHbbD9Jl1hh
 J4ushMPWj2YQKIg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Bringing a linked netdevsim device down and then up causes communication
failure because both interfaces lack carrier. Basically a ifdown/ifup on
the interface make the link broken.

When a device is brought up, if it has a peer and this peer device is
UP, set both carriers to on.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")
---
 drivers/net/netdevsim/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index ebc3833e95b44..fa1d97885caaf 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -545,6 +545,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
 	int err;
 
 	netdev_assert_locked(dev);
@@ -555,6 +556,12 @@ static int nsim_open(struct net_device *dev)
 
 	nsim_enable_napi(ns);
 
+	peer = rtnl_dereference(ns->peer);
+	if (peer && netif_running(peer->netdev)) {
+		netif_carrier_on(dev);
+		netif_carrier_on(peer->netdev);
+	}
+
 	return 0;
 }
 

---
base-commit: 0b4b77eff5f8cd9be062783a1c1e198d46d0a753
change-id: 20251013-netdevsim_fix-b9a8a5064f8f

Best regards,
--  
Breno Leitao <leitao@debian.org>


