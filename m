Return-Path: <netdev+bounces-164900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD6A2F915
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DA63A7392
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A225334A;
	Mon, 10 Feb 2025 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rtVg7KYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C6253327
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216362; cv=none; b=rTkCWoNw9XMS6ea3o/2SMu3AcJDE+lZbovlBKnpaFO98Faa3N9aXTDpGLBvhyPZGrCaK6PkMsMheENokkGwSmw2jN8OtdDq2Ex2Dpk6hCwo9hj9QPp48A6c6sgexdFom1gGw+aItLcELq6slUCuGv7Synj3C8wrA/Q2klM3epPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216362; c=relaxed/simple;
	bh=fgaREE9e6jz5S5ZRiFkiZ2u/DNlIlA4sG+vDOPb2x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opOidtNQavO2uDXrDJmCPFPn2wBff8u0qEZn40KXyQp9urbpqc6Hmwy7Tt1wdWKhqjxKYBsSzT1fbcT0ZZvz1yHeR8IjuTAtk+uPnD7kPkOssnq1hcmpzlc7tQ/fEhXiN6giW6OgjaSkULOPqxOTsRbIGHrzwnNE51XfPYMAEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rtVg7KYe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so5013251a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739216359; x=1739821159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=rtVg7KYeG6rlcqUBkPEtBW/Hkz8LFtyUXm+/jr7RXNJaNf2S8Z4U7thMKtaKvEa+vE
         sms/VEMM7c/BDF8ZiOlNXz7myFov6JRtK91TXeAdBbRSAvB5OWlxYsgSr+g4o8HlhWE+
         tVGjgxtour9kR1tRYtJcid2wI/Me9ZVV74kNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216359; x=1739821159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=dO7+4WCggQNEvk5TvsOQJ5VPii1X6pS3XV2k72Bo3Hzoa6lFXAONgz907801GSjDsk
         CRGOOCvTsLg/llg1YMvi3CmLxx/s9r3kYq92cCV3tNjy4H14O2eFHKhWPwEH2nxrM22k
         JAQ87y7QXIVQ9aRUg/6ctw43zk4jAnWs2rXe6ahfc60MqqQgUKvXLPVxDyC3t0Zp+flU
         2cmF99Tpr109Lb63vFaV5DUfS+TCCLcBcrAde8Kk48ZkAp0/FGW1WTxzZn+hV3nrwjXF
         4Aq7oRWIVXlFctxzkhAC0m8wst8fTUabryVSkImOFkX4r9q9enyM66Y4ME5GaN+DUe9E
         zRLg==
X-Gm-Message-State: AOJu0YxBT/CrhaUNpotnYRYCoQwCHCjcnOku6oc1Ia1N255b5zCVPywM
	wgo+3rXjcmwNWsQSw4CKQ4Jp3xB+TxKHF++8pcIpLhwqZfh1EAftxDukVdg6iUm7Ih3Q9ZOGRZN
	9i4UMBTKH+OAcp9Kcpxv/2ouWSJXWTzgswvIe/FJ1OwxsRSzIV0nb//pltV2h+GYZZxtG3FdoCO
	nEpi9uUlumbqFp2SjKJyRMqa4irsfIx/2PjoU=
X-Gm-Gg: ASbGncvgRhx0nGhGLCJIg7dRJVV742u68abkmPWgVTfkUxNHKqzVmwb9sg/sP0n0Ve1
	TvcjfE5z7LEUDFVx0BhDW5FX03YdXn+dZIq9QwGpvX2OraSzyxUGqhktFyekXvS/qq15/5EZU8v
	0j3QuYkXfUYp+BnE+Hv4ixJtWRkzoVnBtlvZA2xtekVSJQcDnXTdU4LzVRzN2pvq02Gym0yEgXS
	Ist/TpWmYa4orbQKRVERZY00mtj3vpUCpDIjOQUY9/UJfVwvNdWHcUlF81zALFCxkpxLAcdWZhr
	n2BqK36393DDCwcJbOM83Ow=
X-Google-Smtp-Source: AGHT+IFzgpeSIAhDART2sLKxOwBNGJpSGGSROdPFQrtdZ9UrtHaaMReBtMO/Cwsrjd+WaeJliy55wg==
X-Received: by 2002:a17:90b:3c4f:b0:2ee:f80c:6884 with SMTP id 98e67ed59e1d1-2fa243ebda5mr24811691a91.33.1739216358980;
        Mon, 10 Feb 2025 11:39:18 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2ecbca6dsm4226510a91.0.2025.02.10.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:39:18 -0800 (PST)
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
Subject: [PATCH net-next v6 1/3] netlink: Add nla_put_empty_nest helper
Date: Mon, 10 Feb 2025 19:38:39 +0000
Message-ID: <20250210193903.16235-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210193903.16235-1-jdamato@fastly.com>
References: <20250210193903.16235-1-jdamato@fastly.com>
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


