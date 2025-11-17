Return-Path: <netdev+bounces-239009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D0C6223E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A29E622EE2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38C2494F0;
	Mon, 17 Nov 2025 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSStujHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AB23BF91
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763347511; cv=none; b=deEONA6pujWE2H25hfgEqGFGvuGXMT5hPh+1N+W+UEgk5nRZi5e6KezD7s3COPbFgg3Ag0gP//dDzsBrGfQLVwootKpS1uba7g7EVDObHJrWw9j5n3RNbvh4X5GIcNEg2XBljZR5QE+/MAJhLriLF/LtopMujI35/vl9GpPZvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763347511; c=relaxed/simple;
	bh=ZVUTfDhTT/GOlvzjT3r/C0OfmEYwDYEsAH2JocXB04o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKpMpoRbPYTAgm4nlXY8qx41doR8ilDzdpUAYn3dCHLUB9QPQ9OLpRUn4ez7PkFcgFypeKsM6qxB9nrVKkOeExAi+00HWRdEfaMgDhq7qlVdBGFGqvnCmm2azQFarnQ98k87tIUakuHt50wRiA3Ie9jb2KwnX+2lft9dPM2+HJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSStujHv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2958db8ae4fso34757055ad.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763347508; x=1763952308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oepM6P0+Z/yp3y3nzv3XvDuV7EmlyvaBGIywVHHDMYc=;
        b=jSStujHvqf++85Y0e270zBheBgmqwJJ3snlJP72HUSY6DUZrGbGiKqKcI9wmiPiCU4
         cX+XoQcEWjYbkTk2YKjWvyF/Bs/+CsQ1Pt6/ITaY+NlvCPCQTB9eBb6CrDi+nEB+h57i
         SGfuC5YxJwr6LJJkMSJVAKsbGSaNrZv7Lk/LnG2SRkDU6ESjAlGtl63PJFmWajshWqco
         hK6El/0hxAjwRTHutIPX1cCtaTNNaiLlZZLGvZ0eu6iESCBHxRzc8KvFHRhECpBt2jiP
         SyMPp6lkeU5zUL4HXcYCQpkWa+lxBo7PXLL9SyPhZQ8pvUrS+h/9vAA3Zn4VipS+c7rv
         0K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763347508; x=1763952308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oepM6P0+Z/yp3y3nzv3XvDuV7EmlyvaBGIywVHHDMYc=;
        b=YzDHIRfO/SclH14To+EcaFKMnjACImJMAUG9wgNkzwp7HWH2LzKh13sEWXy4WYJtgZ
         Yy15C82qaIGQpxyMY4YzDpxn8NjGNHFRYaLj61SLUas+f9+2t0PvUpTidypBwCJ5n2Ee
         lXFSx6LOEfYsAz4uG3lwJNrugJFZYwmYxt9ct2c6ac0h5VG+b5B4lVvG5Sm9RmJ0tzL5
         Xoq3jBTUoRMX0SiuelzUcNMbF1WW61mbLT5glA/FJ/ejSjPh9LW9KEWinQQyCkII7a3O
         mUbnbXaSoafb4PnhDyVmnBoLYwcbPUaFKBmSjNtROlfSyLDVZ/2RmpcsgzaTK6wwK0cN
         W4sg==
X-Gm-Message-State: AOJu0Yxcxv3P6X04D69KdnWV0qjQNTLZX4ULmb6WulpLv2vHoub+aM3Q
	HqlCvOYuZ/38jO7qGjBejy0RPGpt4Q5pbty4X+t4TpZaX/em5qbKyR0a7R5NXGeV
X-Gm-Gg: ASbGncvERSgwMIDClzJu/Y7Lf9GttYdWMM5g9jWYKpOjWcbU31gV+y6ze7dwO+FVp4l
	IH6zC6mc4GPddQDiGGeeE7gpwyPW3DZ8KrpwLdrePNWJ6x/fKBK4RtanQqfYirg34qkvqXanC6a
	Mls1IiK+gpAzrovbNzeDylcD48/qy3M9wBbYrvv5l/FoTs5m6aK54w1+O7+mGvl8GiMrNwuy8rC
	V9bf+7xNclkjVH5Dxu0FpK+4LXwI82eZfl5t1t1QETKHYCIBjHvZOI8kAHI7rWX1n3GLpdhM/0i
	0gKtrCU0YCqej1AICx3qj2UWWTk18fxI2SyOXI7w0RRoUf5mwjC5LmoowD5gZt9ir7TahrXq8E5
	eN+tBDxWkKXgDboRf5JZLEH6v2sQ52kwrrXxijwALltCRbVs/VKgYloy3t0geAlLpLiM49zasMK
	oJpJARK6hjMFP9P3Q=
X-Google-Smtp-Source: AGHT+IFmc12LBLI+wPXxTBCBbV5nW6D84rkWmG1TtyXKTarka+BZ4+yNnGUgJxNc7UKyKRTH6CsO9g==
X-Received: by 2002:a17:903:2350:b0:298:616b:b2d with SMTP id d9443c01a7336-2986a75275fmr116940015ad.51.1763347507621;
        Sun, 16 Nov 2025 18:45:07 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef32asm85041885ad.39.2025.11.16.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 18:45:07 -0800 (PST)
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
Subject: [PATCHv5 net-next 0/3] Add YNL test framework and library improvements
Date: Mon, 17 Nov 2025 02:44:54 +0000
Message-ID: <20251117024457.3034-1-liuhangbin@gmail.com>
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

v5: add a comment about why disable shellcheck (Matthieu Baerts)
    move ktap_set_plan after setup (Matthieu Baerts)
    Use TESTS_NO to track the test number (Matthieu Baerts)
v4: Use KTAP helper to report the test result (Matthieu Baerts)
    iterate through $(TESTS) instead of being hard coded (Donald Hunter)
    Link: https://lore.kernel.org/netdev/20251114034651.22741-1-liuhangbin@gmail.com
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
 tools/net/ynl/tests/test_ynl_cli.sh       | 327 ++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh   | 222 +++++++++++++++
 14 files changed, 625 insertions(+), 23 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

-- 
2.50.1


