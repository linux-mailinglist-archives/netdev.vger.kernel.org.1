Return-Path: <netdev+bounces-47182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED87E8AF8
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7121C2083D
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C814014;
	Sat, 11 Nov 2023 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCB2FrO7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507713ADC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 12:55:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74463A87
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699707355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FWtuM3rWBnpV7rVtzL0eR+/PEqwZ6X+zWoLWnScSfdI=;
	b=fCB2FrO7/6TsWaXD86+/fUBmdjUQQ6Y7e2Ox9ZkU+qj7TFuHnVbcGe3zFOeKPK0IuvfZJp
	YCEX6ljOQ9bLotWyD0/yF+bglm4gDTq8lKxaVSWGpboMMvIIjCKzHRmG2VClk2JMFUELql
	ISUpKeOHZIyim4FnN3g0bVjlRQab98w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-3P8EXirrP0CIJzq_44yD9w-1; Sat, 11 Nov 2023 07:55:53 -0500
X-MC-Unique: 3P8EXirrP0CIJzq_44yD9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8101811E7B;
	Sat, 11 Nov 2023 12:55:52 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.192.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABB04492BFA;
	Sat, 11 Nov 2023 12:55:51 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrea Claudi <aclaudi@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH iproute2] Makefile: use /usr/share/iproute2 for config files
Date: Sat, 11 Nov 2023 13:55:41 +0100
Message-ID: <c26af87143b645cc19ce93e4624923ef3f25204d.1699707062.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

CONF_USR_DIR was initially set to $(PREFIX)/lib/iproute2, then moved to
$(LIBDIR)/iproute2 to honour the libdir user config. However, as
reported by Luca, most distros use an arch-dependent LIBDIR, which is
the wrong directory to place architecture-independent configuration
files.

According to FHS:

"/usr/lib includes object files and libraries. On some systems, it may
also include internal binaries that are not intended to be executed
directly by users or shell scripts."

A better directory to store config files is /usr/share:

"The /usr/share hierarchy is for all read-only architecture independent
data files.

This hierarchy is intended to be shareable among all architecture
platforms of a given OS; thus, for example, a site with i386, Alpha, and
PPC platforms might maintain a single /usr/share directory that is
centrally-mounted."

Accordingly, move configuration files to $(DATADIR)/iproute2.

Fixes: 946753a4459b ("Makefile: ensure CONF_USR_DIR honours the libdir config")
Reported-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5c559c8d..8024d45e 100644
--- a/Makefile
+++ b/Makefile
@@ -16,12 +16,12 @@ endif
 
 PREFIX?=/usr
 SBINDIR?=/sbin
-CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(LIBDIR)/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
 HDRDIR?=$(PREFIX)/include/iproute2
+CONF_ETC_DIR?=/etc/iproute2
+CONF_USR_DIR?=$(DATADIR)/iproute2
 DOCDIR?=$(DATADIR)/doc/iproute2
 MANDIR?=$(DATADIR)/man
 ARPDDIR?=/var/lib/arpd
-- 
2.41.0


