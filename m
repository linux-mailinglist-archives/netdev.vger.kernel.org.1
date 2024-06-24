Return-Path: <netdev+bounces-106071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BBA9148A9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58CDB23B23
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F313A87C;
	Mon, 24 Jun 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TAdUCadi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF1139D03
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228586; cv=none; b=ApUuxHVcNbYgVwFNC8l18yEIwrSCnhW021csZ5pYY+cwrlwlVyR0Z3jw4ewEE0d9cdq98E6oEY9yqgmdEKwtarim7yJvneuhxah/rD2vzK/zBtTPtxgR03dym62CJBi/nX4BUWipvw0C3heJlalGb67ykTsC09X+c42dNHGgMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228586; c=relaxed/simple;
	bh=V7MPt8PDOxXDPtWOM+GNOu+M/+9il2AqPOeTW8O1Hf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHzCS0Rzxac0jh7N+jn/fu+2rvWj6t6XbwVQhnsgehUs0QoLAXt3jMdhvTX7t6G9kMBQ1NUxRQ4dta68nJdR1h3vDbLWOIYkiE1PPY8Cgz5qxZLzLVmnTgm2+NWqMWUW/iMrd52PBiuqwA8VWbLeq+9DM/VdFfPxdJvzXpoQrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TAdUCadi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso35654565e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228583; x=1719833383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PntUQhJvINaWyY9oMx4aZppJ9esKPkZrEGBhtjuzln8=;
        b=TAdUCadiUIEP0AoDPNvBEc/0osksbyx1KcFFVqPnIwNUKoupByi1ukv+wVAiiZq9DU
         5yeK320pgbVqih+KJIEde0H1LYqFhtWpAtXgRTUkL6TIUDOrsK5hXAD5vdYnmPKT4Z9g
         khsVAaT49eEn3/kgg+9HQxs6XnjMwO15+z5OXd/HQYXlD6dZhsGWZrFh05+4mOtCXm36
         pU86KAOqTXdhDtiqPBGdBLJvcIoui8c/UiaQm/7k7U1IytOtRGAwRcdtxWHkLFx4JGVO
         ZY4SU/gr1g6naaAmcuTivOPhJfpJwXD3OenYoe4adYa2CH09pAi8PzfQTHXcndEhVFhs
         ljhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228583; x=1719833383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PntUQhJvINaWyY9oMx4aZppJ9esKPkZrEGBhtjuzln8=;
        b=R8yTosjvi1ue/ge96V1NCDkcdSJYF3x1Blk3gaB/v6kbt2mVjrsdZCgQQM97CZlanF
         1y7jz2wNgWBvgj7rFO+BnS8kD0tFpN030P667nUnZ8ITU/eS4RYPOpqxs+l3xrsClfIN
         ngbKSu3AxLFQePGPAfN1pOXYTRdAtyz5vKE5ClQnUS2fEtYuAzWBto/dgsqPUcx4BNPt
         42FYunUnppZW77ADDr/HuIlhPz+z8MPD6DBFI8Cw8+g7TJARVYSd9sPBR58rdd/+C68R
         W4gtwyZX/wqVcUHZX9OIYtRr+tTV9ZX3aUvRcJdcsa93hFRYCweHlF7wS0JDPWaqyNSf
         zHyg==
X-Gm-Message-State: AOJu0YyVbRjvhPcGR1sUBPtAu1Koy3LzGIpmMkCFE8h/2hd3kzUtjUt2
	Vvk3JIUwugFr3dosQmPY9nJ9g3wy/bSIzZxlLStj8SRZ7o0Rv74sq8zGEZgWLksV60jGTJTibbW
	C
X-Google-Smtp-Source: AGHT+IHHL9kfbk+dWQsxcDi5gVUTEGotMCu531Nr5IaqB/5Xnr2Zhwlxr46BL+baadC9ph7pqFxQug==
X-Received: by 2002:a5d:458d:0:b0:364:348:9170 with SMTP id ffacd0b85a97d-366e95e6878mr2785273f8f.54.1719228582903;
        Mon, 24 Jun 2024 04:29:42 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 01/25] netlink: add NLA_POLICY_MAX_LEN macro
Date: Mon, 24 Jun 2024 13:30:58 +0200
Message-ID: <20240624113122.12732-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
with a maximum length value.

The netlink generator for YAML specs has been extended accordingly.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/net/netlink.h      | 1 +
 tools/net/ynl/ynl-gen-c.py | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e78ce008e07c..31d83f6a465b 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -469,6 +469,7 @@ struct nla_policy {
 	.max = _len						\
 }
 #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
+#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
 
 /**
  * struct nl_info - netlink source information
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 374ca5e86e24..5910ecd38081 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -466,6 +466,8 @@ class TypeBinary(Type):
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'
         else:
             mem = '{ '
             if len(self.checks) == 1 and 'min-len' in self.checks:
-- 
2.44.2


