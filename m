Return-Path: <netdev+bounces-251406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AADD3C3F9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629736A5381
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556993D525C;
	Tue, 20 Jan 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X97+D+iN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81903D523E
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900969; cv=none; b=gsO0hxhichIGE7bwCx+DmO/S7OHrxvO2Bt8FMfLWzM/JnvDWkFvbu431NvJdjTrtAVxOHkkiu1Piuy9EIyOnahvV0ky/LBLfI7I2NhlWPlPa0iPXmfqEuRKx+qu0HDVvECjM3AQlTFD0JclRF+dmv3RFED0W5n3CINjRj2xF1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900969; c=relaxed/simple;
	bh=aXepxHEM+bUanCG6M2YQkdGsjdUrPkO4BtQqkZ7jSTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcP7UkTwuNcIMfY2EIK3ni6upSmbuKg8sKKebA1OtxTVyYQVV6dClG6j8ojFKO+XWmk5CY1sK1P5ZYWkgtHb5a2o7FRUVC11mm58f5UQOvruT3irWQsTUKpZ+nvPC1pf1QocMs2ZnZiz5y6nNy8JlQ5CVrk49Wlt1/hvEBHPBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X97+D+iN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso32341685ad.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900967; x=1769505767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vCyzApzHRVDFWMwd6G0sX6h4LUY1dkAl+mfLdsoDQo=;
        b=X97+D+iNrIv1FwwnCTOTeKmEmoksQTrcoSlj9CoAIe98D4q0w/wgAt6UaFVDSclRD3
         GsFDtok5AfVYyZpQ5enZDJlhM0pA5iQVWMjolS/3DDw4RWyuf7kwk6bwOuXmDdPVGHNo
         VfDi2oggg96zONg0XcF1RpHbkdurRekiombCPfaQlzg8gyE2dQHh5rEtOfGGILzwCpCL
         0nzgY7gYmOEl3U+QLQwORdAovd1LVTXK23mAEjMoS/4cSppSirBfzTa3bvZzHBGvM61B
         Kr0ELIflwwlrlimRtP+RJBTnke+mXsGPMFbT3PxAleIlJ9HkE5JE39YwF0FvgkjdRzxt
         8qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900967; x=1769505767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vCyzApzHRVDFWMwd6G0sX6h4LUY1dkAl+mfLdsoDQo=;
        b=mRnZnM96h2oo9OsnMt+7CbEjO50wgVonDVzW09P4uw/B3bwv++bEIUGvhlReTdRYR7
         Z6YdPEufE75k5Lr4i2ll2o2FadC7/H9zk8OHpBIGf/EBlwQ5VNQfQR+qAEjpkEA3pAwh
         hdc5xYm3lr1v/pnGJOrGJdlkfd4Sg0gzTTyuAlf450Y/kTVy5a7DJTuJxJCeeOeuaEiY
         VatPI9+B2OULSAbKkrnpEb0XVxEhZ73Mldg93GOh5hEQs1fVClpgytYTYE7j2GwUY19d
         l8hL0GJxmn5PVaywWEVpcbxXxeup4lfsNti8aCfCQI94Z9E+PR3i/MRDO8eMrNLm7o3A
         ePzw==
X-Gm-Message-State: AOJu0YzIXCrjL10mQqiZ2J6Owxs4rN/LfjA/xIAUFSrQ0B1NUuzzEr1X
	w4LuZ2yWWBpoLVJX6Vdn0MqVdxneNxxShR6DihkmWgrFB5maMsNozBt8rYOziQ==
X-Gm-Gg: AZuq6aL73g9A0Kgw0Pxhiw0M4dpqVC/du9HmxaK/v5u6QOFejZSrAcWNCHjVixVMco+
	L/6hLx9uA+2u3PhX4EQIrx1PSVtlHXEIqEycfFr91A9vGK0j7owmg78+Ue1x0n5JXVwolCFJL/U
	35MIpVtKAy2HuVFiBpAQ4Fr7WhkuIX3akhCA6Bh0abPISnoaIBz0NWmskqjmeBQmiq8+NZPb5ET
	952Ka7L+tGbVOxrrsTX6OismJjSyTB9GONgwcudY2j8nYrz7XaCuFjY5kQh5nVsTc85E8dwQtHm
	s/TKsiABxgk/34rmodjsYHp/miaCxD4P2AHXs/zojeK1gLbC2eWQpL7uNX6dpxhreaDHSJCEDcQ
	sJ1qTZiMzEAWvZvPIeEI6gTuJ/QGRqs3/JzTr0lhYLfHPnXQOa22W30KO6i9aLwWnXd0O7U8RNS
	6+5rulqv+X4pjMPmySpr7OlV/cKS6A3rB8/Rllu5F0MJ02aUTSO+CEPA==
X-Received: by 2002:a17:903:13ce:b0:297:c048:fb60 with SMTP id d9443c01a7336-2a76a389391mr13454865ad.25.1768900966610;
        Tue, 20 Jan 2026 01:22:46 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:46 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
Date: Tue, 20 Jan 2026 17:21:29 +0800
Message-ID: <20260120092137.2161162-2-mmyangfl@gmail.com>
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

The following (anti-)pattern was observed in the code tree:

        do {
                start = u64_stats_fetch_begin(&pstats->syncp);
                memcpy(&temp, &pstats->stats, sizeof(temp));
        } while (u64_stats_fetch_retry(&pstats->syncp, start));

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing, especially for memcpy(), for which arches may
provide their highly-optimized implements.

In theory the affected code should convert to u64_stats_t, or use
READ_ONCE()/WRITE_ONCE() properly.

However since there are needs to copy chunks of statistics, instead of
writing loops at random places, we provide a safe memcpy() variant for
u64_stats.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..849ff6e159c6 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	for (size_t i = 0; i < len / sizeof(u64_stats_t); i++)
+		((u64 *)dst)[i] = local64_read(&((local64_t *)src)[i]);
+	return dst;
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	local64_set(&p->v, val);
@@ -110,6 +118,7 @@ static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 }
 
 #else /* 64 bit */
+#include <linux/string.h>
 
 typedef struct {
 	u64		v;
@@ -120,6 +129,12 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
+{
+	BUILD_BUG_ON(len % sizeof(u64_stats_t));
+	return memcpy(dst, src, len);
+}
+
 static inline void u64_stats_set(u64_stats_t *p, u64 val)
 {
 	p->v = val;
-- 
2.51.0


