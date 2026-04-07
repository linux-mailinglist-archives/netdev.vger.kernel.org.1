Return-Path: <netdev+bounces-276055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN20Mtok1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5153B1237
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C78C30F07A6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC353C0600;
	Tue,  7 Apr 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcJ/x7Gm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE73B8949
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575905; cv=none; b=YfNnXMAk7JvSBbfX0Qyuayp/7HEVF+b3n1Yw+iJe2CpUK/koIXlDIazBzY573jetV7Il5NIo0GQOZ7yH71czY41/L6o8I1WEdo/DkX/4J0stca1ISz/U9seqZ72tr/FkQPaFAUBgU8hzZb2nQNnXJUTG+lqzX+4n3WjvB6or9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575905; c=relaxed/simple;
	bh=DKidY/MdYOtfevcdXyx7V0aSlum6iiFr4TrDbULjJ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwE4bYsNU2l+APgrLhrvQxZ0y9mPyakxvXMG9GuDQM+rMfr/veA7q4+mGLLZ9TsMjqRikQdCn/Cf0w6fZxSlj4NczRUD2H6yKLTfe2o+dKbAamRzyc7pSuRJ+k4dKE5neOdMTJTZLaft14zbwspRynoA08m7OlCwUlNUt71qXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcJ/x7Gm; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-67934c83063so1745019eaf.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575891; x=1776180691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQnMk0pGtkY3ChCrgRcgnkRgU2Rn3bzSZHSrL8+GszI=;
        b=VcJ/x7GmzTVh2AU3gtnbyWFMm8s558scbIzPkQ5aD189XGtQzgXmQELxe0FSRK9Wds
         U45On6oszw49DZXBJJbjYUDp3PcnuyfS9s8rjIrZsq9oWhsaddmlpiqkjzciHO7dN2Zj
         oiL5n18OaRUwHWdLJC16UOAnm+OdNnqsKBqVF4mWBia49fpWV/vzExPtOJQnfWiDmqq/
         ARzlZdY19IhDg55GNcOkNnf+KZK70QCSHTbdTxEfRIDeIqnhDyk/ztkYsDIA41YbYIj6
         9nz5CRS6VytIjEAWOQSFJYwZUiFclQbYe2QFNVZrWxRLSfxoW+kNWTDcSRpuUZbMbT1Q
         qHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575891; x=1776180691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQnMk0pGtkY3ChCrgRcgnkRgU2Rn3bzSZHSrL8+GszI=;
        b=RMjMsKdmXbzAq2l4VAjWpncvPNVslhYjz+E48GjbJLf1BiEWhUbBASuy7CznJPArqf
         0nQiFy7RMdoIP6dp016Q3LqVESE9pKJTyPvhum7T5+KVo4rZ3hTMH+bcQGLFug646Q8F
         l5RuJe5/2HlCHXGlb+WkkwKJ6a0k7+2E4ozaJ+DHVZEhsQCaeOHfWhTY5JAd32rDEL6/
         Tdwz2nBm6IVpnc9lnYhi6jn+ddLFQuYlHPwB/hZl58tOSIwR2EvSY0ig0Vc+kZDkdNd9
         yBWIZh8kFLVbJ5BrBqwrWrLWkvzwULiU3rZ+7909htLOot3pQUAdxYwv9E8uWGNCclpk
         vs/w==
X-Gm-Message-State: AOJu0YyeEVtk2l8nyegQ9FTfM37IAFP8VQAj4hcMYaI9I574BJWHNjKL
	XQOzlaRfWuk+GM3t/RDDFB4sBwtMx3JaTw0YvwLQOqh6PlVDJ94B05aNrnCK8d665Hs=
X-Gm-Gg: AeBDietFhb+cwj66aAQi8Sy8kckXW/96UlRhJ5nQBY61GoixKr1ZynHMBuHLODuEc/+
	DRGZCrlmyvp6i7bS+kDaR0FmI/tdQxxVyPGxuImYhpBNOvjZlvGXPx/qMiqULx571aD484wLJiR
	+6D3xyqOpe+cl7udkWzJ1Sb5GW3oo/kyd6Dfp0a1JGVVJDgLcuWefWN1FRB1q9fwQ8nH+gjgvhn
	HoNM1nJdkfeM1RmJeSkXqVF6+5YYbjetHgRknlHfsTvuks65BJ5KC3U/ihY3jIHAccpGOdYfD0r
	h0A1DPyO6c8RheRq9rEtbFmT/Fsi/IgnqzZMxz5I+o8H7TdXDM97ZFy1ax0NXN0es5wnG++3+8F
	yshzraOVETMSIwUFzaPQE4vfl6eDWRdbpUHeXz48cmUSJGO9P2qIv3eTba9dSGI6cIBS6FSsvIZ
	XTvDNM96Y6aDoN11wv5w==
X-Received: by 2002:a4a:ee0c:0:b0:682:e9ca:f810 with SMTP id 006d021491bc7-682e9cafa10mr9698902eaf.46.1775575891556;
        Tue, 07 Apr 2026 08:31:31 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:58::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a8d1d2cfsm10111593eaf.13.2026.04.07.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:31 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v6 12/14] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Tue,  7 Apr 2026 08:30:59 -0700
Message-ID: <20260407153101.3694714-13-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276055-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E5153B1237
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
index d2e72fdf3dfe..e66a893566e8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11346,6 +11346,11 @@ int register_netdevice(struct net_device *dev)
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


