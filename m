Return-Path: <netdev+bounces-248524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF0D0A9AE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D86C3008C71
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBC35E52A;
	Fri,  9 Jan 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCNcswNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB535C1A3
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968584; cv=none; b=n3HzQUTz06EgB13VB+A1LEHmgY4AQ/7DWvfbX1MFt7HGm1eLIefm0OCXBVpoBY/xnA8qVL5bh1eiT6QtuYUvFoniWMiTuqXQfeDbd8IArUglza0xaGhG1uwpuuRMpPm1OPuEoGlJNgRYnRakp+i1ZgS4KOLDKcK5kgWyzDxBqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968584; c=relaxed/simple;
	bh=UY7UFflbDgHZVibFTmDMq/bNYvMSyEoJd/ePrvRn4bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgcUMyoaKM0EbsxuZfjjil+Fdvfb55ToSEa6Bjhg9llxTsA+0mYFQoaDohXlgYbl+5ErgwuT1XKhoYEq/DvCZsuqP6LMoDR9ehyP1sm9j/mUjYcxSiDzcM0rp9/5aw6J7mq0XB2waM1Pg6XpBDRcfomyCPQsnmd/16j8RHhO5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCNcswNh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso28171585e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767968581; x=1768573381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZhhwAXsDIlx+lDJ1akeMoR5QOac1v63YDzTMpwdMz4=;
        b=GCNcswNh5fdd0ywVQd83AEgN08putvRSqXc2WAqW7ONxp9tJvycRwLUFJGVHln9PEa
         flYYox094U8NpyQTSbZZDPxPv38wN83VbCEnnDI2+NyhbXFSPtgwaNaXfYCgHVcckj4Z
         fVmT5xWgxO2eC1Ztx/JkeQ1j6Yn14nmfQIvT4wrWEvE2sKdAdRtK/L/jxillAvVF+1it
         yr54BrGS22C1sgjq3rM9e5jhmHgxwLSa2+E98DDj9FMUSDr5+RJ9VVz0r1+Sf7z/5BXQ
         JEZzR4XXyMz80lASupKf5rXNq8+KnKNX7KFLO5sOsP3DJyN7PsLD7TxBu0uZZAzdSWEH
         e6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767968581; x=1768573381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZhhwAXsDIlx+lDJ1akeMoR5QOac1v63YDzTMpwdMz4=;
        b=o7WxjAVit9xyQPnsBwdcDkUE4rd9TNN5CWsp4t3rBU+C88FfXXai3K4m762S0ec7Ge
         1bGnS3Oq65z/tPHf9xcFha9qguIuowO2JwBvl6UOMwaeMnK9ZauoyTe5yw1SJQtwkQ7+
         NowVUKzrmyCyiDJDvOon7/R11cjPOWfAQrps3qRi3SbQC7bbqiG/ssyzfxKRYrfUo94f
         6JH7yi0wR6fLjz4Lgwx8z8OrMZ0yjBlcSidkAfQYaZUmxfvvRPFOjINp89+fhfHLZ5Wn
         5yYzZpztGOu4tIONH5s9dV3v/J3t+uJ84D/cO3GJEkI48cX+wwoHbRO5SCYEBT14hBq4
         /aLA==
X-Forwarded-Encrypted: i=1; AJvYcCV3LRd7i2aMqJggeEl9J90eyI5SeGfgSK0DTMYw0IkxKK4c2+LVMD9EcpIvprUdATLyZiRaiUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaYoPXtON4uLC+bBHJcmaV/uhfmOkQLd5RcHd9yJykb+NPAnF
	4XmydfbfISu5VUvP0xKHl7h4RswCAgyrwtYl9FdfhJPu7HhrYdWYDXyb
X-Gm-Gg: AY/fxX5bS5lUAD/WDYHj/wB9kJRHUV56hNI6szG/YRxX3hLAL6vTP3akJYObW0g0qOn
	jEiSP65sb/K6yh4xL+OHFb3Ov3pRMjVWAHoNzosrPNVPIY01sVzMh8h4uq3Ewygi+9tle7ZGQD3
	L+dALQpIR+fiA+HJc0DY8Nzw5JfpzJzZ7YhQrykB/taLBSwhIWAOq5+pKlyv8PUPrpM0yd6w0Nw
	yeW/ueBnsgtZBdOxYTTF1bZb7T/ebvNO+3ChwvT9TKcloBs5PbUwLRdP+JHStNY9sXwc07VZmxY
	HFp10Gj74TQVR/eLTXxk4AhY9P/PoHG6j9gKzF+jaFizjML7pSCwerlYuWKcYdrz8J+rFWPIPjn
	HPel9TjvNGqfaZKQ3CG2MpjZlgoaQQkyI0ckIWGYaTSt0a0f1TmjLLbFk+xRoFu/SKn84aIpMb0
	i2BxWvlB7hDa4H6YV4MdSCdlE5nrLuCKt2sUsD3F9mmIBoRIvwLpXda4IvI7x3sGnDIIxbHNNNR
	6x24FQ/yau25LHcBoAtXpM=
X-Google-Smtp-Source: AGHT+IE4xUeJTRReFgbyqrI4+BRSkB5yL0hyNobdmJhLiKldprwBuzroJ3WhNsl5L6ooZUp8tRuy0Q==
X-Received: by 2002:a05:600c:8b37:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d84881c77mr103101565e9.18.1767968580372;
        Fri, 09 Jan 2026 06:23:00 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a1e11sm61448855e9.19.2026.01.09.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:22:59 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: [PATCH net-next v2 0/2] Add support for PHY link active-level configuration in RZN1 MIIC driver
Date: Fri,  9 Jan 2026 14:22:48 +0000
Message-ID: <20260109142250.3313448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series introduces support for configuring the active level of
the PHY-link signals in the Renesas RZN1 MIIC driver. The first patch adds
a new device tree binding property `renesas,miic-phylink-active-low` to
specify whether the PHY-link signals are active low. The second patch
implements the logic in the driver to read this property and configure the
MIIC_PHYLINK register accordingly.

v1->v2:
- Updated commit message to elaborate the necessity of PHY link signals.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: net: pcs: renesas,rzn1-miic: Add
    renesas,miic-phylink-active-low property
  net: pcs: rzn1-miic: Add support for PHY link active-level
    configuration

 .../bindings/net/pcs/renesas,rzn1-miic.yaml   |   7 ++
 drivers/net/pcs/pcs-rzn1-miic.c               | 108 +++++++++++++++++-
 2 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.52.0


