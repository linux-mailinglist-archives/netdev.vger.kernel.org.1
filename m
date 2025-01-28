Return-Path: <netdev+bounces-161393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA064A20E96
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7EC3A567F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BE1DE3C3;
	Tue, 28 Jan 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PhU9Pn52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6108199E8D
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081853; cv=none; b=Jc/3HLREkFt5+kyx/lwk0JA2gHEhinM2PgU6OfgdNiFR6cbJ7sCpTPsnpmw/JdbD4/XxwcgNm7YUWyDKP2xPfsxfhlReqKLw06+GrffS5XL15q2zqwpFXOvRd/EAglSYStkWQQ+uhmE5upvJBsuKT1FEDJzkK0hTiBsguFrr5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081853; c=relaxed/simple;
	bh=u5O791YdxIpS8aoD45P7jv082v8LlinLwr77M4V6kdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/35vPfjNvmze2zaLs2l0aSP9cdzY8erYyc/HIqoqIrEjtexWUPwM9XBpGt7ISX7btIw0wo7fVJzYv+Mw5iYAXIg9EKJ+UdX9EyaNzENwp3fGsafO8OhyP+v3RByH7DTU8h8NO2LqcO8Whgsl8h600yiDwx2sgEc8glJlE4CBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PhU9Pn52; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb95317so104910735ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738081850; x=1738686650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LX1jGIIkfllcVoAdPxK+2jAwohid6/STTjw8AE9goHI=;
        b=PhU9Pn52Nhcdh8hUwoiPWhrn4XkO7ifq3byXC8m+ySnEkClz20K2dTh0V7mbpS0To4
         X3ojx5TQO558YgIhEP/J3ADb5Anbh9w7knNg4oaONZUz8NZblOdeDfRyc1yM0SF4USIL
         r8HWqLcdNNslMg1egK6ymkFIDPYcRf7C+DkLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738081850; x=1738686650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LX1jGIIkfllcVoAdPxK+2jAwohid6/STTjw8AE9goHI=;
        b=eP0wdBMwads90NJv+r0XDCgJg93iSb1buQ7bFyacqx0Ctkm2o1ZCQGFXSJvBI1gu5Q
         JrluB+1jzRfoDGLQG3yUaXqNJvA5pQyLuQJtsEt2qYJ4f2EZpVgQLIso+PqA2Yj9yZrY
         tqClHsWWWrETZlBUp/tH5a/ymTVAc7/OeLqa5VIKnCB+d+0uFHNzD5xCud6i7KYeRdXc
         HLpZecvqIqfoGpYwZI9IUoWKJpRj+miOvQUE6/kZoMpp3iki8WrapDreu4u2JGULBMSu
         qatgmVOcEGxIjYXnebytSeJDiEpNP/SrMP1ksqqYm6ckmVI4XoSqjbmOXcJFgJIg82iP
         09Kw==
X-Gm-Message-State: AOJu0Yx46wZFEB9rgowLd6Rlf5ga2w6y9MjrFFdyPggw4GUVgwIgRa9h
	GEJxOACkwFlAl6wTLHua8mroCwgewxGMm2nxrtXRAFWwj5IIgRSFqpvZYpCFdZMnn4eUqaYXeh3
	sF4JZJQpzbFVgLz8mf3hzCA7LPRvhyD9HyuEgEX7Kq+Bg+SYw0RbiH4Q3Ccr3EPQIK9frkZoYv2
	LbVdPMbDucVSm08xiNCDd/wgbwSr4WWbj6SK8=
X-Gm-Gg: ASbGncs5X+wS8sj690cB2NeNHOMhzUhS7nkEbHqYPEmBS3XPJOxjHRZbsJe9yWMW2r8
	a/pQ6J4i9JDl5aEIBBWIk0b6ADkDj300a6EkBypcfwkoGp36srfOEQ/+G0TUusaK2hKzb1L0RyG
	qKHNa854Knv1iqku1JJugot4ryX+i/iOPcgxL0SroGcB7YlRezA3x9qJMxMtBk8GWs0lYVdWt6N
	U1bQKIqL2G/HJHMYC2DoECNlvs24slRsMaVmgFXdRrn5SrqLDdZmKSfblT9devJvj37OadoCRPN
	+jj6QNXPK9Z0Eb4Ems8v9jU=
X-Google-Smtp-Source: AGHT+IEAl/Zi42GFgnT8NQz6rfBEjd3C3YnMh7rFy+I613HyXYnDjSd+uiXcdCJPwy5Jeu918ctDNA==
X-Received: by 2002:a17:902:f64b:b0:215:b087:5d62 with SMTP id d9443c01a7336-21c355b5684mr738165195ad.36.1738081848738;
        Tue, 28 Jan 2025 08:30:48 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141302sm83759335ad.154.2025.01.28.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:30:48 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next] netdev-genl: Elide napi_id for TX-only NAPIs
Date: Tue, 28 Jan 2025 16:30:37 +0000
Message-Id: <20250128163038.429864-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens to
be linked with a TX-only NAPI, elide the NAPI ID from the netlink output
as a NAPI ID of 0 is not useful for users.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/netdev-genl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..3116e683e516 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -397,9 +397,12 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
-		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     txq->napi->napi_id))
+		if (!txq->napi)
 			goto nla_put_failure;
+		if (txq->napi->napi_id >= MIN_NAPI_ID)
+			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
+					txq->napi->napi_id))
+				goto nla_put_failure;
 	}
 
 	genlmsg_end(rsp, hdr);

base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
-- 
2.25.1


