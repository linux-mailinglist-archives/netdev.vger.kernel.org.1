Return-Path: <netdev+bounces-34185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C807A2786
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0369728141A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEA1B26B;
	Fri, 15 Sep 2023 19:59:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6015487
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:59:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1970C2134
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694807978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h/54iYh/ChAZhPzlHrnvoWJI6GvDL2HzWtafyXzb+xA=;
	b=SsWhPKGWqwxTgg9DG3tV64pyi1ux2EYNUQdK9s3cn2UIJPjkVgFl/rE/FLlNShlXAurzac
	Mjhm6+xmBbdQwFDiyHJtv99orNaoSDmSOkFG/hz7k62K5H1QngSmb5GMJuO0L+PkOtVKxL
	IhQvoDncg5HUsJVLUktKU5rWyMr7rZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-blt7FCk7PdedlnPhMMQbTw-1; Fri, 15 Sep 2023 15:59:34 -0400
X-MC-Unique: blt7FCk7PdedlnPhMMQbTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C70E81B18F;
	Fri, 15 Sep 2023 19:59:34 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.192.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39DB41CBC3;
	Fri, 15 Sep 2023 19:59:31 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Gioele Barabucci <gioele@svario.it>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2] Makefile: ensure CONF_USR_DIR honours the libdir config
Date: Fri, 15 Sep 2023 21:59:06 +0200
Message-ID: <156bb2949a091c8daa1ce1f4a8c6d7125eaad7f3.1694807902.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Following commit cee0cf84bd32 ("configure: add the --libdir option"),
iproute2 lib directory is configurable using the --libdir option on the
configure script. However, CONF_USR_DIR does not honour the configured
lib path in its default value.

This fixes the issue simply using $(LIBDIR) instead of $(PREFIX)/lib.
Please note that the default value for $(LIBDIR) is exactly
$(PREFIX)/lib, so this does not change the default value for
CONF_USR_DIR.

Fixes: 0a0a8f12fa1b ("Read configuration files from /etc and /usr")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7d1819ce..54539ce4 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ endif
 PREFIX?=/usr
 SBINDIR?=/sbin
 CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(PREFIX)/lib/iproute2
+CONF_USR_DIR?=$(LIBDIR)/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
-- 
2.41.0


