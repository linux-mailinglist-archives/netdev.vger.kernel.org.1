Return-Path: <netdev+bounces-73007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4A85A9DD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9A1F2206F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332C44C98;
	Mon, 19 Feb 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rCGVgKmu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5847F77
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363532; cv=none; b=Vr0FkAtJj3xBGULtxdoWcahSdQsOthJQHI32AzHbRITLOLv3SnHyoec4VbUsyji+bD3WrQ+HcOeOPz5nEGJNCrQMckc8JxS3Ku91mGoe8y23CjzhJPmOtEYO9MdA44XsDcm5Wgs3gUqEo4JcfMLqjCGkj6PPftzQRSd/1JObz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363532; c=relaxed/simple;
	bh=JyGVQNocAfXL6bIwVkart+6gGnvFOkzFkqhl4v3PG6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgTyh2NqeG6weC/CfKMCWqXyZ+eKQ65XlCxpNs7ALfmkfi+3++k8jQrNd6S6sZu+r4fEseXbJaLRRplToqwtiV3owo/nZZu4FIJTadQm13NfAc7u8dWWBnM+O4VDx3pqXQQtT+t4ypJdAKeK7GhrvcvK3yvEXpJ5v8+Ef/Vx5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rCGVgKmu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d36736d4eso1315093f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363528; x=1708968328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6JeMIHTNrEuCOSfDgndLT6fFyyaJOMpzTAP3Ggk3Nw=;
        b=rCGVgKmu320aXGMWizDa8OHLmjukolUkk47aDrgBrcOZA9X3KihmCVivhy8hViXFNl
         WcedrODWXBaOnaysQh6SWbyAdhdYktjKzG6dibQmnngQKn696MiN8O4l0s1eGFqkCGTF
         hXTu1jUvZtHyGjVSck5whqhr2Y1kchJu82nHbk0g97PEx6BquZEK4PobBBOpRs56/QMf
         bee4Zq+6qZ4k/PohRCnGKxSCzlb5v/9sRlEh1hY0PLJViLbeEMBMf+y6Jq3iqGzG7hMt
         GZfuqFgZjfhDo16yMFiqzF5X32RxiS2LbrUvEomrLbMiqYEzE2Wh/vGXqWuvYoWPaTMN
         352g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363528; x=1708968328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6JeMIHTNrEuCOSfDgndLT6fFyyaJOMpzTAP3Ggk3Nw=;
        b=h29HJKtU5IRy7K5xNUvTGu7Wrmljfc1FlMIsLJP6a1je6LLxGQi065pmQV6InLwTCQ
         SXp7xg+LDit686hdwJ1w1vgfed7VOWaFc6qBzraN9UAtWabEjH8zgHAkq9O2Nt068Usf
         jowbtWs1iOg2b/jihXtpoSt6FTVdr+LiIebwxfGtfmaQDHW4hBYOMVUmYseIh9XHbRQg
         SwLm242NEE6LeUlxhZEjXcjEmKjfIrk+ah7IcH7zUvffg32oLngEWewZXMKTXfYtM9ER
         EPYj2wDiZwh98IR0S8seUDlkokLILVRIypy1ksIgHKJXv5As9g9LCfvGpAXvZ+5/U9j6
         JhJw==
X-Gm-Message-State: AOJu0YwzJ53eRbZysf/xTAxI4AMxfXn5l0BkRM4ZpZuIEG7tb/GXb2Xv
	q0JEBbU81ksf9hJDwz4jEyXwdG3U0QjpWaKZwRH4DSq0sW2wem/D5S7eOKQAoi37D3lPO3lYAIe
	h
X-Google-Smtp-Source: AGHT+IFN3CXKSEGPkAtitvm4EmcE9v98twNdNRjOAK8GAvq7quT+J62U+m9nRjtZzqL4yeho8yV3IA==
X-Received: by 2002:a5d:64c2:0:b0:33d:3098:c20 with SMTP id f2-20020a5d64c2000000b0033d30980c20mr5999967wri.2.1708363528375;
        Mon, 19 Feb 2024 09:25:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d610f000000b0033d4cf751b2sm4239607wrt.33.2024.02.19.09.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:27 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 00/13] netlink: specs: devlink: add the rest of missing attribute definitions
Date: Mon, 19 Feb 2024 18:25:16 +0100
Message-ID: <20240219172525.71406-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchset is adding the missing definitions of devlink attributes.

It got a bit tricky, as the param and fmsg value attributes have
different type according to a value of another attribute. Thankfully,
the selector infrastructure was recently introduced to ynl. This
patchset extends it a bit and uses it.

Another tricky bit was the fact that fmsg contains a list of attributes
that go as a stream and can be present multiple times. Also, it is
important to maintain the attribute position. For that, list output
needed to be added.

Also, nested devlink attributes definitions was added.

Examples:
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
                              --dump param-get
[{'bus-name': 'netdevsim',
  'dev-name': 'netdevsim1',
  'param': {'param-generic': True,
            'param-name': 'max_macs',
            'param-type': 'u32',
            'param-values-list': {'param-value': [{'param-value-cmode': 'driverinit',
                                                   'param-value-data': 32}]}}},
 {'bus-name': 'netdevsim',
  'dev-name': 'netdevsim1',
  'param': {'param-name': 'test1',
            'param-type': 'flag',
            'param-values-list': {'param-value': [{'param-value-cmode': 'driverinit',
                                                   'param-value-data': True}]}}}]
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
                              --do param-set \
			      --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "param-name": "max_macs", "param-type": "u32", "param-value-data": 21, "param-value-cmode": "driverinit"}'
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
                              --do param-set \
			      --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "param-name": "test1", "param-type": "flag", "param-value-data": false, "param-value-cmode": "driverinit"}'

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
                              --dump health-reporter-dump-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "health-reporter-name": "dummy"}'
[{'fmsg': [{'fmsg-obj-nest-start': True},
           {'fmsg-pair-nest-start': True},
           {'fmsg-obj-name': 'test_bool'},
           {'fmsg-obj-value-type': 'flag'},
           {'fmsg-obj-value-data': True},
           {'fmsg-nest-end': True},
           {'fmsg-pair-nest-start': True},
           {'fmsg-obj-name': 'test_u8'},
           {'fmsg-obj-value-type': 'u8'},
           {'fmsg-obj-value-data': 1},
           {'fmsg-nest-end': True},
           {'fmsg-pair-nest-start': True},
           {'fmsg-obj-name': 'test_u32'},
           {'fmsg-obj-value-type': 'u32'},
           {'fmsg-obj-value-data': 3},
.....
           {'fmsg-nest-end': True}]}]

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
		              --do port-get \
			      --json '{"bus-name": "pci", "dev-name": "0000:08:00.1", "port-index": 98304}'
{'bus-name': 'pci',
 'dev-name': '0000:08:00.1',
 'port-controller-number': 0,
 'port-flavour': 'pci_sf',
 'port-function': {'caps': {'selector': {'roce-bit'}, 'value': {'roce-bit'}},
                   'devlink': {'bus-name': 'auxiliary',
                               'dev-name': 'mlx5_core.sf.2'},
                   'hw-addr': b'\x00\x00\x00\x00\x00\x00',
                   'opstate': 'attached',
                   'state': 'active'},
 'port-index': 98304,
 'port-netdev-ifindex': 7,
 'port-netdev-name': 'eth4',
 'port-pci-pf-number': 1,
 'port-pci-sf-number': 109,
 'port-splittable': 0,
 'port-type': 'eth'}

Jiri Pirko (13):
  tools: ynl: allow user to specify flag attr with bool values
  tools: ynl: process all scalar types encoding in single elif statement
  tools: ynl: allow user to pass enum string instead of scalar value
  netlink: specs: allow sub-messages in genetlink-legacy
  tools: ynl: allow attr in a subset to be of a different type
  tools: ynl: introduce attribute-replace for sub-message
  tools: ynl: add support for list in nested attribute
  netlink: specs: devlink: add enum for param-type attribute values
  netlink: specs: devlink: add missing param attribute definitions
  netlink: specs: devlink: treat dl-fmsg attribute as list
  netlink: specs: devlink: add enum for fmsg-obj-value-type attribute
    values
  netlink: specs: devlink: add missing fmsg-obj-value-data attribute
    definitions
  netlink: specs: devlink: add missing nested devlink definitions

 Documentation/netlink/genetlink-legacy.yaml   |  54 +++-
 Documentation/netlink/netlink-raw.yaml        |  10 +-
 Documentation/netlink/specs/devlink.yaml      | 260 +++++++++++++++++-
 .../netlink/genetlink-legacy.rst              | 126 +++++++++
 .../userspace-api/netlink/netlink-raw.rst     | 101 -------
 tools/net/ynl/lib/nlspec.py                   |   8 +
 tools/net/ynl/lib/ynl.py                      |  81 ++++--
 7 files changed, 500 insertions(+), 140 deletions(-)

-- 
2.43.2


