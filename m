Return-Path: <netdev+bounces-71378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5985321B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277C31F2449D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012EA56472;
	Tue, 13 Feb 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbhlq75Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82856444
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831673; cv=none; b=ZzHqI5vTkyCGwvjEwziey4fTk+SCBQXnnf1z1tOOHFAvdAWeNmPxxpSG+L+4ZnwqR71fqXzfDS3/g6baQ0fx44lguGtwejLMnDZ5CVPKA8Baxv/q+IZq4T4QWC8dcvF5lbigAIjmRtEZ8VpGpoWkJGhPv2Dm5159rXdEJlNPlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831673; c=relaxed/simple;
	bh=vKmLuetPiqwNK/NvBA+xm8qgL06cnvFOrzu8BOu3TPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWuAXn7k6C516DYBVxhbyJ6fTP+VXCs+JogVjg9Vfoi09t0sSxmHCzHto/Zepn6kXUsTfHmv5JlioMZWnY8iF1sqO0DtHMIOepVVE6G7hN5SF8xdYXmosND2K7vzj4sZZQ7xOnMo16OIXHv0jMZhs0pMXTb7b6+SGnbCUBP1SUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbhlq75Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707831670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sM9EeqHVbPE97OjydZplmGb04tZWIE1q6qjGihVxaso=;
	b=cbhlq75ZthGaABpO+G0qNau7wArEHpjqWwpgPDuOXRIoKje5aPRvxNYLWi1NsXq/avwN1r
	W4PDDfyT4HEzBNHb6tannJOMex/Wu5t8isxEOcVJZTzYzvg0OGlZHqC3rg/ThgKKL/6v0E
	Vd0+PAcnGFhypmu87p6/3YopIEDNroI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-6SgUwBfgN4--lpHLX_TK9A-1; Tue, 13 Feb 2024 08:41:07 -0500
X-MC-Unique: 6SgUwBfgN4--lpHLX_TK9A-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e0e62e5d41so2480341b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831666; x=1708436466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM9EeqHVbPE97OjydZplmGb04tZWIE1q6qjGihVxaso=;
        b=UGcMIAUvrgVHoaelyxVv8p+Ve2GGXmiQb5AAJKWq8MlqHoLV/QyQYndm241saac2Tn
         Puv+ds8LrkpfThLyP0zvPb8m90z5/5OpguAFIy8bRMgr/vOOFi86zueFmVDidHAf5A7Q
         /TQnQkn6o0iMBcaypbwPrYiVyAIrqBtSFEYaYeRcd/W5+pxwWfZsqGqeuoYY2QPal9Pl
         CjaO4UWQYNRvV0QDqCbwwvFa9/FUIfO+YwU8+zl7FpNKYLHF+kKIhQRzbWtS6G+XYZBW
         1vyQTyqskDm0VXMizvHlzV9bjnoAahZvvxl2mFnTf+nKDEtRY48//9dNB3DydbKKVoFM
         QWHw==
X-Gm-Message-State: AOJu0YxqzmAfIeLPY7yldtF67J7Pl4UW9UA+GAORMIoOlKcP7zNC5IFs
	Yh3Kq9Yx08E6xdOZWWlkHvjlD8lSFMXuuAII4JhvUZ27u5oJtNRTQYQPl097nkxLO/eU2E6b4Eb
	v0jiE8lHCf+LVYBBKn0d+vcy5N9no4fOkCe+4cQ3GxfFYhx//9hzL5g==
X-Received: by 2002:a05:6a20:c707:b0:19c:a4d3:2041 with SMTP id hi7-20020a056a20c70700b0019ca4d32041mr15569189pzb.42.1707831666687;
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcyeBaNRft6IVSe6YFMBp5QkjLKlFRhM30jbFV2dNHxXXjhh0TOmx3zAxp+5APBQ1oR9mU/A==
X-Received: by 2002:a05:6a20:c707:b0:19c:a4d3:2041 with SMTP id hi7-20020a056a20c70700b0019ca4d32041mr15569171pzb.42.1707831666433;
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPTpsWr88UqwU41Z/VTHCIQBM+G9Y3MSqC3XMWud5NWsOT2+3tszlERKJZO40rLdaH+zJf58/ZX30Bj/62Zv3cA7vVUzL6cLbiOUpTZtrqKq8GMYiP2ETfbtEIh44xzUAQob+BBd4EkxlLNm8U0YpDs1sLrry3sBtUiwReJmph18iVFoQDrF6RAywt4drK+lu1t3kDIWlYmjh9e9oMtQLgwDLIH5+aXXhLk0hugAdcIdBNssLXSgE8HABS0E+dXQXgX3alJfWcmjJo6IXDF0AXXI8tZxEmax4FwAfgaPNGJzMVd7k1dKHYyjVQqzis
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id p39-20020a056a0026e700b006e0f3f544fcsm1932208pfw.67.2024.02.13.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
Date: Tue, 13 Feb 2024 22:40:58 +0900
Message-ID: <20240213134058.386123-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the error paths of tipc_nl_bearer_add() under the common label
if the function holds rtnl_lock.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/bearer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 878415c43527..5a526ebafeb4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1079,30 +1079,27 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 	b = tipc_bearer_find(net, name);
 	if (!b) {
-		rtnl_unlock();
 		NL_SET_ERR_MSG(info->extack, "Bearer not found");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
 		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
-			rtnl_unlock();
 			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
-		if (err) {
-			rtnl_unlock();
-			return err;
-		}
 	}
 #endif
+out:
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
-- 
2.43.0


