Return-Path: <netdev+bounces-255126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNwfM22afGmzNwIAu9opvQ
	(envelope-from <netdev+bounces-255126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:47:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B71BA28D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61225300406A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36B236D4FA;
	Fri, 30 Jan 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcdEaBDy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728636CDFF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773671; cv=none; b=AMAUFrfh7841z+F3ipUQIerXX5oPNFfEHRrbMu4FmOME7CHj85YmfVykIrXV1UGoimB38VTaYY8lPB98gfzEnN8T7uXt8WyNKBp/SAkKVAB0YsPOpe9cQNgRRcwSoK/vNBxs8m/Fleb6aNkUEXQy38PJ0HLyiXlNOb7w0aKqq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773671; c=relaxed/simple;
	bh=xHsscL/S9sNPH/BVUVEofZMZpcKVEo4gOfIgKcOUPec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F91HuBph5uTHMCOh7OBAt8qenqz/peC/XDX/rOgAgLJMPqmGYsI/ztgjyu+/hiWLblLN+v0iIkqTKIEWtM46nZ8Xw7hPQg51eAsxocwVNL9vdp9QL9Pyjrx7Cypi5z9qUK0Bc5JVm54kjnEBfSXoh8HEShj83FyD2yWil/+vyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcdEaBDy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso2676984a12.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769773669; x=1770378469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiAdJAOATpphPKKt4Msqi/O3DHV/llCZQK8v55LcCMs=;
        b=bcdEaBDy8wrYyPw3jBEiiO6rA35EWsJ98KQvsC5slJ5Fg8zZliktHQSOt2C6DcjEqW
         imSjym9FnAY21ieDUlTt1G0kTJMPk1jfAk+WqFs98ra07UrPVe8dCwT5S118e2xJrWsJ
         /Bi4mnjylJLtfGRrR1HHicYJy5ORKh09rEjtbjJA0/UBQVfuV6qL14jJFOLJi9WjIHXQ
         pm5Xq3z2tAlIRWIEKU0rtkprL4yP+HkqD36WHgyVEKSci5/J/rdl1CT7tOh7JBffF8D8
         Pg1Qe+LYFxVvUkLlTacdSS883bM8pR02vM3CzJswBBT3hQ6gYeTqlB5+CHo67SRflADk
         0kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773669; x=1770378469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiAdJAOATpphPKKt4Msqi/O3DHV/llCZQK8v55LcCMs=;
        b=TG75kwiKiAdSzyPBO4rnA+4G5h04ikb5S7pRIVBWOaxUML9jy+eSLMc81LEdpTcNgG
         8SLOraZg+KWE9E001riEfJHDu7PNIRK32P2AcboDFi7yCb5d16n9hLjInr32j08xdi3S
         cHwQGsNJXzLK40gsiEjlX9uPAMuvMEf8BI4pLbNJp5GVzKwZKC0ZRQkwdsq54rAZaUCM
         FAHMZEHVIxAie+vRTZHgcWdQQA6pz97E+EykFPEdE1Z24/AsAnGlVgXKrGpDkCkjOaeR
         Hf5WP/NJlYM1kUqeqCi6OFYrnYdzQx6JPN8CLvNKmF578iqdm3LoATXP2sKLfriy46vS
         MWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtJMKdjnDbF/wD9BpioSLzpe8b6Ke3E8i/t3OZcY6ub/9JYBKEDh3gPevkBxiAk6ANOolTHKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4p+FSPEd0awzUQlRPkqH+OlY4GupLNOF5zQdca4s91MyqNVee
	Jspct0dzMh22reb9QJMpz0VgOCNrXYa+7nJZ1A0DxwO3jP3juO1KyTnc
X-Gm-Gg: AZuq6aJisr2BfIOvNdiFR31rHNdI0fJXx6dwIxa9Gj2yaaWCfIfevSSguPbtqcmtN4x
	K109UhFlr6BRD0CtRfxDCvr4omh98/algEhwlfNpqVSQRHXq241IsbSjKWIDLH3jhW1qVeB5owy
	tiCelTLlP3hxYMhcrZ2nSyq7RADnZcT6hECMZHkutX2qssTsY0JG6oYEIwAcub8KseiAbPzXnt4
	cJKjlz96sORLpnEJBfIRms44HXknC4bhILBdVN+e9oxQbZ5BRXkAQiGq5wfj4m30yBi3mSZ0PDU
	H3YHwlzpxYj+m7iy3UsFwsBW7zEv7i04/iI/d83thb0nKbyUth2CfsSvkKdCNnLL/KGeGSEW/1q
	cQ+xegb/oYZvEz0HKzbXXQEBucopEyRCMpgvDKuoNma2lW241E7IFWf2jHwhIMEXU3g5Oj+UT/K
	xGNv+YvI1D8JGhr7yMcCVtgQisewbVYDYz8L4=
X-Received: by 2002:a17:907:7212:b0:b73:9280:2e7 with SMTP id a640c23a62f3a-b8dff71f572mr144266166b.34.1769773668637;
        Fri, 30 Jan 2026 03:47:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bd64:2984:fe71:7633])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de3046abasm243751266b.2.2026.01.30.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:47:48 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
Date: Fri, 30 Jan 2026 11:47:40 +0000
Message-ID: <20260130114744.252533-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130114744.252533-1-biju.das.jz@bp.renesas.com>
References: <20260130114744.252533-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255126-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,glider.be];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2B71BA28D
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Compared to other Renesas GBETH stmmac glue drivers, RZ/G3L GBETH IP use
the version Synopsys DesignWare MAC (version 5.30). It has an extra clock
compared to RZ/V2H and has ptp_pps_o interrupts. Add support for RZ/G3L
GBETH by reusing device data of RZ/V2H and can be extended to add other
functionalities later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
index be7f5eb2cdcf..19f34e18bfef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -214,6 +214,7 @@ static const struct renesas_gbeth_of_data renesas_gmac_of_data = {
 };
 
 static const struct of_device_id renesas_gbeth_match[] = {
+	{ .compatible = "renesas,r9a08g046-gbeth", .data = &renesas_gbeth_of_data },
 	{ .compatible = "renesas,r9a09g077-gbeth", .data = &renesas_gmac_of_data },
 	{ .compatible = "renesas,rzv2h-gbeth", .data = &renesas_gbeth_of_data },
 	{ /* Sentinel */ }
-- 
2.43.0


