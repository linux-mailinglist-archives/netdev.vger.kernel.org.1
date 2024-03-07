Return-Path: <netdev+bounces-78493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CA8754FD
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF971C21552
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D812FF9B;
	Thu,  7 Mar 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeAhcUQv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E21EB40
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831677; cv=none; b=kKYKPsJ5NMmkVumtuPTS0ehBHJz0JhRIqoKyX+y91sWD0RRWWB1QV5ZO60KUwtpTLrjrOYEpDZpAY6D9nBAheDXNuyVHaXyFEdskrDAwzu6+ELvnNkbLBmlWceYjybKEZYO+q8SBZKkyvKpsI2m0IpCtw12myTHSASM7TaOv1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831677; c=relaxed/simple;
	bh=RHYXIvGJo8q/LIBWiLq20XUcVqSjEGZKfomR2XrwR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jrvp+0cTuOBzMUwKsdG4mjnjp/Cc+f2mFBSMkaA8PW6ka1whcp8uqeLtcIJPRBbC9zMMbJIM89WxOCUuOXEAOvY6O8tL/hwpHqtnagAbhDJg8g0/T+PT3x96EQxB23eDFuYAZ+tU9tRMRdkEYgR6YKgswD25FQcVFrZecCiOAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeAhcUQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709831674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NG816kiSDpgCjmlRtzxBd0pgqG2tGupf4H8p5jd/PSY=;
	b=ZeAhcUQvJyD8ImiBHyO1Y6AtLcPEl5VBtorXCuS1qTF2Kwk4vJj0TavL9TMA88bl+Xwmh/
	NUF0CuK2ERJFo/qBWwZvl4YQmSEuNoNmnT80+zLII/qUEQxp8xFZes1Uh7J+3hFds84v4z
	TQeTy/pm1uWZrHq4NGiNrXNn5Y7umvU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-AO8X13KGOb2-QP-mwOuRKA-1; Thu,
 07 Mar 2024 12:14:30 -0500
X-MC-Unique: AO8X13KGOb2-QP-mwOuRKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDBF3C0BE2D;
	Thu,  7 Mar 2024 17:14:30 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C931F17AA6;
	Thu,  7 Mar 2024 17:14:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 8CEA840AD6D54; Thu,  7 Mar 2024 14:14:03 -0300 (-03)
Date: Thu, 7 Mar 2024 14:14:03 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v5] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <Zen126EYArNCxIYz@tpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
SOF_TIMESTAMPING_RX_SOFTWARE will cause a static key to be enabled/disabled.
This in turn causes undesired IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)
v3: SOF_TIMESTAMPING_OPT_TX_SWHW is irrelevant (Willem de Bruijn)
v4: additional changelog improvements (Willem de Bruijn)
v5: late initcall not necessary, can use subsys initcall (Willem de Bruijn)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..7832793b2980 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,7 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11596,6 +11597,10 @@ static int __init net_dev_init(void)
 				       NULL, dev_cpu_dead);
 	WARN_ON(rc < 0);
 	rc = 0;
+
+	/* avoid static key IPIs to isolated CPUs */
+	if (housekeeping_enabled(HK_TYPE_MISC))
+		net_enable_timestamp();
 out:
 	return rc;
 }


