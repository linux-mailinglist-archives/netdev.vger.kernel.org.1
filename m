Return-Path: <netdev+bounces-214259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88AB28AA5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81421C84DE2
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D31DF261;
	Sat, 16 Aug 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL3XInNl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DF1862A;
	Sat, 16 Aug 2025 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321988; cv=none; b=og3pq9Ax6uX+I9+4KYqnaaMrJd93ziBFXzoAwM3KSXJIUiBCekWZbL1CFu3qQqd3G/uSSrSYzEpRFydPduYBI6/XQYknB3Aytmo/wy4pdlMRoqns7zQ5/emL5b0d+IN/xeW9FJH9Gwqbh8WaLqfJ05ylppDLd1HIAwSeYBoTdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321988; c=relaxed/simple;
	bh=nVjqhG9sbPi0wuuSS6+4rvv16FUq7s90IVK1VJVy9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi3oBi1yRWj98ND4L27oDJp3Zjwijz4JVu0xkcbuygvm9MO1vkUyfSOorLzNlL8QszmdavaNqr5TyI+MU4sHJF14MBQGtGuWhEOOzMvEMQ23hLOzlbKXOltpxI75QNIJyLj4YW/usoMvbbmKR7/k1pJgwQLnzmqijXhG8IntE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL3XInNl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47174c3817so1910269a12.2;
        Fri, 15 Aug 2025 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755321986; x=1755926786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfYWh65R6C5URO0NO9DTk8nFnnyazeHWWO/jHTbMAPo=;
        b=IL3XInNl8wepyuIQaawz7FIQn29IrodX3/X6UVP6R/80pcJcBWBHFV8enB7FwY17j2
         wdtEtgyjasTMQTOiuVHo5F6rW5edTe7zYHK+FyVoIWXhqJDg7F2teyrcqO55BBfY5IFO
         RG6FD6bHz8MRcm6DsPfWp47y9pl3qcn+1C6E/4eqIQ0zZ/KD1pXQbrgRsJcoAKBo5wTk
         RgpIcHvZiU1LXteoVMR5VY4BkwXC2uGVq8SxsmgspfgFaBkgm+pKmZ8ERZENFQ7ALYum
         m9TVzrGR1iGnvivASN9t9lGNpQQFg9sJgwIY6wZ3i4z1xJGjfoTq48Z4OuNT/sUAnXNS
         jOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755321986; x=1755926786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfYWh65R6C5URO0NO9DTk8nFnnyazeHWWO/jHTbMAPo=;
        b=o14T3HLLvIk2gKNy9uANFGYsfM6aVnm6kOQ76Kl4MxT+qqCHpGVJk5sge6y81GOcPI
         5zXDExMX0uq3wb+pKVHsPNkNnDwXswO+8Gj8nLczAEhsVCyRNPe9M7OA0tCV0IwIfIBy
         X/R2wjwn49t0cXHjsjab7oIczoWVjlHoEd8G/vKMBFfiwiQZaj2qxg9nrOQuDRI55nv2
         mtbPMP/rgNPzidgNsVEoPgFZGxMNvtynw6k0XMCLlOoNIuXtNZPqn5iOLKX5CW2126B3
         t1b46h3RPCMvx+gGGRBzHtZ3JgUbp9uTUVpx6/pRTeRa06U4XbPnivt7/4J/8mZL7EiU
         I3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVAMn+CfXbimu+QrdSEXrO2zx/5/Igil367hzpOsgzJrbY4qZAvbFBNEulW2Wm4ClirYbQa08W4vk1u@vger.kernel.org, AJvYcCXD3Yd39T8Pcr18snEDwWW5jgHa6mkGZJd6VdvuqriOBanaHvPsZLWjLDGP5tDeQIPPqBNoYyb5j6xk1EwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05APa2MCluLGAQm8hy+x+VXaj4B3hBa4/R3GFCkVaCe4Zb2Oe
	KgWb2KAUcOgZp8pbmtHIczZkXbazCN1XiA8imbhocdnKvUOTX3AzrtESjvqEsfR1kZBU2g==
X-Gm-Gg: ASbGnctWlZ3li0HBklAHDB6Kg6eioWfJngo7DKkgGtoXTtssrlYyBlWNVJWwjPC5p8T
	HtmCIajXeKs/OjKcEJYJWBhHLwN2LANnU0BLfFo6IZZEovi93NUO2VCxWp+0N1dhXXqkGmwR6Ot
	Q6bSVXgoiaL1vuOAbw6GpFjz7eH2WhPxaYqoJga/meV1SW0bENJAZWheqfMecSSsnsPCPnZBlIx
	GhK/DeUQmgR1AlzwV6kYL6Gw89pLdWd+6Nm9uGE/AGO6lli+JJfw0XwsobmxvMHYA6ZZA+6pcsv
	8r4Uy9fgX4O9Pm9irkdvAufXpH4oqHBfoguhp8R+ALHoLhuuhFbQNEeUntBn1FYSwfJcHtsmADz
	xi8xdGJhTy477Pqwan4Bae0S47DnUiQ==
X-Google-Smtp-Source: AGHT+IGeDOSO0voCJeRuqzmLYix6G+3EdF64VR5GERchsW16sjMcRRjfTUF7mFkmG9sK9raG14dzBQ==
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-2446d745130mr71210345ad.22.1755321986160;
        Fri, 15 Aug 2025 22:26:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d016sm27225805ad.35.2025.08.15.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 22:26:25 -0700 (PDT)
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
Subject: [net-next v3 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Sat, 16 Aug 2025 13:23:18 +0800
Message-ID: <20250816052323.360788-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
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

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  166 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 3960 +++++++++++++++++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  126 +
 8 files changed, 4269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.47.2


