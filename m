Return-Path: <netdev+bounces-238571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF22C5B3A8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 04:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9523B09AA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28125B1FC;
	Fri, 14 Nov 2025 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meI0SFee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD39248F7C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092028; cv=none; b=NUQOE0XXpzu8sUj6O8XRluPr3qRLNOgrBn/KPMnhOV97mnIC4Rpswo0FJFUvEtmtdc8ThdXpNm2ndINzr8571ynXrMaf2r/8ZMYGce9KvHhMN55hfvmgVGVuOMQBfBWrhw0dBKvsradtm99OUDnB3Qtjva2qJ3CJxCHCJKQIQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092028; c=relaxed/simple;
	bh=Nh5zL4xA2rX4GNSnI19vwMeytPqf8ylAnuDTjYE8FBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7gUgJ/GQzK3zFcSuxiYSbMDDeSmVue4G2A9bPZ5eZv9h2GJ7Qmuvf3baPOn7v5qQSazC3VnTX/ZsjZYoPem7xz7hiACImJiezhXpg8MY6qhDTZ6EFRVb8/bntzv2CYYUNopCur9NQcWksoLHRkAQm+jbBbMgArUdlp7sEJSnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meI0SFee; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1345009b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763092026; x=1763696826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjHPZSNEDc7jSI++71zidaetpR13unOEAN3/hk64hPA=;
        b=meI0SFeeeUUMiT40NgE7m1JaHjowCCx1mTRWqHNcZpo9Junf40twjRBba/Ao9URC+5
         TX7J9VxlYi1LtnSjHDTNgoKljp2a45G9IEVShrfxakvGPxKyuqnAvJ5H6WOXzDKZ9Ukq
         3XGArMsQO2HOU4gG0INbHOzURshgCHnwX+l0THuX1LMAHgRk6iWp521T7a5FTo6XOwVA
         f0t0iIsxDNf2SfTHUsnMR17UfbWQIR9oUCHMX03Afkd2hRmUeyp3r27yMtmOSCLVSiEy
         qd6VqNCNBT/PnBLIXaJnHfL6wXjVsc0/KE3YxukwmH7VMxZAGGV07an2VoeI9iXrFSzf
         s2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763092026; x=1763696826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjHPZSNEDc7jSI++71zidaetpR13unOEAN3/hk64hPA=;
        b=UVnihwlRameOutROsuEFa49KOYT059PT1xZfIYXNpDBVQ5v+nL39HAu8ib4jAKm8fq
         3eKVvibEL/fQDzs7L0jENZwW9Ax8yWx4QamVWRxG4MmWQecITkFrHwOGVJIqH9d54TLI
         lp4r5uli1ogWIoj+2tDo0sjAbprVwj/QnFre/bBzKX2fP5LOm32naNZgLleWtPsmdWBO
         bOwnlvqg/xoyFccUx9R2fzFp+GZK4qNtGrhX0+T9lVe7qrhR1O39P0boRhRxp19Hkm/0
         D75FARq8OyDwZ8I1mH1eYd2z1OqL+rtS6xw+lThPOIRT9GDeeqoWqHfU19xhqC1AENnY
         Iwsw==
X-Gm-Message-State: AOJu0YwK3NoEmZ+lKzWr6K17AQxkLBo43QlGkYuDjOiC4sR0gR72ct+A
	zz05xUIwxEOPxghu39r228pv95SokgAc0SaqA/1Le0TkQnWUcEcdLl6iHFqaN+ra3RI=
X-Gm-Gg: ASbGncsSrGzFQBBhgauonIyyIJ8MFdWeyu7KLzoRA3KW/kS3l2UTkvceT1Th7DA5YoV
	0DusFIPVTb7dTq7rUxBi+QK8mKBcijsJY7PbBdNuc7VwusX8hWxfOTnCH4x8EWi9l/cg78jwpZ1
	5PA5UYPFHPKU1LYszD2F1Ae7PtPsUY5tly4n/wQj7NHVL8XV3CtWqtVVS3hpyONLiw6/aBQplq7
	UA5+IOPARJL9jT6elFyVgduVfNd0ihvkx0EhS3bte7rOlExs4EUyyTc1oSfq3XPu3LpEt5bO+XJ
	zv7oG/iAmEjf5lhHjD70WMIF93PP3atvWEBv/qJChivV0crItjMrIFCr2p8dyTTzIs/XlB5V/Ym
	fBTJCtDhBUm9HHBPizKNl8dqV+m4jK0WoBSqfe6cdmeYNBNi0YmIJ3kZBcb0DNGMHYW3zPYx5UM
	ViKWdx
X-Google-Smtp-Source: AGHT+IFDGWk1CNs2A+kYzEGZAn07KmrMl6kbLxJewC2KHVHvf/BBphHHMRE4UsR2yI+tMPV5R1xFMA==
X-Received: by 2002:a05:6a00:991:b0:7ba:13f4:a99a with SMTP id d2e1a72fcca58-7ba3c6654e8mr2102120b3a.27.1763092025610;
        Thu, 13 Nov 2025 19:47:05 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826273sm3669756b3a.52.2025.11.13.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:47:05 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/3] Add YNL test framework and library improvements
Date: Fri, 14 Nov 2025 03:46:48 +0000
Message-ID: <20251114034651.22741-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series enhances YNL tools with some functionalities and adds
YNL test framework.

Changes include:
- Add MAC address parsing support in YNL library
- Support ipv4-or-v6 display hint for dual-stack fields
- Add tests covering CLI and ethtool functionality

The tests provide usage examples and regression testing for YNL tools.
  # make run_tests
  TAP version 13
  1..9
  ok 1 YNL CLI list families
  ok 2 YNL CLI netdev operations
  ok 3 YNL CLI ethtool operations
  ok 4 YNL CLI rt-route operations
  ok 5 YNL CLI rt-addr operations
  ok 6 YNL CLI rt-link operations
  ok 7 YNL CLI rt-neigh operations
  ok 8 YNL CLI rt-rule operations
  ok 9 YNL CLI nlctrl getfamily
  # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
  TAP version 13
  1..8
  ok 1 YNL ethtool device info
  ok 2 YNL ethtool statistics
  ok 3 YNL ethtool ring parameters (show/set)
  ok 4 YNL ethtool coalesce parameters (show/set)
  ok 5 YNL ethtool pause parameters (show/set)
  ok 6 YNL ethtool features info (show/set)
  ok 7 YNL ethtool channels info (show/set)
  ok 8 YNL ethtool time stamping
  # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

v4: Use KTAP helper to report the test result (Matthieu Baerts)
    iterate through $(TESTS) instead of being hard coded (Donald Hunter)
v3: add `make run_tests` to run all the tests at a time (Jakub Kicinski)
    use ipv4-or-v6 display hint for dual-stack fields (Jakub Kicinski)
    check sysfs in case of netdevsim buildin (Sabrina Dubroca)
    Link: https://lore.kernel.org/netdev/20251110100000.3837-1-liuhangbin@gmail.com
v2: move test from selftest to ynl folder (Jakub Kicinski)
    Link: https://lore.kernel.org/netdev/20251105082841.165212-1-liuhangbin@gmail.com
v1: Link: https://lore.kernel.org/netdev/20251029082245.128675-1-liuhangbin@gmail.com

Hangbin Liu (3):
  tools: ynl: Add MAC address parsing support
  netlink: specs: support ipv4-or-v6 for dual-stack fields
  tools: ynl: add YNL test framework

 Documentation/netlink/genetlink-c.yaml    |   2 +-
 Documentation/netlink/genetlink.yaml      |   2 +-
 Documentation/netlink/netlink-raw.yaml    |   2 +-
 Documentation/netlink/specs/rt-addr.yaml  |   6 +-
 Documentation/netlink/specs/rt-link.yaml  |  16 +-
 Documentation/netlink/specs/rt-neigh.yaml |   2 +-
 Documentation/netlink/specs/rt-route.yaml |   8 +-
 Documentation/netlink/specs/rt-rule.yaml  |   6 +-
 tools/net/ynl/Makefile                    |   8 +-
 tools/net/ynl/pyynl/lib/ynl.py            |   9 +
 tools/net/ynl/tests/Makefile              |  32 +++
 tools/net/ynl/tests/config                |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh       | 309 ++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh   | 206 +++++++++++++++
 14 files changed, 591 insertions(+), 23 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

-- 
2.50.1


