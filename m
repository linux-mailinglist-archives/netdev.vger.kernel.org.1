Return-Path: <netdev+bounces-186846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C58AA1BF4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C136E9A52AA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095E26B96B;
	Tue, 29 Apr 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnfFxaBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8D269B0B;
	Tue, 29 Apr 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957857; cv=none; b=sq/n9khLgcYY0qgwDLzwW6qGhSQ0/MdDmg6Oqebu7mQxl5mY02JC7hPD9w0KIhI+L9BYoyW26ugrAXYs+ipE7V3hX/dZA6AdEGJ+tzal12lwF9CfADuaCdak1RW9Fmny55eiY2cG1M5oa/EOkdj7ukFtXOr5e6JQr5tI2mUgNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957857; c=relaxed/simple;
	bh=H56EU1nOCCAUx61wOt3KPL9uqVgerVQaBRXIeahG1nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfEbOsWQd0Qm1QMsfypJSLV0fXb20CU4vWAg1Rgf/WzEpiAJY3iORfHoHiMoZ4NXiPbbJyhCDkKFiYWiBRD6y+6FdOquPR3Gcj2Me7N+x+RoSZtbl+SYakgMVSwg1tkvt8Btg462Lje+2hlsnR6Gt78j/kHp35T6AQzoKgk5wZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnfFxaBQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ace94273f0dso651232566b.3;
        Tue, 29 Apr 2025 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957854; x=1746562654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nIEJjxrvzj4Asc20e0VXhByYckHaoOwqjNexZFI2Ac=;
        b=FnfFxaBQwouygopVUEvmOY18Z+9L/tLNapc8WhgQ+FHddIuOHRpyPd5d/BvQid8d2/
         2FDZY1MKYzoGlsVh1U0T/Qh584N+6NlpoLLj9+WX4Vb6wsl+A5fiWRMaF/lhbBzJHZoS
         THYY0iGMV2YQUh2kGIXqHGYXF03QHsbaPy3JJKU1hgQrR8Ou8DkdKuPWTgXzyjl78Oke
         v5R1VFdgnah/Wp4lvVXd6ikV8JaEEBXZjp5slZKiUkacQpZaRRJjVwZRZRIOvulBBuh2
         na1y9da8x0CYvKHaMdHlDZ4oZgvY4wYvpz5zznBNSy87HjyZd2yfeFFeyZ31JfdtbKMl
         7TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957854; x=1746562654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nIEJjxrvzj4Asc20e0VXhByYckHaoOwqjNexZFI2Ac=;
        b=n5VvPxmgypeWJkrqtdjLCflkWuhb4f6xK8KxUo9k0lq4O31I6DLHyMRf69XmlspRc2
         5+mHec4rsZrn6Tgyk2McmX5Ga7C/p7DYm/Vi4B3qGJ/NJW2nvuR+3QZ2tTEBF/BqSQOc
         S8Akes927Ff9u4oj5+hbLaAEh40wmQs8st1HdvhEPILtWeyOo2Mxy8ZpUIAq8DofQOTS
         LmjY5Z+pzbJ1+LpTTMswMGrH0VM3DgsZWrbEjDS0j4qMj7m7y8FiZMGgNzFX2olmlRca
         WkfKNRRGR7/pYJDbB6tSO/XO4eAyBQbEWj4XsIRjOrnOf7FOkkviTw9vU250uy3+y6sh
         L2PA==
X-Forwarded-Encrypted: i=1; AJvYcCW+5j3k8+rodYXkKmOajHuQ2L/Plj4qa3pUhE1VuwVV5309GvxI7syC1kVwqOn1ga+B2FnyhqrYaS7UIss=@vger.kernel.org, AJvYcCXDWKX8aGzX1tCp5xXJ+dnXnuYyKnQMMY4sy2KOcw8Z90WsezXs7xDtROfbFMeQK9596NMQZqiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9RrJBzPijgsx32kpnz1NRtoemhgMIjsVoFhNsJyb94+RmpRl
	hLvKb6zCq7ziWWpfX4kulRt3eE2f31z49nSUeXGZfiqc268lkn9x
X-Gm-Gg: ASbGncvpWa6MsLs21dp7izuH2rTJd0YxzOPkhoHKi2oemp4gbo8AjY3dSkKEmKcryjS
	xz+QfoKDGmwc1ZJmZk6z0aXIeyFlonpX+PGvqeWrhhp/NN/ypLsSJBRsE4/rYnBS7/4JbIIDITV
	3KZaUvN0ArcY87EgBArvO/Qgpj0+WLbrkXD5zyCM6KszEPfmFKmhzDBSfn5Ear33E9Zhwlrh15n
	NcOQ9qZu7tEqG6ZejG4sV/Mbc7MFJHQyGpMyT17GTf4y459M28NMVs3PIluRb59jxvjxErL/wE9
	mxOuibw6x1kyNFTDuDzyR0hTWeyIULEIk5glbwTbe22lWZnTZ3B9pw4LRZJx7miHqqnfJ/At7ZK
	xAEe6stlxazxgH2k4vKbEq05aSLH5gw==
X-Google-Smtp-Source: AGHT+IHXntBnHZDI4DzAhU+Xas4tLE5FMaDTPfZHs5Vv8EdepdiXsFf6bG0wUeMMLYYpTuH0t4tbfA==
X-Received: by 2002:a17:907:d17:b0:aca:a204:5df2 with SMTP id a640c23a62f3a-acedc7932femr68388666b.49.1745957853652;
        Tue, 29 Apr 2025 13:17:33 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edae042sm823748666b.169.2025.04.29.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:33 -0700 (PDT)
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
Subject: [PATCH net 04/11] net: dsa: b53: fix flushing old pvid VLAN on pvid change
Date: Tue, 29 Apr 2025 22:17:03 +0200
Message-ID: <20250429201710.330937-5-jonas.gorski@gmail.com>
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

Presumably the intention here was to flush the VLAN of the old pvid, not
the added VLAN again, which we already flushed before.

Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 65d74c455c57..c67c0b5fbc1b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1574,7 +1574,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
 			    new_pvid);
-		b53_fast_age_vlan(dev, vlan->vid);
+		b53_fast_age_vlan(dev, old_pvid);
 	}
 
 	return 0;
-- 
2.43.0


