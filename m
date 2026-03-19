Return-Path: <netdev+bounces-269372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBJZLEjCu2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D62C8B03
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C75232EF191
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B03B6C15;
	Thu, 19 Mar 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdT6p+oM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBF15B998
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911484; cv=none; b=seLIcycQ3i8zH7DXk9Eq8Ggi3BqjEJ0yd8xmmQ1uQkWGdcUave/jYvC9VToj4RqEZCaaOhDc8hApeSVZzyDAWgJjLMvryJ+HWYZ/8rvrOz/e//MVZ95pmGg9SEO2cq5G/CrPfTsr6Be1JsIyjk/QkPyyyL5hhFCOrcSloWNG9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911484; c=relaxed/simple;
	bh=bIjvyx7WRM5OrhlB4sKJe7A88jbCMzyVU7Rb39RJsKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgxZf2jOjtoX30WjBGpgvWQcDUOulSr245Q6uWkpiEboK6xiB3BKGPFuwPUdHlDD7TnAx4REHU0uKvpjf68/YMqizYVs1jO0wU5Zga+4Bmxv5avNPQ5gGjHQz6KIE7CoQ2HmJh6wiMGq/L4pbSlovtYqEjDdj8as62xSObB0IhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdT6p+oM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82418b0178cso434683b3a.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773911483; x=1774516283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkatcgHQKlyx5yNngB4ghSz9qHnLgeMZNCch+Ad8GQ8=;
        b=QdT6p+oMsUdDWWChb9BOZxWReezYIUUx6Qbhilz84qOguJulguY174Q9SkIWtlBimf
         XV4vVGCaU72b1ehvpOqjQWerXB6y5HpPysWbBztQfzfgEJLwF3RmWUh4GAsrZz8qtfOZ
         NLhAyDPy1WUmy3qUdHv99GWSb0ecZDtvM2JC8dQQR5lkDLVpL1JDpdMEACwbKx1il/qW
         sszJ/glUb0UMMouDYWy88duweD3SHNhaSIV5dcZVoXALzqTmVcGJ/AL8dFvyd6FQ/yY7
         jy4I8CQdhdUrCJiryQ9/DlGwx70Lxiy9z0I0rtiYlAr8dTkG0wzjKtqLMudx8wmnvcC6
         N4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773911483; x=1774516283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkatcgHQKlyx5yNngB4ghSz9qHnLgeMZNCch+Ad8GQ8=;
        b=hfjIpag02aJSRPn3o+lwgr86znN9Nt42gTJWS+lMekA8X4fTWX2MuWv4azVzRaAbDt
         mMAeIwwDbaC7BUZ3WWtUXuMLuOBPh9HuwULEiSW1GOjCTmYB9qdf6pj81wwqAGh9JcSP
         V+X8qR/dCbPC2C8ffIMtyA8MLJS7davjRtYgGTLrr7K9oTkUiQyUqeD9qYX4RiUFJHgu
         Yd8EPcG6FzDnSpxJ8vwsUuRxJ/L/hUNZ8tXtuoCSJQcFQBS0b2n7E31rLvPx1YrKtDpL
         zJD4EzfVud6rzMI4TlWqhoxqJcfmWX12wVtU0mpoYzOQjhTF/mgzjLGNARzwtYRDt/fL
         HuFg==
X-Forwarded-Encrypted: i=1; AJvYcCXpMSq6jMrKo8RNYoU2u6bLu4yBERfRjuQqMu3dGn3I3PK1zaobDuDAYYnqZ7aNcZ2B2ajCiD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrk9/56Lzh9Cex2uUzSl7BnNlHUFV96LXV18LJoN6VWWZFHMY
	G59S9izNeHM1HL2kC1f9Lum7EdnD/jBwW+kfQEs/vWT8RF+8gCZCTdGF
X-Gm-Gg: ATEYQzzyg+6ZG34lggGvYYwb60RdLpVlxU6xb0p4OqFsLwe/k4Bso8qEOWeR/24IIj+
	DKoKjYvIZXrR6Tv8j5/oqBPS0Cvg+qaGEPAp5kRy/I/6sCTZzOJTge1mguKWLWEh9E6ktXeeNUU
	WFKYQqed3kAh6Cpzt8dIrPp0rDFn8v7cnuprSR8NqE/1Qq/r6Ev5qRGu7IkLDFNX+aAfWaixLmd
	O8FcQtxXWi1BWOAgieqgAH3MUiMq1rWcczC4zAAXMXk6E7+Sq+urhedAS9OmN3UUzcwZLl4gh4S
	MYEK+mxPMywFhqgvXDej6+QBNrOlrHBFtaNSrSiJB2o5m6IxWvtkVa+ehtu4tgwS0OOirR6u+cS
	hzAcj0vesNgUTpuT6iDNucSX0CXubhnZvKMVTkJqy2Tv/2vdhQz+4dEjOSJegagEi2ykyuv49yu
	1E6fzjxpbOIqqq5MiV7LIJ4sHzxA==
X-Received: by 2002:a05:6a00:12d5:b0:82a:1044:3582 with SMTP id d2e1a72fcca58-82a6ae70a27mr6691313b3a.28.1773911483131;
        Thu, 19 Mar 2026 02:11:23 -0700 (PDT)
Received: from ubuntu.. ([152.58.152.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb522asm5324925b3a.37.2026.03.19.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:11:22 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: iyappan@os.amperecomputing.com
Cc: keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] net: xgene: fix signedness bug in xgene_enet_get_fpsel()
Date: Thu, 19 Mar 2026 09:11:06 +0000
Message-ID: <20260319091106.1662-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269372-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[os.amperecomputing.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 155D62C8B03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xgene_enet_get_fpsel() returns a u8 but can compute a negative
value when xgene_enet_ring_bufnum(id) is less than
RING_BUFNUM_BUFPOOL. This leads to an implicit conversion of a
negative value to u8, resulting in a large unintended value.

This can cause incorrect behavior when the result is used in
bit operations such as BIT(), potentially leading to undefined
behavior.

Fix this by validating the value before subtraction to avoid
underflow.

Fixes: 2c839337520b ("drivers: net: xgene: Add helper function")
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
index 2f534f9d4416..fe563c396773 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -405,10 +405,16 @@ static inline bool xgene_enet_is_bufpool(u16 id)
 
 static inline u8 xgene_enet_get_fpsel(u16 id)
 {
-	if (xgene_enet_is_bufpool(id))
-		return xgene_enet_ring_bufnum(id) - RING_BUFNUM_BUFPOOL;
+	u16 val;
 
-	return 0;
+	if (!xgene_enet_is_bufpool(id))
+		return 0;
+
+	val = xgene_enet_ring_bufnum(id);
+	if (val < RING_BUFNUM_BUFPOOL)
+		return 0;
+
+	return val - RING_BUFNUM_BUFPOOL;
 }
 
 static inline u16 xgene_enet_get_numslots(u16 id, u32 size)
-- 
2.43.0


