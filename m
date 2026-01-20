Return-Path: <netdev+bounces-251409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D0D3C3BE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E07EB50A2DB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273793D7D97;
	Tue, 20 Jan 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2oaYKzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FA3D7D7E
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900982; cv=none; b=eqbntmOY+TewFsDXLHNtXrDqZF/Vo6H11J+z2oZEZSg5LjSgD4T+O2bnlW/1csmQ6mIX8jsDgY+kUCHdPTZ/LV0ozBbGgFl/YYvSc7lcQ68I/eORHN0w5SC4bTwzgk3On6lT0HcSZg3Tn0JdlTNAJGoqJxmQNmF5cLL22LZyKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900982; c=relaxed/simple;
	bh=CSmRzLwnwCsA/vnTMKg639sKOpJB+31aFmQ83gXmJ/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/XKg3a+Dy7DZQXuN5CD7RLL2eU27dW/erxxpPj1olVxHSB4anrAAzt6SbjyCix2vVK9nOtOixiPDUXDGeiAzfN+iqFnLZYPUUGnz7iwBzBr9YVS5f5Gq+LI00pKLU3HSkHwqmDnbYAekz6WPW6lt4u8BMv/3VCdcklE94xdH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2oaYKzO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f4a1a3181so2772632b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900980; x=1769505780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaEU7JqPQPZcp4mwlpZjeBbbu3WMdRPp729xKwSniOE=;
        b=h2oaYKzOuK3JCKmEomsMC6kSiO/2RovGhDd+VD2xnB+EEYmyNvJ3iH4jcniGlBcMPC
         NebJVB3nAaFOXs+kgswAxUSLVWBoIQYUdZIQICCZh7xRTLhsKxR3OLqcwPxdqD3dptQV
         fMupfCfvM214RCkk4/dEL64ImFQW6WY+w7fMlksN2nYAPEo+j8cNcnL7vOSdfMXS756y
         l8CcEAeEPX5VzVWlZf/LkmLe9Ds8SfhzUro9GZHvF8pqSljxAFJQ5+rf/SyFmZ7FJWXs
         hkZc8KoqXZwNT2zpItCgB8HJKxutpjNn7r+dqw93R/RXazmyApKYNO+TZ/Oz0FeDDyMd
         p2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900980; x=1769505780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaEU7JqPQPZcp4mwlpZjeBbbu3WMdRPp729xKwSniOE=;
        b=EShEQTW+XKOyXA0uDEX4GuLk1ZQKqVEcMsb2WotGNOz443xtaj7AwJ+BEjcuQpnoEY
         ZWubwzkzz8w2N17u33UEBuYg6JmW8OSKLocHVNfDNnu8FWEbb/azCg50oT1BAhITBCbX
         UlyPUWYWuhdtOomdv3hbG+l6r88NF+Pjf812pK7NDcE/jGZRyoeexHUt+VoY7+6GfrPP
         41WQsZxM5EM5+LLvFpi24MD6GSwY0rZfaLO6mD3kVjPdf7CcDlUr+GeyCVDTIgD8aJgE
         U1+SlBi6flKk4mizzQGYkl3mx0eZf2t429tqS+cceSJNp4UYSF0YKBCWlT9lPh00E4TC
         znjg==
X-Gm-Message-State: AOJu0YwtNIQDI6ikxtin8ZGFQoPbgqZL3ewD971wxMK8uwQdkapZDDNH
	m1kYA7Q3qeynNVkWW1w8tyj4tfQpwwsw60ZdtjJlp3WgjUlaWpqmMfhu3Qh09g==
X-Gm-Gg: AY/fxX5Q+f5R0Oe7rRDrvq0ixhcN/EiZYlt+owX/28lm5yn2MrIevggEr59/73FznzQ
	32XphANgJOaau6NqhV9WnfsB5zdIZ8Nv0HvUdHK9P1d03hiSThCWRxJIGHI9emC6fLb5ylSCcLl
	S6M9wFNbR/cBxwJhqFXPdW3qKE5Q+egVABB8sMpyVLqTpdp6iiiWuV5XTUJpCzkI3C28gu9OPeG
	OroQNMS4FeynlytJVvSlzT3P88KQt1fg6XjlX7ghGZYQ/jyudG0JI/OElgzJxut69NIUSaLfR0W
	t7SMubLLWOy1YP4brPZa+HRhideYWXj6RM+4U5UTrdE5T8aeDVtV5kbWwl6x3gfeiurHxf4g9CF
	rg5TwcTjVVm2Roba8Vat0+hMT2/OGRS33oa0oizf2SNbrWtey7qMN2ixA9GMoM4Gw8KV1bGfgjY
	hwVlQV65S2W7Uxo9rRAl+mXljZ29TpTFsIEFqJNRmPvJHjSf5WRznkHA==
X-Received: by 2002:a05:6a20:2d08:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-38dfe7b6e2dmr14284967637.55.1768900979811;
        Tue, 20 Jan 2026 01:22:59 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:59 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] vxlan: vnifilter: fix memcpy with u64_stats
Date: Tue, 20 Jan 2026 17:21:32 +0800
Message-ID: <20260120092137.2161162-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120092137.2161162-1-mmyangfl@gmail.com>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered atomic
against u64 values. Use u64_stats_copy() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index adc89e651e27..cde897d92f24 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -126,7 +126,7 @@ static void vxlan_vnifilter_stats_get(const struct vxlan_vni_node *vninode,
 		pstats = per_cpu_ptr(vninode->stats, i);
 		do {
 			start = u64_stats_fetch_begin(&pstats->syncp);
-			memcpy(&temp, &pstats->stats, sizeof(temp));
+			u64_stats_copy(&temp, &pstats->stats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&pstats->syncp, start));
 
 		dest->rx_packets += temp.rx_packets;
-- 
2.51.0


