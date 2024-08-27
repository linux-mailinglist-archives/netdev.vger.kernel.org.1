Return-Path: <netdev+bounces-122277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16468960995
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488E81C22A10
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DF1A0B15;
	Tue, 27 Aug 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="f0cfd2UZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8581A073F
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760405; cv=none; b=oOYnWy1AlZoKzO9/8p4+LCCMVl4G2lqtGZbhu3UUy6NaFN98BMz9tDR90183xt/bVUT+dhxU754y42uPmWxb3vZU21IBVboF+mXjWOKgD7bH6wwip+jHkk/XZaeNcTrdNTxNM3Ce+QVegaFdgX8QkJVbfAW1dFrVCb0gg4XDfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760405; c=relaxed/simple;
	bh=u0LWPjn5XBH/9O/VTvLnhnLVNfkAIrQikVTqUdJGMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/MvnKKN6j6ffDcK225zmx3mk6zwFQqEl/E685vhgRkjby/m3QMYETl0S0ZlmxdzbsLhz+iSpOEXCBgzsJFDd7HZTiOvmIMgjNqNOQql4yaXyfcYQZqLuLxaOTNVA88JgfLEHZwyS9OcFmw2tAG9OqMtWUPTHNM4l1EIQOsnNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=f0cfd2UZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428fb103724so34108195e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760401; x=1725365201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJmgvTQNVfbweS9GVTTb1jFbmLNnw0ul0tR6a0S5+Ec=;
        b=f0cfd2UZwxSZgOAmPZtcEEUnsLFR8GpqyMkaSTQcMj4kK1oV1GUrJ4H6H0GdgCLhnh
         an2Q632hCRAh3iN/SLOrnvMpKLzNCrliraw+HQGARrqr1yqxV24O6qvUkAuJ/FRlHOdW
         bsiGI7TduJvMaU+otL/Z8LkEdyIvTmR37O/NZq/7hNnImi6oScEL+/nHj5VJbS52Onb0
         23dgAeHhukcNdGl8xJvbr9xzbDrPqnMbdn30UyhrlsgnkVYzcaunc+oFUtkRr3Ljua9l
         +W8t/R5xZbYxj40f/bx9Yx6+Iy53G/TeZanjK5I+hrT+RhZyav/3zKxWwK92UedM2uzE
         Tpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760401; x=1725365201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJmgvTQNVfbweS9GVTTb1jFbmLNnw0ul0tR6a0S5+Ec=;
        b=tF/EyGinWrMgVVEcd6wvhQHhqw0+fAyYEu7g9LSlNlv/tyfb0rTMtgH6B7MXSLAIHv
         04mcFO4nV/VnGOUzietpF+s1WMccKVrSS5aJtOxmmArbN9OTGVEFf5Fzzvbao90mWuW6
         q/Wp+4D7Y5SDKviGxlmAQ/UOJFaf1IVriYQOvUv3qJRD/8BtEtEj5CnWA1tNBc4Fi4OJ
         aROn5tVhIQoFFq2FRRuUfjvdbiaMhuNHPesax+a2KZArF7OI3yclWLZZbi11N+bsUiXd
         BQonEafx16yN0pKxKya9WicXAsPXmuRWvPPiwCyEGTg7BKYPD5omyioxGa9Sk2aLkW8t
         3CWA==
X-Gm-Message-State: AOJu0Yzrxuh16/LjePY6amRf+vatPhTwkAgYrRekCzOLvrjLhhY6s8gW
	phdsD75ozhb5iG0yNkEbm60lD/xfSgHr6buSfB8xi8FlnzJd4UBBsVuKq45F5yaBK7cVlGGbqtp
	K
X-Google-Smtp-Source: AGHT+IH0bbRE1ccpMl5FgcSCCLd5dvy8d/ad7IlmVcgBxqUg/bN7L/V4uYgrjh/9gnKTJyEMxeSlvQ==
X-Received: by 2002:adf:fc0d:0:b0:365:aec0:e191 with SMTP id ffacd0b85a97d-3748c88a349mr1673117f8f.21.1724760401525;
        Tue, 27 Aug 2024 05:06:41 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 02/25] rtnetlink: don't crash on unregister if no dellink exists
Date: Tue, 27 Aug 2024 14:07:42 +0200
Message-ID: <20240827120805.13681-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_unregister_ops calls __rtnl_links_kill which calls
unconditionally ops->dellink on any related interface.

However, if a module hasn't implemented dellink, this
invocation will crash.

Add a check to avoid calling dellink when NULL and rather
invoke netdevice_unregister_queue to schedule unregistering
the device as usual.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cd9487a12d1a..6da4a6b598ba 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -453,8 +453,12 @@ static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
-		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+		if (dev->rtnl_link_ops == ops) {
+			if (ops->dellink)
+				ops->dellink(dev, &list_kill);
+			else
+				unregister_netdevice_queue(dev, &list_kill);
+		}
 	}
 	unregister_netdevice_many(&list_kill);
 }
-- 
2.44.2


