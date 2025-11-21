Return-Path: <netdev+bounces-240737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9289C78DA7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AD02365B76
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5634B421;
	Fri, 21 Nov 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBh9lvWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E234D93C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724978; cv=none; b=etpkCnEPQk0XWjdiYIan/j7YU/LtP2gZegizDWTotlpJHCkCHtqT61ywt51Fa29/KB8c5qan9xKv+JImyxvIO90rIG+vWRHeWfrmQToRRy6c1ZpPYMehowAab9bvUf3U+3WD9d/JyDzaKaWhLCGcYJknFY8mE/LsIaofflijw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724978; c=relaxed/simple;
	bh=iV5547O2Jkc5KxmhzNymYPOd0IDQwWkKNkuGqo67YKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzyyI6JhPu/giOJM9SgtdlbTZqBDkgLKvrQaHtJvhAMiKQK0bGoTuctKNG993y+0BiSfPK/H0bbLqAfLzIFJf0qHl1h4zyBd8tzA4x3NpYAzQRJ/4JqPVXdW/fvdgfrqUtohcYHoqtArczzcUoSMz7aW6M7NVg+JK/a+jM8ibZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBh9lvWP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso11922925e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724974; x=1764329774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL9yVtMaskxLuPDjF5CARhK40Dj9w0uig2rqjbmy1/w=;
        b=TBh9lvWPl5qCRjt4wm/sUSifj8jSsSY1iO707TIGFAs9gDc2y+HpmHNNrmd6jYIHOr
         DC8ZS57NmuPuKvYD5fIIbeGqWAxCKKULLafZzgY5hbovc6JTn6QUQtv1qf8gb4dkUXSD
         WEpmw9K4IvmbmBgwI6BKwvaN7xKhfIOkUPILxevhFFPUXWbirFVjVn55cB9Da0qqqLHU
         2JKY5NrEoPH8vMMC0EhpNWoiSdss0tER2t8zcsWNDGl8EW7ZR9rak3lZiH/oxghN+kGI
         nNhrZeffgVjAjnngBs/AIOhpCqaQQIv5DiCw8wEvz0a3KhWHlmFoI759n3yvq3m8YmQ/
         XsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724974; x=1764329774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BL9yVtMaskxLuPDjF5CARhK40Dj9w0uig2rqjbmy1/w=;
        b=ThwMsKRCNkBlCM7dY2ElC2zGbe8yAy5+t38TZ9PTppMpSrI0HNTv4aq28kwfU1nDdX
         FqRjhvJCjB4UA+6QKRVt+YkhtiIJ9asLIFutLotXdlBduFtbIHg/2R+Jnbos3RSbd9Ty
         3fmBBfQi8PamuOq4S7LeCObNWmuGJRpST74cAo1qd7xi7kV2LoRVjd+r4lyQ2Q0xgzNP
         WEunfCNRXK8B7H7FQ232VC6jpDp6plsIytuYQnTqqWyiPEDK5IEQ9U1WnXgoNnvFjN1t
         wi4xOvE9UUXmbu1dK+cf+ZftogUBudqtw3at9FTu426QQ46eJN+zxbzoKddssA8kY88A
         PSRg==
X-Forwarded-Encrypted: i=1; AJvYcCVC2MmyFSwLFttPvqh4apdQ0378rusMVBH8johK2cxi6z+drgaN5Ep3X5KBqFJaW6u77JWkNds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzklsdb5Cgsw/FYlgO4yKoYnCC8yiGWh0P+Hb+Ls1Uw2Z1zIh7+
	nbMdRBPUj/yH36JjFHQ/vC6nAAnFJ9dkp8o26oX2EAlbkR0rGeTdi/20
X-Gm-Gg: ASbGncv13E2va6jgf2/224cFMKF++BmnCh03b9KoxamXr42xFUCqG6xpOnPiJLP3goo
	d115agLqF0XONPEFc96tGzvWExg2oiOFW6XspaK6uBgwH5Ap/oHOMCk38zEohjww6FERy6LLWSA
	WzQwx8WhgOsk4QhLiIBtxdIPM306/sLsMet+nBeT0FJk78HT0IeDu9r+VNZaXzMd4Wtumy2Ktb8
	sbGarOwOHv6lhc1CuTXyw1FlJ58Rh6Xyq6vjD6NjFqLh4RRrZiRu+oqZOc8bVGBNYFk94h/7hzT
	+/o5pL5I8ka72dj48xM9+jip7u3uB+a/jLG3UyrLJWGGDpJfewAfdweqnhWCSdVBW+dtZDf6mRO
	O3yT6lUvs/ivhOrrXb4AlN7L+uR2BbairQhaLJXXXJ9tU2vMHKMTNe3FezLEuzNG+tDI+f/IB8V
	X9Rau9J+JP8qpae0Y7MBRTQ8fBdsMkxDwLOls=
X-Google-Smtp-Source: AGHT+IH36k8lUJuOn97e5nXbz9w9MMFZJjRypq3XClPag4vI3s41hFu6V390MCHf+PjbZXWUpQ6F2A==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id 5b1f17b1804b1-477c11175a9mr22999955e9.16.1763724973805;
        Fri, 21 Nov 2025 03:36:13 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:13 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 09/11] net: dsa: rzn1-a5psw: Add support for management port frame length adjustment
Date: Fri, 21 Nov 2025 11:35:35 +0000
Message-ID: <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Extend the RZN1 A5PSW driver to support SoC-specific adjustments to the
management (CPU) port frame length. Some SoCs, such as the RZ/T2H and
RZ/N2H, require additional headroom on the management port to account
for a special management tag added to frames. Without this adjustment,
frames may be incorrectly detected as oversized and subsequently
discarded.

Introduce a new field, `management_port_frame_len_adj`, in
`struct a5psw_of_data` to represent this adjustment, and apply it in
`a5psw_port_change_mtu()` when configuring the frame length for the
CPU port.

This change prepares the driver for use on RZ/T2H and RZ/N2H SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 4 ++++
 drivers/net/dsa/rzn1_a5psw.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index dc42a409eaef..82f4236a726e 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -211,6 +211,10 @@ static int a5psw_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	struct a5psw *a5psw = ds->priv;
 
 	new_mtu += ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN;
+
+	if (dsa_is_cpu_port(ds, port))
+		new_mtu += a5psw->of_data->management_port_frame_len_adj;
+
 	a5psw_reg_writel(a5psw, A5PSW_FRM_LENGTH(port), new_mtu);
 
 	return 0;
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index 0fef32451e4f..41c910d534cf 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -235,11 +235,15 @@ union lk_data {
  * @nports: Number of ports in the switch
  * @cpu_port: CPU port number
  * @tag_proto: DSA tag protocol used by the switch
+ * @management_port_frame_len_adj: Adjustment to apply to management
+ *   port frame length to account for accepting a frame with special
+ *   management tag.
  */
 struct a5psw_of_data {
 	unsigned int nports;
 	unsigned int cpu_port;
 	enum dsa_tag_protocol tag_proto;
+	unsigned int management_port_frame_len_adj;
 };
 
 /**
-- 
2.52.0


