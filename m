Return-Path: <netdev+bounces-254249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LQ7OBiAIemkK2AEAu9opvQ
	(envelope-from <netdev+bounces-254249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62722A1B19
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE247301AAA7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBA352953;
	Wed, 28 Jan 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPGeMiCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731D350D53
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605140; cv=none; b=tJsUeHWEzOyJoq4Roq2q1nECRNxy//J3Jvv3U8I/7oj1tieFW+iF7epAZV32kfiN3NsDVd9SXe21CM/maWVifc04CaKkpEq2jffepnc+zXV2MdV5l7Baq3VmC+Vg8vvjBzlHV67uf+SsB7TTVHbqMQroz2XOtxGptgpueNJYsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605140; c=relaxed/simple;
	bh=S+pGS/X53FfVPE+fl+yFMCW8OMTXCM4Zs5O7qT9dlBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgaoetWtRsPsewUvk6CWod7ceHtsrx3LuoPM5r4ctO/uUmrVuS/+Gw/E6HGGpfPwLoOcOlZB6kyChU2e1UQgygtH3yF4/je2PbXhtl0B87e8VeXTt3w5MMyFt4IO7XR//zzKZsDlxisj3Zo3aqmccclkg11olNOHOo5CrXfFRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPGeMiCp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8707005183so1038244366b.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769605137; x=1770209937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8uaattQ84x7k0dHlXaaGs69eppir8vSPiEkCl0d5XE=;
        b=MPGeMiCpCAjcJ3sc4oe/+8JSloIf0rZMoX/00D7G6GR44J6o4BEuCQZj7PLYgdEIEY
         2Fw1dF9NTaljfWlGfu99RRhwxPt5KHA9EQQ5ExCkQTAcWFHxprhi1wH7vXI37WGTybAl
         aH9wu1B8zyI6HsgINAzU3laLMxpoZkhSRVMQTJOjTiXmf3LPo6pSJQBwTdW2Z3dqoLyq
         wyg0nqJTwIRMs15tMPltD4TkAvGJR6hdYVv7kU6Ya1QCprBL0ef0HkezJxfKPNylAlfY
         qtuJ6ShAQNi+76+1XMb0q2jzSsdUTa57Q2OQg6XYc+U8VCf8Tuz2I5xBrFWaUqJxEy55
         KwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769605137; x=1770209937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8uaattQ84x7k0dHlXaaGs69eppir8vSPiEkCl0d5XE=;
        b=jKsiDroJq6bSF0e31yrmEczLeHuhEftSqcVxJXciXEKSZhHf1zjWY7WRSWJFuVTADh
         NZjq/VClJUIO9GRniqVgrM5zO1xXiyUCuvpw4hVPjIYPB+LIuk5Aj4CBCTGuHcbBb6Vw
         /9acJ8p+XGp5wChzgVNkjvHf/zFAB1yszDrkUi5U2z8AA7SDUuxoZa2bC9Lxcjf0yclX
         1tFLfrBLECGAuT2yDYK+MjHcolTp41BCN3oIEve9aaSC94KImUU0sSgWx+pqJUXXaSTv
         v06jXE0TgS0h1Iyye/NgT80JpQO8tfGS/9iO4VMahy2wLXe8Uxoe78824nvV01v6JwlD
         FtVg==
X-Forwarded-Encrypted: i=1; AJvYcCUycpU2UpQu19ZRkcMhYR9r3Dc4C+1B86V1+0cHxjUmflaONnLKksD88m9akBcFJV35CBSY3Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcj/68EO9ZiR6TBqER6npAVGBWr4RrbxfLOOPnWigRwVbHMlS
	yKcpZkBZJXWKf8Z3QzSi6NXq2W7Was2xf4CvkRVAXJpviZBVvOMSEQf4
X-Gm-Gg: AZuq6aKvGMdDZ+8DhiRhBDbh5Oh/vllJ8WLNAtbebckwrGmRp9TtM9FUhMPpAEp5hXu
	blVAvdjb2B95zXvLQd2sLZ/nA6HV3Owx9j89EY+MqbOQDmDowHIUiValt0a5GuZlmJS+AbSHpX1
	0Xkwb+41es3emwYELMEwkTz0b3FkJlwiD4IsP9MJaDSfKfgAdeYSFPDupK2RwyELlGht546zKRr
	13O/cQvFMfEUXIm0qrIoQNdvr42/aNvX0yHuEui2w91cBsl67BGWTs+vbLbGRhlddG9n/U0n+P6
	sVlEXCFiROZIc5PoBTY6aVA4ap/LsfGUDHiVVHYFwKqZQNYpyFeoLFXu7S6bqzb7Oi8knyRBX1I
	uNeIwizkSPl6jDSQ/2qIQpT4S1j7Sz49ZoysNpc7fkjhKAPlNW5OkDnRDL4HMIiSbWwXgk5a95L
	GJ7hUi1QRarmM0EVTDcC90MPYOM+/mmUmq/xk=
X-Received: by 2002:a17:907:d8e:b0:b76:f090:777b with SMTP id a640c23a62f3a-b8dab2e7d35mr340320966b.22.1769605136436;
        Wed, 28 Jan 2026 04:58:56 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e29d:6e0e:72c1:d15d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm123344966b.67.2026.01.28.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:58:56 -0800 (PST)
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
Subject: [PATCH net-next 2/8] net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
Date: Wed, 28 Jan 2026 12:58:39 +0000
Message-ID: <20260128125850.425264-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
References: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254249-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62722A1B19
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Compared to other Renesas GBETH stmmac glue drivers, RZ/G3L GBETH IP use
the version Synopsys DesignWare MAC (version 5.30). It has an extra clock
compared to RZ/V2H and has ptp_pps_o interrupts. Add support for RZ/G3L
GBETH by reusing device data of RZ/V2H and can be extended to add other
functionalities later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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


