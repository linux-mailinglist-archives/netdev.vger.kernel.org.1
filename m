Return-Path: <netdev+bounces-119067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A218953F56
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCD4B25FD6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0544366;
	Fri, 16 Aug 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qeKaKKT7"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98E405C9
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774072; cv=none; b=e+uif6NMIJbjkEIudbd3VOTkFlEFQvxcM2WpVRUBO/cNKNce89i29SMh9MqFsQRPqNBueCXQ3cT+/S8QwciisO0BSjaBbVuWX5voGcm3RnxDSWR1BmdPoCuevDQMyoBxA7djF4ZF/OpX0+DYFnnE6KjPq9N0dOiSIagNL346yP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774072; c=relaxed/simple;
	bh=XNY7vebXqMrmetrq/aYt5R7z2tZ5wuo67ImP2WdSgSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HFQM8pNdvFxM5ac4wXWQWXhuMiEsbAfn/RREEUczVtwxbMuhXrqfII4YrINtL4esh+C8sogbDuEA0z7epag/BdiovlA7nFrsCtIjtAC+IEE9QPtA1WPVqId0a3p6ABpBPSKVSXNUl0R3L9chnEGnjEfwfjrdlFv+07cCr6W2DFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qeKaKKT7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723774067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Updp3ZdjWPHrFJNsKQqxeNoYexZubNwa7gQLBwn9a/Q=;
	b=qeKaKKT70yy3bIr7JqOaWjEat6Yt/VVuhpgWgpG9dvIy3CsD2mKOye6aWyIeSGC8tohUEf
	hxuiOtWv8xh9QTYVkGzknTY1K6n9aj1MdJtbiXckbWc5sCdCrR7ubSyWCJK5k/TiuKJPax
	QDShZ9TsoFFQf14tk18+YFWM2qYjVZ4=
From: kunwu.chan@linux.dev
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] SUNRPC: Fix -Wformat-truncation warning
Date: Fri, 16 Aug 2024 10:07:40 +0800
Message-Id: <20240816020740.15135-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Increase size of the servername array to avoid truncated output warning.

net/sunrpc/clnt.c:582:75: error：‘%s’ directive output may be truncated
writing up to 107 bytes into a region of size 48
[-Werror=format-truncation=]
  582 |                   snprintf(servername, sizeof(servername), "%s",
      |                                                             ^~

net/sunrpc/clnt.c:582:33: note:‘snprintf’ output
between 1 and 108 bytes into a destination of size 48
  582 |                     snprintf(servername, sizeof(servername), "%s",
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  583 |                                          sun->sun_path);

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: NeilBrown <neilb@suse.de>

---
Change in v2:
	- change the array size to RPC_MAXNETNAMELEN as suggested
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..c7cea069a5df 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.connect_timeout = args->connect_timeout,
 		.reconnect_timeout = args->reconnect_timeout,
 	};
-	char servername[48];
+	char servername[RPC_MAXNETNAMELEN];
 	struct rpc_clnt *clnt;
 	int i;
 
-- 
2.40.1


