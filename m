Return-Path: <netdev+bounces-242279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B8C8E46C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78C9634ED47
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5A3314C8;
	Thu, 27 Nov 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgI5uJi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C92330B1F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246928; cv=none; b=DiI4mAu/jJD8G9BGRIxaW+zpDqj/4uqJQwZqvpUO+KqlkBZTeskXaZJx8uAXF72Wch+dkHyHdBIkJIuzopLb19QL/IitEinkM0CumPSJBYsMUukUzP/642HLdJkatY9JNfISg8bWuBOAKekqgRReOUbbMcCR2GRy3k3feMGMp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246928; c=relaxed/simple;
	bh=oFQAQr+guZ9WJ+rPsOs//O0mt8Vcr7rWKA2Syf0mx9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFeZw2PpHsWddFr/4wVVbe0vayQmWDkNR786NNC4eDq2HquYcrwlbhihVdFITIr13VcVI9zoXxrZN7hhOEdRLRvpjLh4+bVNDID2bP/ZBWx4VfNI8XhSru0D0P15CD3mFu67OpifR92HVP1PZzgpcAt/hBsxBlUMwegw9LHCKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgI5uJi8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42bb288c17bso533144f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246924; x=1764851724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFSE3qlztEPFHXYaOuOeoAXc9urd+2kpsmMnNVBXBIY=;
        b=DgI5uJi8mDO0s30xCTNoW0wr7MfhR8DFn/P+x+AyQ42JU/7maTK3xh711KS6RdAc4K
         0AJUZz3YBa9U1zW9UKgxeT8aPnkGP7R2H1OTC63ne5jLpR6YBZnmw9aF26RQGCGZSDea
         4Ah2+68WCuSNOGBLJ/jJySCMR6qb4As/TxL2LV/fhbB0QJm1gU48/ACa8IpQ2otsC5UN
         QUtkkPIOBvFmjpLqPO1br1kN7stutm+eOei7oUjQODABkwXoMxX4gEzmJPJzBstMH0sx
         ZMTq3nQYBZ2tNdWLgDWUOQQsSs7gwZfHfv2Z/EFbxEULIWODGLXAHPZxVnUZx8wnmJ4T
         T20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246924; x=1764851724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFSE3qlztEPFHXYaOuOeoAXc9urd+2kpsmMnNVBXBIY=;
        b=U7qfUBbUu3sJEkGDefgRAGNUy61O9o0BitqYlLy4wyxE6UR/aNdzDEApXXGX0F2uVw
         rhopvavS2/v4VF9sSAz0ZspGA2h39jNYVA+sPxeoL1Os7Nxw2BVkG1PvgvxHbAgzlZSv
         keUV/GhvzcSwLY/iPXO8fqyfGhEqehAB73e31WRSMPKm6gXlz5HxveAnnoY5RXx7xLXy
         DstHkG9n/fzWw1w4NCH5aGPOLRrYncDmpqSRPOnXdEo6F1xKump6XSFMCt730HiiXXdb
         584JltTkWOzKxw6V5Uu6NmOnLGp/gW+MACyIxrJSd/hvd7JWWIQIvx0TdWL+97MYpQ3o
         bhmA==
X-Forwarded-Encrypted: i=1; AJvYcCVuyipJMdZHBFp2B/9o0SFqmMW//3jfzAu3JmDMqlr8tu09sdZSaEgrwFoBcWgfZfl/U65CpuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEonwxI2RuAB8Lbrx+Q31HPcAwxCzmEAl9Pe3O/u3vGhCYfVKi
	z74drVgjXMpfwuRv5whcH2/CtekMnz6ZX/mP9Ky8g81mI646zm61cYo0
X-Gm-Gg: ASbGncvvzf7ocui/nahZsyCoA3Bjdu43vNF6BaBFYoAkhypZDbUZi654k/CBQa5IIVZ
	vbigLbf3S3j5NH33cTzkngnRxmB1G0qNRd1l+o96ijditZzn/zyoGNvDgjJ2V0nD8jpxSk4A54l
	WnPaduzLEbG6MWN6JhFxiBK6uWEH1bSd1i5zz6UYffQXO6gZtwx7K/uT10ELvbXmzmvsGIjZ9sD
	edmH/mMtYAOx7YLFv30xST59D8BXiqkjYEjhnCp41RGs5AEBBVS0/BjV8lJv310ZcIDdKxxXMoC
	0TvvnlKEYww+tVv+tJc8ph0L6Q1F5Ruedper9tDfB0gkGU9m5rMhHnN/R/gFhzz5cx42wDZLR9f
	FywIJ0BsH92A6D0C2U9oxojTgIxbibnwkfle/EmHehB+/N4gEhl0304x7/5T5B46etiLr26Bg1J
	2hcfvRAR/khllSv673oj2FxAzvJg==
X-Google-Smtp-Source: AGHT+IF0emZFKM88VnuIpz692MetuXeb4OfphPqaHgKp0/MlOrsZDvpjdLEm1OuF2Fi4dfspC2YQiQ==
X-Received: by 2002:a5d:5f44:0:b0:42b:3701:c4c6 with SMTP id ffacd0b85a97d-42cc1cf3c16mr26202368f8f.38.1764246924278;
        Thu, 27 Nov 2025 04:35:24 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7864:d69:c1a:dad8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm3220718f8f.29.2025.11.27.04.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:35:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Florian Westphal <fw@strlen.de>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/4] tools: ynl: add schema checking
Date: Thu, 27 Nov 2025 12:34:58 +0000
Message-ID: <20251127123502.89142-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add schema checking and yaml linting for the YNL specs.

Patch 1 adds a schema_check make target using a pyynl --validate option
Patch 2 adds a lint make target using yamllint
Patches 3,4 fix issues reported by make -C tools/net/ynl lint schema_check

Donald Hunter (4):
  tools: ynl: add schema checking
  tools: ynl: add a lint makefile target
  ynl: fix a yamllint warning in ethtool spec
  ynl: fix schema check errors

 Documentation/netlink/specs/conntrack.yaml |  2 +-
 Documentation/netlink/specs/ethtool.yaml   |  2 +-
 Documentation/netlink/specs/nftables.yaml  |  2 +-
 tools/net/ynl/Makefile                     | 22 +++++++++++++++++++++-
 tools/net/ynl/pyynl/cli.py                 | 21 ++++++++++++++++-----
 5 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.51.1


