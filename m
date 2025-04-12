Return-Path: <netdev+bounces-181895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97551A86CE6
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4721A8C4A3A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C01EB1B5;
	Sat, 12 Apr 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dymjudEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73101E9907;
	Sat, 12 Apr 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460679; cv=none; b=O52CKpJrdkZosAq/zWLYUySK/ovUDBkynt1bRbaOI3eqy9Agww5iq7BpC9gMm/ouqfQTu0IqRAGKCAcS0Z/HNt+XDJh/CnoNYzBgtszXnsz/iReLSJNeANXEIVdFIQ7qJ2pW2k5weIEgakW7Ia7yznCb472n/26PHJYUwT2gawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460679; c=relaxed/simple;
	bh=rY1TeKaSapTBrLHShvIxdhjK3OX8149H0qymlwcITCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLuxIeNmVNSFplI5nZCCwZlMIpB0A1SdaY3Qgoixdcc8dGDJqxjCp+QccqgnT9rxwqSeGqLQ1WFo58YYXZe8oGv+8E7lW95iiv1rnkZMEr+mJ69FPATf01jyKmXsiM4JlvoRv5jLoznVR17nvaMnQg6/pBDsFgb9tFki2LeYwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dymjudEd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso540597166b.3;
        Sat, 12 Apr 2025 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460676; x=1745065476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkw2DLu2MuX4YCRrxN6mIReFgA1BqxAF343I23fbZ64=;
        b=dymjudEdacioc4vH2m+6u6YvGYd1i7cWWi0nttyWdQAIIaTqmLq7pGI25D5WjiBpRn
         DeD+C+mr3gb+MKqAPjZ6rPNz/MXQRLKnW8PYJWIaF5kz68iClj37eq8axo2ddcd7VlLu
         81Ecxb/gMrE2fYoQfo9qdaFiuvhvj9HNQO8jd9z1XUzhW3KZQfmXjqacEVW5zd5Pq1Gt
         y53fVS/wZoRex/+ZCDeWlNRqnI0/m4xj7jttogkcQBtva44HtTp/X4dtz5xlGrX0T1JC
         kxiA6MfkaIrVSGDbFItloZT2yMgvlvVCsfabx2pmEkWntEDNlhRJorW1ndFgMPhHkVHc
         HPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460676; x=1745065476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkw2DLu2MuX4YCRrxN6mIReFgA1BqxAF343I23fbZ64=;
        b=NgQ85fs33k3mnv733xVrGBbHSRVOTfWh8kTOBniuk46QlkwOBG0yCSzAKnc9hkNDp6
         8iFweonldmBX/6avDmf72wh628X6zr1LI3PgsjsiAWAjWLQZyCmZNjQ4ZC7GokOjkazb
         TjfcEBpLAa3lf3Oap6lV9ePNG3sPPZ01nGob2vzb9DkMdr5X905tDMgsfpCGiXfirZ4r
         /ZW21bwuxvPdGb6Q7G8GICECMcp+yTIV1CztrlNF9+lofTNRfJ+fGvt4gFR4qgAUe5tV
         f3THclTpwVoxqSrOCXTPoLm9R5Jm30+BBH0fAv46JE97vrwY4zjs2mlsMe0Ng46O5xmo
         lG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkneLRnrIaDecQ9bOJzgMW/W+58DXSBXuH+uiAhO4re5YZaDmy0Go0jsIKl39wvPNV6Bh8wW1b@vger.kernel.org, AJvYcCWwuzEVPxtRx1e7WhC5/Z1XEUKENyaXk/Y10lqk3t35OiPy+iXdwhfLlIxiJt0x0jljAsuNFcUoRixmCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7Z88iiICoePUj//D+BHJoeE3ZxxCK7hOYadcx6ZnvsMEZOZq
	3Ix2fGIzpaZy4hG6VGPrP4Z6ZGWSotJOuO7Nwq88UvM5i4nM8H0j
X-Gm-Gg: ASbGncuCR4KwYFJ9AG5ykIKCjQSB5kSdrbNFxqN6ulDpGDui9wMmziKBKhrYCaUh2Kb
	8/AYE78zUpXEp7fDj6S2cg56WF2/Zv1I+vlyf7rt3+RK1KQuH0Qa5WY7q+nSIpCmX96VmURZtBR
	P/giAP0thCghgRNh7XhdZA7astgH50SYTpUIJeVgujwxxcjMgH5A6ClUSgLPMmdsED4fAV0ptNd
	TweFQUB4tl8ydNN2zq/qgsUr0lZfA+xIQWc7PefON5/kH2BnqZL2fr2uR9rBGGKxnbsDmAtbXcK
	UNnSnmH+E/7KJEvsS0ibNGky9tSKsiLy3G91ekAh9Cx8MyaNtTHKg3FylNJjakZ8sWVFUEFIYaX
	f4fmOAc/SSPzoleV9HtXi
X-Google-Smtp-Source: AGHT+IF6b7JdMoOluM6K7HRrjYFSRBdYLvJnP8t2CcaA5YsZbKa8oHLzNRX8VZ7oAaKXWjrBmMk0tA==
X-Received: by 2002:a17:907:d92:b0:ac3:3fe4:3378 with SMTP id a640c23a62f3a-acad3456bebmr548716766b.12.1744460676005;
        Sat, 12 Apr 2025 05:24:36 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bed98esm592465166b.72.2025.04.12.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:34 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Date: Sat, 12 Apr 2025 14:24:28 +0200
Message-ID: <20250412122428.108029-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently any flag changes for brentry vlans are ignored, so the
configured cpu port vlan will get stuck at whatever the original flags
were.

E.g.

$ bridge vlan add dev swbridge vid 10 self pvid untagged
$ bridge vlan add dev swbridge vid 10 self

Would cause the vlan to get "stuck" at pvid untagged in the hardware,
despite now being configured as tagged on the bridge.

Fix this by passing on changed vlans to drivers, but do not increase the
refcount for updates.

Since we should never get an update for a non-existing VLAN, add a
WARN_ON() in case it happens.

Fixes: 134ef2388e7f ("net: dsa: add explicit support for host bridge VLANs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/switch.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 3d2feeea897b..dc3cf13ef29a 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -702,23 +702,25 @@ static int dsa_port_do_vlan_add(struct dsa_port *dp,
 		return err;
 	}
 
-	/* No need to propagate on shared ports the existing VLANs that were
-	 * re-notified after just the flags have changed. This would cause a
-	 * refcount bump which we need to avoid, since it unbalances the
-	 * additions with the deletions.
-	 */
-	if (vlan->changed)
-		return 0;
-
 	mutex_lock(&dp->vlans_lock);
 
 	v = dsa_vlan_find(&dp->vlans, vlan);
 	if (v) {
-		refcount_inc(&v->refcount);
-		trace_dsa_vlan_add_bump(dp, vlan, &v->refcount);
+		/* Do not update the refcount for updated VLANs. This would
+		 * cause an imbalance with deletions.
+		 */
+		if (vlan->changed) {
+			err = ds->ops->port_vlan_add(ds, port, vlan, extack);
+			trace_dsa_vlan_add_hw(dp, vlan, err);
+		} else {
+			refcount_inc(&v->refcount);
+			trace_dsa_vlan_add_bump(dp, vlan, &v->refcount);
+		}
 		goto out;
 	}
 
+	WARN_ON(vlan->changed);
+
 	v = kzalloc(sizeof(*v), GFP_KERNEL);
 	if (!v) {
 		err = -ENOMEM;
-- 
2.43.0


