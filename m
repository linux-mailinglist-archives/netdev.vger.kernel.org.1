Return-Path: <netdev+bounces-166197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEAA34E6B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228B216B4DE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007524A071;
	Thu, 13 Feb 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k8JUe/Xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6324A056
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474629; cv=none; b=MK9MBDIO8pNXrd8hBc7fupvx29xgc/f/L2vhIxaImhc1Zf+jRM4flJmWEvs6yePtiX11RV+RC5HvKAydEleWPA5WuOzy80qkJcvI3CoCdT1woOFxHyYmu52Zzr/Dl2G1eB/95QnRWYo3eYHQGYd+D8snPNGeLq0dP3lNsR7o0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474629; c=relaxed/simple;
	bh=O19yHCpkqJTXpsHZkKuIx0bHDAhaiab89LoRBXElqsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf1J/zClI0sYjLddjcymSXAaYSjI4IbPkQlqjK79sO1vewMb0mS3p2fRVM+8lUXDqncCWo5NzsN8L5vhj52A9eVIfXYJMfWEGARnwXa/ih+OlR8lWdYbMH0S8q0ROJhKznlmkP9u/SUlY1xK87iv/RHrmkw0cRc9w6ArnL5aH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k8JUe/Xh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6d2642faso32621525ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474627; x=1740079427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icDgF0dhXJ+X9NyKJop8wxjdfDNUacr6ErfUqD8p/9E=;
        b=k8JUe/XhdiQz15gtIIzsurszeZsdaHQhCPns5OybRpK9ZmL3HLIDEHmyTIxS0oOG2g
         8YB9s2ehxkJ9Nq0kq1v2TdNtMj/SrmuCzDfOyDMkLPFWnMHfZexY+BsS3UQ8jj+3m9e7
         Vk3iQzDJ5LpuH+enTI9wCYkZ5mp0Xq5vCbzKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474627; x=1740079427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icDgF0dhXJ+X9NyKJop8wxjdfDNUacr6ErfUqD8p/9E=;
        b=Y5XD3RaBY2Mt8yrHXyXWiDN8WuerZwvCwnrJBkexaUC3aXhiDLBRO7rU920qml4Kxi
         SolWVapxC5269YbeLUn1nwd80H4tejRiAwUpVUA1QtDeZ0Sgui3YoKuo+vtVyQ3A3FPw
         7uuWiYrWSKzrBq0XL4dHCdXceg27Yzs6Szlhq5/xNtUrJHLlL+Y+T/RwVbZLGYGoIrHD
         rC/NFpVI5QM0ejjWv8rh1zhZqoxvzXOQndQ6hZQxxxAAMfQPXrS2lxhHPnj6Rx0nu5MK
         Zi8ZhHxWTlU1ft85hhsj/91kPsB/GHqLr4pZgOC0d3NLFpOQqoqLrD1OMIRTURQe3Ax8
         4V+Q==
X-Gm-Message-State: AOJu0YzYDWJi800GQ2UnggsoiKLmm03BT5nXF0v1v69g/oVQkO1NieDG
	fucoYAv2LdfTRS517MyO7OaQKlMQtfuM3el+6sR53bR6Lpvj+meWIMFlyysp1oUk1CyG3f6xtiH
	NeBWq8AK5hyZejJeqg/oB5rHc+ZpcmMNOS5zmfIv8Gtl7Yo559g72ipKuP/1s3ZHHyOUB4IQ5OX
	NF4lmz7Dme3ifx+ULeb4v67CBYThk9DIZj78ZJXQ==
X-Gm-Gg: ASbGncvieVUzozESCJj+dx/uzF+NTbzy4BE7haE9xi3Xdignq+0wazAajBNDgSmMu0e
	JgvzpBu5ZtZjcpoT3TmHNxrM549SNWMdEZDbs7UAZ79Vkx4uiuzUS7hTe2X0fihEytdeBr9Vo75
	O7R+d7/FOtNdioPUXeRz9wSV1l0XhdeZyo9vKJnLMEtaBQo3H/+IE3KA16qhHhlSucvXIt3rjvD
	0K9qN5haRX0eRG2km0/esEieOVQBYPS5j35+GZA+X/Lzgl9p+B4u6RMAqht95zGRHA3Exg9mXp7
	it7g4wo5dB8pCcC9KmritiU=
X-Google-Smtp-Source: AGHT+IGWSm8u83uqTS8PspXgmBAMPe2ctcctOKcrElV+Kvu4yuGLuATPkegQA2jTuHjMlGiwUOVI3w==
X-Received: by 2002:a05:6a00:3e0b:b0:730:9946:5972 with SMTP id d2e1a72fcca58-7322c374050mr12054627b3a.1.1739474627147;
        Thu, 13 Feb 2025 11:23:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1633458b3a.45.2025.02.13.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:23:45 -0800 (PST)
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
Subject: [PATCH net-next RESEND v7 1/3] netlink: Add nla_put_empty_nest helper
Date: Thu, 13 Feb 2025 19:23:11 +0000
Message-ID: <20250213192336.42156-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213192336.42156-1-jdamato@fastly.com>
References: <20250213192336.42156-1-jdamato@fastly.com>
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


