Return-Path: <netdev+bounces-251220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F22D3B552
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DEFD3019343
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE532FA12;
	Mon, 19 Jan 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrg+OOFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616232D7FB
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846496; cv=none; b=JFzjPviO86L9st0PXRp90npXuPewZoBqrDwT/MUi//0ISX2Cu6SBw/9mvKvu9tTqVOloQSD74FEgHw4wKSrTeou4JFV93Rka4GaDsBWSubHO0mZBt01l+xvwT/n9cXpIe00ro8CIxl/1VTFTMzTdHjRk7JPtQkcceKWUWctvTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846496; c=relaxed/simple;
	bh=KRlvyiPdOgWjaxLBz2wxPfYpZQKMBz8PLU0ghSnguQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlNTA7CquZkhUIBDvAmg+TqbmRJWekzg1aEVSCGWhUOgb5k5MGSyk7s/BPC5/9f+9FdMmHrbEBUPQocW03bCM3uEoQcuDfriLx0U2dYngl2UVjcPwKAf3amNmqSMxEaU1hVl0/hgj4lvR9a5GQfSD84n9TsrszA+tuFiZuUAp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jrg+OOFy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0ac29fca1so29030915ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768846494; x=1769451294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDGrOETKogt96LjVqGzaFdVyjaVcAYfl4rZy/ucfVuU=;
        b=Jrg+OOFyiWFH/TJLOhk1nbqwnFm7tLIABb7wIvTX8yoeP7VUV1KXZmuzni2R9PXYcL
         xYadtWhHA/9Ka7wCPktBYcI6OWj4ccBjlW34D3jPMCrM1+KzlKDT6C2q7qg54yqVZfdK
         S6CwpOUrKnRmqntnTfHoTj4Xwi4gb8CGiuzLO6+xllGwwPT84YE/C4SATZoHnkmpKXwN
         GYQdFBD7Ldo1W6wr5siT+ffUQp7XkN+b3Gn1ZXAQ1LCVOX9Drrl0xYIn2kZWQr9Sgxwl
         15PG1ZP1fJWPm98FT2ZrnwnUcAxE0yje16tABeOft0fMjPJ/15sJS2R88h3iS3esmNbY
         pdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846494; x=1769451294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDGrOETKogt96LjVqGzaFdVyjaVcAYfl4rZy/ucfVuU=;
        b=puMrS6KjUToN/8l3VNJGYPUHveJ093qECf4RrlorJiFZdgABXaIbw2gmO1WfKfAqLY
         Y46WyhEANCO9JNYeuhXoUJSfs7aOoc+U9DvB7VpMSgb12te63ZMiawZKFQH+3eKcq6ai
         lDyPy7Fqg7V8HAxNM5xoanZeywy7G3Zi5sxEEIXMh9KhZ17GnHiDHQHNyr1b8aSfNanC
         dK7MhjrxN2kyX5r0INoCbMKkX70nm7iWcmYb/EYJOVHScgijFSltWIxmraZyHFjnJj9Q
         Mmkfu1HaiCFcjPUhq127inBT8wTEkQbqRps4blEf2f9fP1mLJgOgRMssnrGc+v73t/p7
         ju7Q==
X-Gm-Message-State: AOJu0Ywl6kpTUm2YEGCt446GWODyTm0Iz0MAu1FgVXZCQLWLS3v1PJBJ
	CYLqDe2twzopVjFpfonpyWNRHwYeM5n04e6YYQI/E2h3Escn/qBmHD8PWZ1Emg==
X-Gm-Gg: AZuq6aKzaWFTX7NZYIAA5CnH9K4/eZw7zEK97Nj5HLQpts5Nqr8V7S4b7cOtn1vxaP/
	PUOE9uvoo+1U4JnWOoyhQiXApBMPTI97IrnJDyMZOiCLA5hHGo8+EeJH3gPlK1K+zAwHHlw/2ix
	ebq86zBWESTwVqO/0ySPpXXNNQFNgu01WstNOjwnwf+4X7hXwS21tbCzRNIIAPW70bcAgG0dgPg
	MWGToXY8fIkeCzSEj8ANZn0otEqBgziYfFqeLCSQU8t0ajAxeEk+FIhTeHzb+ZbCYqC7QjIqVwX
	hBtJgNuv+rzCZRTRwvHKSvcqU6ivngy0HX8NLVTsBSGR905NzE/EFzFrcBrlJ7V1PrELD9mPpfz
	8Irywr+9rLgt761zECvT11VZ+0QxRo7ZID7+Ou3uJJLzHbErNAUqgsj08pGVoUkwgVapECeuNbz
	4y5hZ/3UvlF9dUnSTIgfXVK3zNiOTmyouXktIXw5ihpjxYuiOsloAyig==
X-Received: by 2002:a17:903:244f:b0:2a7:5171:921f with SMTP id d9443c01a7336-2a75171932amr1730065ad.46.1768846494076;
        Mon, 19 Jan 2026 10:14:54 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ac3bdsm101769645ad.18.2026.01.19.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:14:53 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	wangchuanlei <wangchuanlei@inspur.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
Date: Tue, 20 Jan 2026 02:13:09 +0800
Message-ID: <20260119181339.1847451-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ovs_vport_get_upcall_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics are already accumulated
by u64_stats_inc(). Fix this by reading them into temporary variables
first.

Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/openvswitch/vport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 6bbbc16ab778..bc46d661b527 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -319,13 +319,17 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 	for_each_possible_cpu(i) {
 		const struct vport_upcall_stats_percpu *stats;
 		unsigned int start;
+		__u64 n_success;
+		__u64 n_fail;
 
 		stats = per_cpu_ptr(vport->upcall_stats, i);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			tx_success += u64_stats_read(&stats->n_success);
-			tx_fail += u64_stats_read(&stats->n_fail);
+			n_success = u64_stats_read(&stats->n_success);
+			n_fail = u64_stats_read(&stats->n_fail);
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
+		tx_success += n_success;
+		tx_fail += n_fail;
 	}
 
 	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_UPCALL_STATS);
-- 
2.51.0


