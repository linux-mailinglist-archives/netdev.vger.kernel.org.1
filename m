Return-Path: <netdev+bounces-163797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390FA2B975
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2A18897EF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0517CA17;
	Fri,  7 Feb 2025 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="APga8b4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4E14D43D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897781; cv=none; b=pPNHs/Ywl22lz5BWQQ7jZPIf6u4fabdrIcL8vYCzzOEntgyAmBPLvjprwBARFeN5YmAbQ2mZrCuGaecbkWRjZv679tAEHuVbK7JGvqwZrPfW/nTR2UTeKBUEfYXhVmBrTLC/gqsCBcAJx4VOvS4MsASgBQlMdA23nQQsgDjiUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897781; c=relaxed/simple;
	bh=fgaREE9e6jz5S5ZRiFkiZ2u/DNlIlA4sG+vDOPb2x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlfEOp6c34NlCmIX2LaVGZ8SORPopz0smnld2jyLjuyKTBkpeMRTSerrc+i2qPRTwZ4nit0bHRHewTlap9WAXsB0kKySZoMsOAD1iY5Z1ro9LuspAfiYsOm6BMlHnURN2w1HwBh6x7Nx1RjKFFWPPTBC7IAeofPMVsAlrKyPerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=APga8b4f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216728b1836so26432275ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738897779; x=1739502579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=APga8b4fbzgEXKOFmm5MmkAFi0jZh+FJAOrfHHXUAcN9sW+vSWJJNhuGZhh7iTWdu6
         S4+aY5eeemqo1htVA96fbwaalzjjfVaFUKO1D0j4OGTi6iQpIlFSjYRsG+kR28fhLC6r
         fsFhE1X4UOgvx/ydE308PRnrUidf59NaRCCgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897779; x=1739502579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h50Y3zF4tCkc/2EOdw4zLXgmcTIrGB/eNO65/LtZobs=;
        b=hiZDxuntNcwAg4gbhhidkPpg7TXrEvxdKBxHfBDO7ytJhvogXqeoqoQ3liDOPetHIz
         ZAVeaudXdNdSen+4NZZDpFG1MfAhzJXnFbq9xyBj+hQPCABgw8gR7sVzI0ZNWQIIX7ku
         ZuTOzSFy9JuUpYzcIidn7FRpu26UbBJtWuAlNRcCGe2gJC51AA47a65S+98q1BRj+Nwo
         zLAD00200QNPRK3egDvtpH2Ous6ayIDs7mI3yYSHAPKsZXPWtckMg/PGyV+Zbs2nBhUj
         5lSTaXajBKy/e/OK5Zo6FMNh1f/hGooeFRar8mneRsXgXVEkNmDOp4XWyB6FUxobkbJD
         E4MA==
X-Gm-Message-State: AOJu0YwhhZeVghjGfwJBqcS8tluFrF23MIWC2e5PbjAsGVAF2cuyjkZI
	YUTDNJ3hkSzOiqwUmK4W4SV205qO2GHv4FAiXfGJB107IE2woP1zarbW6S1Db9anbEEmHsTFpSm
	vgA5m8kviat3qqIVuySO2pRWreDiGQu5yv0bqPJgGTLWIjOSdMgtVpS63Sjm6EQYBBLOAAB/SSK
	Osm7R6xhId4YkJYtWImF8LDavuj34AIot1HzE=
X-Gm-Gg: ASbGnctsHD7Or4cu8PgAA3cCvQO/2tyMxQCoP31P1leLAAU50hOTiHNcCo98lfYT5hv
	Ekvmn41LPxF4eswjIGvAzLiuBEuqgF0kLGisIyrN1CeQumzD2nqMvHNwQ6CKShwe1WCMPSMPU0a
	bAWOb9OAYRzwHzXPnVdQwRLbkcPpsdwaM3MwXqTqgzs/Ui2LVfV+VxNM0Ix7LET9WJKp1Xstppe
	PvkK9CdPFi6151/fcjwLL7Pk92ISbtfFxKtKKCWsTTCOufhzujVS/FmPMr5jBdvqYH3/6Qr/50z
	ZB2S5mgisFojxxNhHnQK+A4=
X-Google-Smtp-Source: AGHT+IEsXqluB5whpo0nI6jITa0t39sjBeWFPYnCLTBer2jrngUDZ7kId3P8c0MJsNOUiKHKh1jCvQ==
X-Received: by 2002:a17:902:f60d:b0:21a:8dec:e59f with SMTP id d9443c01a7336-21f4e7637d1mr22711705ad.39.1738897779089;
        Thu, 06 Feb 2025 19:09:39 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368ab196sm20348955ad.222.2025.02.06.19.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:09:38 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/3] netlink: Add nla_put_empty_nest helper
Date: Fri,  7 Feb 2025 03:08:53 +0000
Message-ID: <20250207030916.32751-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207030916.32751-1-jdamato@fastly.com>
References: <20250207030916.32751-1-jdamato@fastly.com>
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


