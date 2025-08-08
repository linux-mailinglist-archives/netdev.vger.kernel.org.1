Return-Path: <netdev+bounces-212260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD69B1EDE6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96766188B135
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE71B394F;
	Fri,  8 Aug 2025 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpQawy1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4581DED42;
	Fri,  8 Aug 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674893; cv=none; b=TojbIW73C5xm+usUuVQxmiGkJi3lNcrTlMa3RjGmxUMunMyth3d02n4eiezzBIw8z3ArpYicPXnL8jh1oZYTqaPnK7S5ZoahWiinqvbB4AamlZTVj5FBQjxm4UNn6MzFtgcJKYZ9xr88HczoigFeQwEQiQNJCeLDM0G1bV4JQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674893; c=relaxed/simple;
	bh=hsINl+4v4aRuuwnMtF7+lm5+v9ngMnqF3tUz2rgqZ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhEuzlpU6DPjKhTS3ZNKfT2hunh+ISbl3jVOEszC22qMbzCw0Dr/0Sm2oQqd6sd3q8SgmcPb/k567jih8WgiycPqwijUxQF5E7k0MmKeMHcpolyJIP1MHCVeqF+KuRjwMlrloFXZolyOvoax5JgazR2NaN/9tN84XqExoQeK7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpQawy1Z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so2708296b3a.2;
        Fri, 08 Aug 2025 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754674891; x=1755279691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OXvgZ3ldfhwLT3iaAlad+viQpH+0pL7nvqeNZCv/cA=;
        b=UpQawy1ZQP5evlBY+CdVHiYjgs8lriHsVs+xAXwrIbKM+MQW9Jaqq9fjeacHkR5BfB
         rV/FilXM85/8fo0cYsMJYONB4PDdDl3RSHU8F6NXwERBmqfoU8B5O8U1V+3CYa397wmX
         6wKfVFjhdvUfC1uwWa4Dlgzrbr/GoAqTNx2gK8935EGNAmBnr8RIqHPfpKmdJuGYMC9g
         ZmRUjfdxwM2DfDC9YSm04gUraxMV8CyAooAE9O6e50nkbdEUvnIKpJvFrbmKpWZXk4o+
         xN2lVBXs+jCo999x53NBAA/fsx3UeKd5icm5jqb3HcajRGcHWUQEjxaHH4crWR19Pgnz
         8szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754674891; x=1755279691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OXvgZ3ldfhwLT3iaAlad+viQpH+0pL7nvqeNZCv/cA=;
        b=ApTpDF412pdGumAXbwq6qQnDwnELIEiyQkYEQxcziOPYUkpFja0dC5dacEqAvukpLS
         uUXDpWbQUuK+wJe8hGGfMRR7sMAk/hvm+9FAO6bH4J1T+8lo758lZ2YrNn0Av43EItLN
         24slZExSdoZKGm3Gy5plhNyEP3NQDf8rtmTVEnA2uGLuoetwVVx8+QyfKgQG43rBeoMR
         Hs45VpAULXfS1HzaH8nZL1ap31PT7V8gK33dYiRvoxTmvpwLRkw7yUVuunpSjh4fyhRy
         Mb1q6zS8Jq5SGdCEIMCIcUPPtIfMTYfnSFJEX839IdlhygUrKUZ1JMWHclLZRfSeg9Gj
         Hl6A==
X-Forwarded-Encrypted: i=1; AJvYcCUZDGF6rowycbVntEfnkF5ZmotVOvF/0Tdf+sb2TushhPEoBy6QLU+56qId83sOMGsqBHaCzVilrR21fZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX9yNfspqzEIMDcKVRqgnAqg3EaCdsx7aIq0PhRutgrVVkKGk
	yF1yGSn0ZjQoVGD5QGl017+y6+fYtU6Kzy+MvMpmEgbARteC5e/baxL5gWE56mKFSNQ=
X-Gm-Gg: ASbGncucjnaurF7zyKp6Lh0YBmaQIoPCsKVVjBwJwpLnACfxMpuzZ+df0lpKX8LC6OL
	qrZjkVDZB4LSaELXkvAAOXFbk/pyjZ2ElB3Mj8LD0EdmnTDUx6fjgPFb99wbpvUAI3whC1dpORo
	e4/IHfFt2nNO8ckDlw2cFYg1Eqx073ngqastTRpzqFw8hWyS9aQCDxQt5WGXy0fx7jl6Oru3WS1
	OKkPqcUvYKFwltC6pFtd6ZPyfUwERqSKGpODynKNOjgU5IGtY0FS7f9WW3lacRlO3F/r+jtqekN
	8nGsn4/WbglVU8hgUTFQxMKY9HxYKkBcUvRAG1arhcglw0/3L5cNvny+X2AlDwM+pjL92/rmr6R
	1SQUF/ugbZozjSs08fkpEhn0ezwrEtA==
X-Google-Smtp-Source: AGHT+IEQuucx5ig5t7hJMZjSB7Dmsv1FfUr9yevl3VS/T66x+ks6l6dkfNi/rIhfWqbP54gjCwE+wQ==
X-Received: by 2002:a17:903:2f4b:b0:240:6e54:3cd1 with SMTP id d9443c01a7336-242c1ff42e6mr65276025ad.1.1754674891446;
        Fri, 08 Aug 2025 10:41:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975a66sm214174165ad.95.2025.08.08.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:41:30 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Sat,  9 Aug 2025 01:38:01 +0800
Message-ID: <20250808173808.273774-1-mmyangfl@gmail.com>
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

This patch adds basic support for a working DSA switch, but not
including any possible offloading capabilities.

David Yang (2):
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x

 drivers/net/dsa/Kconfig  |    7 +
 drivers/net/dsa/Makefile |    1 +
 drivers/net/dsa/yt921x.c | 1895 ++++++++++++++++++++++++++++++++++++++
 include/net/dsa.h        |    2 +
 net/dsa/Kconfig          |    6 +
 net/dsa/Makefile         |    1 +
 net/dsa/tag_yt921x.c     |  116 +++
 7 files changed, 2028 insertions(+)
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 net/dsa/tag_yt921x.c

-- 
2.47.2


