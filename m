Return-Path: <netdev+bounces-278151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJZdEccn3WlpaQkAu9opvQ
	(envelope-from <netdev+bounces-278151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:28:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD13F1719
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 219D33050B91
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74D34EF1C;
	Mon, 13 Apr 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POJyDsyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6533F390
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100308; cv=none; b=NCHYXQVxHQf0h1+2Nhvwog/5M34aLAqm9AJKBb6GZv1TO8sy66emAIbPMPZAeFYrqublwGOxaipJ1j+KdBiXGBCR/iQsdMOLcopfiYVAMeHtWPgSgzZg+Ndd750iLROtTXJT8KcapN/o8FZ6sIqTUVBxKXRClVvwg89+oMcMIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100308; c=relaxed/simple;
	bh=XCn7fNG29eCyajNe7iRuuYGq5z55KVY9f/U8xl2Pcio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxvjUlkxwKk7sDjl2oZirgysuauq7+PQllO1ENkJ/wEFHN4nDFtcUtMx2IAjIDw2diWAz0psy+jia1/Zr+4UbtcADgzqlAv62RvWJixDxlsOj163GriX5GCi0cnbdhkFcn2dQxVXH9s7TenIFGGn2xQK4AiF3X0v1CQOYysPzgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POJyDsyk; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-688a8e5fe5eso2310051eaf.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100306; x=1776705106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTCpb1WIQyNRfMSCX9t/p16yWG77DX8v8xzgWcYaii4=;
        b=POJyDsyk2DT9Qqb8BFAug0ad6C1+xofn6s8crRu3TNHxf44RHPYkdr07q/D2mun/d+
         /izV4rqbnwr223tQS41iPM20nkuys8l5jIYcSx7TSXQLZgXGSn2/e9zGWDgHByH/O8UM
         +hEZI4WglvncZ1bppsF4LLvbrIHD9InMxnepihCUaWX4hiYRDX3YaN5QlWziOss/boE3
         U0tsbuZGuu7lp1zlBIsBOVtcooI5GOMpZDn193bCN2s5d+kl+s5mwiDcAT+gdTOqRNxJ
         1VwkDkvm/pLx+J9SEPo18hwXy8rCcbm8vLvYqCfM4iEvbAarfRePCi0a82w2kRHNQd8T
         l41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100306; x=1776705106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTCpb1WIQyNRfMSCX9t/p16yWG77DX8v8xzgWcYaii4=;
        b=TEUiSuRJk/8d8hGAAluiH290zXAFoEV5GWqF2V+cx8us4VW53AdXJb9zKCdIf8r3v2
         sHo/USTqvk1rUpZWuwDJkHz0iGQW4xFIwhla5dYJ48GR95BxosuMjH/0R8Q351XqHEwY
         MOxtxg2qEe0rfK4OEVqg/G/7CGar5N7W2obOX+2gseDqQaFAwdN+g1mAVwZwYcvzG7e+
         UHdxbEtOdtFZzb5CXpJyQNCnrhqEMLCiV6QbuwrN/SGcJiNmRH2TgoJQz3mb1A6IaU3Q
         fgrLXzFHonYE1da5DVG7cfCX9GuX03i8VTW4f9teFgBpfH+ZeL3gjCP1IEuBnFQbP9cM
         h7/w==
X-Gm-Message-State: AOJu0Yx0vmlX5KNso+JNJRxi06HZ236uYKcVRJHi304cQsuW7Eh2RksB
	49zXh/4hII5oy91aJQ4/yiPSXBd/bGV50Aj6k78zEeB5sx77Wx4WS7Ko987aPt2+
X-Gm-Gg: AeBDieuPMWZOs2LwRBU1K4NaXDULq4gIPriyj887HVBV9pDiEygspdxeHUHU0FjEQr6
	zePsXYPzxNXYic0Ystw0yAkXOnd6lZS77ft5UJ9IVh0eU4JUjzRxYsHV3dWS73DHfl+sQWssEss
	YDNbRt9BFowgbdxPtGkaAGaF7odjJzQYqDVXIJ7K+v4iFZDaAOYJoovytvm9cJRs93r+QCZDaR9
	V//0T4p4oU1gZ2CUSrNZ7sjMO9XMwuY8ABkqJsE2VxDw5bGQJmpsl+liFp0E0EUJcJmkA5rJYv2
	1t0DLxidZ46tVPZHnH2fkBl/4qfAxXaosYJfU0y4sUzB0NsbRTgMcsri0xkv6oAwTXYxl7xBa/c
	brDMtxrTi1iogi7diV9KU6Rxgu8QwVh/Jl14+kLNE4nKZG4dAzSFkClYHeXyysBSxrZ9AYI4tjd
	3nDEkals7yrm2DshJ0
X-Received: by 2002:a05:6820:4dc3:b0:67e:dab:7cf5 with SMTP id 006d021491bc7-68be604a327mr7333571eaf.17.1776100305880;
        Mon, 13 Apr 2026 10:11:45 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd39a157sm8224128fac.3.2026.04.13.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:45 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 13/15] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Mon, 13 Apr 2026 10:11:29 -0700
Message-ID: <20260413171131.550126-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278151-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 36BD13F1719
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
index 49346d0cbc8a..3bd7bd396de0 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1362,7 +1362,8 @@ void __dev_set_rx_mode(struct net_device *dev)
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


