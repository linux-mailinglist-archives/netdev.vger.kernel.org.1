Return-Path: <netdev+bounces-75737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA886B061
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE64286B1F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9CE14EFE0;
	Wed, 28 Feb 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF+i35zm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2D14C58C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127069; cv=none; b=o1LZp4r2uO9rd8vpLhz48wwbmdAAU4dECtGu7W7AjrdjKduzl3ofGSJrg1r0+FRT28Vkgl/6QIcsDWdMpiBUtW/c7I0y3MEKTPyUy/MMYvInexGikvCit7REoxZcBUBLR15dDaU1QqIG8sFE/rUwTtaW+SWtjCUIRx3DpSsY75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127069; c=relaxed/simple;
	bh=3VQZtPFFjJ6KMik5qwmu9RFH9g6RLd3eRx0NWCx6Qko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2Pji0dzbDlcPOS//gGnuGrAEpayGS+2OFsIpngtgUrYAmVWjkVmbyG2PtsTu+RNVgw514junRRkHM6+fZAmsqpBGezV8tpi8/ZmQKoKqYWXjMX2sK+emcCId6Rr+cMVY69kTTwmm+wUIk9HfV5gKcNEx/3F3kahzpB4eo7QQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TF+i35zm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709127064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mYhUY0xj59xhvUYFGeVBejeoiizOAuL7jH7HPYGmaLI=;
	b=TF+i35zm9i6kCWJihP8ir2/YAv//BrmYzImsPVzGb2SzT85QLf/VlaU0TkCDtF2x1vjSgt
	QSMvtFhwKu+Wz0t6rrjORL9xbr83yElIyA1HhcfGYjBggbeY19+APEWE1LdlDBOugqH8fh
	AW1/hCiJG3C8dWP3Xkh56NfjLV41+t0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-aBSN9Oe7P5W_Su_A28IPow-1; Wed, 28 Feb 2024 08:31:01 -0500
X-MC-Unique: aBSN9Oe7P5W_Su_A28IPow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD1CF8B39A5;
	Wed, 28 Feb 2024 13:31:00 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 937901121312;
	Wed, 28 Feb 2024 13:31:00 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id EC662401E122B; Wed, 28 Feb 2024 10:30:42 -0300 (-03)
Date: Wed, 28 Feb 2024 10:30:42 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH -v2 net-next] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <Zd81gp2utD9+ripX@tpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE and 
SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
static key to be enabled/disabled. This in turn causes undesired
IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)

diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f..15a32f5900e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,6 +155,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11851,3 +11852,14 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+static int __init net_dev_late_init(void)
+{
+	/* avoid static key IPIs to isolated CPUs */
+	if (housekeeping_enabled(HK_TYPE_MISC))
+		net_enable_timestamp();
+
+	return 0;
+}
+
+late_initcall(net_dev_late_init);


