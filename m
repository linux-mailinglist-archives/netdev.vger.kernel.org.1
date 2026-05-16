Return-Path: <netdev+bounces-288666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEfcLSThCGqE9gMAu9opvQ
	(envelope-from <netdev+bounces-288666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 23:27:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC455DE69
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3193011BC8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E600C37E2E9;
	Sat, 16 May 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuUzrrzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393E86341
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778966798; cv=none; b=L1u4Uby5ILVwWOa9LNFJwLzF20phN/SRWtTYZ7W5In8cblbx5sn2t9YiKjYRpfX6aQbJfa06sOXkrntbMLYARsEgzLUOjriR6th36Tb9L0sNszbhMLPLuUKCydTPhoxG4fShe7tCxKxaC1+v0bkLcUAh9rzA4krR4VlItpDz8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778966798; c=relaxed/simple;
	bh=f9ZwFuaKGQRA+DBYG7F+VjxVpKzmwhziUkp/RHQr0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILNInJVo1zNDL5Pzr1QKh8VlRQh0VmHxUnS7jbGydlk8KuLaXNl89JW3728eB3r1NHAFoY8IpT87+jL5CzOSDKMXloahsgYXvklnAVtwc1rEq/MztKyheXAdoEv/G4rgxXczvoEtSRjiSgcyhZKxT6wTIu8k0OW/to/gVbQLknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuUzrrzh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5b55062fso11066601cf.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778966796; x=1779571596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65ej9TODkD4mh9cNuPqJS9kfozbOcNNTiAmzyQQYmMc=;
        b=AuUzrrzhPDq1jfnzDysx9JR6YM1aHpkoFUdJf2s9kbPxPrwHxNCOgABHz8mjw1n5Uz
         e6qbH4MP4DH/t6yQFCvzBmaUuqZkvcNxy2pjm+mrNuIznfdQrDLw63RmX6V+6it1knCZ
         H7GHq0KzsNGb5jDCz3RaukquBtVw28qwfUfzKcL/dLSW4SYv2OdnK4/eb1iXflrzuw1A
         30eu7geAB8/6xobtsC1xUPmjPRFEpVWIV8HerQOOarlgOz3tm+mbgXogfwjp5k4yk61F
         WPmmTDQnLrvU29bNg0aCFrkYIGQsMGVSTJ4IY73zmn9NRIcGHqAwCLVJtsNNApkAgrA6
         M2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778966796; x=1779571596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65ej9TODkD4mh9cNuPqJS9kfozbOcNNTiAmzyQQYmMc=;
        b=kgjNasCA5oDSHSSeyH5ejQxEjBUqcvVlNdcQK22hNL3zaxOHLRYbMZUo/xCgemjF8C
         meJS554isGzXPfa91DwbiXEjSnq7NtXm1+Za7N/2TidfMK6XoKGtI+YS4f+V1a1hJfPU
         tREMM+3GgnKZhnslW0+l0hZQpgi0Bwmgl5FcdlJiuY5Id4JoSe0BrW3oNrXkBYP/Siik
         2ZfKJWGQvjdyGBEJtSsdHUiKAvUepzXL6A0tkRUYNtBDZDawr2KiOl4PamAH1m0BZXsG
         BnXPNium0nqcRhvIi/FlRkKLPUytm5+dCmPTjYza2xHGHTkd0IKzw14OAcAa3opnxXuL
         2jFQ==
X-Gm-Message-State: AOJu0Yyp6UcEBpZArkZoBjO7Mh65QTDqnyggK/704mFZjFfP4qXw0yLN
	xP0/Q9UbZBq0P56S9LsKvd+J1V3QtUHbjMTXMCrG3FXumBCm+Tqd0wZwUu6PWA==
X-Gm-Gg: Acq92OHbGql4gI1OnDaROmlQ8DjKrYWOgfy3QTznOl8pEeXNwusYqO2e/iDLftfi89Y
	uho0AJ18wRIJLUrEM5ScWhVepSGM5eoXZ/jZqZjdzEI4NMO7ywhJ1MSwUdfaNCR6eaJOuoZ4wmJ
	myCywVSvS1YFCTWpM/RafM91tKETw1E6HQc9MHiwNpwBzgUjOx22hB2ENpEaEqcqg+GVhqV1BHy
	Ac92j18vjCulziCSUWHTGbYTnXqMPfZe0te90Sc4gejc5+8CDfXw6LZNlUeNJ9JD0BxeDt5Kd4f
	O71sxZWi97pgMNa1e5b5scw9mCwjQjeriA7NdnnmL4982YqWgOHzlygCJ2G2lJdlGaMSO2+TICH
	ZSZ0ch1GXflQsWqtaKNLVlehsBJzdgcjsMWNbCD3X1owPPJCEvBLlnHmHAV2zhmQxgB5iPO9AEf
	M8esdTUywPdI9Z+sOzAtjMs0vN2Fdce/x+8g4I7tGALjQ1JHVxJoC9oZMd65pgxvrDSOE5QsYlj
	C/CSBzqAUtYVL1OUeYEk0mz70g17f1c8Zc=
X-Received: by 2002:a05:622a:1e92:b0:50f:bd51:f1d2 with SMTP id d75a77b69052e-5165a253abbmr136300431cf.50.1778966796201;
        Sat, 16 May 2026 14:26:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm85319761cf.18.2026.05.16.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:26:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: ag71xx: check error for platform_get_irq
Date: Sat, 16 May 2026 14:26:16 -0700
Message-ID: <20260516212616.11758-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54EC455DE69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288666-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Complete error handling for a failed platform_get_irq() call

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: adjust description
 drivers/net/ethernet/atheros/ag71xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index a5ab99474179..4e4794c4dfdc 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1856,6 +1856,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ag71xx_int_disable(ag, AG71XX_INT_POLL);
 
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0)
+		return ndev->irq;
+
 	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
 			       0x0, dev_name(&pdev->dev), ndev);
 	if (err) {
-- 
2.54.0


