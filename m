Return-Path: <netdev+bounces-219230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2CB409A8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68333541721
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859B32ED40;
	Tue,  2 Sep 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fmX9XELa"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D373320CA0;
	Tue,  2 Sep 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828026; cv=none; b=h264pXg+omDLHaEgS6nUi7sKDrkTasHgJkjdvDrEkf0MxdhOIrRJnd2R1jwUV8+EsXxA80Oebpbd/6wAsDHI5sLQlCk6OBb20FYQxxWqIuftZ2sLndy/m0YdLpDvH4IgZAQaszseBSr+SQNy5q+DI+sRlZ8gFtd1LUldU1ik7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828026; c=relaxed/simple;
	bh=2Oj3GeVuGicmnBhIw4fVSO0Bo0tkKjrFOupsr2XCeSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSWefx6UOLNFFBxTMuXkxUl1bWo5DajVjpMJ5kijNtx4zjr6/yQXFecZZfM1RuKfhslVcNIFfAGcOj/S2LLikTZXrAcWXwR6H8HlMzylUvVEDZ7FArmdWDx44sFwk0PQGjh9SRuTt31jR51dZezJk2xFyXq+Nw7h4sSyDbMOHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fmX9XELa; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756828014;
	bh=2Oj3GeVuGicmnBhIw4fVSO0Bo0tkKjrFOupsr2XCeSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmX9XELaqBQdxCQ+VVMzKyHYuz+pwU0ZJ/Cb8JQaO2uFuQ1nGTIJKQu5vG7xV1cuS
	 A+sdqtGTGc5GKDPqWsPYmv9veekidtE0Ulrn0WdOp9w0+bZJTAbzo3xSUeVB/dMC77
	 CR9T/vuhor1sK0Hpztp+H2mlgQm+1My+oxHqLPvo7qMMlwozmx6/a/G+iMiCwztVc7
	 12BeFKIwOBnVKytFCB8wp7KxUqtMqZMS2ao94gW5LvdFJKZdWj5K3FtPpZswOiaQpu
	 E6xrrQQP9j+B8pRZv1QGmhriaS1iq0YdN2F9HrWL87esQmiIJx2jOMriEUhIOF3fCf
	 xrElpTpegb38w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4744A6012E;
	Tue,  2 Sep 2025 15:46:53 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 03C372022B0; Tue, 02 Sep 2025 15:46:44 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] genetlink: fix typo in comment
Date: Tue,  2 Sep 2025 15:46:37 +0000
Message-ID: <20250902154640.759815-4-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902154640.759815-1-ast@fiberby.net>
References: <20250902154640.759815-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this context "not that ..." should properly be "note that ...".

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/genetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index a03d567658328..7b84f2cef8b1f 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -62,7 +62,7 @@ struct genl_info;
  * @small_ops: the small-struct operations supported by this family
  * @n_small_ops: number of small-struct operations supported by this family
  * @split_ops: the split do/dump form of operation definition
- * @n_split_ops: number of entries in @split_ops, not that with split do/dump
+ * @n_split_ops: number of entries in @split_ops, note that with split do/dump
  *	ops the number of entries is not the same as number of commands
  * @sock_priv_size: the size of per-socket private memory
  * @sock_priv_init: the per-socket private memory initializer
-- 
2.50.1


