Return-Path: <netdev+bounces-93557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180988BC542
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463BD1C20C9E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C243C489;
	Mon,  6 May 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NoE1RVxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641A38F91
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958134; cv=none; b=YOXbTcUxw71HC7oBnqgJWe0gdQPA5iP/WUxjeSEElRC4Zp6bu0gVRwApOaK8kWNw2CEvDaNc7pnuKkuvBIL9M6YWEI5v0uC2K+/o6/m+Ke51fk20xW3WmLhd7bfDLSNjhffMPMCi7+a7KD0ldmh+NObDd9NiTXSJwLOTqkhahfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958134; c=relaxed/simple;
	bh=/5lNF1WJ/HrrxL+t2+OWXzqsoTF0rVXoAnfgSVTs+bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxd4PsBZhgGNQ83z5OX1X+Z6RZB43pXkOaSanj79eJ9WFDKiwBnN7uqW77j+qTMfIYvYPcG0dgqa+LDh2qq5n1SY4cN9vZ/h4P6JBK4Eporm3yylguJgXfSlRLfFH8A/LmLsba+7Qirs3exiRjYCuMHpTJjnlNnjpY4mP44sadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NoE1RVxR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b79451145so10233775e9.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958129; x=1715562929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyfN5Lkj3kmzS6BG02aMlRuSgZTXJTQXPl4iELQlTvw=;
        b=NoE1RVxR85putC+B9S7GJdAreuDc9D/QKEthJ327uMoNmO+VeOp6d95PJJwrBu3P69
         yW0BPiNWGVuxOF5dJtwEnizWH9Un7SsGs9O6vff7MZE9LphbWM1Mr7sSPDsJxM8/tn6I
         b1xyTieGhXu2Rni3juTPgdS9qweL3dQGmHdlUB2WO1rPygUv3+SdIhmlSf7Sgo5rxbg+
         TQSTNQqoxjCXTi8UFnYDEZdyh9y0Fd+eIjL3LEo8sKqg0Xl0foAYMyWgrf4Y8ZeTVIrg
         B/etEX2x3HYhV1qEYutrRUktZ9bwXlH0ZfFr17DHkhOUHKlruJo+BAXZbEhi57RN9U3u
         1VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958129; x=1715562929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyfN5Lkj3kmzS6BG02aMlRuSgZTXJTQXPl4iELQlTvw=;
        b=wZ6dyw4rOCoSM+eZGNy+j9doUwcMYqzWfpxMh9YLoVbEr+Ae81yEGgWmEsmFcyFUc/
         BqRHjZKLDqrw45nVSdKVwR7C3o96PFmxvQ8mokx/azcw1jU4iRvT+R670CtxJV2S9ONL
         9pVElIldvj8hnfCO2Oi8fS2Rh2d6KOr6HGRt7uZbNf5xI/1M8wipRUARD86BGgrawFxP
         oE+utmqpoEYcTjQwbcXf4d5cp2t6USwsjKxOGvNr+htflJMS0ipk2GntzGCKjYywBoAP
         3L2mnp9Ds8ldJQjngbkOgW7QON5qXztyAfbua9L/itjMt8T/QHrDlhbDJ+DH+ZBCsfba
         H87g==
X-Gm-Message-State: AOJu0Yx8Uwq5SLAn/Q9yMX6X9k9L7OI7B/2B0eh2DiGgAPwQuZWR0C69
	s6a0/QuNnJk5ekBEKcJ1ry6CyYrlyre6HQhhsmkeAcbtAaKqfcfz7jABe8E/tio8zNDQNVmiLkf
	9
X-Google-Smtp-Source: AGHT+IGsvCcBkgOoLDqWO1KbVHxYD1MZ6PatiaD3DtyVpAdUpjDLv4CW4LDpZ0TuyGWrWXrbMhqHbQ==
X-Received: by 2002:a05:600c:c0d:b0:41b:c3f0:b933 with SMTP id fm13-20020a05600c0c0d00b0041bc3f0b933mr6175510wmb.40.1714958129122;
        Sun, 05 May 2024 18:15:29 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 01/24] netlink: add NLA_POLICY_MAX_LEN macro
Date: Mon,  6 May 2024 03:16:14 +0200
Message-ID: <20240506011637.27272-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
index 61cef3bd2d31..24b23547b0af 100644
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
index c0b90c104d92..dd60c51617fd 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -466,6 +466,8 @@ class TypeBinary(Type):
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + str(self.checks['max-len']) + ')'
         else:
             mem = '{ '
             if len(self.checks) == 1 and 'min-len' in self.checks:
-- 
2.43.2


