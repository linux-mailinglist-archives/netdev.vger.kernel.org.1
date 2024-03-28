Return-Path: <netdev+bounces-82690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8A88F365
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9011C20F62
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1118D;
	Thu, 28 Mar 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4jzFoeV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F317E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584309; cv=none; b=uWRHm6h4vOzUAjQ3E85NC0v10rbimxYm/AWxLHHJgIU/vG4qBhBNNDBaoSvPybmLeaA2e383BGSQO99xmD23Vp1p4I1wo5bfxwhq9lvGi9xbJv8plHGYKNyIfMcZUU3/GcvLohHJPyoDH+PeHQcrlSDzpUanXniCoD7bDKU2lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584309; c=relaxed/simple;
	bh=QfXzi0YNDFsvO8OTu50pvn3hzJPM8ReXHZFLA98loos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gUQJ8Y07eVjOq6rZVfgD3wS7Cie+h3ocTWgsW8NYccWdWtLAbm3UZqzFUQ7GasYuYUndYdhoT2YHWbkqcSrYbJvINDHNEV8Ko6feb9pmakmtU9oAqaEQ2rVxpvquNE63UHo90UEr0FJOYAk2WyqBSMVtlU/cFpZLJKx6JDvryXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4jzFoeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711584306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RNzpMpe3zjcO2rv2cPTPhLNPeQGeEirCU3wKPzNxR/w=;
	b=D4jzFoeVvjW0zJqxm/KOvqTIjObxnpHXYAtdEKiVrX8j4LZ7iwEAFHveTPH3XttGUNvalk
	Kk/fHS6XWD25PUsB7tLdk34LZQDzqYALMogf3fI1iodE51o+C0RKv/PHeYrD3ovWisvlaK
	YdsAUfJAHuIdB8YjIdpiXyicIrv4qQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-vcdqGxDSOqaFiXMEOj8Klw-1; Wed, 27 Mar 2024 20:05:03 -0400
X-MC-Unique: vcdqGxDSOqaFiXMEOj8Klw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D78AF185A783;
	Thu, 28 Mar 2024 00:05:02 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA3FC17AA0;
	Thu, 28 Mar 2024 00:05:02 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 48F7842125D75; Wed, 27 Mar 2024 21:02:13 -0300 (-03)
Date: Wed, 27 Mar 2024 21:02:13 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v6] net: enable timestamp static key if CPU
 isolation is configured
Message-ID: <ZgSzhZBJSUyme1Lk@tpad>
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
v6: rebase against net-next, change subject (Jakub Kicinski)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5d36a634f468..48c725caa130 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -157,6 +157,7 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/rps.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11890,6 +11891,10 @@ static int __init net_dev_init(void)
 				       NULL, dev_cpu_dead);
 	WARN_ON(rc < 0);
 	rc = 0;
+
+	/* avoid static key IPIs to isolated CPUs */
+	if (housekeeping_enabled(HK_TYPE_MISC))
+		net_enable_timestamp();
 out:
 	if (rc < 0) {
 		for_each_possible_cpu(i) {


