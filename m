Return-Path: <netdev+bounces-85755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2F89BFB2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFBFB28FDE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F757BAE7;
	Mon,  8 Apr 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLE26bVk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58396762DA
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581108; cv=none; b=S8ulQzVPO15Q+vALy7VzuEIuUUIYpYsxjNA6PaH2toj966D4HNNK5FOJReg2Kjr5Xs95UqC8iIPZMvIRSRAzw33hD1D7+RZ63RYo5m3rT0i+vuOHvlo8YJBYJkwEvYb+K+nRpVgbnPERaBvMJfqi820chjKTZtvAOnuzWzT1Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581108; c=relaxed/simple;
	bh=3AyGycfT0WMau/4BHOkgdyQ3sS/qjOjS/YxEFf70SDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7rsGI40WtI4c82EytbF1y0nS9LA/qmTvrxxJbAzmVlpJrePwpeiz1xsUMRT6P2m1JIROf9iSDGg2RvrWb26GxdyHLHrEVJz3v3HSSDIt1Du+9+TTEMz1wZRbxKuK/b6zxKO3Cq0Bo8h5sSckZjwz3pGubKqOhMNIvMO8gOzEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLE26bVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2q1CIE8IfTYGc+n0dUKKT+JjLmE8wbfXj7V+fytNap4=;
	b=ZLE26bVkH9ibvLvGw/n0EJX2Odqb9EdZ9An/7TtNUuxRxKVwMNQRs3mfBIHYc065sjaln7
	lxxN1ceLpe0PZs1NDKChSP7pNd20HY5zd2SSRh73oFiORpwm8kfaMOnOD9Uz1Nhtt0bzFn
	/kA2axQ+Zy5x6bd2zw98711ZQdN/QE0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-NNqM-5KPOLCUDf7c-Zl0Rw-1; Mon,
 08 Apr 2024 08:58:20 -0400
X-MC-Unique: NNqM-5KPOLCUDf7c-Zl0Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 558903806222;
	Mon,  8 Apr 2024 12:58:20 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5542547F;
	Mon,  8 Apr 2024 12:58:18 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC net-next v2 1/5] net: netlink: export genl private pointer getters
Date: Mon,  8 Apr 2024 14:57:40 +0200
Message-ID: <20240408125753.470419-2-amorenoz@redhat.com>
In-Reply-To: <20240408125753.470419-1-amorenoz@redhat.com>
References: <20240408125753.470419-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Both "__genl_sk_priv_get" and "genl_sk_priv_get" are useful functions to
handle private pointers attached to genetlink sockets.
Export them so they can be used in modules.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/netlink/genetlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a116..beafa415a9f5 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -726,6 +726,7 @@ void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
 		return ERR_PTR(-EINVAL);
 	return xa_load(family->sock_privs, (unsigned long) sk);
 }
+EXPORT_SYMBOL(__genl_sk_priv_get);
 
 /**
  * genl_sk_priv_get - Get family private pointer for socket
@@ -764,6 +765,7 @@ void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
 	}
 	return priv;
 }
+EXPORT_SYMBOL(genl_sk_priv_get);
 
 /**
  * genl_register_family - register a generic netlink family
-- 
2.44.0


