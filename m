Return-Path: <netdev+bounces-150249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4D9E994F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FCC1887F98
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3A1B425B;
	Mon,  9 Dec 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cifgoHdE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D811B424E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755663; cv=none; b=AcrJwM1rLAW9LII6Bz+3vnBV6Xt93+cFsZyl0WuqD0zY/FCLSPFvLOx21eLoKxMMRuvS33YEHM2/tB2MLO/QeRl2q8V0+ngLGFAXAhwESUUUFjOZuJ2Za23Mxt0Ez97LDjBnv1SqHiwBurO86SLnpEIWbomladhegKZ+ncgXiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755663; c=relaxed/simple;
	bh=/SpHMbHWYU+1Ma28z8lJfuTHFRqCyaLjd3t+8icbYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=sULQ+V/tpUYmyJ3WKCSyiLfffG6CWqTWTObHPtokRhkbPAgnij6m/tD6iV8WiVxLlLrguBuvYleGxz15eQZLczNkybNPVsRD5JULISkSaFbWxEuQo7Kv/M9DyhN3rLao9D3+It9FMf/eKURfPgReujMaVd+LsRBBHUqF5w+ry6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cifgoHdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dpybdRZv29vukozctoLYUE7OBLoChH1fK4UnEFz1tVI=;
	b=cifgoHdEOhLStcrstXN3yhOiMsbm1lgdSMskeO42/zSbT/90lM50ihCddK+hTbZrZ0Nu0u
	r1X/ZADLHcy5Us5ST9quEekv4+g4TK466JkdhrLN96uvg+OhKNn+DDEv4BUy7rUSJzNyPj
	v49EAKei7ozY/xPzND86ziOmTLRRaT4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-oLl0wyxBMaefeslkKharbQ-1; Mon,
 09 Dec 2024 09:47:37 -0500
X-MC-Unique: oLl0wyxBMaefeslkKharbQ-1
X-Mimecast-MFC-AGG-ID: oLl0wyxBMaefeslkKharbQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D2D1956048;
	Mon,  9 Dec 2024 14:47:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F3FC1956089;
	Mon,  9 Dec 2024 14:47:29 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v2 0/5] tools: ynl: add install target
Date: Mon,  9 Dec 2024 15:47:12 +0100
Message-ID: <cover.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This series adds an install target for ynl. The python code
is moved to a subdirectory, so it can be used as a package
with flat layout, as well as directly from the tree.

To try the install as a non-root user you can run:
  $ mkdir /tmp/myroot
  $ make DESTDIR=/tmp/myroot install

  $ PATH="/tmp/myroot/usr/bin:$PATH" PYTHONPATH="$(ls -1d /tmp/myroot/usr/lib/python*/site-packages)" ynl --help

Proposed install layout is described in last patch.

Changes in v2:
- squashed 1st and 2nd patch together
- added symlinks for original user-facing scripts for backwards compatibility
- updated also Documentation and selftests references
  (tested Doc build and selftests ping.py test)

Jan Stancek (5):
  tools: ynl: move python code to separate sub-directory
  tools: ynl: provide symlinks to user-facing scripts for compatibility
  tools: ynl: add initial pyproject.toml for packaging
  tools: ynl: add install target for specs and docs
  tools: ynl: add main install target

 Documentation/Makefile                        |    2 +-
 Documentation/networking/multi-pf-netdev.rst  |    4 +-
 Documentation/networking/napi.rst             |    4 +-
 .../networking/netlink_spec/readme.txt        |    2 +-
 .../userspace-api/netlink/intro-specs.rst     |    8 +-
 tools/net/ynl/Makefile                        |   25 +-
 tools/net/ynl/cli.py                          |  120 +-
 tools/net/ynl/ethtool.py                      |  440 +--
 tools/net/ynl/generated/.gitignore            |    1 +
 tools/net/ynl/generated/Makefile              |   36 +-
 tools/net/ynl/lib/.gitignore                  |    1 -
 tools/net/ynl/lib/Makefile                    |    1 -
 tools/net/ynl/pyproject.toml                  |   26 +
 tools/net/ynl/pyynl/.gitignore                |    2 +
 tools/net/ynl/pyynl/__init__.py               |    0
 tools/net/ynl/pyynl/cli.py                    |  119 +
 tools/net/ynl/pyynl/ethtool.py                |  439 +++
 tools/net/ynl/{ => pyynl}/lib/__init__.py     |    0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py       |    0
 tools/net/ynl/{ => pyynl}/lib/ynl.py          |    0
 tools/net/ynl/pyynl/ynl_gen_c.py              | 3018 ++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            |  453 +++
 tools/net/ynl/ynl-gen-c.py                    | 3019 +----------------
 tools/net/ynl/ynl-gen-rst.py                  |  454 +--
 tools/net/ynl/ynl-regen.sh                    |    2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |    4 +-
 tools/testing/selftests/net/ynl.mk            |    3 +-
 27 files changed, 4133 insertions(+), 4050 deletions(-)
 mode change 100755 => 120000 tools/net/ynl/cli.py
 mode change 100755 => 120000 tools/net/ynl/ethtool.py
 create mode 100644 tools/net/ynl/pyproject.toml
 create mode 100644 tools/net/ynl/pyynl/.gitignore
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 create mode 100755 tools/net/ynl/pyynl/cli.py
 create mode 100755 tools/net/ynl/pyynl/ethtool.py
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (100%)
 create mode 100755 tools/net/ynl/pyynl/ynl_gen_c.py
 create mode 100755 tools/net/ynl/pyynl/ynl_gen_rst.py
 mode change 100755 => 120000 tools/net/ynl/ynl-gen-c.py
 mode change 100755 => 120000 tools/net/ynl/ynl-gen-rst.py

-- 
2.43.0


