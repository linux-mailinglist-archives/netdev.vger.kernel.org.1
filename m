Return-Path: <netdev+bounces-48119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711B7EC9A0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3D6B20BB8
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473133BB33;
	Wed, 15 Nov 2023 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhjQaTk5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D54C127
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700069143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kZCIiJo1U+S2LVXVa7Kah+bzd2iQEnySPn/fl9KY1AI=;
	b=GhjQaTk5Uua/+5DNq9yXgiOBRPagKEIuJkp51WjfgxhkSr+xrlik/tqxCv7jd/9QXcBzS7
	RFUMtTs/weP8vjzsWVE/eISS9xB/fht/oKDx2ZqoHcS7xNCH+c9iJXorgasDJo4j4fAEDp
	ahhwMTmFYTcwpDhNooZ8fWOwqJ278ZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-a9tDUyYdMoSrtH_gWzmgEg-1; Wed, 15 Nov 2023 12:25:40 -0500
X-MC-Unique: a9tDUyYdMoSrtH_gWzmgEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AAAC101A52D;
	Wed, 15 Nov 2023 17:25:39 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.192.189])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46AE5C1ED7D;
	Wed, 15 Nov 2023 17:25:38 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH iproute2 v2] Makefile: use /usr/share/iproute2 for config files
Date: Wed, 15 Nov 2023 18:25:35 +0100
Message-ID: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

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

v2:
- Rebased on commit deb66acabe44, changed commit message

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a24844cf..8024d45e 100644
--- a/Makefile
+++ b/Makefile
@@ -16,12 +16,12 @@ endif
 
 PREFIX?=/usr
 SBINDIR?=/sbin
-CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(PREFIX)/lib/iproute2
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


