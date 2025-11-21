Return-Path: <netdev+bounces-240598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CEC76BD8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CC0F429555
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F023B628;
	Fri, 21 Nov 2025 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bd6RLsgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC322DA1C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684459; cv=none; b=aRjNNzkkZ0NhsYj92LYMdX62fDvQZ/fWPT23sa681m5qaKfqSpkC2pAiN2WCZeUHY4BGW0xwDKghdrBGErvAV6PZ9viHs2QVfzS3cIE6023+IlQ8REO9H0iPAv/4uEJc69h0GkdYx+VcOk16AkwzuXTPm4h/J278tV5xUyVlT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684459; c=relaxed/simple;
	bh=53VXLoOvdPtY7k2oENUGFGgWNzEuZsEc5ZQh2CGHwH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV0tzWiSO2/3bFJNsc7zLxLEH4OIbdeg9Z7CVbJxp5pbx8aMlV2chMSLGXLX/7Jz2noHwDnWr41qgOJPoZxZ62+LfuIeViafINifNLUhlUr4wmQph8WUkx2cwitdo51ub8BEB4chCLLtfLHMCIlF3YO68szIBKwWlaAffohX+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bd6RLsgQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so15858525e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684455; x=1764289255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OioY6zxd25aFaY9ZQxPP7QjER9MSTqkKCg/WdIxgGK0=;
        b=Bd6RLsgQJVXP5fNPDHptWu5pYI1FS3FU9CZc2Ma8W8m5PqKqS8SXeHYyu4AQUctAuz
         pZyMJ98i1r/Dm08zBm3TCYfACclezNnEZmuBV46EQ4GLFgYDm+nQZFeUpUf3HnbiqeWQ
         kQark37vLhA5/e4mXhH3LV73tTLWFfWsku+AOuGVf16FI2H3PRrqKsbjUymemUq0MRBB
         Q4OHA+P7+Si5UYoqDR8z7bnnUQE/iH3ih7GgVBHCwDAAmCHUv0H8Lhgc9Jvpz0L9lypc
         e+qJHjteL4eK72BKHHzWpR9xm7vvT+WqgKVzIoELo+9oP23yXCEgd3/rWkwlG/3jz4a6
         Ej4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684455; x=1764289255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OioY6zxd25aFaY9ZQxPP7QjER9MSTqkKCg/WdIxgGK0=;
        b=Bpw45vywA55D+iUNoRlm5NBQts1zzGdd1kLTPPdFyKQ5Lq7fJinNSCfCSD5nNknMof
         LgLk1beAYPeAn1SF+27sHtDHVXwDty9WYY6y3uYIBc9nqCyI0HlxtuBFHk7gE9tYaqWD
         yAKe4jZbDjsIuxRe1Ijf1fxlNl0AUFNr7U0myq6f7aq5VXnD/1CEZ/qDv/v3DnNR0Hpl
         7hWAc2fz49EqXQ14hBy0BLfYThQNSBYJFrU7hnqJDDr9D4xyanvWooG4W9enQILv/rSC
         mcG/Zj+e7z1XfS2LFtgGWGijCsVzAU8UJIb02XNrhXlGugSQ6+JQoH4o2+9Ko39A3X9z
         /Ivg==
X-Gm-Message-State: AOJu0YzDvwDhFk4K33Qx/6cseBcxq8PvOZuod9DO6jfmm/iAEhbr2zhK
	4hbN/8Yd383oHjEgpdNka1WunXqq+MMYXNbaeyjUHai/uHt41eyXctr07LPtu9wNjI/lMco8sm1
	Tn4b2hmY7NDsPRJE867AfBy8Pt9X/1aCimrfCQouzotwZTq4bXTTHvHcRA3LXXwAMtWg=
X-Gm-Gg: ASbGncul3LRxoJJMWKRzd81PeUoSsQNVZ4fIGxMsxLS3rPVoZA3SalulmWgr6fUx2kA
	FZEz12A9c0IddWOHl5MdCNM9nMsltxc8inFpfHBvU8s/060xaMvaIBSnFlkAVKEG3xhs4D5qYXP
	MDP4RUT5Bn6EmtlItxs0RSA1ejW+zrCpAhc1B7xHEzhAdZT7BlwYI4wlavPprOzth2SXaeZufOb
	sY9eIg380PtJLQySetjXVIOGApieMaC6W1/lmNRzSpG1pH/I/KMYagPqsdX1bETWTVurFc6eF7D
	3vjnQpUYxpNZg8ks7YeLMbBBiMldNhkketvxIDlZxR3T5SmgM8rFLJEiY8dAI563vhd+ARdY4q2
	hqhgzyOhR3B18xvPHLtfVZDqaWYzFtYpzJDXAHuD1CcKh3P4tK5Tel8eluXIaFsLsfbzpqkQOll
	iD9H2FO8qZ/NJeFR/at1pMqGMcRYhQbHWEpls=
X-Google-Smtp-Source: AGHT+IENO8kKJmFBvT6JaVKbI9aoW+Fm63UySKCq67MmXauU6jsjjjhIvId6gcTBcrtZhx4M5gg5mA==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr1966775e9.24.1763684455321;
        Thu, 20 Nov 2025 16:20:55 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 03/13] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Fri, 21 Nov 2025 01:20:34 +0100
Message-ID: <20251121002044.16071-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.51.2


