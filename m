Return-Path: <netdev+bounces-162704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66440A27AEA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BAA3A224B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3F218E8B;
	Tue,  4 Feb 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="p2iNy5Wu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236621885B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696275; cv=none; b=T0I/UjVd4I9aJougq11jdvL7WxYwwg9difkdnxYQwQ58nuUwt6rEewkREJa2rnsro04todrcXSsG1gG9OpT+Bx7+FEw+m5oaTxp1jxN3HMQWLrGf8RG0JT9Oam0Nypa+BWrpYzlQsdf3OWwSZo//MrKoA+XlcY6ZlaLAjpfWwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696275; c=relaxed/simple;
	bh=0fuYrIsqllSYzLcHkJwRY4bJmN7f0RR3V+7BnwkqZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NryboiJz0Bw5TXPEvc1K0qekeh2+3+BQ3bhfse2BgNwwJSrpcRFwOu2UrHGdGdZE6+K0R3GYxkmQJln1jXDGNl2KLQmCeGSf+0FCb04axBswttvlvom0N4mxDDcWszw0ezWURVX3MDL2Xr1rzs/X6Oig8FALdVFU95L5krktSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=p2iNy5Wu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21ddb406f32so16078165ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 11:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738696273; x=1739301073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6v2PFnPWGVlwpnR5q4crYxZDb82PXI2M6sV6qpxfa4=;
        b=p2iNy5WuLXL7dHihh847affEbdk5jw/XsmMqHzVKEeg58Taq2ilrheA+kep6UOex1C
         3fzqB7rMwZs820NvP1WwDqN9HeD5/3ExVn3TUh9mHjae6bMXvoE8CorbfPt+FYD2RHB+
         cFnL4nkHXDUb/ThnD9Uh/NUBUQB+sKeWPLwKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696273; x=1739301073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6v2PFnPWGVlwpnR5q4crYxZDb82PXI2M6sV6qpxfa4=;
        b=DTo37IfEHHhCxS7dEFbK7VoyUC+C8qvk0TPX4ODAhhKKT0wZYfS3CYtT8bCqOcY0+J
         yDnpD+vGhgOpIN9tGf5Hbfzl1kCDQC3s8WaZvGturrHuIVYjtZdE44TWVzYjgCRSwjMd
         Xi3F5gb9cLowRe89ojCbW4UcbjSCfQ+0H6h5D0vlyKmUSM3kFg47qIkCbPOd8nAdIec9
         mEwA8beHJrUOVj+cEWwdFY0nE/7OuksitQOc19p1Gjw2G0bekR/8ayMN6B2mU0MfmUEk
         bqmEjjqdWLgIHym1lgnPOr4TMGmi/C0SIubj2RdTODUmAphFlMcMmeTF3hEa+89oSBnu
         IVQw==
X-Gm-Message-State: AOJu0YwZbh96usgDZ02gV2etRMpiACvdKiULpzvp6b7svv7B5tzsSafz
	wlXlyJRXRx4jYhwyex9hAnErlI+7npYjeVVx2HWSa8Bmo3jJkZCBlsLpDcqXqUcFO2oKX/pK5+e
	ufxhZphV51sd3gH+vBytpuAKpz51Au0JgkRepWaxk0ZMpz7hLy3Mdo9s8mtb4QjNfXwdaoxwLjz
	rtxKfCkIGrT0V1AfMQBLwv46Bhqvv4RHfNgYU=
X-Gm-Gg: ASbGnct+KZ2dIdUxxKgKjMmp6iKQXBG46cRQgfTuwYugpAioc335ban/MR8Jv8ZsGql
	NZcsQUx5J9EeEIt5aSdjsk5Hz9O5RKEUsjNPUM2bLLWyERiOzD0pT1U+cPtfol5aSDr4zFuPiIm
	Gy9wwtrsezzSRSnWmlSpAdL3/pDXGIB8Hwa54ztouD+4FtfqcSGPZ++CRqUC/43MhZ6oL/IKUPU
	W/48P8+ZvrQc+eclupkod4wdbmqa94wj5KFe0FLVOMbUsaRAgwXOv6qkz6T6eMUkBh1soS58uly
	yJLwxdNX7R6XHFP5ppg8MLA=
X-Google-Smtp-Source: AGHT+IHanqXpzFtreEkBCacmTKic/+ySduWwGEttNxARnmGyeReqSJRYRr1Lcw0ZgAN2NJKjdJwsaA==
X-Received: by 2002:a17:902:e747:b0:219:cdf1:a0b8 with SMTP id d9443c01a7336-21dd7d7ccaamr366849085ad.30.1738696272708;
        Tue, 04 Feb 2025 11:11:12 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5f1sm100749785ad.130.2025.02.04.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:11:12 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v3 0/2] netdevgenl: Add an xsk attribute to queues
Date: Tue,  4 Feb 2025 19:10:46 +0000
Message-ID: <20250204191108.161046-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3. No functional changes, see changelog below.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v3:
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

Joe Damato (2):
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 11 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 8 files changed, 162 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
-- 
2.43.0


