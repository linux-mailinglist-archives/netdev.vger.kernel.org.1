Return-Path: <netdev+bounces-156285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1102A05DD4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876A93A99A0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A311FECC3;
	Wed,  8 Jan 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvIdt4yh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392461FECC0
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344632; cv=none; b=DaixVHA8lbBJbZ9yTWaOyTI8JxukKhSuEiEFrnqimTd8ZxsNw7GaJjRpt6wPdvp0lhSv6ZRh5JzNVN5oSMiMdqqX7Hyt5Aad96dgBAKbf8Ns7GUsyErnOzGGKGianr3gzphNUKHJGjuFu3TYjPqo+b1N4MszmPmsaN/PT+ZL7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344632; c=relaxed/simple;
	bh=x6RBvTMcZ5X62aLm7aaMxVUwHB1WcKVkBt2OXooWazI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=iACWTZiu/msEwmPbawLoyz+CKYZwtr8FFzMsrNwFj6A4aBCYHoLnGGcFJ2Woj25oexfpHOErqvpjC0GIrcT0etmkW5MiVlyllgYmaotp97YbHGs/j31bwWsxWe39zTKSTWs6ozfk1GM+/EuRXDXSJh+L2R7CnPz/mzY2z1bEL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvIdt4yh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736344630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj+9bkMcbgYjp1j76W/k+z9tz21m1d2MVUe4vLIF8dQ=;
	b=WvIdt4yhsbzs3El+7XAKky3vPQxCLxtpukzboZLsmgTToBhojbYUwb7ovrUlPlX0an64gL
	BDb89jb0BDcSwTYImigaSPMzO+aB9gdeJRd3MQGBD7uJ5IjaXuSi1VeG2DL2oqiro/Xbmp
	ebc69whUl9VNRIt86T/3MzyN4637GpU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-lokHo0-pN7aeMVTxn1N5Pg-1; Wed,
 08 Jan 2025 08:57:06 -0500
X-MC-Unique: lokHo0-pN7aeMVTxn1N5Pg-1
X-Mimecast-MFC-AGG-ID: lokHo0-pN7aeMVTxn1N5Pg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAF5A19560AF;
	Wed,  8 Jan 2025 13:57:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00DBC300019E;
	Wed,  8 Jan 2025 13:57:01 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v4 4/4] tools: ynl: add main install target
Date: Wed,  8 Jan 2025 14:56:17 +0100
Message-ID: <c882688d751295c7f35c7d4eba104cd5174a0861.1736343575.git.jstancek@redhat.com>
In-Reply-To: <cover.1736343575.git.jstancek@redhat.com>
References: <cover.1736343575.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
        /usr/include/ynl/*.h
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
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 tools/net/ynl/Makefile | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 5268b91bf7ed..211df5a93ad9 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -1,5 +1,17 @@
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
+includedir ?= $(prefix)/include
+
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS) libynl.a
@@ -23,5 +35,18 @@ clean distclean:
 	rm -f libynl.a
 	rm -rf pyynl/__pycache__
 	rm -rf pyynl/lib/__pycache__
+	rm -rf pyynl.egg-info
+	rm -rf build
+
+install: libynl.a lib/*.h
+	@echo -e "\tINSTALL libynl.a"
+	@$(INSTALL) -d $(DESTDIR)$(libdir)
+	@$(INSTALL) -m 0644 libynl.a $(DESTDIR)$(libdir)/libynl.a
+	@echo -e "\tINSTALL libynl headers"
+	@$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
+	@$(INSTALL) -m 0644 lib/*.h $(DESTDIR)$(includedir)/ynl/
+	@echo -e "\tINSTALL pyynl"
+	@pip install --prefix=$(DESTDIR)$(prefix) .
+	@make -C generated install
 
-.PHONY: all clean distclean $(SUBDIRS)
+.PHONY: all clean distclean install $(SUBDIRS)
-- 
2.43.0


