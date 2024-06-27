Return-Path: <netdev+bounces-107261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E591A74B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61532836A5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01018732C;
	Thu, 27 Jun 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bOlrdo6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC1186E4F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493670; cv=none; b=HiHkBvFv3bPeO6eUGQU16vNk9Y7LOvTrLcRKxwuxMoKH6E8+t0kCzzsQCRVpcFkvfwv9bqK78p7w2r69Ki2xD8AC5638hWPOxOJFNChtq1n/fFiWd4kdijmXiCiOQHGgCSoUaO8mA8eqBmtFN9LN6yaDuHkusN1J4ABsLRHJ5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493670; c=relaxed/simple;
	bh=/lQToTywJROapgqSUK2VxMCXP2ThenLHUPgTMYATWrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgHtYekMX76g3RehwizyEmMgBePMCRklq5QliP3oCfuumFVijEGRQFZ8p+a5uUzRRmOAACnPo1oX245ezqvWysnUaWdwt4mc4gnu1OVwNhHnatIM+/RsC4sXTGdSw1+J/ntMo/qFVs9yqVlKREAEA6kEIlG19EaU85DInXcmUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bOlrdo6G; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ce01403f6so5253997e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493666; x=1720098466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjKRgU586Ds7BDFW1y82AnZKh3yl2yZ1n7QN6Db762A=;
        b=bOlrdo6G3wq4/nvvB5r6dkROXuKJ6YilJUlvY88rqoYqOsNYyLwfTN67l0rzggc1wh
         dPuu6fF8FOwrmf8HIdbu/7chgMoBpYO9BZAtruwhpYgzngZ2Dm1nT6FYkCAIe/k2x7D7
         OKvfAX1FWYGsN12tKKynRTybgvit2lQlbTvNJ71zbyJ7OT7J5Mw6P1RzrtiXPyt6H9AB
         d/gIcbaNlZpSa56IFRccS3FkObUd0VSgaWlqwNkvw7jg1UAgs7ONIkHyzeowG7jE76Em
         wOqPFCSEjkRN0RQZrGtAa+ToWY989WVNkSo4yir7VPTo1AMHwnt3YswMuOHeK2Qe7ntP
         ewvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493666; x=1720098466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjKRgU586Ds7BDFW1y82AnZKh3yl2yZ1n7QN6Db762A=;
        b=J80mR3bwdXmMkAADp/b90Ue8pLE+jSj/zbUMuwwfda0d0QM/nh4trDIgHopSI7zL6D
         MWxzWlOZ09ZJbeDksHWsRyugs4wMx9LlzhUWQYQIhu6RHDMV/fgQpB1I1903mSM5o0Ki
         FjFqxGPUir22GaNFWjVlDmYaTKtNQ+mnwHgwlLDnbUFmGjIj6Iwsq0adW8LaRsyzJPqh
         MrrflzFypBHQEDLiEefE6paaNUvQgYC4Tq3q60LDd22/sSKMXB3hmWA7mWInWTWTBwEp
         KudEE6WQm2Bd/degX1t4QK9XUG41cne6djAmuj4J5yJcB5CVPeDR6wzmR87fbnNGs9SG
         u58g==
X-Gm-Message-State: AOJu0YzY9sUPIey0oRHcBd29MhiebFIh7LIpjNnqEc/vA4oVilF4pK4d
	wY3JyE+wWgc8fkbLObmFUbpDjudHnM5BFJ//V9OpWn5oI3TVXB0Hq+PcXoLXLKjfih0QmX/b7mh
	S
X-Google-Smtp-Source: AGHT+IE48hhNX7+o8qX+ZK65rUk1R4l5qTlf1BNIM5d+2bzJsKgq6+ctfS+8EAp4fv1pJZ21qViGIw==
X-Received: by 2002:a19:5f1b:0:b0:52c:cda0:18bf with SMTP id 2adb3069b0e04-52ce1832bd8mr8181378e87.4.1719493665584;
        Thu, 27 Jun 2024 06:07:45 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:07:45 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>,
	donald.hunter@gmail.com
Subject: [PATCH net-next v5 01/25] netlink: add NLA_POLICY_MAX_LEN macro
Date: Thu, 27 Jun 2024 15:08:19 +0200
Message-ID: <20240627130843.21042-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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

Cc: donald.hunter@gmail.com
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


