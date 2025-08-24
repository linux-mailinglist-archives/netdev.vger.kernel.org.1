Return-Path: <netdev+bounces-216255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C419B32CC1
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 02:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57A27A223B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507278F51;
	Sun, 24 Aug 2025 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPcISu0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494546BF;
	Sun, 24 Aug 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755996813; cv=none; b=j+fJCj7MHAB2c7KQwPt1hKYlbNOWDC12aJ+2gGsIMWHQK35umpLNZmiVHGsLAr2/5DVwwLUsEWMZBATOlFPXqZjUl4r2CDQI4wg7xNetcaF1yEGvALXUI1CQV9iVoqW8hxqJzHU6DjNCzuK+vvILA/I9QxqmxNM8DXs6fK+jSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755996813; c=relaxed/simple;
	bh=BaGOU3IFJlVva5JiZ/lq1xm0BXzmWHIiJ31EHMDePr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3eQ+PK0RbXWXakjX6jDut57BN0KVz9j/+Ayr9peSf1/A3XE29Ka+UYy3M/WPpq8tvULrPXp9X1L+KUuozvjJGSNLWJnDmdfKsyk2phIo8qItfFfjKdOroyh+1DxkJ0ly8CUIX5o8k+quUXFHxAqs6VbaApOBQ1XPIkozKSEUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPcISu0I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e67c95so3569183a91.3;
        Sat, 23 Aug 2025 17:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755996811; x=1756601611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGl7ywJWnMLVhYcOhEEdPTWdvtBYoj0FI5EpbNpy2oY=;
        b=YPcISu0Icfmb1NHWMgZL34SuhuGeN7R38SpgY6e+KPQ1/GeuqyP8S6YZZdFXruujyD
         pvBbIaBKxHQJMuopIcxiPLOOZu8MP41DMwCyB+jbAOOWq6uy26GQ+qAsQ5RfUf67QDwK
         OegDskXPB4HY9nTb8lbvq+SYFd6ewlQuWGTtY/kCrammj3GoD3sVmzh+qlEOWSiwsehO
         xPwGYb7FRu84vnQ2UooOu9y7h7Tppg8oZn2LVgZTFIs0DVh9RUzxdsOVlBwfmoyevXpV
         vGg5onYjuARw1iP7TxFZcQi/fB4nt710hnVh/FsHY9WzDaHEHXVFU47hsU5pz3HadTgd
         EZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755996811; x=1756601611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGl7ywJWnMLVhYcOhEEdPTWdvtBYoj0FI5EpbNpy2oY=;
        b=rXUGCu9jtjZYrIx9GURl2vQUpipA3B+599FevuFcQUeotpRyI2tfer7yMMIil5WAwX
         7hXNdZ8O8wW51gTfa14hDrU+9xT0SGB3wW5+TeS2HvfSM4gzjiavyD38SGvF2aZ6zznE
         1lRdNXpC+0ET2YlLBT8Cz9jj/3jLrPovdX9r8KtG9Pm9z+efjhXepWpOQsIA2YcxUftC
         ikVv96WI2X4HWVg3C6GsG6P4p4YfDsKxrcSsT78fxIGKp7u0RZ95dPPoC+63aR7ULrb9
         UCM44KkF8edwBCorULx6VFI4VBvkAunS74j0J4uKSfLd0y2+Ps4VkM971QDfw5lp1kVC
         8cqw==
X-Forwarded-Encrypted: i=1; AJvYcCVemORevWXt7Zrw+2SgK1XXapYK9pQc+SA8DlEIUXf4tEVzO1W1bAD4NBygcGMK38EqGTP64AtG3RMP@vger.kernel.org, AJvYcCVw/mxlgpgUOg5ft48bVpq1D+QBb1xqJw1xiJkjCxbOdgYVe1QpLMZ7hLcOeskINCsDD4iDbPa/mg27dT3m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3jSSde16UwORZ3o/BsJkvZ3T/QYYRrNE5+P9hl1RhUQVI9bQ
	Iga1Qp4IRKN8nk/osfSOUl8TZd/ISeHT3RTbuYUgyY3u5iUyotsgPZ9ymwOFgQQ9
X-Gm-Gg: ASbGnctB2NugQYibDsfX+JJleuL3mBsHtbSJy8duUuu2vKphXxG9tO/Hsc0f8VmP7Uv
	aQZ2SfHcE40qJq0ijbCDfiMU0wfeLsHNtTjeWkoVZ95p7Vmdco1dNEfrOrJVL/Z6Yk5aMyb++i6
	NVfUa8R5yWTH4/lCZVkBNlv2i+syntrcr2JzQ8545zHUw7BkvxpmlTX1qK0OOKVkYe8v5MZc9u1
	VW3wYpMION6aiTUF0D+tclUij0XaSKxNVb7VpThE/aEoeMTCJ6As0vvEUJJ6voxxfESlqblhTtS
	DoWX7ESTsRcv7GZAlzIlQygHe9nHL6hWBqG6j8ONuTkML1wT62UUznXH6QEQi3nru7l3sItjGY5
	eCwq28V3v4IylhD6LeFtD3KqvNCNUDQ==
X-Google-Smtp-Source: AGHT+IFf4Eg5Ex9fCRm8LSQY3U8PsuF4uwMY8YffYbjYFIF6TDtBuxsS9p/B4iBVXNytFK7cee7xQg==
X-Received: by 2002:a17:90b:1016:b0:324:e6ea:f90f with SMTP id 98e67ed59e1d1-32515e4123bmr8263940a91.9.1755996810743;
        Sat, 23 Aug 2025 17:53:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.247.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c38asm3172485a91.17.2025.08.23.17.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 17:53:30 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
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
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Sun, 24 Aug 2025 08:51:08 +0800
Message-ID: <20250824005116.2434998-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT921x is a series of ethernet switches developed by Shanghai
Motorcomm Electronic Technology, including:

  - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
  - YT9213NB / YT9214NB: 2 GbE phys
  - YT9218N / YT9218MB: 8 GbE phys

and up to 2 serdes interfaces.

This patch adds basic support for a working DSA switch.

v5: https://lore.kernel.org/r/20250820075420.1601068-1-mmyangfl@gmail.com
  - use enum for reg in dt binding
  - fix phylink_mac_ops in the driver
  - fix coding style
v4: https://lore.kernel.org/r/20250818162445.1317670-1-mmyangfl@gmail.com
  - remove switchid from dt binding
  - remove hsr from tag driver
  - use ratelimited log in tag driver
v3: https://lore.kernel.org/r/20250816052323.360788-1-mmyangfl@gmail.com
  - fix words and warnings in dt binding
  - remove unnecessary dev_warn_ratelimited and u64_from_u32
  - remove lag and mst
  - check for mdio results and fix a unlocked write in conduit_state_change
v2: https://lore.kernel.org/r/20250814065032.3766988-1-mmyangfl@gmail.com
  - fix words in dt binding
  - add support for lag and mst
v1: https://lore.kernel.org/r/20250808173808.273774-1-mmyangfl@gmail.com
  - fix coding style
  - add dt binding
  - add support for fdb, vlan and bridge

David Yang (3):
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  150 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 3596 +++++++++++++++++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  126 +
 8 files changed, 3889 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.50.1


