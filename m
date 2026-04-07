Return-Path: <netdev+bounces-276053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBcONask1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C593B121A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B3F30DB8B3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD092392C5D;
	Tue,  7 Apr 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUxUc23/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAB3B6C1D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575904; cv=none; b=Ndn7E3li0QgUa22coPYzFfkSdC+6zFlsXbJZ7ECsFy8w1GiAdBli2KzvPwsoUxtKsuw+myk8CcHSn1W8J6tHSXElp4S8Iv9k8fLjEJYwavgRkSgyEkEeoHybF99jp+32cI5WqLapydU0oXbIcj4eFqtj4Go1gBR4/DqWMLmJcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575904; c=relaxed/simple;
	bh=Ew0xXpehQz7Go7vQ6dIvOdiSol/5CKHYJVj2Y82Gw5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsXNOP407J2szTSJMchhy80Z+2DdItXOfSUgJvNTiRhG9N0ETG5QRJiTADJDsgikSjfb/in5kRqC3CWTMKrIr7ri3Vf2NObjylTGXPTn0v2oM0LD0bmbDAE0wsbHYb0G5LoU3XgPN9Y6ALn3cW4eqGbfYFFRt8hxa6qHbl1Zxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUxUc23/; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d86eb7c854so2640379a34.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575891; x=1776180691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=WUxUc23/kHEof9XFQLifC9QZzqux6ymgH8jtKVg2WmsPB+3pigbzuoC8Dq09Xqpoty
         eCXO7O2PDLopx8IERrHOCpRqXe+EdHkcH3nW8Jpoa9GRrA3d2HYtlG14i/YsN7L1vz0y
         wvJjlaowh6sO/USVZI82lDvsSu9J34XANFaa7IvoDOQHXFuvdJRVw7MuUo/r0uW1AHv3
         Rj9hC/XECzugJBu15wyHEA6vvhWSoDMZOhy0KwcwCE75xis1PJj3riFyxNGVjFCWIv34
         PC53QAvg7NMR/swUbxc4X8xZvGgPmUzi/im/Sn9RhBSZK6MZ8NuBR1SuTaO8ExoiDRAt
         gCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575891; x=1776180691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=b9kF6vHboq1eFMpTE/PqKo+fN/asXikbNTqf9gmXbjdhqFrRw9J8d8wGxF1PZ5bPKN
         GPBsOfrQljw6Q/pu4txw9cMRLVADC5QWdIcqDd7cHFLG9XyjSZVnG+tm4uMtaAdaCIqR
         UNgIGEpfJA2VeNBjTM4wzfE//9oOOyhX4/WwR6TptlCEcPe6RYXy077xhrxqLRTA/lV+
         2e27mvD/lLsP9jH3C1UuKXk02iKay7gfQxTYxLodOulvQtJQvwbUkSgIebgDz4SxxF9j
         0nryOKZCjbO95Ct6fcTNRH9F9K7pYx3b3dC4Ld0lwmb6vU8ZsOPyvvoeH0FB2NWxG2KH
         u7wg==
X-Gm-Message-State: AOJu0Yx7K4vsxKalMzDW6HVyCBHXlWX91B6n8ZfsxQQ2xKOHY2T8i59Z
	sNIh3egM5EgvgmCTZfj2aVjWeeqT0HIj40QvdgwQMnjdUjkkY4yir8EQKwRMu3v6qfE=
X-Gm-Gg: AeBDieuRbH62dAJsAiouKfJ/dIoadvzG+Kiflr1e8TfccqgRql8Hsy+BfeAfDOOPMaa
	/GETKORw2KI4NpYWTRyDUv2rWwBVuLaMFTFLHKxVzwttwl8/912VDtac70XW4nC/JdYoRL3gEdz
	E9VR4N0sqTyA7CiYAcSUVnfB7k061TGEJf/TU6j8IWoZEmCnFTM0N/+tKeGChxhmDcPqdzfRnY4
	+bBrPJq3YZXQ9T2RiQ9rNslWUbEyoTKeqMIdA+OTjQKOt1klydK9E6Sx+WRQqt5ubVGjDt9TPxI
	snU5ZcLU4Tv+iDE06IlWKyp/WX6AHdq7kyKqPr4sLQQ0OvYd8CZkpuasnu2WyjIHFUTjlrB5M01
	noVspnQvUYJSEfzKqWUR4hJ3LfibM/6LJs0gfzLa3HJRecP4jXV9s7Vydp+euxwN4rukg/UuAgq
	rgJ94F4QJLXKOMGaLkRw==
X-Received: by 2002:a05:6830:2aa5:b0:7db:a8b7:c565 with SMTP id 46e09a7af769-7dbb7111006mr12203050a34.20.1775575890697;
        Tue, 07 Apr 2026 08:31:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm12787183a34.9.2026.04.07.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:30 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v6 11/14] dummy: convert to ndo_set_rx_mode_async
Date: Tue,  7 Apr 2026 08:30:58 -0700
Message-ID: <20260407153101.3694714-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276053-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 65C593B121A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.52.0


