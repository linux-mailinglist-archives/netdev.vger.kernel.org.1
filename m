Return-Path: <netdev+bounces-74118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16A8601A0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4861C24B5A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE06140370;
	Thu, 22 Feb 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASdbDPPX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C513BAE9
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626557; cv=none; b=Wo0/lxGnAEUMN65qVvQxqzii/5fBj0LfuZegIsUy0p3OxSRN43LVWRO/q1y5Vo5NpBxNu5yvrdy4k0O/dgBwYshCjD4AnmDVzWQ5Ukhq9IflKCk4Nu9ydVGc7IweltumraCawgUe7Imh4C6Aal9HtBQ6ZtYpUUu38qt1Nwsjz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626557; c=relaxed/simple;
	bh=/wOS2SUpgSsEw/ISAn+302Uf7UW8Yp6RwMhfod64tJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N/sPNJHTq+ECXYi8OgyaPXuWD5Mmmx93DF+M4y7SZEtpU5YUqJlc/JJD113Y1skj7927Jb2NVeEttd2+bjbuioNOSvMXjOENfJX8fp2qDgXlvRa222C1zG4BMWF8V+9UubJxEtvCSY+qOsezUJ4mHwtEXi3d9nBbAVN5dD8tEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASdbDPPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708626554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bvj8T6fBipY3xpufjhC25WSBfuxca3GiHOALi4Tt8m0=;
	b=ASdbDPPXEGkjt7Xayf9WKOqTZVzBF00AI53Ac0dhvxuW9AjZ6uuI+H9tng2yICj9CtIHYB
	eSvLBss8L73G6PihuKgA4cNG4mYgU5SSc9UMhjRyzp2wG5qDi6Re4QwYUUyeF0CyZpPKDp
	fFlr6cqoKwzhK/p84mKue+JA+vwHcqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-H1RAiGg0N6q0UzIEJeJIww-1; Thu, 22 Feb 2024 13:29:09 -0500
X-MC-Unique: H1RAiGg0N6q0UzIEJeJIww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A3A5106D039;
	Thu, 22 Feb 2024 18:29:09 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 06861492BC8;
	Thu, 22 Feb 2024 18:29:09 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 762B5401344BE; Thu, 22 Feb 2024 15:27:41 -0300 (-03)
Date: Thu, 22 Feb 2024 15:27:41 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
Message-ID: <ZdeSHbRa3rtHE+2E@tpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
static key to be enabled/disabled. This in turn causes undesired
IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

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


