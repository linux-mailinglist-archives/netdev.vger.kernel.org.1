Return-Path: <netdev+bounces-167456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8FA3A5AD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A711893E5C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34217A2E0;
	Tue, 18 Feb 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOJP5LaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264252356D6;
	Tue, 18 Feb 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903608; cv=none; b=XgawM8rRgjoR+UP9AyNrSTYjTFtuzUe8yK0p6FGqcHcoSmFaZNEdHttYMEAnc8cQuw3g7loYiy8O17BLhn7Nb/a04NNAJILDuF4YupPRKgtN+DJ9WWdDROiMQr+s/IyuyM5BTZumxf4uHUMAkGDvnGN6pGULt+M8PEx4SnhqOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903608; c=relaxed/simple;
	bh=CLX+RDq2VWcGf6HMksoo+sold6zfnddBA8DO/uK8jSg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E/hAjR/SAnplaQjCdDy2m7bTdHfWsez+Q2ffEZmaDKMS7LHy9hBxsLncFEMioA/Dt7KjUYcZWGagjQrC66jmw+RR6BPpfHGsNqgYw73Wy4FeE0E6AodqKhbuyj/X9FzHf3XmjdOnZSxQCvKUMf9S0/9OaOw5Y2cX+cR70WOtv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOJP5LaK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso890221866b.1;
        Tue, 18 Feb 2025 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739903605; x=1740508405; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiWaYyIQgq/zvsUV9YAcDJlEM1SSFLHFaWet2X/6k/M=;
        b=FOJP5LaK4dGQwghoi/FgrvTzG1nEpHcdJaj2WFF8bK0wQABQS2UolGhwg5T0QWsa27
         6MkdyuDEst6N8b7JiFGNjL9pArlOgMQN3juQ4PClgtTNrSnY76E5qjzXaYjIlU5iRKGl
         SPyLuIm3tGn9TNkbXhub8nNEj/3pVU/VR9+H1tKn9Nkr0LUgbUmjoThYfoAQKgy+EIWp
         AhWFwK7oMnBjpeIH4BzMQ6e18RfVXSG2S9aEGA+9dUF4OMhhweDJ9rfOTDb4ylzdE899
         Xl9aGESNw1nLNs2ZIHrn0zXvuVaQ7bY9U4O40gyLpHavaa0ELKhDLW9LGaW9R5THV5nK
         5+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903605; x=1740508405;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiWaYyIQgq/zvsUV9YAcDJlEM1SSFLHFaWet2X/6k/M=;
        b=Fn6fVc8AbiGaqQivLPWzT7tVOXrUUhtQ1iY/uIR8+nfC/wrN2x4f6MVX0U7Z9hTB2L
         fqx6/N/p0yP/TFGiHACnJ3gKT02/2Msc+dd1XjLJ2w0zA1h0AgrxbSYKB6jufB/MITUa
         7cCntbt6mbL1iXXZy7JuGXsVX41ZhkCiXh85pnZ3+NMlp2qcO9WdvXIXAn7eyzRVHr3t
         sqIF6FQ2FL5eunUkfopjsipHdWrpqA40wLKu/koLGO8iARNrbHTf8c8m7VPGpWGXth2v
         9ugQXE+XSgH4OCcYA92AQaDZ7/fnrgGdJQxZwrB2CfnuICF6mjNR5aQFUnbL2CClRwm2
         Kqbg==
X-Forwarded-Encrypted: i=1; AJvYcCU80+5OR+ltxhnumKG7fQSgPCr7+Kq2AXndoZMfbkG+Jfcld/fpkV2M9Aur/Edj2UpBCTV9MljMdt49914=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5cgs/oYcQoyE2XRn3PZJ48cnG469utWsg987rF+goj1f81q2
	udXaiOQPetCJppYQAYYi/u5Rm+Lx1UXbMhRnZK6DCbkuxE8XRA37XOovkw==
X-Gm-Gg: ASbGncsjD2CFKaw3HiOUWtFRnU1ZCCzeHyByIKr7QyGLPwfNF4beCMIbhmU38Qc9N2I
	cg+WmjVKw1ULXE+wTzk+hcODuZ+EbTbMZJkADAv10IH3gGjvNRu0yiwD75M0rK3m2vtkfMhL20c
	uHbebUiwhGQSZ1BioTmJu4gSwCwqsgYN2oiI+JCbv5EM/KjedM0pan3PdQ682/6kTgY/gWefJp4
	CitSLRaUeuu3xl2kyysQxCG8+JfIEfbbFxogIE2QeNN2tXo5YCiSRFCsGikmu1K/KC/+/w1kV6X
	f3xrVE4f5qz/pttEPeg=
X-Google-Smtp-Source: AGHT+IHilc1/LeFkTHY2RAJaXraZFQ2RzkRGy8HMc2JHm31GKT3plqARIwcVuuhbYOL1sMbOUgtxbw==
X-Received: by 2002:a17:907:7743:b0:ab7:ee47:993f with SMTP id a640c23a62f3a-abbcd0a6399mr69832066b.47.1739903605019;
        Tue, 18 Feb 2025 10:33:25 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:625:3600:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232039sm1106649266b.9.2025.02.18.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:33:24 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH 0/2] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Date: Tue, 18 Feb 2025 19:33:08 +0100
Message-Id: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTStGcC/x3NwQrCMAyA4VcZORvYIq3VVxEPmUYX6NqZyiyMv
 bvF43f5/w2KmEqBS7eByapFc2oYDh3cJ04vQX00A/XkehpOOLOtEiOG8KZaK07fOSeUxGMU5A8
 ulkdBYvLeH8mdg4PWWkyeWv+f623ff++7x7J3AAAA
X-Change-ID: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Patchset fixes these:
- Enable temperature measurement in probe again
- Prevent reading temperature with asserted reset

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Dimitri Fedrau (2):
      net: phy: marvell-88q2xxx: Enable temperature measurement in probe again
      net: phy: marvell-88q2xxx: Prevent reading temperature with asserted reset

 drivers/net/phy/marvell-88q2xxx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
---
base-commit: 071ed42cff4fcdd89025d966d48eabef59913bf2
change-id: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


