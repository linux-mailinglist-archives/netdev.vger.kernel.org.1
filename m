Return-Path: <netdev+bounces-197728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C9AD9B25
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5420F3A2EE6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1F2165EC;
	Sat, 14 Jun 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgTDmEdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0960213E74;
	Sat, 14 Jun 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888022; cv=none; b=qMao1Sj2Rp/9ujMxy/3kXtMzHEo9vftxj0jKNNQRhD3C+CdX/oBIVXv8tDiCsEy7mcPjW89wZlUWXAXzmwzHYGBi7xNuQ6sLrTayJf9GvL4v0f9UP7uKAtJsOC/mbWJ8xdbu6d2Jx9IEDM/srSRFrUCowKNjV+1qbBJkrIuZjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888022; c=relaxed/simple;
	bh=jI7h90HuTxp+BOmcIzeI4V3HFQ58DfYw+6FufhX2uO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt/YxCo9xLC/t98u3O1cPocnxcvzoFlrXkPG4KUOAbTT8aATRu2MD09XuNv7nKLbcsgN57A6gdCUm3+FoyIip0f7QtWfh5kjR1XcVlpaxfQzMzAhDHSpXp0rS/XTF7uPsyXh5km7s1lE5yKF1pje6xT6n+EWa4ONn/jSzbu6Veg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgTDmEdT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so2256657f8f.2;
        Sat, 14 Jun 2025 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888019; x=1750492819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgMPt/38g/Hs9S0fWSTZAkBpKnbwpsi+zVrrd5GjeKo=;
        b=DgTDmEdTIdG8zwxzlqjTyf7YLKxXZqm0HqW7pKYKCB/iRsWpEpH12FQi0u8QfDN8+e
         KR73lhEYRraObxbkxFQwxeWvV3SWJNzmQDa3L2AxJlz0ly1v/DHSCUFZ4ePVKB9arQcd
         V30NhLmyvwlo4GQsdbOgZwGCGhZ9Sbp3Ug0Q+nGr8tDeEQ10x4q5FkeNtKlFymD3GF9+
         BVOJoEj+11aVN+L7rwAAtFRMU6WMZnPToj/+kT1xfTnfnDb8fGYtnDU70g3wlPiba37h
         iEth4a7WrkyjiK8BIiy5ueHdRVrTphcJZEglM6K1gDmI3vrNSZmxXgiSZxfiLmWisbSM
         MpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888019; x=1750492819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgMPt/38g/Hs9S0fWSTZAkBpKnbwpsi+zVrrd5GjeKo=;
        b=wvzsDIlNM8hksNEQJ4Z7A+ON3IZDF38tr6Xi2kIxZL8foV0Z4iRZZ90kc4GNLnOt5c
         gD5NJcUsxLVbYerPUKcRI/DWJbmWZRdAn1JBKrzxetK9naKi0VVIEEJRZxduhsmtlHZH
         dugLO0GXHw4y7K3OS+xjyvbaIfphplDwCUouzBj/dvINb7YqNfuMzdaPgDQ9qa1FDiBZ
         +145FGJgkmMTUb7KhXE+EZpM1sC4hSwQWLgdZQimzQLUO7Jhpl7oqo36GVhcP4fXVQjD
         3WPTQ+gxAqjPtsqzUfR1DbMI7fFRwEiD9KE4IYM/YRPXkv8XWXTq1tLFTUNCQsDnO2+2
         MPdA==
X-Forwarded-Encrypted: i=1; AJvYcCUKUbqLuowy2DItZtinbByKPK1nrN0u40HhZQB9PWlk0UbarAyIx5saYHQNGqkRLoxpzfmt8JWU@vger.kernel.org, AJvYcCWJ1PrMzOEkzdFWPaWDPH18VWrSoJ0qfCGoNwm9cywPY0YrQKguJuePeYqirDbZ2CRWtfKIiGzLwmEl3Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxnktJAd98VsWeP1+mi6rbPXCjbCPfIApdywxQAew7Tz3BB8o
	HTmUWCF2uD0XpUb4FTO6kjqJ4d225zxjGcpbY1zhJTLLo/+M3V8nSH0R
X-Gm-Gg: ASbGncugLfo/TgOgc7FWVpeHU7JPS2alzyKeyv67z7gwkcJrIxDDmvsWuYJlSuUxOd4
	hSaPmDK9L1lH+NAJGQU0w92oL9vODJJg6j10998iNzBfpnOfEd7O6z4ZASVP+zv6eA5VJM1Xyy8
	vm3+DlNlB4Lgu6XWc4AIRhPcqbMAJgKGmj23B19kepRV6aVAtfiBX0ahe7Uot5qSHvVCoEMPyE2
	ztEPrL7FuvXd0LQsY4n++Uz1oBre5cJkGxbvp9EkBbeonWU2Wq8fAtdzS+y0FRQfiEWpJBLn0ZO
	xY+wi/gwkjbNk9Ew05dJHVqly2VPCNuyQCZPIP7JkbCsQKMLbfAHpjlA7/+zkS1vQ6WZ2rKKccX
	nPZQv7150IeyaCB7WcU2+w9y//uBxTpLsqS9qLekW7RhTDzzR2n1mALJSvGqTSlA=
X-Google-Smtp-Source: AGHT+IHKKd/gSBq0yron4WXR7/cbYXyEBmPvZgzrpLP/QCJ6Tk327PX4lB1Y3slCRMxqwyrxrHowfg==
X-Received: by 2002:adf:9dc7:0:b0:3a5:7904:b959 with SMTP id ffacd0b85a97d-3a57904ba6dmr320687f8f.58.1749888018801;
        Sat, 14 Jun 2025 01:00:18 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:18 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 10/14] net: dsa: b53: prevent BRCM_HDR access on older devices
Date: Sat, 14 Jun 2025 09:59:56 +0200
Message-Id: <20250614080000.1884236-11-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Older switches don't implement BRCM_HDR register so we should avoid
reading or writing it.

Fixes: b409a9efa183 ("net: dsa: b53: Move Broadcom header setup to b53")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 +++++
 1 file changed, 5 insertions(+)

 v4: no changes

 v3: add changes requested by Jonas:
  - Check for legacy tag protocols instead of is5325().

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index daf7c1906711..2bcbb003b1fd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -730,6 +730,11 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 		hdr_ctl |= GC_FRM_MGMT_PORT_M;
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, hdr_ctl);
 
+	/* B53_BRCM_HDR not present on devices with legacy tags */
+	if (dev->tag_protocol == DSA_TAG_PROTO_BRCM_LEGACY ||
+	    dev->tag_protocol == DSA_TAG_PROTO_BRCM_LEGACY_FCS)
+		return;
+
 	/* Enable Broadcom tags for IMP port */
 	b53_read8(dev, B53_MGMT_PAGE, B53_BRCM_HDR, &hdr_ctl);
 	if (tag_en)
-- 
2.39.5


