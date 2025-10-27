Return-Path: <netdev+bounces-233234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A5C0F099
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D201894781
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14530EF89;
	Mon, 27 Oct 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vm8NgZ5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747D30E84B
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579906; cv=none; b=RVYUsnYFwM3GkywZkHb3jIQxwhdRU2w+9pUHJHgW3U2PFz5wHG/TFv0CjCGhyDDKRIEEmwH65M+OxAzDiZxfKlhfioo3HcHwgrQbldsnjHeAIAsM5Ojg29XeeNKfQ+NCQK6L8VmMRUAm5sCv6KNRo+FGN9fALJabnAOaP4dIPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579906; c=relaxed/simple;
	bh=C/+pGWh4ZCGZOy76owpq0eHfBoBaYrs3C2W6uIOqIOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UG50fFmlWmMegxOdSYphDsrcLNTLCfTNeIuFXVNy7y/+vqoy3XYIdrfxagvv3yQKVQKReC6ff4EeHhvWrLxcxpQ8kO2Fpa8M+oD97VMtEJMLSgHREeO6moeeWZI/FMnttMT4paz7JnsE8qOuhPFdFUCPrDyk+4+EeZvauoEIcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vm8NgZ5m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso13624305e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761579902; x=1762184702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lb4VSxhZ53ib++NoC6OQcXArogDrZtQGJ7FBlNPhbfk=;
        b=vm8NgZ5mxsa8skQeVO0C576cspmF/3C4v7J0Pg2Na2m+B7L5JvP6wP510VZdW5TJes
         a3sEtNdWDgcRJ5wjYF2KJzjLjWzBtisfQIqM5MRYi0Qu7WvfL/TMIq80TpS5eyPqQcF6
         DwqDWmTvcTdTQiyMMKyZmflYFU+dEFurKEiyUFol194UY7kCuI6+iTpXAFZOb6mbAnQh
         hYuN9W8jWTpRclyUvRNxl49FyjL4r9LV0Pa3b60SyNMyLAepQT/48JqtSHV10PzEgV7u
         1KX1tA73ligOP7uS+cYswa5BxMSExF+Uy3mfmOZ+cLajzHSJqVHPlR8xtcX9CMYnCVNq
         sDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579902; x=1762184702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb4VSxhZ53ib++NoC6OQcXArogDrZtQGJ7FBlNPhbfk=;
        b=OIrdqWBUaX00SzYkwXHlHZKF9hDYxYyZKBWuNhBCNBKZvbfEMViiiXEeoBItdl1wBy
         VXHi3W4xHzG3SmcA70eA2GPhTyUonwqLqzZQmimjRJRvRhZ/BpeZqVkoJEkD0D8pA8Ey
         YecLDXDqhLlal3rGJzqUjoPOAEQOZjfewL44jfyr4H/6LquTxf2Fq6sfbaCYAwu7bIqN
         e6TR9tRU5tblQn7h7IPIwRKhVzWBKDpCiM0Hho02Z+O9l3pGxcGE8r1tCEDWYD4aHrxM
         NaXHfPco3ayP1MTnLJqCCGchRSAOzEIK0CpUroY1cem4NLqBQ84PPoPCRfmvZEkRPbt/
         oKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVATtw6nijr3SKBThoGo3Xj5Gg1Qxt4iTz/1l5UMygtVdccIR5WWtUMGlbjlGAvfWPWw0EOdUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaU6BRjTiERc7v3BX3ucnmQJP872pHQ6gM2z4LcgjBNZCdEQpE
	sJeuvLjENnF4azB70sz+CRBJtfhgLp7kYo+owaq7B5m1ux5QRL1w/emNoOtPagjHybw=
X-Gm-Gg: ASbGncsjNVnokTSifhqd2gOoyd0KrfQqi0dUCwaQlzlxE8yrFWHAMeaNO04f8+lMfop
	+GrtPighSd2cXjV98u6JZNkc3IGJ72ZyO2LUM+yeOpS2Vhh65ufujRXm9TPB+0dIelYG5tpIAe4
	CKDHu9wZToJ0F8FePO+sSNa8m61crhLwgrInaPfTwKn51TTAc4rfV4OaGeNlBO6zxxKT2UFfnGf
	e1xCaxIDL2n6DKx9uwdC6Q+SvfcXgzIhZN/uC0TcO70iKb2ksl5akaZ8H2zfcQqfIyur4P5Atn7
	XUPP993pyFhfWEyVXg/98JEHxV4JUKQPcbDr5MDsCgWisXScilifYl/c8C43PtOvm/VfVUd7r+n
	W7uDcI6xD3lt7N+qv8FzsFoqzcoycKDEw245n8b0GcVGkBiAROMETRUyPqNft7cGOsNvOF6pS+k
	3MuzlJLg==
X-Google-Smtp-Source: AGHT+IE4u761VTQhz8y8t9/OtyAFKbyH7V0oLh0quuYxb3Ci1sFKCWOHqVBDOe0fEldTYqcbNTrciA==
X-Received: by 2002:a05:600c:5251:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47717e414d2mr927705e9.19.1761579902369;
        Mon, 27 Oct 2025 08:45:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477d0esm138708045e9.0.2025.10.27.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:45:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/8] net: stmmac: qcom-ethqos: add support for SCMI
 power domains
Date: Mon, 27 Oct 2025 16:44:48 +0100
Message-Id: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCT/2gC/22NQQ6CMBBFr0Jm7Zi20FJceQ/DoqkDTCIUWkM0h
 LtbcevyveS/v0GiyJTgUmwQaeXEYcpQngrwg5t6Qr5nBiWUFrWocPFhxOSs0npGGp1HWxmhSu2
 8lgrybo7U8eto3trMA6dniO/jYpVf+6s1UvyprRIFlsrVje8kGWOvD55cDOcQe2j3ff8A+SryR
 rMAAAA=
X-Change-ID: 20250704-qcom-sa8255p-emac-8460235ac512
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=C/+pGWh4ZCGZOy76owpq0eHfBoBaYrs3C2W6uIOqIOM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/5N3VBuLTH0yAZ2M7A9DyhsM1dSsCaRksN/eN
 7ktQ+jrruaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP+TdwAKCRARpy6gFHHX
 cmW/D/4qwTNffsadNq6O2GGPSLLD6/KbqYR6hYjz+j02Ym/SK7B4K4488T2mDJH7VKBfwLNw0F+
 F8UxgRW2JqCsR88CbbKcqaEHHIf0hjb+CQ/00REwEdis+58fXQ1yM65j68YRE8pnCvr9Z7/6yMr
 PqzVltEr/mMDst7I17x0N2O0yQeePnBlPVr5CD8xxVvUMPYnQ5VYC0UdaPHnzcdc2owSgdt3UzB
 EhgXHyWxAYgl5Pk6BDSB7R+q5EJ/4N4T1PU9Sb3H1jG7cVjxBVAfsYRxQHm3WRcKLuQH4pVWnGJ
 2hHKyz1YkGJr0JxVVFRDtnzcS/pXpEKdnv4/YhkwS2jZFKnZhs0xvhko2T8w2WWvppneETXCZT4
 /O2DyyXo/gEXR9ARvrXkQEk+CfUSMfw5RHiqWZ5/x1QoaKDM9MYma6Y0l8jmvcTFZWc0xT2vA8w
 sTxikCmtkPxWxEnOr4y1f5Ve+bTBge/QhuZV3b2xPJ2Jj6bP1t9dAOFSU8SzNuTaDJH8SB4j2gB
 v23ItHdt1cXOl+/OxnDhRNaqG2VShqvPvbiBoIcMT9dc5cNNf3v8gjZt2gkjlVcR6oFiT5oNtWm
 4fw+J26NqLyZ8ysRPJPREz1TWntL5wyPyYMwSMheLEPgktnGd5NZS6pasFvxQByYGOIUSGSTjY4
 R4U5VJ/Y4EWoQTQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Add support for the firmware-managed variant of the DesignWare MAC on
the sa8255p platform. This series contains new DT bindings and driver
changes required to support the MAC in the STMMAC driver.

It also reorganizes the ethqos code quite a bit to make the introduction
of power domains into the driver a bit easier on the eye.

The DTS changes will go in separately.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v3:
- Drop 'power' and 'perf' prefixes from power domain names
- Rebase on top of Russell's changes to dwmac
- Rebase on top of even more changes from Russell that are not yet
  in next (E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk)
- Link to v2: https://lore.kernel.org/all/20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org/

Changes in v2:
- Fix the power-domains property in DT bindings
- Rework the DT bindings example
- Drop the DTS patch, it will go upstream separately
- Link to v1: https://lore.kernel.org/r/20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org

---
Bartosz Golaszewski (8):
      dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
      net: stmmac: qcom-ethqos: use generic device properties
      net: stmmac: qcom-ethqos: improve typing in devres callback
      net: stmmac: qcom-ethqos: wrap emac driver data in additional structure
      net: stmmac: qcom-ethqos: split power management fields into a separate structure
      net: stmmac: qcom-ethqos: split power management context into a separate struct
      net: stmmac: qcom-ethqos: define a callback for setting the serdes speed
      net: stmmac: qcom-ethqos: add support for sa8255p

 .../devicetree/bindings/net/qcom,ethqos-scmi.yaml  | 101 ++++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +-
 MAINTAINERS                                        |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 342 +++++++++++++++++----
 5 files changed, 388 insertions(+), 63 deletions(-)
---
base-commit: 5b54ba44a7db08b43d345380857bcf0fd95ab10d
change-id: 20250704-qcom-sa8255p-emac-8460235ac512

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


