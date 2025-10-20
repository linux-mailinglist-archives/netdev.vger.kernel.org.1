Return-Path: <netdev+bounces-230867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC00BF0BF6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D07E34B221
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E032F8BD2;
	Mon, 20 Oct 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhEOgi5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE02F83C3
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958702; cv=none; b=AnqxyOL79Y1iixwPWWR+OP+f4sotfoHAp1sAkxAzd1jeobNNvm2Nm2t2iRcbJaqHOqW7ozNnI0L/r1BMq6ZpJKnyQnEcrtL7SWkq8fbRFUmUXtm48hTrdCGYNgAB48EtVkUP4ORIspaD+afxJ8pjMtTikL4I6LM9+Etp3Q9mWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958702; c=relaxed/simple;
	bh=/u/sHVZSfi2e7MdgOitq2zS+yVeC+SRdoWU5NFexqrU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hX5RbE2vGw6i25+zjTZ8UY9lbH8Ko8/FVzNhnXEAIHepJIzGuyVs/IEmMbDNWYCDIf/bCmjzbDw0WMpALBCloVcep3a2i9cEXCs4fCDr3uu7iJ1D0IQKEoM/99UKo+uIRKGyADKijWZyxSmTASWqWXnRCVMAHMPHxrAKfvjeNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhEOgi5U; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710ff3ae81so14613085e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958698; x=1761563498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=RhEOgi5UXsSU8vNyKz4oBwYPFx1Uzzzf9JTlFu2Dd88WadnggN+nWEI/T3+a3D6eLC
         d0GwMBepUd+UXj7RMdPkiRnX4EKTdsT9dWfKhmXemlBPqdRj5c92UYEC48OyYy89C7PY
         DkNxeN6uPpUX00JOG2niIt6fsxg5IOmXgL/7QX+J8k0NLZm14AYWNr9whKDyTH/csKuG
         Nvk3MQB8LR+f3XUGeKOKvDxWS3WoRb9u92JE+Q0A07o0MWWQsis3FquRfH6UjK6PrS45
         GYkMEiHdhr0A4Fs4trwPxn7LfErpW69Er5PA13bURCu4Mnb7ICobaqdb8fHZZ8Fwv8QF
         fSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958698; x=1761563498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=DveNUOGVUWzl+tow1wijjoXlenUmPAoN5yS2F7nMhFlJ1NpAR/qy1dkOb2PWbLGUJW
         puOZO3ISh7HlJdklZScmjGy1SA5u4U3JGo0N/467LE0HySopayse9IWM1q8Iibk8nIOt
         qqMaQCL/WkkDdzikvmS/u4HD+5Bvs0Ss2ypJeWjyspkQ0y8aslHykyQylZ4rviyckBdW
         7Rzc/Bd5ovmKSw0gzQtwwE+FWIEpjQbLSkiD0q70iMCMnCEUKwf3N+H3rno6wUIq6xUk
         JhWTejflroSJbY6e5D2uVaBQLM0gi/ClbC6HbhcHJfvCZPUzxtJHNf7H0EZimRk4s7Rz
         WfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDbEugAD7ML4IPu6TJsvxSnFoNCRRrZCErjaDz+p+sLijbpjvim5X4Wxvg1GwKfkGyikGOoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1A14zFRSDQw7lXz57lxzdaCp4v8XdH063DRAYdyspB7UXiyS7
	gyvGH7rKtn8m5wCHffcxbr1mSCrrTHf3qTXFdvRDhHtZPuMT808W5Xsg
X-Gm-Gg: ASbGncvvSCMbhEKbZWd6Avl3sbeK+a9q6HkFXhiapdw927DXs3nsMgE9Iu2XEnQZuht
	kE5FyIPH0YLZPrqjs1qPVOlgr9Lv1Z/BivqctS5u+v92x2QQ3htcMb/NcjHiQC//F5RPWBtXW3r
	GvtxnxfrCmmvpvssMYssZ4cU1CDCJ5zCHMoBBjJXx8j3CPdaj5Wzdo31hGqIY9E6BuE7A6+H3Rv
	/GNUVEw97GQ9m6q7epz7nDBfR+dZpQTVJtKdsaplhb3QGdIccEvR4ioZW5lhFyTfbI3lwQGJphQ
	GLhw5Y++VhIotyUIu5eC7hCt9rfWPmKkY3ZEOePh0btiNHWChe9J8pvPNRmGJZA51kP0BMR7ZpY
	+1wJv4M6zC7BjwMRPFkvs3l+fUo/n4rjYGDzGcJvlmIHJVaHXzoPOyFdzzdUEvgtG+iyhmx48py
	ePhc/a6ykl0jawz0x7GFR95xVC2pwlugNjN7rtpOszGRY=
X-Google-Smtp-Source: AGHT+IHVbG6TZHa2zycGcNFH3hDK5XZiaq2XHp38I80LU/N8i2ztgAzL/k/rCSUQlcdD5KrEG0KaOA==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr110884785e9.32.1760958697834;
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 0/5] PCI: mediatek: add support AN7583 + YAML rework
Date: Mon, 20 Oct 2025 13:11:04 +0200
Message-ID: <20251020111121.31779-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little series convert the PCIe GEN2 Documentation to YAML schema
and adds support for Airoha AN7583 GEN2 PCIe Controller.

Changes v6:
- Flags -> quirks
- Align commit title to previous titles
- Drop redundant comment for PCIE_T_PVPERL_MS
- Drop DT merged patch
- Add Review tag from Rob
Changes v5:
- Drop redudant entry from AN7583 patch
- Fix YAML error for AN7583 patch (sorry)
Changes v4:
- Additional fix/improvement for YAML conversion
- Add review tag
- Fix wording on hifsys patch
- Rework PCI driver to flags and improve PBus logic
Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (5):
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: Convert bool to single quirks entry and bitmap
  PCI: mediatek: Use generic MACRO for TPVPERL delay
  PCI: mediatek: Add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ------------
 .../bindings/pci/mediatek-pcie.yaml           | 438 ++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c        | 113 +++--
 4 files changed, 683 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


