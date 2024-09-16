Return-Path: <netdev+bounces-128470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373A979AB3
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38B71C21DAD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330E1C6A1;
	Mon, 16 Sep 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwrrtSCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591B43AB3;
	Mon, 16 Sep 2024 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463962; cv=none; b=HTXIe0wkWkQUsW5FME4BLdgEXWS0tKX3Q/2Xb/8s8hLFxYtSyDZPTzDDGepDo0EEwbAXSRIpUxkE8go0XzXMtmR6tD0i78A2CnxrJhbjSBcU3EjH/EyvkK/LR8SK/oT82lvvvxWcTcj+V+QN8P7qbEG8a7xlmv0Shm6VKogq9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463962; c=relaxed/simple;
	bh=OXqkU1oovvzY9i4GUhkcKAZjxQflXuORLOmDSrHHHoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7n0hb4ikf7hS1ugOWy12t6trKSSGqlWqv00w1rMH724iyRl2jHBnCGsgi5jefCXp26LGAtKPWm2rsky6NQUXVXNtz5Vd6Z3sPTaPSwkFFHnyqkptToYhqaAsKF6O9H5FvrK3SpJqmT+tCtdvAUikCNOilZCo9reNOp0j+GPkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwrrtSCa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71923d87be4so1898386b3a.0;
        Sun, 15 Sep 2024 22:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726463960; x=1727068760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLz0lNADH7cCWzKMs3iTI8r4aFamVAr3tXQHItr+s68=;
        b=iwrrtSCaZe4KhxHmrnFB9T853Jm1JB75pCeTBe5REMIVbX2t6B93OpeRmDvwZCZDyv
         UtLDQqta3d0YbmBZvE9wdblN5ChHasSLQvME6qBmU8Rvap6bIrNwBCM2BlXsBBAvHUwd
         mc/SPM+9g72mer0SiQmg33qWIpa65yA8YTblu5rqImSEAEdLOqJA5NYke4c2atpXxasV
         9cEYms9g6t4E7EoABYDM/zXeeJw6iAFcdCPkASKZb9E6dCgUZr3fpnzpf7ohKA9X7ZWr
         ykwnsq1tLm07sH0h2raFMTBqMcrWHtfdbx9T2nNI1frdyuaKCOmpRgtRoSgGH4pCYfg9
         Rpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726463960; x=1727068760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLz0lNADH7cCWzKMs3iTI8r4aFamVAr3tXQHItr+s68=;
        b=nxBJDPWX2uKXZuXTi6XPd2505yRjuQUSK/NcaFMd6EVdKG/BR8i9mqKL7EvHRzktBN
         DHXuJROVVA9HVECjryK1dFOk+tpRoMPCHlUs2V7ZfwT4DPUTWNv2u/zbW0wSW9AmYjYS
         I9N5uMOoyRX6/nGp6KRLBAJQEcE0/Z+04Fw2GLMEMwQFlzmWEaOzBtbcwqgIvKnzNbnF
         X84vS3jAOtUSUbz2olHk3LSjCbyDDQvPbEAVdRpMGUE7l7XD61xlReuWR3ztV0Fp/Dyz
         bvY2gs9mxgMy2yXrX4pWD9AC18WbrVfy+IzXDEJeRV0svNMvtWsKwOjaxadLqhPAu0WX
         OyrA==
X-Forwarded-Encrypted: i=1; AJvYcCUHqjuIYUUq3QFgBnjAcvG7j7grESfqMB0rdqcmj0dYRuURtf/u6+5RNOc6FYOB6SyTNOydQBVq@vger.kernel.org, AJvYcCVP+tHomGIEBwi9cQMhaYFRXgAZ1y74zgTrlU4opJYyF0/BwDvE1YJsjUIqsHC0BPb0qJTDUHkgLjdVxhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYEdWYtZI0p236pRzm6U5i/oK7iDQ35QVhySYh1si0Oc9Oxqj
	MaAFjM1HreKuQ+NPrsoFIhoPV6cM6OfjZvDeKRWKQKa2QO2THae0
X-Google-Smtp-Source: AGHT+IECprL/e1lSJ081ju9W67Hla644iD+YJKVrm05Da9fVhYEVbjpVllpzzu7Iux0WiNmYxOBd4A==
X-Received: by 2002:a05:6a00:23c3:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-71936a4d269mr15666243b3a.8.1726463960194;
        Sun, 15 Sep 2024 22:19:20 -0700 (PDT)
Received: from amenon-us-dl.hsd1.ca.comcast.net ([2601:646:a002:44b0:1457:4fcc:532f:1c65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944abb7a0sm3028087b3a.73.2024.09.15.22.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 22:19:19 -0700 (PDT)
From: Aakash Menon <aakash.r.menon@gmail.com>
X-Google-Original-From: Aakash Menon <aakash.menon@protempis.com>
To: daniel.machon@microchip.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	aakash.menon@protempis.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sparx5: Fix invalid timestamps
Date: Sun, 15 Sep 2024 22:18:04 -0700
Message-ID: <20240916051804.27213-1-aakash.menon@protempis.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914190343.rq3fhgadxeuvc5qb@DEN-DL-M70577>
References: <20240914190343.rq3fhgadxeuvc5qb@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
30 bits are needed for the nanosecond part of the timestamp, clear 2 most
significant bits before extracting timestamp from the internal frame
header.

Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for
timestamping")
Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index f3f5fb420468..a05263488851 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -45,8 +45,12 @@ void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
 	fwd = (fwd >> 5);
 	info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
 
+	/*
+	 * Bit 270-271 are occasionally unexpectedly set by the hardware,
+	 * clear bits before extracting timestamp
+	 */
 	info->timestamp =
-		((u64)xtr_hdr[2] << 24) |
+		((u64)(xtr_hdr[2] & 0x3F) << 24) |
 		((u64)xtr_hdr[3] << 16) |
 		((u64)xtr_hdr[4] <<  8) |
 		((u64)xtr_hdr[5] <<  0);
-- 
2.46.0


