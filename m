Return-Path: <netdev+bounces-285018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCbIHKCd+2m0eQMAu9opvQ
	(envelope-from <netdev+bounces-285018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1594E0033
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9EBB3019C9F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82034BA53;
	Wed,  6 May 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el1KsUiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBC34B662
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097564; cv=none; b=RZfiAaXn94OdLA1lFeT/sqsJXrQk6IELgDsQzaPFJCLkx9MDbZ3LStOsJ0/kry8y9ikYAb6OAa1nBKQ4AsMWyWfeMm18ZotcWJ3Z7jIuYGyOLiJK8MWAa8LfxpSsIixBPB3h7rXk9gRjvy2RduOCTjmoK1J28LLHSyIq8NKZPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097564; c=relaxed/simple;
	bh=xzf8tjJbNBE1eQLCBg4Op8LMYXu5IMMKhKKyfVzSZhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=reKnkopn6Pfbq4N5OimXdoMIfz4IGvri456eUfQXud/2ZzDkK4h5SYPILZYlJW4w7ScZkS/KKrHPPTFBmOXylNumrVcKd9a8tYUZbXYv+vDpR8rlb3dKItj18jbUrz409/nb+i9FlSbPGria2enptte8FwWMV2a9YOlsL1UQk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el1KsUiI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso99643a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778097563; x=1778702363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPFeHG3eQWm7h273qNIPgzRDB2uND5oH+mVxaZVS8FQ=;
        b=el1KsUiI1uud3U1zdMvl+pb9Kp94Af/SkXYGx00Cur5kBriELvmfJKQSygY1IlWE75
         N9Mcki3cLhkHPe7/YG1YjIJrZ1O28KyqGTHWanbKgsN04RMhIXdQmAmHdLq4ZVtkMdVM
         MY4QRfEYCGMnbB4NqzFE/VS1LPjzEUTTXPP6OmLlWJX+oKXvor2duNVwuOe8Pi2Apa6N
         101snLLQqwYV63g4BRorqP/t1DA7vhj4QxYi2v6rKGDupwRj9QdczBn+Amx9znXAP+wk
         +Q10bzCu/9e+9bf0QS0yV9MV1AdBvblbq/jI8yFbiSFw52p3De1z5PADMQ0f6XaJ2EyJ
         t8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778097563; x=1778702363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPFeHG3eQWm7h273qNIPgzRDB2uND5oH+mVxaZVS8FQ=;
        b=NGu7k0iCBkWD/jPUeWM4eHl+J21HuFtdX548n7huF97AdtaGjvgS9ubb1W4tKjsGOR
         /bLM1UvbNPEsoOVpZR0cl+40hPSw2ajZ+yw6QjMrQmfc/CUnbDhgs1H5FnswqhwMK9jV
         c4olX1ZiRca13rEqcFztwzoBrGOiZVAaI9P9s0S+QYkFb58GExrGRdVXKgfTCbSmViPr
         qfYAO1Ig/qbY51jwUTKliJ9iZGfLCffuUeMD/b2dhtu17hse5O1PxzzPJiFNlUlw3u1l
         6LFXwWPjiecHtpQ4NOG9e1kgXfC5inyh1WVIfUemSKxprdsrvAyGvjaiQZodpDtJKh+g
         5JWA==
X-Forwarded-Encrypted: i=1; AFNElJ/gvVpGs/EFZvYhzudS+olc1qYM5oBWo+CTeB5AlyLoC6jrUkYDl0sNL5uaGV5mBKJ9d8qUv0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7UyK6T7BWIQlY8uhMl3SUKKw+JXb33tyKLuDAGVXX3urhUGs
	g8XaActGmgh7rcZSK7t7if18Pbz8GDEHQ6jwj/oCoMTEdj0O4YSw2/A9
X-Gm-Gg: AeBDieuIt1VJ//2frIc3dtJbntNaKjIvdEaXKucSjWTpp19fSyqUKaorvSzWVj8K7F5
	Fkx6bgkVDKnc+f6LohI3CIUi5s5dilKmwuxNWRxv6IqLN/ZWv+/B1QngmsRs1jMvDrzsx5NxNlE
	oNNGC18YVrSX7ypxsjr7a6v43MlROLQP3mxj6Y2SoYUTRrUHxdL3433CLdUDF6s+UpBRGA8p+/V
	jMGde/Wouce7dzSZB/zSyytkSrBC9X7U1zRX43tWjG5SbH8EWjABD7p5/Om833f2ujvL9nbfEOO
	ZVbWBFXrmrLLyoygZCS7HL1ldpfhuOqwN4zE+rXPzcX7IAcWcgZbn8AOXHlTuLqPKGD+Kntk8hE
	id8K7ua782ReOmIVMxvqpuCs/UofaKY1j3pPzZdNpXi/AADekhQa9IUWofUC2uzSRn6ggcEvrcW
	rd5tRPaiu64ItqOsrv+efxued7QZ+6tAPD84SWpdu0mKDg7tyoP7uUTqntXuXikH6XHeZpVEwtK
	PPRWorgCto=
X-Received: by 2002:a17:90b:3a8b:b0:364:8f64:49ea with SMTP id 98e67ed59e1d1-365ac795084mr4891618a91.27.1778097562894;
        Wed, 06 May 2026 12:59:22 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b0058b30sm1935300a91.0.2026.05.06.12.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:59:22 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>
Cc: Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: ti: icssm-prueth: fix eth_ports_node leak in probe
Date: Thu,  7 May 2026 01:28:13 +0530
Message-Id: <20260506195813.641610-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA1594E0033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-285018-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cambiumnetworks.com:mid,cambiumnetworks.com:email]

The error path on of_property_read_u32() failure inside
icssm_prueth_probe() returns without putting eth_ports_node,
which was acquired before the for_each_child_of_node() loop.

Drop it before returning.

Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 53bbd9290904..b7e94244355a 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -1825,6 +1825,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 			dev_err(dev, "%pOF error reading port_id %d\n",
 				eth_node, ret);
 			of_node_put(eth_node);
+			of_node_put(eth_ports_node);
 			return ret;
 		}
 
-- 
2.25.1


