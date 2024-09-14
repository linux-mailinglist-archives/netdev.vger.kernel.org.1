Return-Path: <netdev+bounces-128336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B8978FFD
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767312838D5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C631CEE99;
	Sat, 14 Sep 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H48Ifsl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A391CE6E9
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309962; cv=none; b=u9D5mXciCpgc/yjov0NVGV6/9/zA+DgEPk0WMLYdvQuqb+MiHQTf0xzfElieNjUsoSbfZ9CqS6yIHL6EMV4HYY6CoGbz9zxXknKlCAsjzIKPgQZ5cEUVOXrHvI69DUvypzOyF7GoNYRXWFXqckrFKdNYufii/mJaQNtehdAriOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309962; c=relaxed/simple;
	bh=DdYB00ibTxT+QJRCxLcc/asgoMEjnRMB60l7urVdFTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhlvtgxJApbFpBqa1QNB6tyDUvA+kpRIyiafp/rH4l7LZTbtHdNwmI1Qr4j0FxXcw8meRGy3B9bc8MVL9X2UBCo6WD1QLaOkjYieECEYrkqJBx3ykTwO+c6hLudlyEKMjOdDKNDO+96subHJkJygG0Z1u1Nt+BAQX5HXKIHAw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H48Ifsl9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2084612b3a.3
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726309960; x=1726914760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoScSacKs8+apMRHN8PMRjEmtp//jkcASgSvFvAksOc=;
        b=H48Ifsl9Mi+sjKnBeoN3uI4sUCUDqRWSlgRb1MthfWaUSorboOfNxpOIei6sJ0WYHp
         uxCC9iQza3QYs0bnPby45hYajaFJ5kmsMqkryb8/GDjh6/Z6uVDBMdHErYyC5/+ez4+H
         j9eg8Ueg/ROzZlveompWIqq/aMJCShCAw4btV3Q9hwvNij3gz0zq8s6PmkEfDgrhcBgG
         FwVT1qdgR1mIZzo49ZShjAmXjyvxe1uC6m1cXG93tLakFUXr2aR7hOqqcx0BoKbwtj+B
         ytAq7N4zyAYMDxm8ELu+SYS9hA4Qa8hfuQXt8vjYFPTU4nc8KIBuAhHtNcgaM3hbXM7y
         Ul6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726309960; x=1726914760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoScSacKs8+apMRHN8PMRjEmtp//jkcASgSvFvAksOc=;
        b=MucBA3LMwSaoNtkWAJmuZYD0M7Qu0WYNTx7rY4JMbluvYZuQBAaBOWWYTOBkchOs85
         R7Z1KxFxNj+VPPyVDzjyO7HEEgfQyYbIBbD5bLMM5GDoaMislaGxp5qxUm9cO7H8BEPa
         scOrjxwmkDF84W0rEvsMvKdkA/V7eYz7y0X6LaSFeItPmY1nZ9gXd/ZjI5MNeCB6nCrI
         E5J0MSNeovoNlW2HnDQKlg+8NCYUpcgpbrYrwFjo4/g3OLo4pKcxhcHN/BDQhvx3TkdK
         vBWYas3AsZm/IKqmV1+TCSdm6EiTjQWp6nT3kWQadS6ypcCGC4rDjHR14q0x975byQzB
         Ku+g==
X-Gm-Message-State: AOJu0YxBE4IN0mZWXeOwFEM815l/q7fiC2Ju4nannxq/tJWcBW1se1QE
	mhYimFB6bIeEZsgKJf7H7v+RDVEVeAHzeSR1jfyp4E0wIGCt7f3AHxwoOt3hqSA=
X-Google-Smtp-Source: AGHT+IHyOQXstBZ/vgJqI3gYOTidc2uIM7hZ/h3P9ag32Q0XCBusk2SPUr0cj7hP+LUn4iRsjuZYeA==
X-Received: by 2002:a05:6a21:e8f:b0:1cf:4458:8b0d with SMTP id adf61e73a8af0-1cf75ec54f8mr12394722637.11.1726309959601;
        Sat, 14 Sep 2024 03:32:39 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50cbsm788332b3a.53.2024.09.14.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:32:39 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
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
	alan.maguire@oracle.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v3 0/2] Fix bpf_get/setsockopt failed when TCP over IPv4 via INET6 API
Date: Sat, 14 Sep 2024 18:32:24 +0800
Message-Id: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When TCP over IPv4 via INET6 API, sk->sk_family is AF_INET6, but it is a v4 pkt.
inet_csk(sk)->icsk_af_ops is ipv6_mapped and use ip_queue_xmit. Some sockopt did
not take effect, such as tos.

0001: Use sk_is_inet helper to fix it.
0002: Setget_sockopt add a test for tcp over ipv4 via ipv6.

Changelog:
v2->v3: Addressed comments from Eric Dumazet
- Use sk_is_inet() helper
Details in here:
https://lore.kernel.org/bpf/CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com/T/

v1->v2: Addressed comments from kernel test robot
- Fix compilation error
Details in here:
https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/

Feng Zhou (2):
  bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4
    via INET6 API
  selftests/bpf: Setget_sockopt add a test for tcp over ipv4 via ipv6

 net/core/filter.c                             |  7 +++-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 33 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 13 ++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.30.2


