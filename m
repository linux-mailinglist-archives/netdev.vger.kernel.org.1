Return-Path: <netdev+bounces-166560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DEFA36754
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3513AC12B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42BE1DC998;
	Fri, 14 Feb 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LkNu7q6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312101C861D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567592; cv=none; b=JrMPAjRWaufjazeMpYFdPhivb0cqzFADMHnWgOgISMvIeNCFHqMnuxdfTtRIHtWBBFS6jRnCNcv+5AaByDOh7y9TAYv7vl7vFX3d2xY9W8PdrJmSscFpHYvFXPOzsGgUM5MjYXYd/4H18ZxLUqv+rUKcLO+JpSH0m+OvPg6apzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567592; c=relaxed/simple;
	bh=fgaREE9e6jz5S5ZRiFkiZ2u/DNlIlA4sG+vDOPb2x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIjXIWFAXhyEOuEMG0ZhWZy59RZTea2nnsOGdfrcaX0PxmnRZiNMQ0YMf0mJVoJ9CaVJ1+WgSn2fk8bvnmuW8qdDOamWVYdNwWj/Y/eG/oBjeNthXGmCFTI/E0YeTAdV4R/YOQbtIPEX1si/BxgYZ0MsY7djycfOts3VYtbaz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LkNu7q6E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22101839807so11959985ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739567590; x=1740172390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=LkNu7q6E66cr1tsNbLyRLwWYxV7/5nUoETzU/U9bqY2BqJ8gFMl7zKSImgeEpRlxNw
         9AngJX2+nQmE+uxaIUxKMOZJn0KsURDC5QSeTcNrrtDozt8eBKFfhQx1ImNxSgRwJxGf
         ulsElxXqRVCOx86g6cshIESAXbP8W+mdINOSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567590; x=1740172390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=gz9RF04ePxokjgU9WqXP987AO3/1tGvx6t0ex/jXXSRPVPp8XH12REqB8HEwaqmnZc
         3JM/4pVpkqtLnca9na4XPq4bocJiDM8XTViBh4hUK+deey3KMN0Z1hn2s4bAKBb+3jWT
         5WLZY0YIgl/yoBy6E3A8NufPZu3UGzvEHpAKCqi8EQVEEprRmEf2zxwV3EX8KU6AAO2k
         YBdwS6YGCZqVG/V5Tru2hqeNdlqEt5GkUEcGDYjJL4FnxvXCFMZ3Mc6oF3bzoH/pUkaN
         gXSCNMf0KVjo8UZe0nRs4ZY/6lD6x5hQjlyKA6Xzz9A0WkjDqFSSOh4ivB0Qc3pGj/ZE
         QbXA==
X-Gm-Message-State: AOJu0YxmRstKjUYKJEmPMx5afamQjvLh3Ma+NBgzipC/EaVlxFAJOFFu
	3DOooVgIvLOl/xHYVsBAXaBKdIPwhFyTl0GMJzOn1/0zlAJpvCSTegtTNb5XjN7e+hreR5oIGlu
	zyFhNvJrDT0UITqTu6/jPwHV800snMR0iPcZ8ySTWILtUeJbWoLuIceUBELu/0Gdd9xvK/zhjf+
	2ozsxpsFHQxZztjvx1VDw9yBfRBJ1+Gp+1MSUCjQ==
X-Gm-Gg: ASbGncvZ8BhxtCZGrGyKb/otTQMsGnM2iJVNxJkhxg/NbeURZ2g7c5ggXM63NJbc6C+
	22WKL4CpwrVn1SX0i2MNSu0HKodyZtK/Q9NfcDzoUg4cWxm1u+OFFJlREhKYRto1P8MenXL0z3F
	t2k+Quc5PJvgZP4MIzPi5Kcx/8XX8c+VYW+2DbIeM5eAXVCrnJBExfBlrSTrhrp/Dnq8HQhpzvX
	CqpcswqZqVpQ0AWcCstoeD53ew2Fi18qvSWQIlvbC4zR8QR3UCh64r0F711Jc/Waqk/kASrGl9O
	3oEE7DeLBlKOWCA0UubI+c4=
X-Google-Smtp-Source: AGHT+IHLzbQ5GQfrunSH/5MZfcXL0ig2ibFP6/HEsx6LkPpxC/41PemipAIBEq3dtSX+KfEf55fVPQ==
X-Received: by 2002:a17:902:d542:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-221040bc31bmr12353955ad.41.1739567589935;
        Fri, 14 Feb 2025 13:13:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm33285265ad.240.2025.02.14.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:13:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v8 1/3] netlink: Add nla_put_empty_nest helper
Date: Fri, 14 Feb 2025 21:12:29 +0000
Message-ID: <20250214211255.14194-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211255.14194-1-jdamato@fastly.com>
References: <20250214211255.14194-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating empty nests is helpful when the exact attributes to be exposed
in the future are not known. Encapsulate the logic in a helper.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v4:
   - new in v4

 include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..29e0db940382 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -118,6 +118,7 @@
  *   nla_nest_start(skb, type)		start a nested attribute
  *   nla_nest_end(skb, nla)		finalize a nested attribute
  *   nla_nest_cancel(skb, nla)		cancel nested attribute construction
+ *   nla_put_empty_nest(skb, type)	create an empty nest
  *
  * Attribute Length Calculations:
  *   nla_attr_size(payload)		length of attribute w/o padding
@@ -2240,6 +2241,20 @@ static inline void nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
 	nlmsg_trim(skb, start);
 }
 
+/**
+ * nla_put_empty_nest - Create an empty nest
+ * @skb: socket buffer the message is stored in
+ * @attrtype: attribute type of the container
+ *
+ * This function is a helper for creating empty nests.
+ *
+ * Returns: 0 when successful or -EMSGSIZE on failure.
+ */
+static inline int nla_put_empty_nest(struct sk_buff *skb, int attrtype)
+{
+	return nla_nest_start(skb, attrtype) ? 0 : -EMSGSIZE;
+}
+
 /**
  * __nla_validate_nested - Validate a stream of nested attributes
  * @start: container attribute
-- 
2.43.0


