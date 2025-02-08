Return-Path: <netdev+bounces-164283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0EA2D3A8
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF216A870
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF649190665;
	Sat,  8 Feb 2025 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MC3CNqEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73A149E0E
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988073; cv=none; b=RQ6Z6tSthvK9icOdpaWxGVxxtqTHjY1ooCIu+5D9ZHOMDDUgtIQ4UCEbQCKAm5XMhCgiTvZCPJAPr41PZn2udyyHxm01LkpixO31s+JbI15xeViKeY2z+BlN2dWcDSkuWC29XMS6vfrMmPUt3DQySfjpUMZI8yTe/aRiKSfBhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988073; c=relaxed/simple;
	bh=FpM3QtS635xaasFRFZ9L6RSUJzPITN/8NiBEo2sy4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrPkok3tSITSNAvxhvBIq7YSFDxFVl5YiL3yP4CdEkmwjZKjpc27irrsMY/AEtjJB2PPgxFU/z9wqUVdlGf+5J6aNAgPJEqaEM0nFcnw1s+LoGscvUV1xGpmEee6jUpZHNL8zH41TaR1r9M5rQd2OjubHRHD6qUzUO5s/ta1slE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MC3CNqEq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f50895565so20441035ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 20:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738988070; x=1739592870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bw9rVK6jiEnat/1Ue/qEwXGDpUij+zoVhLuOEXleUM=;
        b=MC3CNqEq1o9XqqmkVRwvCw8dmnY4c7Gjl/tkmemMIztzM0P4BnqrCuGL7cXwCenmSK
         W/rpkSZhSc0IHRcXthbyd8D2RIfdcUJ8SGns+2nbxt7ZFUEEsRXA6u9X79quiD8RiVyt
         knOAb/VE9iXDU8Qfac7kmpplwkp6z7I71m2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738988070; x=1739592870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bw9rVK6jiEnat/1Ue/qEwXGDpUij+zoVhLuOEXleUM=;
        b=iWtn7uxpfe7vabCb3A4ke8ujU4sy/2NB43zHUxg5M3m/y54uC9zss5D0hm+cT+s8vS
         /sRD5LuHjXgQzXUrfWfznzAg4cY9WY9pFwtcltxs06mwv0GnR8Vel3UVkv7swrQSPhhx
         NfY41eJWm27lL0xz+H+OVZknJOlvuUqe//+Jl73YDWLZQ712WNB0VwYll5N2FLOKnlgZ
         mpVcEi5zB5kflbB6mONGpU7Tq+sVLszlvA+9CQvoBEwu8tWAQnXIbzgp0G1VBATyyHVF
         bEGDNhylPD2e5yX6J6OzRCELUHIqitmCLJ1WFQQxyJrz7xApTP3Zm2ehT3qr1DH+FOoe
         JqMA==
X-Gm-Message-State: AOJu0YwO8T++yNK3KF32pjV5XIp5a3RZFkE1oEAvZIJ08kAw/X1GFNzF
	BoPQKfQXJHNnqfO/P/pJgfSLcwDlElsx6yhnF74d10jarXmtHCtJ4tXd1CRB7cO8rvrm7FC5Fh8
	scphv4QQDP18c7XW9Q/24jls7j4dtyzq1Czu5dNkoHwQxsTclTXPzkigqT2/zoKZYveQunXqZh8
	rC6dVi33hR2YOJ2p/MdUukkxEEx2pVmSajkvc=
X-Gm-Gg: ASbGncvDbBgY3kPSrxjUriiJgHWdQw8engTi1lcsDgBHWtSMqvbbriShJfpj/XL3im3
	81D2sNI6EgBe/cJtDq2UAN9oFICR9zFVa4tiImBi/QQn+mncsSNoxbvWPuAO5JraImW4/Vi+RQR
	u5CG9yNgXrdw/mJn+70R8Oq8Q+lfxSdRA1WCVGhc3zbcuFbiXw9O1crY8huAgglM/AwensNuxwQ
	WDjUdpmiAuNo+iyJKrQDqfYIe98LZ17+hRDr2p80BOSi8gZSRDk+Fqtp4LjJxVNoasWhHDaqcYy
	SgFdnJazfu2vmxJ9d/GB11Y=
X-Google-Smtp-Source: AGHT+IGWm1Uejyrdq6ZcmoCtjCX1hzqxmw/22k7CLLitGoGa5+xyfbDIw7xsgVppr81ZOSoy25T2tA==
X-Received: by 2002:a17:903:166c:b0:215:6cb2:7877 with SMTP id d9443c01a7336-21f4e1cbdaemr101601115ad.4.1738988070380;
        Fri, 07 Feb 2025 20:14:30 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm38567715ad.21.2025.02.07.20.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:14:29 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v5 0/3] netdev-genl: Add an xsk attribute to queues
Date: Sat,  8 Feb 2025 04:12:22 +0000
Message-ID: <20250208041248.111118-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings

Welcome to v5. No functional changes; removed an unused variable from
patch 2.

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

v5:
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/


Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 ++++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 11 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 9 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 233a2b1480a0bdf6b40d4debf58a07084e9921ff
-- 
2.43.0


