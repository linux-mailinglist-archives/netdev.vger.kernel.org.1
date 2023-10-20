Return-Path: <netdev+bounces-42970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732A7D0DEA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842971C20E6A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD14179B9;
	Fri, 20 Oct 2023 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2A171A7
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:50:12 +0000 (UTC)
X-Greylist: delayed 144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 03:50:08 PDT
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F811BF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:50:08 -0700 (PDT)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.159])
	by sina.com (172.16.235.25) with ESMTP
	id 65325ACB0000035B; Fri, 20 Oct 2023 18:47:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 98541134210341
X-SMAIL-UIID: BE8F4D0C822F49899A4A6C274BF464A2-20231020-184741
From: Hillf Danton <hdanton@sina.com>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
	kernel-team <kernel-team@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date: Fri, 20 Oct 2023 18:47:28 +0800
Message-Id: <20231020104728.2060-1-hdanton@sina.com>
In-Reply-To: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 15:35:01 -0700 Ivan Babrou <ivan@cloudflare.com>
> Hello,
> 
> We have observed this issue twice (2019 and 2023): a well behaved
> service that doesn't pass any file descriptors around starts to spend
> a ton of CPU time in wait_for_unix_gc.

See if the diff below works for you, which prevents concurrent spinning
of unix_gc_lock, a variant of spin_trylock().

Hillf
--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -211,15 +211,10 @@ void unix_gc(void)
 	struct list_head cursor;
 	LIST_HEAD(not_cycle_list);
 
+	if (test_and_set_bit(0, &gc_in_progress))
+		return;
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
--

