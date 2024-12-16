Return-Path: <netdev+bounces-152148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE79F2E5B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1487A0587
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B9203D5B;
	Mon, 16 Dec 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh+1EsZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAD203711
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345728; cv=none; b=MKp8ezfgBMk73yxR54vEwyk7nYf5gcNrZ2qk0alHIJa3plf+I96lSmO5X6sDaTZP2ScMVqfN1an2U8Rveo0Fz+g9xist2emwfX7Rjr/w1DHopH9xyZ7CoQ9tuDy1/2BQE83+sGY0Mk9XNwr5l/1uBD1EO6CpxvejnS3f9Gu/RoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345728; c=relaxed/simple;
	bh=1Ft7el1yFPJlxwx0pG7X3rzeL5zNVIzh7CkXKYoDuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=SBg8a+PwZ651lUvqFnkMR+K51uynxTWmmkLgTnmD9yysuDKZ56Me9D8fKzIYMm8DyTytGuBke9NKPDwa1xDJvv73zEBRsVTvecNdK3+b9Rjn4AgYxBqmUnu19+18fmNlmEhkWidLWfnR1IYPa6xZy8AQ9CVmxHM3XhuSdGyw9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh+1EsZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734345725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b6WZV2gnPOdEzOnB+Nf0v4whMjuuUE+0WdddyVdZ5I0=;
	b=Vh+1EsZGqi8RG8HN7yPpIvDWXyIsL6NMf3hYe5cbnn0sGu80TDDGMhpAZZs52HaOo6XCxl
	t+MEaSDUUaM0IqqEO4OToVPmt5rkJPJzo1MfPXaM0paopj1ma+BKOgTugbm1D/qRhp2wto
	hara7lK2YrWFKGMhxn7AqWXzGcUCwHQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-KyyDpGU9OK2p9uCPWi9AIg-1; Mon,
 16 Dec 2024 05:42:01 -0500
X-MC-Unique: KyyDpGU9OK2p9uCPWi9AIg-1
X-Mimecast-MFC-AGG-ID: KyyDpGU9OK2p9uCPWi9AIg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6DFD19560B0;
	Mon, 16 Dec 2024 10:41:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7FB73000197;
	Mon, 16 Dec 2024 10:41:55 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v3 0/4] tools: ynl: add install target
Date: Mon, 16 Dec 2024 11:41:40 +0100
Message-ID: <cover.1734345017.git.jstancek@redhat.com>
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
 .../userspace-api/netlink/intro-specs.rst     |  8 ++--
 tools/net/ynl/Makefile                        | 29 ++++++++++++-
 tools/net/ynl/generated/.gitignore            |  1 +
 tools/net/ynl/generated/Makefile              | 42 +++++++++++++++++--
 tools/net/ynl/lib/.gitignore                  |  1 -
 tools/net/ynl/lib/Makefile                    |  1 -
 tools/net/ynl/pyproject.toml                  | 26 ++++++++++++
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
 23 files changed, 110 insertions(+), 21 deletions(-)
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


