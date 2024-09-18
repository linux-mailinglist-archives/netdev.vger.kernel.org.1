Return-Path: <netdev+bounces-128761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8897B8A7
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54E21C20F37
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4F16BE39;
	Wed, 18 Sep 2024 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OinEsvUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB4224F0
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645540; cv=none; b=SyJupbbGxonhn5i9zOwPgnpBkn4HrB4XYru1h0HpLvKtlXt2M0NxrfMNVUrGcQDBSB9RW2PBqNpUXWgzLqImSUd7fcG+lngTV2/tEivxoIrcsdNZIHU4vqurL9aXG6lUTk5pU9rC6Samv7BgsJeT/E+4HX/Dpc8aPqqRDS7rX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645540; c=relaxed/simple;
	bh=8cbZTCDd4mL+ru6kg5Gf3qUptfO0w/oF9SJAxiqHGio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1upr7RNPFSQW2fNRyd5ExgIoP3zBGnFIgv6b3hbmyeD7hst/rktZQSakp8t7ZoHL5AlnIHMrV1PStKDzGX7/l31cw0h/ES9ZEDBQTTBuO46wE47k9JWimt7DWKhhYqn5sUDvt5enhZDO5ur4NbFR2ibq3w/nCxzfwdmH5M5ONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OinEsvUR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20792913262so47989685ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726645538; x=1727250338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+I7dUgrSuHMQdwaXopkdXCgHbnd+bfTOM+bzbwYhISo=;
        b=OinEsvUR0ZuftFGWF7ydpG/DYZM77aYld2BTT/0RyB3Goa7YtZNqlBV4S/VC6n6TIP
         +YBfao6n/EFRllA4w6LGNEgGjafW+EZXDyJQ9qBdY4laL5tvw05GfJSHtrYGx2Cb5nxu
         FEeKerguC46ur/RGfwQ2Jh8hywu1QHpGdicbX4Khxu2gwtnyaranvRuW6l61dcvhpbU+
         nABMOHBEQ6DjCyYLbOskA7rDSftrXSi8//lCCfujxpg6M+9y4Dj5LbRAkAlkCuVS4u8V
         EW/nXW0o7uijBmI7Tgf31GdHFIkOq67Kb1aAKczX6qAuRDZapzIEgvP1DzgJ6shXgnhx
         N6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645538; x=1727250338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+I7dUgrSuHMQdwaXopkdXCgHbnd+bfTOM+bzbwYhISo=;
        b=u4ftiFwhd8gNojKmxIFuaQX+dylpSGlcwkiTzjQjKEWVooU152/cI2v6TDSKeh/SuV
         7TI3zuO8hIMIPlP2gccQh357akLw18u2xExKyqRTt1Zi26Pke8Akhb133/GzN7QiJRHk
         l4Y+8tH7ehkN/wUBlMR1kPVLH/K5TTt1xzvtq095yEs7AJ/KUsdg2rlO1EXtxdZacVFx
         tBbuQlCdflzAIpxy4ZeoCFsJ6P8HJ9QNoOIbvKAfCEb4TCKdccK9JEc2ivOI78XHwh0O
         YvI2JiwHN22vzT2MPmGFwmrqwG0K3Y6vydFLbIgUKcO9x+mwVVP2NVtgnbrGkwVWUWdQ
         M9HQ==
X-Gm-Message-State: AOJu0Yw+JiunApck6en5MWWGRTgth09vYyFyezWFAWo3y5b0tm4JiZFh
	pC04em+JpTWDnlOnhe4T4jtdwYO5HbPn1CeB41FcrrwCKMQ0/p/27UkziD1uUqo=
X-Google-Smtp-Source: AGHT+IFpSIeGa39ByCsIFwY+HDxOIoRC8C0L3buusq68sEAHO+OkhE4RObZ1rPjsBZYe0iYf4cPzmQ==
X-Received: by 2002:a17:902:ec85:b0:205:82d5:2368 with SMTP id d9443c01a7336-20782b7c5f3mr358418875ad.49.1726645537888;
        Wed, 18 Sep 2024 00:45:37 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794747379sm60412995ad.288.2024.09.18.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:45:37 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	geliang@kernel.org,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 0/2] Cgroup skb add helper to get net_cls's classid
Date: Wed, 18 Sep 2024 15:45:13 +0800
Message-Id: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

0001: Cgroup skb add bpf_skb_cgroup_classid_proto.
0002: Add a testcase for it.

Feng Zhou (2):
  bpf: cg_skb add get classid helper
  bpf, selftests: Add test case for cgroup skb to get net_cls classid
    helpers

Changelog:
v1->v2: Addressed comments from Martin KaFai Lau
- Just bpf_skb_cgroup_classid_proto.
- Add a testcase.
Details in here:
https://lore.kernel.org/lkml/20240814095038.64523-1-zhoufeng.zf@bytedance.com/T/

 net/core/filter.c                             |  4 +
 .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
 .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
 3 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_skb_get_classid.c

-- 
2.30.2


