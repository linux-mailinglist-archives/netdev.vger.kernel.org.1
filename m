Return-Path: <netdev+bounces-186847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A8AA1BF9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF531BA6C51
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720826FA7D;
	Tue, 29 Apr 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjrbfYsJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22126B2A5;
	Tue, 29 Apr 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957858; cv=none; b=tMMuEXRj+Q8NBkgjBibV6ifwPGWEOn7Wh4/pnwQAdsV7rB3nkuQbKaxPp3OGop1JHcxfAOAm2a6P82Zz1j6vLDxuypprxf5Np8v6ZUTgFlcTuGj47qj6lfzldCeX65uex1Xi/uXT36YnYY0UbLuBDAYjopA0NPSSJFqMrq/zyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957858; c=relaxed/simple;
	bh=RLksTWtGHmiTsmRBrna+i1LQAzy2KWB4lGxxw9TFphU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwrBCmL3UrZeKW35WQQcBEyXu2sksSkNhRjxxcU8DajCD1Q88oRkq/rFL/nfybU0gS4M695Du58m8JHkBzJuIfDkT8Q1zu3JfdYgROg5cdBGfVBicRiC2lFUJUOULyP18GBB3Cuc9kBSy+Bpy7b15LUy9VXugicxahaxvktlkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjrbfYsJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acb39c45b4eso1029689666b.1;
        Tue, 29 Apr 2025 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957855; x=1746562655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2T/Nq+E7u0tUt+84S85MGhz6BU3szmSWHsoQxePGLA=;
        b=NjrbfYsJE2QwNupjOFsK8l0XdePSZIJZGHfAvN2YMuViiYQUHvvVpXqQQQwsox2pn5
         ml+gAMkBdHkKD319KJdfjZIy0VLzimHGbBOa2MBGVgTNzjJvV5WVE4r4S1GJgcnby4Ph
         OuATV8vGdDe22M20qA5y1sHZcuJAbDbbBEVpacs4pH8CL+nOyI7KiF9+e4lfxVvKjm4z
         1PYudeQDYPBRzIvZlTjrsC8Egd/gxgq6HO2YdoQLINJOBkNDpbW6pFpVd+pBIdGllC34
         Vh9Q0/WVykJkKATEUvNtNO1Pd7NowJlquaeo0+oWBGpkIGarzsTwxJXlEIfk0lYyRGdK
         Xbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957855; x=1746562655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2T/Nq+E7u0tUt+84S85MGhz6BU3szmSWHsoQxePGLA=;
        b=MisSJc4T61PEjurjD66ZEQ/oI1eb35iXng+6jKz8t+K/oRfkDaZbbPJdR9Hw8FTBHa
         QO9vsfZYHMPDCHYqNKULG/gRlfEuVI0FUwq18jBmll1+vMxtnlPIJUuQ7wViQMkM5739
         LR+2RrS5XM8oEdG/jUSNMApZVgr57L7M6WYcbEfEKD+EHb6BPXtQAGN0n9WH442ZKoQe
         aCCsaJrlLivhujNxMZTVINnBT/N4K6Y+PHsOTurrFzHSqYT8G68IPQ94gp6PDWCOgR6F
         u5k9YrDlH6/JJ5sTZNlnjvTBIbs8Xy1zd+khM1eLq8FYtjHnPQHCmQyBJ/uGvBIynTF6
         oSGg==
X-Forwarded-Encrypted: i=1; AJvYcCXNj3HPDqrGPWvPNJDPiHlVKLmc402AcGqZXMND1tJVKVJ6m9gxJ4GkqOfAq2nDin+AIBmhfFD2@vger.kernel.org, AJvYcCXQ7QFsmG+aBLBwKAmW/gcbUZogGUSEtfmJZ15uvs7LcHkHo8KkRWeKzxikOAX92LG62xHynz8CkpvCQyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+lTpD7aV70oM04B0EP4uCeiKq+dERg9rLjUClp6E5ztdqyCW
	iy8ECpFd8fxpJHZc1UyF28nEpkwUUEu8Bu68yBOXKRm6MZsGUdsv
X-Gm-Gg: ASbGncsCl7nyl9rmQSqBm+oq/oDNsfJwRNZV1zR33MKhS4kmi6Ld2hrNtI3QAOkHljJ
	B9PA5IlPt9S82Nws7lGMB0d9x612RpSOGYwb7rP5Y67Q6D44Amo7Hcdrq5wmQ36/1UYvMh3dmNu
	r+fBRHJP59AuTzFZ9S1q9kIuqmCuz/f9xO/uvbBrZchRxlFd/m652ymx5NVxr38Jv/1uXgM1nN+
	5gPvzCLDUYTh1WnVnyx4Vrd95APePJeSG+T/DrNNo1TovkmtH1rJQh5CoAA7DcLLeppUIAnr6Iy
	64rIyd7RzSySkZFlu2SuQff8pf0dAelugrPAdZBL7ujZROOLB3bpHSgN9S2k9QMbH31dxwv4kaz
	Q7zq4xxK10MOCf9DBBb4=
X-Google-Smtp-Source: AGHT+IF0hE3VphCT3CRveCG8aAazxAb4JKs5W/aiOXMHMCG7iamIfTXX5SOPcXtbsYaadftMVrIiAQ==
X-Received: by 2002:a17:906:f58f:b0:ac7:ec31:deb0 with SMTP id a640c23a62f3a-acedc5945camr53075366b.9.1745957854904;
        Tue, 29 Apr 2025 13:17:34 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed72826sm824039366b.154.2025.04.29.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:34 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 05/11] net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
Date: Tue, 29 Apr 2025 22:17:04 +0200
Message-ID: <20250429201710.330937-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The untagged default VLAN is added to the default vlan, which may be
one, but we modify the VLAN 0 entry on bridge leave.

Fix this to use the correct VLAN entry for the default pvid.

Fixes: fea83353177a ("net: dsa: b53: Fix default VLAN ID")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c67c0b5fbc1b..c60b552b945c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1986,7 +1986,7 @@ EXPORT_SYMBOL(b53_br_join);
 void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 {
 	struct b53_device *dev = ds->priv;
-	struct b53_vlan *vl = &dev->vlans[0];
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	unsigned int i;
 	u16 pvlan, reg, pvid;
@@ -2012,6 +2012,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
 	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
 
 	/* Make this port join all VLANs without VLAN entries */
 	if (is58xx(dev)) {
-- 
2.43.0


