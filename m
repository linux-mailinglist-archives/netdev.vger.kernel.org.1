Return-Path: <netdev+bounces-194659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521DACBBF0
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0133A4687
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AC13BC35;
	Mon,  2 Jun 2025 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKvPR4r4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F204F5E0;
	Mon,  2 Jun 2025 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893778; cv=none; b=NbhzBinIKCiRfqBr4wUs9jrJieI6ohUnAQ5i+DkV3L3Bx9WvTCtTEU1AmmmYvJTCSFIhMS95aI9tVEJuKs78wAoWAwvjlbAsn5UKCeBW6Xk11hBfGVDxRwU+WfBvI6pEyagMUTCeqTAONXKD6rP/jrjj3u3WPbjFauqDFCxCKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893778; c=relaxed/simple;
	bh=YfdlVVEw/6/rdApKtBlpYYw976lAfPWt6/Tm6qeJB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGC8sEyrwFZYaIW0WMrh73/Qqo1X3CtTy7ZEnq26whTQtdha83bvt8pmhx5NWgSaE/zpH54e1ljb0Omoa6R7VaKc8dCFMZZqt6ueHy61mFzEvvChpf1uBAnCdbOwqJ6jZBemMunmxRIac46vC8fWZp6fv1JWWORI/ceWa1hxsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKvPR4r4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adb47e0644dso440942066b.0;
        Mon, 02 Jun 2025 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893775; x=1749498575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JFnvzbjUuGhVJFj4lgN9kbadYFKhk8KIDJQTTgCUdk=;
        b=RKvPR4r4nUzSCGOAl5En8refdI0N2qCGmmYcgua+7SXkNZ5G6m+fKZ4lmvj7Oyml6f
         Cz14qsbU6ivfZjE+UGFm9dIMjQjpoeE40AB7nttZ0JdVf9wENG5GwKfLZ2xQoakLCO5D
         1l7QLnGv8Fx9Hutw2ok2nW7f+NEiYfPtyl4umrIfJipds1C09p4mAMYRRYXz+oPEAePj
         hRo157zDWnsM3jc08AKXM5LCL31nLWC7gkiCiZR+HMfPvqvL8Z8HVEO9zJvpueLLx7T4
         BPyM10p3PhHstK0VPJkp+hqTKhCTvIAHwRqWl8OrBSPycpUl+vYToDOcmUhooSo0Qd87
         SXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893775; x=1749498575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JFnvzbjUuGhVJFj4lgN9kbadYFKhk8KIDJQTTgCUdk=;
        b=csoMSHm18qMIoy34wCid3JWLZJwvsuthXVEPsMt2lb/d36WyTjP3ifn4nGAvdjiREC
         UemdU1ZZ5R0pwfwI4F/9n6H0qpKMmzoBcHC6XyLrjFM+K7wxui5lQOvwWIT8X9nVDh0g
         dfpSc8Xt12LT3PZPXfU86QBaNF2WK/K8izAs5jQxQEOMP3TY922GoxtuE0RhKdSkEj9b
         RQ80GxBkzkUgv0ehi1IbqWbi463qdFY8L7hBW0MJnLXk/HM7A5qWLDWz+ks4ny66GpgJ
         nB1/Kd/kZ2tS3EW1NBgqbPAZtR/CiCMYdNjl12wO8xoHMS6xUnUdzpG/14AM44+fb2AW
         BDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvbf/sz8Mo2XRQk7Z+UaJBndOvnyc5LHc1v4ve1icxGAXNuAAfti8/pwt06tD74cKsL4/KiuqXzYyHf2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQM4pqQxXOXXiGlnfN3jrTXy0z1ng9KjD/tLP/ztLacy6bqgL
	562n8IYSNULjYJpBoBSu0ftcqcXYx1fzBG4rd607AQVNKZm8VlAnr988
X-Gm-Gg: ASbGnctr/zHTyUuC28b7vnB7c5Y73JNznXuTPW8DO7Z+HeBYI7BUJJwaLqQZgc62VnA
	QY2SIrphjvTwSUej+pWS0AhFFpEtih8tITPXsK4xKVR3eAnhMHMXaAUosKcoPuzZymmxu5MFBnS
	+yfDWEkbEvdTUFKIMmxkWDBgVpn5E2hywy0/ZMw9ZxQWGftkrL0QfD0OOVbKmQ8T4x1/vq0OSS6
	aDfdN8DOKo2eMwyve95kxUtEiiYIogY2q9+VZtmRDbIJ3Hr4JzOXr6e7ruOabdXIpNr9sALgvuQ
	1qV6Cl7XTa2AzpFl49DSjz/iOzliHh10pkbkwQhlPOrMIlOZavwjZ59v3UoVDIJSHaq1/Fcr1mk
	zZgdr6J2G0dmWxpLLCg1HqVbpxU9mWTw=
X-Google-Smtp-Source: AGHT+IGPsYM9exsx9ePJFNubHcPZiDtwnOjmoDPhd9AFlpTMUTQswskrVkz8YeRL6XBGY8badAqsfg==
X-Received: by 2002:a17:907:868e:b0:ad8:93a3:29a0 with SMTP id a640c23a62f3a-adde0d54c7cmr71988466b.18.1748893775387;
        Mon, 02 Jun 2025 12:49:35 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb4292ae03sm498280166b.80.2025.06.02.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:49:34 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu tagged with VID 0
Date: Mon,  2 Jun 2025 21:49:14 +0200
Message-ID: <20250602194914.1011890-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Linux sends out untagged traffic from a port, it will enter the CPU
port without any VLAN tag, even if the port is a member of a vlan
filtering bridge with a PVID egress untagged VLAN.

This makes the CPU port's PVID take effect, and the PVID's VLAN
table entry controls if the packet will be tagged on egress.

Since commit 45e9d59d3950 ("net: dsa: b53: do not allow to configure
VLAN 0") we remove bridged ports from VLAN 0 when joining or leaving a
VLAN aware bridge. But we also clear the untagged bit, causing untagged
traffic from the controller to become tagged with VID 0 (and priority
0).

Fix this by not touching the untagged map of VLAN 0. Additionally,
always keep the CPU port as a member, as the untag map is only effective
as long as there is at least one member, and we would remove it when
bridging all ports and leaving no standalone ports.

Since Linux (and the switch) treats VLAN 0 tagged traffic like untagged,
the actual impact of this is rather low, but this also prevented earlier
detection of the issue.

Fixes: 45e9d59d3950 ("net: dsa: b53: do not allow to configure VLAN 0")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
My favourite kind of fix, just deleting code :-)

 drivers/net/dsa/b53/b53_common.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 132683ed3abe..6eac09a267d0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2051,9 +2051,6 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 
 		b53_get_vlan_entry(dev, pvid, vl);
 		vl->members &= ~BIT(port);
-		if (vl->members == BIT(cpu_port))
-			vl->members &= ~BIT(cpu_port);
-		vl->untag = vl->members;
 		b53_set_vlan_entry(dev, pvid, vl);
 	}
 
@@ -2132,8 +2129,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		}
 
 		b53_get_vlan_entry(dev, pvid, vl);
-		vl->members |= BIT(port) | BIT(cpu_port);
-		vl->untag |= BIT(port) | BIT(cpu_port);
+		vl->members |= BIT(port);
 		b53_set_vlan_entry(dev, pvid, vl);
 	}
 }
-- 
2.43.0


