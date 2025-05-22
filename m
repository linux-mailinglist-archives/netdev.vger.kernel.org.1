Return-Path: <netdev+bounces-192797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA87AC11AF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FB97B8EC6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8A29AAFC;
	Thu, 22 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj17yPTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44A29A32A;
	Thu, 22 May 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932834; cv=none; b=IBjPDqig/1BJRoGSIn0WRqqB8BGDlNVJxBCO/RULVxBxPafw34DMiMWYWtr2mGD6Ag+kQFKwcGOEeWt6Nf2ffaXeamGgn9ddlcvOF08xsTDzhLwbKZGYpm6SGRS7dwKJCaO4FBHvCXbGuwBXfdxYpwKA/yR1pDHVfkAOuITMbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932834; c=relaxed/simple;
	bh=xE5ZOtlR6OATG9/4T3dvjATiI+PvfvxCWdxptiFvfeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqOK2LvLcBbQxr6A9HNtgqHuF3u78wOqYEmlFeOeyG5/iAqEBScbW8jyLNNe0jfnwSqNYun+sl4UzwpR1jLAWqx1L+4/erHCsH9mq4zPE/e4I9xrYvh1z36O8whkVTRtfpWH963Wv0jDIyPp1j8kEHX27rEOmyZos+KRA6HgjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj17yPTt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so69279305e9.1;
        Thu, 22 May 2025 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932831; x=1748537631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARK5arm4xRMg5UA4OO1T6K5We9IiVU4dSpLE3tmkVDE=;
        b=nj17yPTt1wQW4sbKrbPjq+Q/Gf9en3mptUNstFos4rda/qIUds+XuSc0Hn5Lkzb3ov
         LjworIxRv0yuWIHAG0yjEnm9gm8rf/Bfz4XMUoVUcqaKy1i/8J2Nl0iEiSmkmZ8/I815
         /y7f24Qsm+cL/A4D4qFqRbWcHzaICiFVwKQbQWPqbLgHBXCwInzxvRdhVtAwauN9DpGC
         gO68xOyC5ltWB1yndvLtu7uaa+fV1hYgwZkxIyjiufQV88POEYpL6ZvMvjBW2Ip+y0xN
         TQQ4oAtMugCKWvs2A/+RFqN8mGw9a+h1Rbgfs6dmVKRpLkx3fzWnK8FHKBn0/QpJsTp9
         wCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932831; x=1748537631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARK5arm4xRMg5UA4OO1T6K5We9IiVU4dSpLE3tmkVDE=;
        b=UVAzxNCIE2vHsHvFLvvXBuvjztk7NJZMT9lg6x0Z1BbX0VkL3MojVALsjpyFVn97dd
         ZxQAbTeFWRMz81ZmnXDLOhGYI+QThGi4htk+Yz+traHvR6IJEv8AxibphWlsftgTdJEp
         xwYOhNUFhDsa5KBm7eCbI7Zdw4z2B4T00bJHIel1im1MeCHdE4riQ7ItbrIogWkqJR97
         MIVbmvdin96Wv0GKKH/Bp/n61Z3YIx/Fq6WkpLGJ3HeQN9muBvgFXcXYBEury4yFFM8F
         zUKc1phJMVUb+WZZFdEWeBbJQGwjjFLhqDkAFZVj6r7z+Mksi4pn0CjXovdXclMqIWP1
         z/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuWv9dtJDXw2GUWdZk7e2tQdMyGNGYFjcHbC0JHYQ808RFGD8ci6cOObCOLHAfjgKjrv1q1ThuGEFl@vger.kernel.org, AJvYcCVr0iZ9TK35h4SBgW2ZV+LQNQeo6FF7et5cX65jRF5im3U73aRalZe2KW7K/T9rT2Nq0eHPJnxq@vger.kernel.org, AJvYcCWp1ff+fv6PmvylxWTItfUsS7Rg7MlDYQ3owngXTI4rsq//UKoZFgnFztLx3YJ/yuegyxLklm259k7Jj1y9@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOMij4+WfL/k+L77MCdDmrep3HQObnSZ3aKZ4zMVjWV2osWLj
	U0KFQ8MDzRqmmUSspAzcw5rJkuNx31GYNszm7YlKPVXluE5DJXnCefYY
X-Gm-Gg: ASbGncuMlq/mR4rqCs85eLRUdNqYWIEvKlOo3twmrdPWqi1pe087M0DOPXruR8MTD/g
	v8roI/lg8mdgY3hcUYU3dAGrVfuvdjkR7BCIoN3ElS/Xizhgfiq9vgDslGy+HG8QpIjJjK5GL7B
	HX80SlMb6nSGcBqXxTyM/YC1PxXfaBaGIrDvHJ6s4/pqpduPUkUchGj/JlVHcuArSdl3EAflJxe
	IECwsJ1TXyxHeR6E/xrifThiqVST9Rcg9XsZ+wCLtL0qetw0xxUpINT7ax9yvMFLjUk6To/Wn7d
	r8ykuUh/aoxrakvxLi9qSxsubRoYEwcGJdPswKbHy3NcYuZKrVn334ZR5aXXi5uKQ8GrKbmLmzD
	DuQVtRLVoD2ywc8Zp8GsF
X-Google-Smtp-Source: AGHT+IHWhtAWXRBGh/ENakgND9IzcrqJZpmuMgIAj3z1JdfL9BG36SGp+6PXxZ3vxlmo2rQYJG68cA==
X-Received: by 2002:a05:600c:8411:b0:44b:1f5b:8c85 with SMTP id 5b1f17b1804b1-44b1f5b8d2cmr16008065e9.13.1747932830716;
        Thu, 22 May 2025 09:53:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm118737525e9.6.2025.05.22.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:53:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/3] net: dsa: mt7530: Add AN7583 support + PHY
Date: Thu, 22 May 2025 18:53:08 +0200
Message-ID: <20250522165313.6411-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series add the required changes to make Airoha AN7583
Switch and Internal PHY work due to strange default configuration.

Christian Marangi (3):
  dt-bindings: net: dsa: mediatek,mt7530: Add airoha,an7583-switch
  net: dsa: mt7530: Add AN7583 support
  net: phy: mediatek: Add Airoha AN7583 PHY support

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  5 ++++
 drivers/net/dsa/mt7530-mmio.c                 |  1 +
 drivers/net/dsa/mt7530.c                      | 24 +++++++++++++++++--
 drivers/net/dsa/mt7530.h                      | 18 ++++++++++----
 drivers/net/phy/mediatek/mtk-ge-soc.c         | 20 ++++++++++++++++
 5 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.48.1


