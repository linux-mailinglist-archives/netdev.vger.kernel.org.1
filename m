Return-Path: <netdev+bounces-150254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E139E995C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B73D18894AC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FC1F0E23;
	Mon,  9 Dec 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeE3xiJe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CD1BEF82
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755679; cv=none; b=oCtslhXCKqhjHSTjEexUlgWi34mhvjNktT7S8dEwR5sD5icK9e0/xzS5n9LYd+OKR5B44Cpn7BD7KDZt7igZ694e0ZYxUR2u7dOOonkBDYh6MXaMo+rExZEXRMAQAzNcHyv8EDv6NOoHnfdboU41pHvo/henSLhzAwx7bV9RTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755679; c=relaxed/simple;
	bh=5L5/QKETaA0ZzUZT5pfI7dgJYc6P10VRFXK70b7x1oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=q+MW+QssnU6oo2Ay+3D76oWr9RFfIocbXxk1rxw3l0vPuUBWr9/3+dBJC3mqCzyVey7zu3EXbPzzNjDI1Np7xV3hjYa2b1vRVKSTzRia1P0wQOR77zJAKLg8/5lG34RVtw7fxSS9LWq0MHg94k1Hm/M4GtNP7Idu8jYZI88Il+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeE3xiJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDX1t6Lz6Nzmh2lZRUVmXSqrClGnwSF3XrGiwKdpOyU=;
	b=aeE3xiJerLLFp3MeoY319alQ4ekatyLox9RTldgH+SFO1dUs5DEAfUmTFdUV/1f+1Sw9MT
	+CBCMlW0PuOTexMtIwCXTgjIcC/zIPmtUJCLW6aMOkXLxoyRMRRPHiwk6D0gySsfl3l21i
	Wd/LqaaVUto9N97nwE6Fj/KtQ42h8Dw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-t2nFFN6xNvaCMUFdXth6Pg-1; Mon,
 09 Dec 2024 09:47:54 -0500
X-MC-Unique: t2nFFN6xNvaCMUFdXth6Pg-1
X-Mimecast-MFC-AGG-ID: t2nFFN6xNvaCMUFdXth6Pg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FE8D1955D58;
	Mon,  9 Dec 2024 14:47:52 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43350195608A;
	Mon,  9 Dec 2024 14:47:48 +0000 (UTC)
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
Subject: [PATCH v2 5/5] tools: ynl: add main install target
Date: Mon,  9 Dec 2024 15:47:17 +0100
Message-ID: <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
In-Reply-To: <cover.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This will install C library, specs, rsts and pyynl. The initial
structure is:

	$ mkdir /tmp/myroot
	$ make DESTDIR=/tmp/myroot install

	/usr
	/usr/lib64
	/usr/lib64/libynl.a
	/usr/lib/python3.XX/site-packages/pyynl/*
	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
	/usr/bin
	/usr/bin/ynl
	/usr/bin/ynl-ethtool
	/usr/bin/ynl-gen-c
	/usr/bin/ynl-gen-rst
	/usr/share
	/usr/share/doc
	/usr/share/doc/ynl
	/usr/share/doc/ynl/*.rst
	/usr/share/ynl
	/usr/share/ynl/genetlink-c.yaml
	/usr/share/ynl/genetlink-legacy.yaml
	/usr/share/ynl/genetlink.yaml
	/usr/share/ynl/netlink-raw.yaml
	/usr/share/ynl/specs
	/usr/share/ynl/specs/devlink.yaml
	/usr/share/ynl/specs/dpll.yaml
	/usr/share/ynl/specs/ethtool.yaml
	/usr/share/ynl/specs/fou.yaml
	/usr/share/ynl/specs/handshake.yaml
	/usr/share/ynl/specs/mptcp_pm.yaml
	/usr/share/ynl/specs/netdev.yaml
	/usr/share/ynl/specs/net_shaper.yaml
	/usr/share/ynl/specs/nfsd.yaml
	/usr/share/ynl/specs/nftables.yaml
	/usr/share/ynl/specs/nlctrl.yaml
	/usr/share/ynl/specs/ovs_datapath.yaml
	/usr/share/ynl/specs/ovs_flow.yaml
	/usr/share/ynl/specs/ovs_vport.yaml
	/usr/share/ynl/specs/rt_addr.yaml
	/usr/share/ynl/specs/rt_link.yaml
	/usr/share/ynl/specs/rt_neigh.yaml
	/usr/share/ynl/specs/rt_route.yaml
	/usr/share/ynl/specs/rt_rule.yaml
	/usr/share/ynl/specs/tcp_metrics.yaml
	/usr/share/ynl/specs/tc.yaml
	/usr/share/ynl/specs/team.yaml

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/Makefile | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 5268b91bf7ed..116a7fcfc540 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -1,5 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
+include ../../scripts/Makefile.arch
+
+INSTALL	?= install
+prefix  ?= /usr
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+libdir  ?= $(prefix)/$(libdir_relative)
+
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS) libynl.a
@@ -23,5 +34,15 @@ clean distclean:
 	rm -f libynl.a
 	rm -rf pyynl/__pycache__
 	rm -rf pyynl/lib/__pycache__
+	rm -rf pyynl.egg-info
+	rm -rf build
+
+install: libynl.a
+	@echo -e "\tINSTALL libynl.a"
+	@$(INSTALL) -d $(DESTDIR)$(libdir)
+	@$(INSTALL) -m 0644 libynl.a $(DESTDIR)$(libdir)/libynl.a
+	@echo -e "\tINSTALL pyynl"
+	@pip install --prefix=$(DESTDIR)$(prefix) .
+	@make -C generated install
 
-.PHONY: all clean distclean $(SUBDIRS)
+.PHONY: all clean distclean install $(SUBDIRS)
-- 
2.43.0


