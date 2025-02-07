Return-Path: <netdev+bounces-163796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A6A2B973
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E3F1650F1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067871624E9;
	Fri,  7 Feb 2025 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CL0Nds8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF62030A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897780; cv=none; b=WJa190TRrd8LjoxY/O6cuovmKh6IU7kjhKrr56TyrQw+GgoIeFxsTtbTGbBZLkKBANYW4dz84pl8ueqAQdZ5uuj3KUracYDwexeeRbEe2IYDkoNLfrOXy4dvkNhQA15Nzc7r5WA6+0afJ8ygNwbGl+4OCDTquMRXFI5wjZxGIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897780; c=relaxed/simple;
	bh=KiRmZ8DqIcR+OnxxKrGOWfmmDrYw/NqG0k5zMUReZ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTYQ/QipsRxFxi38FwgUEEwhx7/KBbFooelLvKcGFbR3Lh2HRYL1tNdNI8zRaBSoS/SReUdwGQ9zMIx61DuN/eCGxHXlCxmOxPdskMHW30+r8OHycMt4eGp5P/xQiJzVfqqJ+Chw9c4JaZ8tAQhmul2apIa+OGENj/ogaQFTk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CL0Nds8c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f44353649aso2335558a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738897778; x=1739502578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsfXGpXzuZR+ErsjE42epoWXJKBH7x41dbTr/ZlyETw=;
        b=CL0Nds8cxZLB3AGY38Nt+6TyEPHhZhThMLLo/ew9tN8dHqOH9rWEpv2gJpA5IK2NwE
         2zFDOCqMAXwhKCmvX20GFwer02ZllS0Cn9pAptPSdhZ9w4P8vVS+v+MY2OTB2mYjmbwv
         H04PylbBwbuCSyJnLSlmEuaRDbB1fxoBNSGQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897778; x=1739502578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsfXGpXzuZR+ErsjE42epoWXJKBH7x41dbTr/ZlyETw=;
        b=cOVquD9Qg8uc2wW/vJy79eagQwAMwXSXKR22m/GxioE0LoLLzq249JQQqcQW9NaHh5
         p4A55ckwBrLKFQivee33BimEy6HAK0vyERD7R0eBsavynKq9Mo8uR+5vhzL0hmtlHy4O
         ZnhYKgRlZfM5Qd6W9RSFAh0wBMYcHucsZBf8ghYsFZnXxbT2xV6GiceYpwIad5vTnEJr
         scIVG9g9CUQgoXdAGzlsC75b4SeFYLf2P6Lb9hxdWjwEHOFsVeESe9SggatjgAoksTfh
         JF9t9k/ag1y8pg7M61+MuJRk+uUFsOVivqTMfm1yXpt8yp/EFaQQCzlQRmaPt4xn/hel
         UltA==
X-Gm-Message-State: AOJu0Yy9tiJmkQiWlXS71pDCVtROrtMl6Yg+kDKDKaDLJwZfZu7K4CdG
	DJPlSn0w73l6Hs9uzoOo4oCv5jPbnzcSQWkgYwzAoyMmJvX6UYoNjx+33Bt0LZPvb3Vru6Y9R6B
	6UZW/PCwWUbR6DvLrNsb3owIQ91gvStbGx30LWIaK6Nz9WPsJnkti1aMERbh2dETRPoBSjEX821
	nJZ2EaiS7561epvIrxJiXoqssGJEXvZ2ZlI+A=
X-Gm-Gg: ASbGncuhPplNgFoZvp4S52LFqb/psxN+5jjSDZ7uvjEVpx2fXlPpk6dX9I73+glOjXq
	eB3tRQGticGzvngznbkkIk6iTbT7+f4M11KaFgsEE668Sqxw33DXAEbbzS5NAurzo07Bfyi4ZJq
	cSRJ/fpyXYilTKgD3cu7bFVP8cH5b6uDX0m7n17n4UePGt5z5QcMR0ufjghLwTSLtumw+zvNw3d
	oPfGSbpqduPEgPIEGQFMOkcn+xI8FdXBCdvo9l45FceTi2mndwNnDfTWFL+AsYGzNGaJHTXnLTU
	ufb0+QhDmSvj7tfkBtnD/OI=
X-Google-Smtp-Source: AGHT+IE4lvGn74SnqtWPP7mNowI1TaEf4zYmlVSufnzq0vzK1BA2GeuK39LAyo8UDxpds6tdfwMaiA==
X-Received: by 2002:a17:90b:38c3:b0:2ee:f687:6ad5 with SMTP id 98e67ed59e1d1-2fa23f5eb89mr2550060a91.2.1738897777676;
        Thu, 06 Feb 2025 19:09:37 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368ab196sm20348955ad.222.2025.02.06.19.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:09:37 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v4 0/3] netdev-genl: Add an xsk attribute to queues
Date: Fri,  7 Feb 2025 03:08:52 +0000
Message-ID: <20250207030916.32751-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4. Small functional change, which makes the code cleaner
(see changelog) and tests pass on my machine with mlx5 and netdevsim.

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

v4:
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
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 9 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: f3eba8edd885db439f4bfaa2cf9d766bad1ae6c5
-- 
2.43.0


