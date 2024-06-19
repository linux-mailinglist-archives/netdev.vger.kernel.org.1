Return-Path: <netdev+bounces-105069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7B90F8CE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352571F212C0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1D7F7D3;
	Wed, 19 Jun 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOlxI/gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D178B4C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834940; cv=none; b=Gminz4KVTAgbTUf5jcOonoCknt/6NuuAb1kCmwxH21q47L8thuZgXVv6rirSsL22NiIvZJEmz93GBVBrgZlL1AUXKmEJPDiO9bcon/1VP8VPz60wmAy2IVOioR6uBKPdngBzWw3SnUWqEU85i8WZk/nwcyeotTvO+xqZpdtF8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834940; c=relaxed/simple;
	bh=/pOQgw9kCGvw0wOH1Y2apYohmquBLKtpUQYEOhdkF/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kzs1qYCsjmvLWbOxG+P6y49HFlHdNFkBZszvt7nCW7OEf38rxOrRVF8qp2gk1E1ogEaKdB3JBdt8CxpW7FhnTE1jZtLvvaa8SaEx9mlURxYgou77cBTElS2RD2/Z9HHBiIiI+shjap65DUCpR4Y2fhl1nGe1EyxG3WIQSeGaUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOlxI/gQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-795482e114cso19435285a.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834937; x=1719439737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igD6hj6MmbdFND+MgPW7YgvErDPfhDh7tnCy7E0aVms=;
        b=dOlxI/gQBpOI3PToZFl932sKDjfQ+SdsJyLk9fbnKtAmKQ+sQGTzZ27/BIDIeFTc/a
         p2GeOp3c32JqtU4TcISQcEVT7d8M0Lhq44mXfwiFPQOAekadtOcOyueMi4zfZrPWM1u/
         dRyajfJiqtnsXnxK4GQ1z0lv3lt++7WjY/yaDCXFq4PGhq9iB0qW2Ksmra/2jYE1OK0m
         cWXv4ZL5bjzIweZFc7WY0hpjB+JpbiLmlqU0ACtcbVu/QK2bAAvAMotg2T+hXISkyTBj
         8yuYHKCdu7RB1pW5bEH8BwTFX1dujDz53JOUbg/wdVO7hn6X7aDft6Z1laMv07F7i2Ib
         Xebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834937; x=1719439737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igD6hj6MmbdFND+MgPW7YgvErDPfhDh7tnCy7E0aVms=;
        b=tcPKGWR0OzGlg7fJRWizby/h2sVTacX3ElR+qkY2+jjQmufn/Zk/5lgcEUt6pnJ74L
         L1JH6lEWimveDpZ4yLl6sFv+Sr1/3beq532NuDW6S8ZAEEQs6YyX1awTQfX9KRB+/1wF
         h7y84Aoi0DZ8lO7GZw2HviHXK4gw28qMRPv58qSMA297cF1OmHUpLgwa2t3E50bceMVF
         sDDSlyWh4XSE2nLVOC/d977f6wL/jm1FrkqWjfxdIal1hWuiREfDC7fNd44YpyPG6PDI
         hfz63RhMV2ol2dQtzd/CuuAkjaCH4FeoO26ydwvf/Kx7t71p88W2zP8X00Q6wWBhX/Ec
         nZdA==
X-Gm-Message-State: AOJu0Yxhf04LbzjvmIJoY5iBoreB9E+wAdJflALq51iqkVX4l10AvM6j
	j2W6USjRe0nFErcMbvEe5NAfuXtvAeWZMqDIODPEEYZy7V8+bq15cavzPQ==
X-Google-Smtp-Source: AGHT+IFIBgB0MB8G5G1g9hxWUllH0Y7MeaUodCEI5Dn9xX7v78/rh4cu5m7ZdpJqOndO//PohtGcQw==
X-Received: by 2002:a0c:e346:0:b0:6b0:6443:7fcb with SMTP id 6a1803df08f44-6b501e0bbebmr45336616d6.10.1718834937298;
        Wed, 19 Jun 2024 15:08:57 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1ceadsm81849466d6.43.2024.06.19.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 15:08:57 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	dev@openvswitch.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] openvswitch: get related ct labels from its master if it is not confirmed
Date: Wed, 19 Jun 2024 18:08:56 -0400
Message-ID: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ilya found a failure in running check-kernel tests with at_groups=144
(144: conntrack - FTP SNAT orig tuple) in OVS repo. After his further
investigation, the root cause is that the labels sent to userspace
for related ct are incorrect.

The labels for unconfirmed related ct should use its master's labels.
However, the changes made in commit 8c8b73320805 ("openvswitch: set
IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
led to getting labels from this related ct.

So fix it in ovs_ct_get_labels() by changing to copy labels from its
master ct if it is a unconfirmed related ct. Note that there is no
fix needed for ct->mark, as it was already copied from its master
ct for related ct in init_conntrack().

Fixes: 8c8b73320805 ("openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/openvswitch/conntrack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 331730fd3580..920e802ff01e 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -167,8 +167,13 @@ static u32 ovs_ct_get_mark(const struct nf_conn *ct)
 static void ovs_ct_get_labels(const struct nf_conn *ct,
 			      struct ovs_key_ct_labels *labels)
 {
-	struct nf_conn_labels *cl = ct ? nf_ct_labels_find(ct) : NULL;
+	struct nf_conn_labels *cl = NULL;
 
+	if (ct) {
+		if (ct->master && !nf_ct_is_confirmed(ct))
+			ct = ct->master;
+		cl = nf_ct_labels_find(ct);
+	}
 	if (cl)
 		memcpy(labels, cl->bits, OVS_CT_LABELS_LEN);
 	else
-- 
2.43.0


