Return-Path: <netdev+bounces-164284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF006A2D3AA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4216D7A53FC
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9E1925A3;
	Sat,  8 Feb 2025 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FA1apH12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736F18FDCE
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988074; cv=none; b=AyIE8y83n9Qzi3JQrdEkwi7Br+ZKXdOgauBCNG26T2wxNfhv0x+FOZeMpm0x3sMD9gJsMwKs8BHumCZPqn/pLW6dsARNwl/7F+6gkOdaFtXMA1QgL5znfQ8vztvmFBk67sReGgKWENdkRKE6k29UA94rE6P+t1er0BpoJJoUubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988074; c=relaxed/simple;
	bh=fgaREE9e6jz5S5ZRiFkiZ2u/DNlIlA4sG+vDOPb2x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLGuyIvJunIYEKk2X/SzAguQiEtz3Z3ZnjevKqrQZjLA4uxXe22cQgA08MvMJzf+Ob8eivyG4E8jdE3g0ztjL9jutfQnsMkPz6rMP6NBP+zOVIf3lqWuY5sh73CgvMBvs1rS3Mlncp5/ES5a/lDDujvSULFF5vlrTfxSiCDWrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FA1apH12; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f48ab13d5so39807845ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 20:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738988072; x=1739592872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=FA1apH12R37ESE1KN4zVVlpFFt82VLgU7O/JZqnzAet/W+UmpDj2MZ3aEYtaNYaf1h
         euPLeo0uoXbubqP4IYbSauBCz1r90fQIFDlDre7Ul/7gG90pD6C+uRTtGJFdb1/zsINk
         M8hPVxquLjUEsWk3FRQZ/rA0aaiR/RCgIBCiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738988072; x=1739592872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=HCa/5RNY8W7+CAuZ6boJQZ4NoBCQ1l5g1KR6lcdo4027ULVnsvH/x9qButudhpsoZw
         eYi05cgGQ+OZlUI2w4PVQS7FbSnYe4os8ycmmdQfvjC3stBHAAOtM0lblBW/ixpnI/OD
         0iE27Ng4lU8FFp5l5uS43N7TH7rd36HR1dIUJPr1SRArSK1zc5GfeIHDWvSoP+WZdLEi
         Uc8BRsAB3wuMp93UGg3t0hcZhuVUgGj2ghSOQFg47iQLNYzt2IrsKkeLNdJM+i1KPxfx
         BBYjqeyZ6VCvQueBBBsepWXwN5BThedFf1dMQ4tzo8g+BlF1m9PTimdZOI87PXHjt4Ck
         42ag==
X-Gm-Message-State: AOJu0Yz+HkVSgKA1fPBwTh05xdUHPL4GfAQ2wc0l7zxBSXpMZUfw5S6S
	2s10RDybt6ep1A4KQuokJuh5uqUsaOvip6ZoPibMmQWljznbWCo+vuYapmbuD1WpPpCsj2+m9C9
	XOZRtf+/khYWFp7CcCtU/71fgJs5ICuOYtTimmE1N7M5p8FJrxsvjPs8jORh83w7JhAdLCs1feP
	kbtAKJ6Sg0YvOES+trhvQCYaSi8QKlNFBQwac=
X-Gm-Gg: ASbGnctwjHFlf/DPSugNZIf8FLNchZNdKqFqaWwJEzfzSIfg9WPxIgvSVXl4jIvCEsd
	EqO/aIy86TnjWDRneIaIUD/joc3FMLFdU2VYEFSv/VJz08nW6HT7JwxpDiy64Rjm+5WfNBLXjGC
	AZEAFTrrYacTKn7/M4C+IW38c1sUW8o+kcLXA6Tvb9xw7gFANckFGeJ8sBi2QD7yNtgFp47VnlY
	Yz9Xxjt6mRU8zc2gcospR51D4jkUFuKc+Hatq8fLl/VbGTG/pZsVOS4AuZPTu63n1lmFFTddn8e
	NI+GBZ49mwjhg4ul5vxfDA0=
X-Google-Smtp-Source: AGHT+IFibipGLR5Jyf9zTmTf+G8WqPE/WDRNuZpNVsIuJ6CUOWboJI4UQgEjzXJ5C+bf4G/4+P5jHw==
X-Received: by 2002:a17:902:e88e:b0:21f:55e:ed71 with SMTP id d9443c01a7336-21f4e6a0100mr87242125ad.5.1738988071853;
        Fri, 07 Feb 2025 20:14:31 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm38567715ad.21.2025.02.07.20.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:14:31 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/3] netlink: Add nla_put_empty_nest helper
Date: Sat,  8 Feb 2025 04:12:23 +0000
Message-ID: <20250208041248.111118-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208041248.111118-1-jdamato@fastly.com>
References: <20250208041248.111118-1-jdamato@fastly.com>
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


