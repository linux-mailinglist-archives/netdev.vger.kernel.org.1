Return-Path: <netdev+bounces-128618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63F97AA15
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC92D1F2783C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA202EACD;
	Tue, 17 Sep 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bF33sRRO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCC611E
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535282; cv=none; b=dv6N4RA5PwC8mZ4V4ILKTdsQYCwgrBp/eiYLGyXPHOI9ghOcNCvIP8sRt+NYFcdz4pje0bxbwON0D05/SbKf9WNcoxMI+NZTFF9NHTECQfcVGGbCT+XFjkPAJrBFm0VbiJRcnWjtnuFn8/vOF694INoX7UUyqU8fDMS4cnIUo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535282; c=relaxed/simple;
	bh=qVsCWbf8DkM0omSSeSYAv0bDS0g4JHxiRC+hlTBbGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCzOjlKnAtVOt/ootHCmf/U2DFZUYPSIUXEGK9NfvOOYP1M1W4cxoTGbsB2/4I9bGphlyto8ZnnoBxzu7o2txrjaXotdJS8TBBpUVdhJ2rgfDPjd3kyz8oqQjElrRW5dToOryzb1omQ3u6rreL/ZEbUyfo0L0he5e42j1DaPmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bF33sRRO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c84dcc90so3303863f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535278; x=1727140078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0d3Btfd/HNzGNNXzL1gIZnsQJL1vSdwDnh66pMcD38=;
        b=bF33sRROXpEUz2IMWghG9WzUhQ0FELspzgWCOu1ds2jl+xAIyB36ltKRixPPi4ctNo
         LNtMEVW3YjrgwH2QUd7QkfA8tPBNJkKjyio0czltb/FTeARa3R3147m3i2Wyr+ChVG1k
         odlZaB2GXEBnXM1ABmTAi01V0CopcJOxhUgWG2mIYPm2v44UWZ9AD5qhl559z1MyztWM
         vvTL0UnfR5na8NyOicalB1LoacprLyK1+JU0G6RvqxZu1OJiNbT/q1Hu831kSEghDhho
         VXABsygRhf82DRQsvtQ6bWNDpbdeWGnHWq04LJ0GBqBW5KMfvY7KKj9Re9wK3uQKCjKg
         EeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535278; x=1727140078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0d3Btfd/HNzGNNXzL1gIZnsQJL1vSdwDnh66pMcD38=;
        b=F4RHSGDisIzhgSgeSucSyggJlyKRlhBo3u/B9EWQKI0xeZ4up04T9LC/NiG86xJD9x
         oMqdqcDPUOhQc8fa7K4NnUFXkOZobi5Q3NTXdWHpub1xW5Z0i3U2jefxYc5EXHGs6327
         PoTNHXe4/euCenKjU19xD3K5J+4H2zrm1oYAwgP3XIyIXo59bQtC2fp2jVfJKRYQfQpm
         UUlg981fDXN1yYqgK4RXhjE8Sp5WfQt9luqKcWDQYW4hbj8CukDnBxrCwgU9aVKVIR1V
         M36CC2SOoGJJXfHqDAe5lhS5NjzxHP6tTov6e1A9FwN0ADMQT57gk6PFDzFjsJ/DRpBp
         nlPA==
X-Gm-Message-State: AOJu0Yz+g82/tB6w+1E4oSHN04sxm7hD8/S3uIPH7IFF1WGm0kAyF5Ig
	4aPOfEOpE1Xe3Dsi8t90OMGQ77e3UFnXcPjTEb5toZYeO66vZFi6/naYBET9/3Xvi8KeGLX963v
	2
X-Google-Smtp-Source: AGHT+IH+IIgja5cK3s8rs3RFEIfwetw3FuEC/KHNVHBh7dAZr3ZUcF4hDhWK0YDwbtnCmo+EwgLd5g==
X-Received: by 2002:a5d:4806:0:b0:374:c40d:d437 with SMTP id ffacd0b85a97d-378c2cfc2f4mr9981949f8f.15.1726535278419;
        Mon, 16 Sep 2024 18:07:58 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:07:57 -0700 (PDT)
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
Subject: [PATCH net-next v7 01/25] netlink: add NLA_POLICY_MAX_LEN macro
Date: Tue, 17 Sep 2024 03:07:10 +0200
Message-ID: <20240917010734.1905-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
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


