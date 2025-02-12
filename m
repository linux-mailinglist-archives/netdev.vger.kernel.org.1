Return-Path: <netdev+bounces-165544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E0AA3275B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E603A8D3F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D120F081;
	Wed, 12 Feb 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tf0qqWKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8F20F076
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367724; cv=none; b=ZNXZmAAgYpEV82p+YHu8TOrIYZpLG/I+jDB0mlMM8Ie2pX7Uk3mAnaeD+RSBxfCZCTPe4PQ43zxlFVllc0j8cLLslbg7zGVyEiNu2x8gQ9DYO4/ih0FBRUK/C8CKpoeqoC/l10iiz67fK7CqOuQEPW22hbB/COWGjUh1ZP6g+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367724; c=relaxed/simple;
	bh=7h6nbFnzFOLt+RWCH5AbtMdfobMx6uMJQ+/GW3rjNHQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC9z3N4uu8TwjCFvAYc015foLoZi+Yb7xmGKltMcqY0dm/GB3vdyBDsZH3I9LFBmy1BUHP71QQmXvTm5tPXPgoVlfTU141/JMZG+so70Ik5ri7qAO1QsHY5VDMcT6BvvqG+LLEwftoeh1j5L1EA3aWbI98b1WNUEXFnZw725GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tf0qqWKO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7cb1154abso399975666b.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367720; x=1739972520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiPPwWHAckmQZTxpa+xmoPK+TKz+hzKWUS2Ki/RrKBY=;
        b=tf0qqWKOCPdHFeTouhdCNfqMdXM62rqIIVelxnjxAPdmmhzshZs38aLfAZtN85B0sG
         dgLWvuXg90S53hSVVIlmCGwmovdaqjSrXPXrfkF4pAE+3287z1h21K6D5a++9KpNwLon
         V+WBPKihByguP+Yl99d++KU1WRA+qcLbweZlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367720; x=1739972520;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiPPwWHAckmQZTxpa+xmoPK+TKz+hzKWUS2Ki/RrKBY=;
        b=A/TI5PwQ+3lac9Ese1dXl6FoptzdGmDWBMyQVDJiUQx7p/0wcFIyigVBqcF8Ip87W5
         Tp1kqNvfMFupGfFON/HJyfnnvGnJ01aP+FMFI+JuxatwKzRyzdw0uhXwlIKq7UOWjeph
         SUoOOAzgBUtk6zyRXjHlKbI4ni/dg8xRxdm9PYh/hFN34P8K5M/wYwH9HEVTZVzefGLx
         cLIhMGUNqX0xHo3AansarUhPeFPPqjtgHu8GsahoRiQY3wMO3Z66WuwCjMm9eR+sdR4S
         zAWsBOaq5r9OUoMh0NPbOr0K2pTrdxFogY/CC/NAK5KY+WieLPI/TSpYaG7cglqh+2SA
         YSqg==
X-Gm-Message-State: AOJu0YwWSrhGZSXbizUHQC5pRVs8oXSHRQ3CiQvaYqBEGNifa7x8Q+Rs
	f7+t+2bqYJ3px5ZkvvtsN1J7wbU+r5K3EkqAqtcdtggU7kv6v6wv7HTyEK9QKfVPGJRCPQuQWgA
	x2L0mLL3cCCZgdwf1IiBUvs3A3zPIg7uFmHvHb1F/PZ14HBqtItc=
X-Gm-Gg: ASbGnctg8BBTaBCs5ClpTWXSW/E17tOMtIBxbhYt5Q94Qh5trdoXw9aZ2vajnYJDMUP
	DFUEDgWe6EfxTzrc6vn6hfgmQloCLt/cQSoor+vFBhgKUxN8jVNLs8tveYJqFQxrrLf0LSbwXGV
	lBCzJN5oUpnviAzH06v84EmqnV
X-Google-Smtp-Source: AGHT+IEdAA4vYWE4f6Jqe5kfoXPBf8sLR14CrtIsQmKMdovKf9+A7oyaNsjV1HVscFoUluPDJ6oVMDtmO0huBxs8zNA=
X-Received: by 2002:a05:6402:2088:b0:5de:aa54:dc22 with SMTP id
 4fb4d7f45d1cf-5deadddd507mr6946407a12.20.1739367720462; Wed, 12 Feb 2025
 05:42:00 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 05:42:00 -0800
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212134148.388017-1-jdamato@fastly.com>
References: <20250212134148.388017-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 05:42:00 -0800
X-Gm-Features: AWEUYZnEliqL8EWyyXri7CgDbBmA6yJKuyWcDbYIfwZ4SEiiHdkwBqv8IjRtz70
Message-ID: <CALALjgyPqYGEw2dzi-AN6oB4jcQUt9e890=FA9+FPyV6=dXbaQ@mail.gmail.com>
Subject: [PATCH net-next v7 1/3] netlink: Add nla_put_empty_nest helper
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

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
@@ -2240,6 +2241,20 @@ static inline void nla_nest_cancel(struct
sk_buff *skb, struct nlattr *start)
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

