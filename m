Return-Path: <netdev+bounces-215166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C44B2D538
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7891BC708E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFE2D6E4E;
	Wed, 20 Aug 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZuZap0J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3772C11D2;
	Wed, 20 Aug 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676512; cv=none; b=AZhraoF4Y1Kam9uJcCcPYjaXUl8Fu/ZI3+PZ/aYnNXDrcsWc1ExGX8mKIYCLqSXV3/fyQkJ43Ja3MsfC3mrltjVP26778byivYQfXmX3vNoKodfwdZwWZimT9nT8Qi+v4LZ48EGqeL4ztdyJp/UvfETKzTi1mTQeI6ya27fz3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676512; c=relaxed/simple;
	bh=VdwHp1cVW3JJbMGk3GTN4Wjx33tASXxNmcasDDtBGbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLN5xbag+9XlB7ksMzPhnsv661wE1Z4DS3d3bXOj70BjdP7MX5UdO6XEjMvnNcXY0ij1TVfqbMDPkgfmdpcPR4h94Yi+Jx4Eis3meiQ84E0Bp+IPmhFFH8Wn1ATDExCkalvJCdHwGQbsgW87WXJF2JEa4WpDarPL9WifhZiWROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZuZap0J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2455585b3a.1;
        Wed, 20 Aug 2025 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755676510; x=1756281310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QlqxA9yJwKQntXrevSHLQB085fz1+wBzdCPMXjOqo0=;
        b=ZZuZap0JxDWljnWc8eiPMjfkcKTJq5ybFawzTFlfAjI0wbo0KH2UtgFECHVRYVGRWP
         f/Hx9eRFYWpO1wSu7qHLuyaOJrBKfZpxGUj6/YWNXRM450h+RSYu9NhXyT1Ms75TcW5b
         S0BKGfGsDSzQf0eoHNzjwucJ6W6mzhv+A1YwVGGSoda/AP7lY0LRMSvAjtWtjcDhkzk4
         uaTrawS82JphxCd4z/s930pHFOS9CqsZ5amgD5hzD7BI3KTNpnn57mOpBTWbxx1AJbVV
         HrQc78hNr7g618mtHg79PoqezognCPoxa7WOcOHkzZf6cUKsALWZ3rBnFa+C4DSQNm3Z
         s5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755676510; x=1756281310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QlqxA9yJwKQntXrevSHLQB085fz1+wBzdCPMXjOqo0=;
        b=lcIujXCUrV84aeA24fclwRkSVLEusCJI2RRqynSS04qIKw5/Iyaj8tWV6/vcl0Dyj4
         UIRIRkEI8pQqUMUIsii3HleL4KxDodU+dJGa+RbDqO5qMEVKE+jJxvIsA3DsJB/sLHs1
         TWrOliwjx5SKrWAkJDKIwp7i/OrMAaDDLMbrokqosiUA7RwqcYPFsDlPSQtVx5RpVjC8
         JB/Ggdb8U5XDPfWIJENqcmAOm/X0ZyERa6231zQxyaYZvPkOAIe9wcyw6XAiaKTnvCA3
         P8E0pUlTCdl3hUAYQEP1mn1EDkbH9wyRKwT64ouPU2ysH/je32r3LmCdyEhMIPSzCd5E
         yxkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd+KgohMXVw+7W/sHTm5ncPuoeVfhyIvIrX/xlm/OPhX7jcnl/w6HZzyDwoJvy/jAAINAjs/UcT4V0j443@vger.kernel.org, AJvYcCXp7/Kq5EqC5x/Q7I+fW+MnKx/75AoON+usJlZ+yct9kEGgPG87mpUoPEby/u6J4cLMwraELh3LgpjR@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVp1A8qclgwulOxkY1IWYnpi8mDoEDBgwYmB+6QuoaAd9qeIy
	w0Tt5QX3qvt6XpPCNtOGpDZJyv7B4wTSSECR7Q1kaODaCr5L3gtjFpp0VCKFe8KX
X-Gm-Gg: ASbGncvt1pp0PEDdHmd5CuBHYnu2ZjPPJm4cW7HRqUMmEPyZREuhIqI1uV9fDPrepq6
	qa62Vwpv3b1WF32y0vtinJ/h59UUb0m92zQa9QGuR4/fI6GViau9kQpg0A5Ywd3G/AN+0LAqLSl
	02OlYdEhWUI+w8rVN8BZ7fXMgajSpUHb+Vq0uHdWO+Uqis2SpXSMwjE3hhmPFvmFbeW2wXg+KCz
	LkZuMVWiVhw9/WhJulCYyJe0OdaNCQntHjcIUKRa3WXW++Fqgl8Cb9BXGYgAc0j8j8tHYfklzcg
	5VFmkPrlKnV64ucsNWMnat8KShzhkmpkFPiKuisMsDLn4zrT8O16agKRTdV/EwsDYhtqgIxLubN
	70UUBKwHxYAglOGjEWn0y2u5fnuo3bA==
X-Google-Smtp-Source: AGHT+IFQSy73ADA0FxknrDmL8iS2pZVf4I3yv6kLCooF68iRno7GVZ7Nw9Vbqv6tf2mUtaJgNVDMyg==
X-Received: by 2002:a05:6a00:440d:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-76e99fcdd21mr342750b3a.3.1755676509800;
        Wed, 20 Aug 2025 00:55:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d137344sm4605225b3a.42.2025.08.20.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 00:55:09 -0700 (PDT)
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
Subject: [net-next v5 0/3] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Wed, 20 Aug 2025 15:54:13 +0800
Message-ID: <20250820075420.1601068-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/yt921x.c                      | 3584 +++++++++++++++++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  126 +
 8 files changed, 3877 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.50.1


