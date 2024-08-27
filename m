Return-Path: <netdev+bounces-122276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9D960994
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10FD1F23355
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3551A08BC;
	Tue, 27 Aug 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="C6MxIxae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7B1A072B
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760404; cv=none; b=K5pjBKOhV/bWDb9eqEuoPeimM8j55HJC2czfr3cH7LoVwazZ6dR/RqqS9nRP2wZd/2uNLlWvcauj4nx7ssS+qOHNMkw4SuiAjR6H523hSElMFII22gDaoLwt8vFH/iSHXMHiKMYGfgagYxPPx/+hlP401SxlNPqi2FepjgPvG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760404; c=relaxed/simple;
	bh=qVsCWbf8DkM0omSSeSYAv0bDS0g4JHxiRC+hlTBbGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+nRG8qAoXcUyIq6TR13Oybe/IZZQZdAohx9XIvYpxTYOpG7LvXZTf4xdtAsCrJKhOC8Xdf+DOFXbLhtp01MYXmrd54bSmXn35nGbQf8+ukwwKhV4rF9RKL1lsIi3vczufhwBV4yDabZlkqN/YPtqQfI9lKdEegY75gUp0Av7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=C6MxIxae; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371aa511609so2720358f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760400; x=1725365200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0d3Btfd/HNzGNNXzL1gIZnsQJL1vSdwDnh66pMcD38=;
        b=C6MxIxaeRDeGJop4okayt6mXnVO/sgI47GBsUzHaQ7pYeMq4Mzoidw9vZXQFm62UpN
         8fEc+ycBDgBxIfnQbG8YI9DaozEL6DBv8qOc+giCXopo31xGGEbVra6G/3c1ICwtEPoc
         C8CsTX+VBw0aeF8Pl2+v7AX+1BlLxZe5XP3T4rM1eLVqzx7aVUuDff9Sd/kKP7lkJMxl
         b2sNzDutJvzgD2kso3svRq5hr0DwbIkGCOPYuq41klErJLU3OqVSG4qhJhYdhoD9mfha
         YfGKzNU5mJY5RP1Nkqb0RV+Kt5aNTkgoBzIHmf0HzNbozH0BJQnmeVKxOLITKgUd9rsx
         3VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760400; x=1725365200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0d3Btfd/HNzGNNXzL1gIZnsQJL1vSdwDnh66pMcD38=;
        b=o+8W6acKWt/7slsVFASqumqgWXdFlfK6PRoULtcjTa7/4xgcpq3Fzybb0eDTwvT/kr
         LyRh7RM7IUiVfFpjE45UtrYHxNYfvoY0FQLSbQ4X7vaMLGjWfAlu/ko1gSbypXsUVSZ5
         BX3WgMfS2OlJK8ijbWgg8AuxHXuog4G9yeyOdPDivcmMk2dYDVmqQTt/vlKNItaanQK6
         8x+r3yYitaPwfMiUiSljBocIfKaB7OsgbbaWWYskE8Nau0UH2p+uvH4I79KBrIKEugla
         6FdoL8jdGgOW1D/+LRKpKaao4ycpm6V4P8iAGf+WqjEmLwgpGG09FIciqL1gIv3uA76D
         enVw==
X-Gm-Message-State: AOJu0YyQehE8Ie12fw1koFysfu+ydUlibHXyXGbq1XldM79ohOD4iDyd
	TWcbKhS+A/1sG1MRLLoKvRh/N1xROU1XPy+ui5/24ZHq5HIrNzDR5hKlZfI8FR/aJQqaObaE8dw
	w
X-Google-Smtp-Source: AGHT+IFX3qSrzQJydq83/QkCjSzgg4ydejTInXlQIq49sVrghCzQv5Hwhft99IVwsLJP/CQFTJ7jIQ==
X-Received: by 2002:a05:6000:12d0:b0:371:9366:6d90 with SMTP id ffacd0b85a97d-3748c7cfaf1mr1818214f8f.18.1724760400405;
        Tue, 27 Aug 2024 05:06:40 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>,
	donald.hunter@gmail.com
Subject: [PATCH net-next v6 01/25] netlink: add NLA_POLICY_MAX_LEN macro
Date: Tue, 27 Aug 2024 14:07:41 +0200
Message-ID: <20240827120805.13681-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
index db6af207287c..2dc671c977ff 100644
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
index 717530bc9c52..3ccbb301be87 100755
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


