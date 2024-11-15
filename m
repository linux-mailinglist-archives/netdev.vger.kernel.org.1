Return-Path: <netdev+bounces-145374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68F9CF4F7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210A0287670
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6DC1D9359;
	Fri, 15 Nov 2024 19:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A713D297;
	Fri, 15 Nov 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699411; cv=none; b=gz3nXhJaM5su3wbZS//8LejTfku1dnWkyy4mT70tnXxDdP1aaUKInLsG8/JykymZpJwtHPZjoQG5kUcLE6VvgkFv4zYgW6v/HwSKXWgebLUkU00G1WbZn/X8ZlX55iQkBaIvetWHwexMuj7vGUpYgbzsgEDYorOr14K7dqK2RhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699411; c=relaxed/simple;
	bh=GWO9EvCFHKHes9kjT7r9Blzu7x/VQUwb7EYAbbCGwBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlG0iVeSR6ibU6UktyOdbsUknK9WANVwZrz9KAETypiowntvDDjT1Zk9wwoqhj7xAgMZP4qNT+MeXq0maNraSkghUuTLF5D68C/w7+qdPIus3DFKn4uhbzw60IrXg5QMCjcDdPTmOUI6fTta8ctEuFMazB2L4ysoxl92/jr7/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7edb6879196so1615091a12.3;
        Fri, 15 Nov 2024 11:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699408; x=1732304208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8X6B+i25vOlZL/WSZpEG2HovtZ+TF0iu9VY1cHkCco=;
        b=JjFMgM35yOR/tUIwc75lpyv/Sqy0tW1RNbzoKtRQDPHeChyprARqmEw6WH5BqjjOdQ
         FEA7fAPAbWXYVdmnsmLF965swBcr13tm42Vh+8Ya8IoL2Y5SRFNxBSDH+MPWS2XQbTTw
         +41cWHqOa7RyRh/BC1GLkJST+izdyXbRTOne/A2e8vzTDKQilybL1X9mUbWAG0ynkb6u
         fIsCMiJAx2qNaR/N1FMUNu+9OBVqT0wrAV4p2bDqGZHjiTKkGo2kEHShX0p3IzMrt1+S
         PYwEJzWndVnBbwA6x12n6BVORZ8Z0y5LKRZanImEXnXq/eOWp4UTCeait8e5arQ2/XM/
         Pa4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDsN/3VtJSaQV6eABk6sWW0KG0+l/D45uViFjObqHuLBLvrDv5cVkCNKnWMN6Sth26jSXo1UCBsg9L8Kly@vger.kernel.org, AJvYcCXEjxmwAUlm7KIeYT0BK0D+7Bwjns2l30sdhT1iKoDCuv9wINGj9R+GzlFzeRyLCEwUMNHtaaVdufQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOX5b8cO3RqYEGf9RX+4ehnBFoKk6P8EiPvCAx6SlHCJ6f//Sw
	yz6KuKNSN0JP+lLdMgIZdR6bF6X6VZUMZ82I5bIBs78YMX3fOzhNk7KOErs=
X-Google-Smtp-Source: AGHT+IEap59/AUuU1n+cG2m+loJDjyXkMh7PwedNfZReu2kJx4PVylES4+gjN4ALQavgWcKE0d3kEA==
X-Received: by 2002:a05:6a21:328f:b0:1db:edc5:c960 with SMTP id adf61e73a8af0-1dc90b23fcfmr5048966637.12.1731699408027;
        Fri, 15 Nov 2024 11:36:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c62895sm1676108a12.41.2024.11.15.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:47 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net-next v2 0/8] ethtool: generate uapi header from the spec
Date: Fri, 15 Nov 2024 11:36:38 -0800
Message-ID: <20241115193646.1340825-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep expanding ethtool netlink api surface and this leads to
constantly playing catchup on the ynl spec side. There are a couple
of things that prevent us from fully converting to generating
the header from the spec (stats and cable tests), but we can
generate 95% of the header which is still better than maintaining
c header and spec separately. The series adds a couple of missing
features on the ynl-gen-c side and separates the parts
that we can generate into new ethtool_netlink_generated.h.

v2:
- attr-cnt-name -> enum-cnt-name (Jakub)
- add enum-cnt-name documentation (Jakub)
- __ETHTOOL_XXX_CNT -> __ethtool-xxx-cnt + c_upper (Jakub)
- keep and refine enum model check (Jakub)
- use 'header' presence as a signal to omit rendering instead of new
  'render' property (Jakub)
- new patch to reverse the order of header dependencies in xxx-user.h

Stanislav Fomichev (8):
  ynl: support enum-cnt-name attribute in legacy definitions
  ynl: skip rendering attributes with header property in uapi mode
  ynl: support directional specs in ynl-gen-c.py
  ynl: add missing pieces to ethtool spec to better match uapi header
  ynl: include uapi header after all dependencies
  ethtool: separate definitions that are gonna be generated
  ethtool: remove the comments that are not gonna be generated
  ethtool: regenerate uapi header from the spec

 Documentation/netlink/genetlink-c.yaml        |   3 +
 Documentation/netlink/genetlink-legacy.yaml   |   3 +
 Documentation/netlink/specs/ethtool.yaml      | 353 ++++++-
 .../userspace-api/netlink/c-code-gen.rst      |   4 +-
 MAINTAINERS                                   |   2 +-
 include/uapi/linux/ethtool_netlink.h          | 893 +-----------------
 .../uapi/linux/ethtool_netlink_generated.h    | 792 ++++++++++++++++
 tools/net/ynl/ynl-gen-c.py                    | 139 ++-
 8 files changed, 1249 insertions(+), 940 deletions(-)
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h

-- 
2.47.0


