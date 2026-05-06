Return-Path: <netdev+bounces-284758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQmKxgB+2kbVQMAu9opvQ
	(envelope-from <netdev+bounces-284758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1640D4D81CD
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E931230964AE
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DB3E5EDC;
	Wed,  6 May 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD0iegDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783633E559B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057186; cv=none; b=VKj4MoO3lrf7LBuuqTainiIhqSHAT/UAnUPt9wYn9w+KlbO1buhSzgxX5LKbBqMd9kVeB0vzNT1fU8F27zCZswcCycAYrfYH35ERHgprDkwJKpTX3wklmjrkBEzGrzGjDPBnyqMeaK5Ul/8i7gfaQC5Vck4g1T6oXMd9tTlXcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057186; c=relaxed/simple;
	bh=bUp7CVn30qUQD1WzOH67S84aqhWLyceTvkcN5eDW3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJ0opbZEJASOeEWE6GiqM+DWLUP7706B7Mx+pInHK8F1EOYXoRVhZ6nMT7iahDSh/uA1hLEns/ljzqZ3WeRuOaKChf0v5cRkzEsOj7nnYZlfo28Xt1VMXj7actqR+ZPVLUp6xnm3FthCOlkmDpYsuaF4UMYF2km/kZAg3Jof75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD0iegDL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so53832855ad.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778057183; x=1778661983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUSdR9R631N14alNwqa0GqPMI72JdY9A7cqHTS5tg5U=;
        b=TD0iegDL7Mga0ASjr2/6pXaglrfpEvT7aVK4Jfi/33FzjpuMqVTubRrIpw8rIAkOlq
         Kxj0umSUzdrGNiZ5BlaFDAf0Sw87UHNmfLRLXPewdEPAVBBdbnoLGdw0sAew3yKhF9/1
         tXHzbAIET7xq4YnFr1ePGrL0w9MojjfF3fOkjnYM8z9CVxd4zg6yMvBSa1o2GSdwkndZ
         yF0Lcocq6SMS1IzrrkIY1jFkTWUUHkxkivN0lt4rccaoEQGo06LavhJ/BiXNBpT+d9lw
         GoZ5sSqCfy/9THCtzMBjnvrSj3mv4L6ncGCrZ4ziusx1MJxrfkPc9A8o7L96Vip7Ooyu
         dc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057183; x=1778661983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUSdR9R631N14alNwqa0GqPMI72JdY9A7cqHTS5tg5U=;
        b=Hk5686sZffCMQYtHAPEGgvM3jnyvJ7v4EzwOztvO0sAxVSP/wJJpPEarOA1f02onxR
         X2bMxa1meVyt/AI/ZHD1Q0ZU29w5+CGGc0mmPkG1dpGt1L0xSjJCrkuS4oT+myEgaibd
         PqR5vrL+7SMFCMwkM/y7zZI47KxYNENzn/E8YYR4ggf3OjCrnojW6X/mfhyYRL2Xq6v6
         igVBtnWGGMV0/A4I/hJ25DCpKBwEGa999MXPD5V1P61wcdRSOlWI+VkFOvLLchF7JSuk
         3mXoinUx428NcIapeVDkLaRGNiT604sGf+BoADE81x7EXlVjtxdd0bW/ubvvqllGOBV3
         Jv+w==
X-Forwarded-Encrypted: i=1; AFNElJ+RhFmFBRXF/eQFbuQv5i4VitOyI+yjRuaLPebngcT8h1mLTqS7KQWWxvK9iL4YBtCGLMuNa8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMjqTw7xpHz8IvNuAnHmVdace29FYgcZrh0xjNEPq8nmHoSI3
	Ia2BfN+yzVDwDka8/rtzABz5UFwwblclsup8xMuHTk1O/WQsxPksqjyK
X-Gm-Gg: AeBDievm+tG1hEPBkTGSQdt4uCu5BdJNYo9WP8U1p2YXZ++64KQS+AhGw+81Jf9fMhK
	5YUSoK96YqyvqLqHEfU4FtE0Hs1ZhTg0mfLBYZYlDnGsBn8POhc+Dxzj3hr6Ig33oGnanhVloUf
	Eu8ThKmWs1dKaOWx4DrbHl5cksTAIC7+wBZfKZHyu4XnZJaxRpKQJwNLW9XGSw4ebtv9Ld3cTp8
	/J00+8bUkVMqGBHM4X6XaIpTGxKvgVe894L9S+01TvPbss5oBbYc6pasvwuLjPGqbdkX/ygutyR
	2huP2XGZZSLjZWJ3zkrZuC1PhYEQEm64nWwy17lVdM3yI4eIZgeGei0wGKlhXPfLcpTYELGYqns
	11iKDUZFiW8mF8IkbiKgMdJ5IcJd2qpdwV5cXsq2qTAJSBu0Gfqab/OA4s8qlH+R7Cpk2Qxi7WW
	gA8w874R9vlA0AUfe/ZPZKRquRGTYglEH4R07ZYd+XS70W+RzQcThHk8PdxFaoYwW7mjlBa0Adi
	9rtkRxMeT6u/NYfDb4vOUQ=
X-Received: by 2002:a17:902:f650:b0:2b9:87e0:1f80 with SMTP id d9443c01a7336-2ba79c2301dmr26131495ad.24.1778057183288;
        Wed, 06 May 2026 01:46:23 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2d72dsm18985145ad.25.2026.05.06.01.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:46:22 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net 1/1] net: stmmac: dwmac-nuvoton: fix NULL pointer dereference in nvt_set_phy_intf_sel()
Date: Wed,  6 May 2026 16:46:13 +0800
Message-ID: <20260506084614.192894-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506084614.192894-1-a0987203069@gmail.com>
References: <20260506084614.192894-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1640D4D81CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284758-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

priv->dev was never initialized after devm_kzalloc() allocates the
private data structure. When nvt_set_phy_intf_sel() is later invoked
via the phylink interface_select callback, it calls
nvt_gmac_get_delay(priv->dev, ...) which dereferences the NULL pointer.

Fix this by assigning priv->dev = dev immediately after allocation.

Fixes: 4d7c557f58ef ("net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family")
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
index e2240b68ad98..2ab6ecac6422 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
@@ -100,6 +100,8 @@ static int nvt_gmac_probe(struct platform_device *pdev)
 	if (!priv)
 		return dev_err_probe(dev, -ENOMEM, "Failed to allocate private data\n");
 
+	priv->dev = dev;
+
 	priv->regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys",
 							    1, &priv->macid);
 	if (IS_ERR(priv->regmap))
-- 
2.43.0


