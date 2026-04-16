Return-Path: <netdev+bounces-279129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPHmIOcx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64C413F04
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DBF0301E21D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89C3314B7;
	Thu, 16 Apr 2026 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k07cdnqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619834A796
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365853; cv=none; b=a3+Ye1hN7BRMjgEg4D8UafBE+yA0hXoDMzm+mSy/ayP0cdh/ES+oqu8UUtxwoVfgibtJRO99kyx6hjKmndnux1g8FyRGsfEynxLVe5MDErx7bLWHq4iTl6bV7tPLfsThrLe+E7tDbj0n1kF6sF1kfpyWbbgI2n28noucc7cN9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365853; c=relaxed/simple;
	bh=9yM82H15LaS4PL0QdJhZZbqNUFw5SHxVGY1b1VI+wY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZGj4iQTeN/jOrJ43I+oQdkGDqQZd6DLi8/A4ZKxN6uw0xW6O2fd4xFlnfy6uD2ox1ukfxAG/6fb6W94Ek0VW7Eqznqxt4ojWeOgdsWXTKAWdvPfxl5s6LXp1gDpdQEYx8Nbk8DoxOUbwE7hX7WmMRrN51Q0QHnY/uvzbpLnp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k07cdnqk; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbff3ea81fso4154834a34.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365846; x=1776970646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/itwDadjKsEHXnJjcB7eAlPzcUecWydhhEt9GoPtsU=;
        b=k07cdnqkGHEVv3Bb2wQGByUYDHqXBZaiSL5blWqhuHQ8u9F8lyRvQseLtRR9dse3cn
         /M5J42yhAEu2Wx4F571KPi9Q0VDaPyiN/CF8ru0CPLlct6Kj/T6ykx8DA/PG8FYt+zWB
         hIbrwZWfmS5C9UAjs/ogmr8PlLSQmmsHuRwQG1wLwcIK+8XGju5e8TN9upOd0lypBcg+
         Cj+oF1pysaDVP5RgYScVCrp/whtTJcSWzIFgJM2P5jAlKO3NAxXrwL2aTEIBgwz60NS8
         JYmTKKsUjms9WJZtV1GCoztQnH8030995sPfM5jqETXp187ZufzBnKJzcuJsJFUUrbNF
         RvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365846; x=1776970646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/itwDadjKsEHXnJjcB7eAlPzcUecWydhhEt9GoPtsU=;
        b=HqGh59TuAr+hbJJfHfaZ00Y9yAui1tuY+dPIO7WGS5kj274Z/b8VmjoHJ3SFMMwUH8
         unixKF+o16PgLNfuAGUwqqSdXvSFVvC86htdTT6G/Bm1o0GN69eReXENAk25WphBC88z
         Q6dC8l/mdGQPpyQihsbnXk75iYbQPH9WIrQOpfyX7AhEeDJ37Vfi7q9Mm2WTAMXxFmQT
         bWvW2911ppup0obCupK6lGXNROKxOQPKpKiw3GTr//JVmYTuY6bdm3Lp7M2vwggwtIUW
         3IzA5CXxSsmlUWbm4hFPGc7HB1kMvaJC7/4PLrEOZLW8Am8xsfkhnEvH0YhoRaddd8xK
         /6Dg==
X-Gm-Message-State: AOJu0Yz+/rUHe//EzllHrlrgC+f8Cg/Dvg0yYYpBYYFypko9wSFwKhcR
	vXpYDX7iBQwP0G4dHO0sm97tRhEYlewZAmYRyGS/wbNZ3qHQqjRdBX4nLfjtVg0d
X-Gm-Gg: AeBDieuWVZMRPFpLfuY9kXMIE35yuINd1OZ6CNlHpxdTj1nxl5Mdn3LjYLk4unp+bQT
	u1dSadq3+sfQK3huAgymD1aijcPcMxX0LJSZk3iME77Vehzq9W+65vaCA+96r8Owz36jETSnUFC
	6tUjrd8sNGRJvf0lkr7fuoGipNwnKBiwfB6UG08G1OHOzhf/Sul/o66On38oI7GPllczpZwn0KZ
	shFiCO5SVs+FALVk8JPUyHRFSv5qqpFBkSPPOGsTV/D1MTGC5wF9iLk3L2bgHXD2k3ocVQRyR/S
	vgZ2od8nCUIdMpvciVpUkYKqURXqIASYBxHaii0kX1c9vOxiBCfyHwkWkYp90tguuRq+XsSRzjV
	/AsT3Ry0iomva2U3o2ZzVL7liuVPuBG4VbtFBFTbRLuugSa/IDSBLm02bikUxc52/ymxHTC7SWn
	z8Hlgn3Citx8DROo5y+qfYejeSW1Q=
X-Received: by 2002:a05:6820:1885:b0:67b:bc25:2670 with SMTP id 006d021491bc7-69461a98bb0mr243130eaf.26.1776365846478;
        Thu, 16 Apr 2026 11:57:26 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6946041f726sm417555eaf.10.2026.04.16.11.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:26 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v8 13/15] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Thu, 16 Apr 2026 11:57:10 -0700
Message-ID: <20260416185712.2155425-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-279129-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 7D64C413F04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through netdev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c            | 5 +++++
 net/core/dev_addr_lists.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8a69aed56fca..d426c1beeb76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11360,6 +11360,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 4c9e8a69493f..d73fcb0c6785 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1370,7 +1370,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_device_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		netif_rx_mode_queue(dev);
 		return;
 	}
-- 
2.52.0


