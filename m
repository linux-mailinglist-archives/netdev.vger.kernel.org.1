Return-Path: <netdev+bounces-83796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486CA894463
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1A1C213A4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B94CDE0;
	Mon,  1 Apr 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6YSQTGp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D877BA3F
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993111; cv=none; b=G+Tuih1VgHkWu8c+LmzB2e0QZ8081EeFc4ZFi73Uz1jyK2ePVNg+wYzFDnlv6wwQ4TVoR3jvhETckgRfZnrUOb0VM3IsO7LmpXMYsKC9B7Nh3Vcy/Xrp799uxAfwxVJlh6ndlx7YqN4jqlJC4MuC2idnWM6sEK+pehBINzy7XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993111; c=relaxed/simple;
	bh=vU+nLVpi/WfnkJ8mv6zLIkdsoFUG2thLNvugrtRrvGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DMqc4Sh7zbD1ePxL+8xKmJlGvw4Ac+/eA9+W4ccU2bzCq2HMjZsUtGFRX3qyJeAMkdyeOp7UBBreeBHL0qHzcqx6UZExQw8knWKzs8Bkn3I2KEcz31RiMoMiaoZnavfzobNHB3mepUMajpeD2cGf5YdFboGX7D1jQZf8w/jYhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6YSQTGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711993108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+t4cN30hVwr7AKRg3KhJ9z4kS4dBitUz/2xhfdDwaPg=;
	b=M6YSQTGpGzxjTwI5KFy1ZOYwmho8/l8Vp6AN6tUReNBvSpUai/zjQwy+h8/3QbhFnzm0dT
	lgrfCrV4m5YINjeObNoPTpOSHPDtFn8JERZoY9AXoTmRAFLKxy+BbHJufRb9X58o04Yvx9
	NI68aK7uio5bZ8ZY/3CSGdU9geQU/zY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-bI44tM-HPeiwIQnbDYlIFw-1; Mon,
 01 Apr 2024 13:38:23 -0400
X-MC-Unique: bI44tM-HPeiwIQnbDYlIFw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EB4C28EC100;
	Mon,  1 Apr 2024 17:38:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70D59492BC4;
	Mon,  1 Apr 2024 17:38:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 917A540109CB6; Mon,  1 Apr 2024 12:36:40 -0300 (-03)
Date: Mon, 1 Apr 2024 12:36:40 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v7] net: enable timestamp static key if CPU
Message-ID: <ZgrUiLLtbEUf9SFn@tpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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
v7: change location of linux/sched #include (Jakub Kicinski)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5d36a634f468..718a00e70d53 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/isolation.h>
 #include <linux/smpboot.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
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


