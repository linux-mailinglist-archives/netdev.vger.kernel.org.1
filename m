Return-Path: <netdev+bounces-130307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8798A07C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053741F24AB1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF01990D8;
	Mon, 30 Sep 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="HpmzvhmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B61957F4;
	Mon, 30 Sep 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695316; cv=none; b=lUpWqlInMUHFDEpbJYhCyBSAZF2xDpGpuD5pUnmq70FcvnS+hxHgJm0XXhNXjy+IVy4hfNMpVIhvibSEkr76h2fgNqcj8P/4hu52S9YOEeIjEyDFGCnOkm49rIJzr2chpumD7xj1jT8EzcsjtAsF2ACXXV+Sy7oeVZRTV+QSpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695316; c=relaxed/simple;
	bh=cbKZFVxD8vKFKjYfmXBm/w08xlle6y2Pu4DuJ3uL0EA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlLF8bC3GPESElQ265SMaaHlORsjtNU9CmqxvM6NGoyCmXbZFx8w1OGMv24AxxfFUEY9is4aDO8yR2XxEHUlm1/oUR/lf1lKgy9S0bkmhptTmSlTqPz1ykVZnD5cQtKCb9+WtrYZEJAX/DPO0e20cUr2zUCCb+Qoc05JNjdx2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=HpmzvhmZ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k7bOPAFANWhA0Ui7wz343CvWa6yOufJZVnn75o1MDXU=;
  b=HpmzvhmZWC2nifwxAkGqF5zn2ddWpZTd4Jm6XdJsfTfdDk4Xy54BJ8aA
   HC095yAgkdAWThCfCejCAoVSe44Av8xZfTRLjbHChvcp11KNRzMMH/Rr3
   peeeFJwrxfFz+dlCVLg60S2pZK/IDFL433lk0UrHQYzw93SUiA+nuJ9wR
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956900"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Trond Myklebust <trondmy@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/35] SUNRPC: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:09 +0200
Message-Id: <20240930112121.95324-24-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/sunrpc/xprt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda526..59ac26423f2e 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -255,8 +255,8 @@ static void xprt_clear_locked(struct rpc_xprt *xprt)
 
 /**
  * xprt_reserve_xprt - serialize write access to transports
- * @task: task that is requesting access to the transport
  * @xprt: pointer to the target transport
+ * @task: task that is requesting access to the transport
  *
  * This prevents mixing the payload of separate requests, and prevents
  * transport connects from colliding with writes.  No congestion control


