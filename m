Return-Path: <netdev+bounces-156281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC15A05DB8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62843160D90
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112451FCCED;
	Wed,  8 Jan 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoW8Cx85"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389F1514F8
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344619; cv=none; b=hvVE+jtvJa0KDrqwMijsPil0HPCyQIDrCyvfBignzMjg/pQnt2+zfe9caS/MngrHU2QKcI643Aow6GD0srpw1CGnge04dDAioo5rbJSL4EgvFJss6KwOhLmbVRhrFf94IVcnMAc7eO1fVAGSwgK9JFELzx0jpK4qb98BO0J9SPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344619; c=relaxed/simple;
	bh=XSmVghZQYJg/guSBgRC1qEwqtZ9lEQ7IH29JTbZ32j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=r8ryPRMu0nIDhc2KHf4xU44IZJxelQp80kOC4mXFc4UcAxkqqq2CgsFcqDR1wu3kuLEbtev96I2ai8zmyI4EevI4epTevVT2XbhJ8rj+JJbEqfcs0ytO1kFvZtr/ZDcXPfVkhBvEfw0JXJfpX7UBMk/AbiLRn4pGQyE0p7v/hJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoW8Cx85; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736344615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3L7zp1US36o3r95Xqx3Ef6BGfrB7O/v1PvmkGJaUDIE=;
	b=eoW8Cx85jH6//0HOAC4aulCjPmKdB4hM9iO7I7eAXfXMc/DPc9ZCus60ldojIPdadE/Guz
	1T5Ewhiywv6iM+0n33PNDEWSAulGOI7+B5F6JbZTUwtMjWbxUm2lFrFqclDU7bL6J5nBap
	Jl4q6o8i13TkHaNlKMEkiVOkYsGEdOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-RDc7fjRnMBOKg2eJNv55cw-1; Wed,
 08 Jan 2025 08:56:52 -0500
X-MC-Unique: RDc7fjRnMBOKg2eJNv55cw-1
X-Mimecast-MFC-AGG-ID: RDc7fjRnMBOKg2eJNv55cw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AC0919560A1;
	Wed,  8 Jan 2025 13:56:51 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2013300018D;
	Wed,  8 Jan 2025 13:56:48 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v4 0/4] tools: ynl: add install target
Date: Wed,  8 Jan 2025 14:56:13 +0100
Message-ID: <cover.1736343575.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series adds an install target for ynl. The python code
is moved to a subdirectory, so it can be used as a package
with flat layout, as well as directly from the tree.

To try the install as a non-root user you can run:
  $ mkdir /tmp/myroot
  $ make DESTDIR=/tmp/myroot install

  $ PATH="/tmp/myroot/usr/bin:$PATH" PYTHONPATH="$(ls -1d /tmp/myroot/usr/lib/python*/site-packages)" ynl --help

Proposed install layout is described in last patch.

Changes in v4:
- 1/4 tools: ynl: move python code to separate sub-directory
  no code changes, added Reviewed-by tag from v3
- 2/4 tools: ynl: add initial pyproject.toml for packaging
  no longer installs ynl-gen-c and ynl-gen-rst
  updated commit message
- 3/4 tools: ynl: add install target for generated content
  fixed mix of tabs and spaces in Makefile
  factored out SPECS_DIR so the path is not repeated
  fixed TOOL2->TOOL_RST
  moved clear of .rst to distclean
- 4/4 tools: ynl: add main install target
  no code changes, added Reviewed-by tags from v3

Changes in v3:
- dropped symlinks
- added install-headers install-rsts install-specs to PHONY target in generated/Makefile
- install headers from lib and generated directories to /usr/include/ynl

Changes in v2:
- squashed 1st and 2nd patch together
- added symlinks for original user-facing scripts for backwards compatibility
- updated also Documentation and selftests references
  (tested Doc build and selftests ping.py test)


Jan Stancek (4):
  tools: ynl: move python code to separate sub-directory
  tools: ynl: add initial pyproject.toml for packaging
  tools: ynl: add install target for generated content
  tools: ynl: add main install target

 Documentation/Makefile                        |  2 +-
 Documentation/networking/multi-pf-netdev.rst  |  4 +-
 Documentation/networking/napi.rst             |  4 +-
 .../networking/netlink_spec/readme.txt        |  2 +-
 .../userspace-api/netlink/intro-specs.rst     |  8 +--
 tools/net/ynl/Makefile                        | 29 ++++++++++-
 tools/net/ynl/generated/.gitignore            |  1 +
 tools/net/ynl/generated/Makefile              | 51 ++++++++++++++++---
 tools/net/ynl/lib/.gitignore                  |  1 -
 tools/net/ynl/lib/Makefile                    |  1 -
 tools/net/ynl/pyproject.toml                  | 24 +++++++++
 tools/net/ynl/pyynl/.gitignore                |  2 +
 tools/net/ynl/pyynl/__init__.py               |  0
 tools/net/ynl/{ => pyynl}/cli.py              |  0
 tools/net/ynl/{ => pyynl}/ethtool.py          |  0
 tools/net/ynl/{ => pyynl}/lib/__init__.py     |  0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py       |  0
 tools/net/ynl/{ => pyynl}/lib/ynl.py          |  0
 .../ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py}  |  0
 .../{ynl-gen-rst.py => pyynl/ynl_gen_rst.py}  |  0
 tools/net/ynl/ynl-regen.sh                    |  2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  4 +-
 tools/testing/selftests/net/ynl.mk            |  3 +-
 23 files changed, 113 insertions(+), 25 deletions(-)
 create mode 100644 tools/net/ynl/pyproject.toml
 create mode 100644 tools/net/ynl/pyynl/.gitignore
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 rename tools/net/ynl/{ => pyynl}/cli.py (100%)
 rename tools/net/ynl/{ => pyynl}/ethtool.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (100%)
 rename tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py} (100%)
 rename tools/net/ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py} (100%)

-- 
2.43.0


