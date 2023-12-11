Return-Path: <netdev+bounces-55764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B150080C364
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF84280D3A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCEE20DE1;
	Mon, 11 Dec 2023 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zjPZ/ejB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F168E
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 00:38:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1db6c63028so469590666b.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 00:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702283880; x=1702888680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJOM5zNqGOjXI+bDyadob+wY0R+4R9z5TZtHlUGlNFI=;
        b=zjPZ/ejBDfKdDg4Ld+wBI/NDxq5atMPMpJh23xumQQG/eB5cfgULW0LsCIOzAB+nfO
         F0dbS4L32r0+2V6X0f1vvJeE3xtyT8IsqIm4i0d8t0TIunrpG/vrrz/cyvauKTw6jiFs
         JtSBqPZib0YyWVv7FucVVO3ydBWVtGCkPS/W6UfXsk5AAJGI/v9v6lJAxohn5h2GatXY
         v+ZyCRAC/U9Z6gqx/R/kaIXyLeLUq/aIkc/z0Gv3n0nkcU1yvPbrMdtrt0yJlW6Kv0Rs
         23AxgVwy98PkNsTf5UyLQH7RICeq3/LfE98HBDfiaxISbBzfMxDaIMTOr8go1HxnxP7+
         FhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283880; x=1702888680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJOM5zNqGOjXI+bDyadob+wY0R+4R9z5TZtHlUGlNFI=;
        b=oUPVrZs8bgndxG5QrAwg2gD9yR2kwtTvipnaeJ1J2fbtKJgadzQj8+ocrgkvHNLZKW
         /Kno0gY28Zl9x03xeLViTqxM7RGpbvS0NPi106Rx6R8nL6pE67fs7QqkOh482Tov3eZE
         9LsGpJa0TwJTr8iFEBewJ1xzxZ8qb3C1KHTRlWTzeotlpyCI4IgqhkKgebSpoJ3v69ZF
         A4lZuBQWXMLZ6o6TzYnj+h3KAM+9nA9/HWtbswqAzRyo0G9lTL/8fgE4V9Hz7l9Jrp6S
         TFrdohW4t28UI8ixWouagocZVCOzf3z55WITNucb5m5xJ1a/yv7ntf2NzVuGTPvl+V+y
         R0dw==
X-Gm-Message-State: AOJu0YxJKml914WYRa1khNWcusimEDsz34ZV2pL4WGC/IopQAgdln6Y3
	gWOAfIU71dU7YPJG3VwvlGgKG3e2Q/HK46bxPmo=
X-Google-Smtp-Source: AGHT+IGe0DiRECqWz2CdGjcd2eodl/kLnj/vlAVEvciYhqTrf1asix5NMmO0N0zDCSvd5dNmtUH4Aw==
X-Received: by 2002:a17:907:2d90:b0:a19:a19a:ead6 with SMTP id gt16-20020a1709072d9000b00a19a19aead6mr2546537ejc.143.1702283880146;
        Mon, 11 Dec 2023 00:38:00 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ub27-20020a170907c81b00b00a1df4387f16sm4521601ejc.95.2023.12.11.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:37:59 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	gregkh@linuxfoundation.org,
	hdthky0@gmail.com,
	michal.michalik@intel.com,
	milena.olech@intel.com
Subject: [patch net] dpll: sanitize possible null pointer dereference in dpll_pin_parent_pin_set()
Date: Mon, 11 Dec 2023 09:37:58 +0100
Message-ID: <20231211083758.1082853-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

User may not pass DPLL_A_PIN_STATE attribute in the pin set operation
message. Sanitize that by checking if the attr pointer is not null
and process the passed state attribute value only in that case.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_netlink.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 442a0ebeb953..ce7cf736f020 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -925,7 +925,6 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
-	enum dpll_pin_state state;
 	u32 ppin_idx;
 	int ret;
 
@@ -936,10 +935,14 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
 		return -EINVAL;
 	}
 	ppin_idx = nla_get_u32(tb[DPLL_A_PIN_PARENT_ID]);
-	state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
-	ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
-	if (ret)
-		return ret;
+
+	if (tb[DPLL_A_PIN_STATE]) {
+		enum dpll_pin_state state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
+
+		ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0


