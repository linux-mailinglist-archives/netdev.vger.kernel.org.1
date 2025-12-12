Return-Path: <netdev+bounces-244468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9DCB8516
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7BE304E564
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7A2D0C62;
	Fri, 12 Dec 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwQ+HP1a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F984212550
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529222; cv=none; b=QWa22+eWz8me8x2/pGx+YrfQTx6xd2lvB/wXp5mDMTNS/K4T14qfaJ3QOH7jioqw2pKNFLZwKhggtW6KcsWasDPfFA5nbKYH5CCz8yempTxnTWm9081Ezl56aXfTKK3bAOgW8cC4ZLcNkSyCDwvljyA8i4hfb1lh5XIjd5MQ+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529222; c=relaxed/simple;
	bh=8E5+Kpt25qMxuVFtPp98+FzLKsx7X8CnYqgMNjiMvQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZgI1J6Ovup5WY/2gx2T88oz+0AsZ9i5bKiY5+7Ox8KqhCspbS4qwpfz0FnvrwHex1OVfVhhgkSTre57JJLqgzRkuBhGuZbY7nzLchUOXOa1FhvmhUMHXGpSSIx0wbLtAIM80urQDS4TC7+Gh/Egh7XWeZmM5cAbnB5UJVVdbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwQ+HP1a; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so178333f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529219; x=1766134019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpScSZouW48AySITqAmVJ4AMB6de2gL0dmg8n9rDANs=;
        b=UwQ+HP1a/DY40Cg0YQ4FjYJSepvrsmHE6YcLc8GYgeIDYwDElow/k7/meJ2jLjjhOU
         fASH9ooFUu8frUdr01lN17bT1UkdEbeJ17mCTCsr/r+A6c65k7XgrLX+/xtiWVxv+FC+
         Xgl5xeISf7e1M4E+Vko/y02HBg6DTIZQiJdqmKnWelK6JBY2GXmEAl6k21DJdYweWlrW
         jnG46qWziaq2E/6/tzBpQy56hiqEqL4ZmTNskOxBKNLSY0e/QvjuJjjCirTeVS66Uv58
         xL7Y+thEjJRW8eNUCrwMeBo8czaO0KJohRe/+hsGmthFNNs7NbcnZsjOUM4YtL0WJYZp
         jFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529219; x=1766134019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpScSZouW48AySITqAmVJ4AMB6de2gL0dmg8n9rDANs=;
        b=klKeq0yahJq5MJVVvOgdGo0NXDEkzvZyknuwzIKh+BInSOcfuKO9K72Qs6MN/ywcCK
         daeqSSx+afx+dAQydaXl/ijnxBVf+ta6ePSOsB9yi0QIT5eJSQ1dXKwQx6vhBtpO1zQz
         FknaDW6yuRAkpSVd8TEWqQnvwchVubUE5vODLFHGlK3p3KMegcgjWuguq3crElMgNpS3
         kZwmaSMKqP2qjsAmGnFL80oqblANRxDR0V9bQpsC62yoDFIxplkn3nTHaGNV0z2okyzl
         7F+gJh5T3Z0oDADrqj/4PVUPA5HJGhLqyR64MKCMr9Y8svp2Gl4/6EoERpJKpBn0uDqo
         b57g==
X-Gm-Message-State: AOJu0YxmYgnjEfxxA/JW6inQouKUgbA2dtT005ogDB9scm0Bl9j4iLCW
	dWlpmJccJlqaaWVb4WxJSpAD0DrB2SVjsGLdRfAiRlJT7g6hIqk/VF2d
X-Gm-Gg: AY/fxX40xLhZQ/pHFMB6KPvr2HnkPhucKIxU+HLQtv/jOluEpHpJCwwruoYNq3Vo/7f
	MaLPVgewLstoYDtw3SdvlBLMEfi64wH8G4yrIFxYWgIYB+nkh4i3O6smeeXWp6pFvUJ/KxLutFh
	nCpE0KfzcuAVZ5LEqnAttejU/98IVIkGseTLLt6lKJ12OXezVjOUFr7RVbe5GXWZZmxkjH62xTo
	t7/Ejnu3oai4Mo0FE7fh3AYpiDYu2n37uCzFDvLNOfH/2yDOUy/6o4V/eJmwv5SOaGIr/VjFWef
	dKeBUsEoIPw4Qlu14sQB9rAJWE4/h0o6qU660v48T40HUXF9lH1TwOBLfoaSTncih5TV506rreX
	yJ2CaB1cIcevJId4UDXVQcR/qthNoZZMgOEoz9GF8BkKSZ1MoRBRLtz8z1ddiLCcIKHqXknykDg
	Z6R7NDaROuNyVRgnbNmY6OEp1ZH0Q=
X-Google-Smtp-Source: AGHT+IEJLrxF4ZhjOxvjryGu5iXxEkpqiLi9xidSHfaDTvccGpMAdBouCofvvVm8bTWQArd3I3G9Tg==
X-Received: by 2002:a5d:5550:0:b0:42f:b683:b3bf with SMTP id ffacd0b85a97d-42fb683b57amr765197f8f.19.1765529218779;
        Fri, 12 Dec 2025 00:46:58 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:9f18:aff4:897a:cb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm10456076f8f.0.2025.12.12.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:46:58 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	geert+renesas@glider.be,
	ben.dooks@codethink.co.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	rafael.beims@toradex.com
Subject: [PATCH net-next v1 0/3] Convert Micrel bindings to YAML, add keep-preamble-before-sfd
Date: Fri, 12 Dec 2025 09:46:15 +0100
Message-ID: <20251212084657.29239-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Micrel Ethernet PHY device tree bindings to
YAML format. After the conversion, a new property is added that allows
to keep the preamble bytes before the start frame delimiter (SFD). This
helps to work around some issues with the EQOS Ethernet Controller used
on the i.MX8MP which would otherwise not receive frames from the PHY in
10MBit/s mode. The full description of the issue can be found in the
patch messages adding the new property.

Andrew Lunn I added you and myself as a maintainer to the micrel.yaml
file. Please let me know if you do not agree and if I should change
that.

Stefan Eichenberger (3):
  dt-bindings: net: micrel: Convert to YAML schema
  dt-bindings: net: micrel: Add keep-preamble-before-sfd
  net: phy: micrel: Add keep-preamble-before-sfd property

 .../bindings/net/micrel-ksz90x1.txt           | 228 --------
 .../devicetree/bindings/net/micrel.txt        |  57 --
 .../devicetree/bindings/net/micrel.yaml       | 540 ++++++++++++++++++
 drivers/net/phy/micrel.c                      |  29 +
 4 files changed, 569 insertions(+), 285 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

-- 
2.51.0


