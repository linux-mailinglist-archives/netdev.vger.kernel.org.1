Return-Path: <netdev+bounces-240260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB1C71FD2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5B06345BD4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB530215F7D;
	Thu, 20 Nov 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YeXVB8Tc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5F28469A
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609420; cv=none; b=JUad3lbQThP1YqWeipYtsqOSnJV3dwWY68gpNY0t9Q+yMuPWpkKNzvwliZB6b5W99MxE6BA+ZnMADv2q2edefCXmtXqwiYY+g+W+7568l13XL2zUCzqQ3/GK7UyMvHIcDQB5nbzAVmlEYh4jTpEMygXOJd9yFnrsj9KXFFG5WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609420; c=relaxed/simple;
	bh=sYpuCmnFYLO1eRI9ASjsjSXan4Qv/IpZDe8OfYolo38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0v/nekqH2A9RI7BEADKT1MNlFhwsBFRBW0nO5ecoU2M5AR/SgIlQDMdgmOMnpYLkLqG98TxxzR0hC7+YTTSuObtvWsh3TGJAbdzIeO+qv4ALHz54bL5/5c/ASX7cHNW7kN/qah1MYQj+ae8keSL7lTKRPODr/gUfDBIouusge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YeXVB8Tc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c701097a75so218007a34.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609418; x=1764214218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3xpM518Be1YFRb1AJ2NXu1S9+wWXUeKQZGU0RlNTVE=;
        b=YeXVB8Tc5sccYyb1XsV2TXDCK+IoRfyI8KR6mjQZ75cp/SyeIgEEBUnhHm4rcR8TE7
         QQ0KGl94XVu99AhUiYR07jPTR8n7YdJXpU48RRLSpXmQGmjmkFebWvw5NyLAQQjeBzz5
         bR9n8DnMkh1kaU9Sla0Aoe1Tuzq2UKhNZcmMnyFEANC0x7RzoFRV4CV3Wtr9TpF+EL4E
         y3nE79Srknr1F8IuUnjf+MWvbW0s/bSjzOxXwQtCjCe87v7uabI9m0GL5kHBAmGfh/H2
         hMlwMywQFISU142nYPfShIeNS92TMkNxS/wjnFxVJHt9kSGwDzzZWvriL7gqUi2zCSmD
         QYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609418; x=1764214218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3xpM518Be1YFRb1AJ2NXu1S9+wWXUeKQZGU0RlNTVE=;
        b=W5z5oS9YLk3GEGklKTMQXrSgwTOSRCM5LYXvAKrkNWi9M0H4hBfCDEex+Zv8gVX7If
         HMJnmBGG3fT3fAmb20WfQamYwuZoIxfedKYfst2RUQLAS7E8Gd3O5NwxEEHKDZP0+v0s
         4lm/CZaLd6I3SBxlSP17tgIg+Uoi3ji5JTJiPYaBOSwgn9nx+83Dtenac2ILTS0aa+Fk
         JpRXpcbqFImwugbTQcAEhzxjYyzJQAOazoW1hHtk8JAH8Ys+xb6N3zYcwGcvL2uAPVIL
         xyp8p2jMoMSmEU7VOUG+Qm5tiMkgxwTrR0/SVlqv1sbTUOeAeJxlZYpLDvghqBdAvXsh
         eHAw==
X-Gm-Message-State: AOJu0Yxe+JllhbpfQlH0Xs/uu5sdpKoG0zgfC/iah5klPOQjpMi/SriI
	8NvjTfl4rMGnXi+Q3GfjoofinM6+BP+iq4O6H9a/fcyhMOB5YACIz9hao6cuFoG7wi1MyCtgAEv
	7VmVn
X-Gm-Gg: ASbGncuP+dhj+tv9wTJ0tFqljkKTj+df2OYMPt87Eq7v9IeCnjaTldY5Ftr5KeflH5P
	3p+NNpN9uHplu23YDEBoxTVFqF31UWopydmFFIwCsGD9Nm6oGFAB7GlBsIMGb83lqrQGYz9f7Bz
	So2xvNTV38c0qg1f8e1oHx25vXVCEXnJDFAFpcmWGVJVDA7Op4ZZOIjcAJGbaIgCEOvi0kuztKY
	EpikumWdbNB6FvabJFCVeYHd1ANn72TdMKghXTmDJc3pxEn9CC989Pq+ooeFgkEo/TyH9EI370L
	KlnYoTCyA85i1XaOBjeWor8FzucQz7cVeWOIcAmtCgJq6bVMMHkmzx+Ulv4EOCICXRvAOaRguEu
	2WM+N4uBsLzHxH51YDUZCGDlGsoQqIUN8TyK53GREj3jY9wKTzeZhwY1o1katnz2ZPC2OZQPknd
	13SPmy69CiJ5DENyn1/c8Yk/z6jz0DDU5XTEeA5tp7aA==
X-Google-Smtp-Source: AGHT+IG2jo3UwVurDS6GmHdpUnYm4agd3Ifo1TpALB280PZLrzvvB1RxKvMKPkD2r/iLxBjX58ohoA==
X-Received: by 2002:a05:6808:200f:b0:450:ac57:48a7 with SMTP id 5614622812f47-45103aae9acmr328438b6e.59.1763609418299;
        Wed, 19 Nov 2025 19:30:18 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782badb38sm451445eaf.16.2025.11.19.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:17 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 0/7] selftests/net: add netkit netns ping test
Date: Wed, 19 Nov 2025 19:30:09 -0800
Message-ID: <20251120033016.3809474-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is mostly prep work for adding a data path test for netkit
bind queue API used by iou zcrx and AF_XDP.

Using memory providers requires carving out queues, setting up flow
steering, enabling some features. Add a new MemPrvEnv, similar to the
existing NetDrvEnv, that automates the setup of the NETIF under test.
Refactor the existing iou-zcrx.py test to use this.

net_iovs cannot be forwarded through the core, and so bpf is needed to
forward skbs from NETIF to the netns netkit. Add a basic configurable
bpf prog and associated loader that does this.

For a remote to talk to the netns netkit, it needs a publicly routable
IP. Add a new env var LOCAL_PREFIX_V{4,6} that defines such a prefix.

Finally, add a basic ping test that brings everything together.

David Wei (7):
  selftests/net: add suffix to ksft_run
  selftests/net: add MemPrvEnv env
  selftests/net: modify iou-zcrx.py to use MemPrvEnv
  selftests/net: add rand_ifname() helper
  selftests/net: add bpf skb forwarding program
  selftests/net: add LOCAL_PREFIX_V{4,6} env to HW selftests
  selftests/net: add a netkit netns ping test

 .../testing/selftests/drivers/net/README.rst  |   6 +
 .../selftests/drivers/net/hw/.gitignore       |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |  10 +-
 .../selftests/drivers/net/hw/iou-zcrx.py      | 131 +++---------------
 .../drivers/net/hw/lib/py/__init__.py         |  10 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 +++++++
 .../selftests/drivers/net/hw/nk_forward.c     | 102 ++++++++++++++
 .../selftests/drivers/net/hw/nk_netns.py      |  89 ++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   9 +-
 .../selftests/drivers/net/lib/py/env.py       |  72 +++++++++-
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ksft.py    |   8 +-
 tools/testing/selftests/net/lib/py/utils.py   |   7 +
 13 files changed, 370 insertions(+), 131 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

-- 
2.47.3


