Return-Path: <netdev+bounces-220461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B7B4620C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B407A2C5F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027430596C;
	Fri,  5 Sep 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt7AQhRO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE0305943;
	Fri,  5 Sep 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096269; cv=none; b=SBWncjKw/OOKGC3yylBxOnYFtBpMsPs+kWcDwxSCfuk4DWLkS+5lxQNRlzQsopsvF460Cwy9KE4Ob1DViiFCpWrag8TJV16ZW5u6u7oSKbMJDf+M55zru0EvGk8HljcYwjhtAhRqHca7qkNgUsKeJCsT/Wp2XlmRKLMexwKlOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096269; c=relaxed/simple;
	bh=k7lXW7TayfxntnRHFt7x7CGs+qTM3EkXOZ8t/uPQKeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLeEIal1z5J8AmKYsPfiiRuIy8KXqbY+uCqGLbZrSS4/30cAQXJiomjtpE76c44Cn33o31YnQZBl/8THG3QplmC4RBK6hV0Z5njaFxFuyX8xHGUhGxyNZ/iT+i+VzHZYumaCQzFvS6RNd6kABA8jFN6oBwPHYqdX2MmZ00+Vths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt7AQhRO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-327771edfbbso2360663a91.0;
        Fri, 05 Sep 2025 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757096267; x=1757701067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXzNAc0/jy/V/ldR3DTWdqE1luwlUpOmaeSaBFZiJ5g=;
        b=Wt7AQhRODFBmRQqIYbKstyDcIXdkGGgBjZnYX+Z+2L6iD61MHnQ1Jk+9feWYPJCZ+t
         zRyUHpIyjhGbPQs5gGYsZcGJvL5m0lGVXUoWTZrXYdw7+xI9ghyxGmygn+mgpSqlwby3
         j5LrbJsViZCCvMHjMoEioGe+pDfAxvlJ9ZulBfyYFcmoyPUbV/WwiHB6oJyeOJAeR7uo
         YZEd2tIgGfiORIDl9wZFW+9jHo88iypkSFdRqQcTg7hhnp1y5LisHikcGsL0G6SDacqV
         XGA7NjMemLzJCaDEILhZI9KlGj0ODBelQ1n+U5vHJXUfVvKCpEfHu/Ta3BroFHcSTE1r
         tVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096267; x=1757701067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXzNAc0/jy/V/ldR3DTWdqE1luwlUpOmaeSaBFZiJ5g=;
        b=BARPxsRd4aABcWstCJ2jFIAO09oQ14JLnA7sSWnXZRzKUyCCbPtZz5DVjYT/IoSW8D
         CKhZ4aCfzPIw/3ANFBcmLODmUpiAsc73YBShdrsmGa6aRYemj+BhHSQ5q5b4M7coULJ7
         R7maXjlVg2aq4XVV3lTb8KjH4etjKfQ0u1XyXI35RrCmwBnCt5tRzj/vpezphw/LrjJi
         RBy/Q2/mXNxNi+0smfn7r0G2LotOf8+/ulUNPuV3Gv9CHJSQrVBShzPcSbX7yxho0gSv
         2fY9w3bk95ZGL7vX34pg4DD6i4bprlOSSc9fwOo8Vuhb13wv5ysEaSDxVHLrIaEupn6I
         xfNA==
X-Forwarded-Encrypted: i=1; AJvYcCUnXYcEfeAyTQ2MDjF7//MpCKXe+boCpCxjEADG456VgUh779muGURNZSdTapt8y4mXVUhQBIw6vv8CT2Tr@vger.kernel.org, AJvYcCWk4hNbdqzJa227GcvlPHriNKrENQ0MWNR8PQhnPxSqD5+aN9K/3d0Gwdf+UlRAN5qWX4gXwr7CzA+r@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4QGVMXP3X3B9IJWi8KtG6evszDxtNKbBbcLOVs+f+DgSev/B
	WC0iKtFO+mmBku4I/3cRiyopzdiec57faH1+fGaIDpkqYMxP7QOC+upCdyAsn9NVO4Y=
X-Gm-Gg: ASbGncuOi0jYAtKoh0mgWC5NU81O5POP1YOYGC6BO24hLwpUxGNom+1u5xZuDa+IS2Q
	Exb/VHGAHlzg0eDv95Ds0saExye8nExO1G7UwLkUgoe4yUXa9Vriq+Wyla+UNuMjH1DTjN7OMWF
	g3SLOwV865n5a635y4Wv3Oi7xX+yxPHPCrknXUuafcn+dxFr7r4zoaaFyet+zoEQyzcSvQDdOew
	ODTGY9bn7JDnQfU7pmBa0xfO28ATm2DGsJp6nSBNxzK2c7VIYuCkdW6ac8HXwci4bhcW7/mbROM
	b+1ZcMy0uroIlMtDQE/TQ/Jpbp2kqKLjINV74V3kbqCGMp74uyfD8TrbY5wkX0LxlvMzs3bWPyV
	+KDr/oos2YelvYYD+kfe/mPzrG92rsPiXCpQkKxM2
X-Google-Smtp-Source: AGHT+IEACK8rz1Fe0a5meBBccK0SV+oq5qfkdHIQ+lcCMl5P4hFxCVJI6Yi0qv36Ucur9MqW/9W5PA==
X-Received: by 2002:a17:90b:57ed:b0:32b:dbf1:31b7 with SMTP id 98e67ed59e1d1-32bdbf1353fmr2761011a91.2.1757096266713;
        Fri, 05 Sep 2025 11:17:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3282dd2sm19964031a12.44.2025.09.05.11.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:17:46 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Sat,  6 Sep 2025 02:17:20 +0800
Message-ID: <20250905181728.3169479-1-mmyangfl@gmail.com>
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

v6: https://lore.kernel.org/r/20250824005116.2434998-1-mmyangfl@gmail.com
  - handle unforwarded packets in tag driver
  - move register and struct definitions to header file
  - rework register abstraction and implement a driver lock
  - implement *_stats and use a periodic work to fetch MIB
  - remove EEPROM dump
  - remove sysfs attr and other debug leftovers
  - remove ds->user_mii_bus assignment
  - run selftests and fix any errors found
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

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  169 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 3004 +++++++++++++++++
 drivers/net/dsa/yt921x.h                      |  593 ++++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  138 +
 10 files changed, 3922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.50.1


