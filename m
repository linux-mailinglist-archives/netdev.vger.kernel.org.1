Return-Path: <netdev+bounces-248069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB2D02CD0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94E0E300929D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAE47A53B;
	Thu,  8 Jan 2026 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQjlJSh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8126472010
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876734; cv=none; b=dkb4/i9Hj5CUhLgajapD1VXXacnRXsA6U9RLwY+N4MGxh3wroYFkB2pxr50ciHG3CxZZxYCEXTMaTmmIuBwBRQCsGky8kxciyDyQ9YM4i1kiIvKdJvS9xOdpu0UV+KQAXLXhVEPtdsnuM+M5Q9oWG5+QFOSU1SuoBNZJ8k9z7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876734; c=relaxed/simple;
	bh=BNEfp4cAiOZAgWM/hLJqzjpC8TrLVyoCEd71vX8euV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9xXOGRWSx4sPS5azjlJjFhfjot+yOVZdjgTksBFUpcXDkjl+5lP2J+oWkEe9jqbP1SIDCLLQ4jr5Q9Zd6DPhr/hco0HZZCLgnwzCaN6auwB4+oLGaq7rm+Q2qg1Dy6UOU0kfFqmDREyh7B8y3K9gBYvnxWEZtSZ5W8lqgoxmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQjlJSh6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so22094845e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876730; x=1768481530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjZnmMsZAmwj+u4MMhAdvmZKxkPC8GLrjW31jRJ78UA=;
        b=gQjlJSh6vfEXAoLZ3cyS1eF7nD76Mt/vCMCbPX0Pdv+58uzfpfChd2xGtO7UL7fNrc
         YJycuMJG6ztUYB9efg9cDISuGVDDTOAN7iYO0rLpMB2B5OmtW5dAU7+rPywpMe5o2kLm
         slHes0XKAxswEuqPka1Hpa7ihV3gQOzj1GKvel6ztv6YddbREn5oyzXWp+8AnawULoIp
         2W+K0zFmlWO1ju1P6Wcq9ILp9qrlKNGkgYUGTQF1eaE84LaCTQQYh779I6lYyq36kJzI
         dDPKrVn5WZ1Qa+ukN18ti6IE6GQ4Yq9LjaIMfE38e9HMzhbPRBf0OS4KubvntgnT8fTc
         x+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876730; x=1768481530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjZnmMsZAmwj+u4MMhAdvmZKxkPC8GLrjW31jRJ78UA=;
        b=wYW2XaYHSI9tIEjv7oBXEt6X5W/gRrX5XLwUaYQHQUBIcfnRSqdpz1j/QdFe2M+YJs
         FK2Vos94FSF5oMu/MYVsHpro3VlV3FUgVEtEvNU0p1apOYCc2IXrRiODEJGFsfOACcQ6
         4/zDr1BQbo7wo3wlmwZTkWIftFcZ17TJcAbSYOlU72peM+YzzuNJKBSBPnnUUNJmwe6v
         Dm16IqC7yjZnUep8QwnQmAGcHz5t/kzqUPLVg3mj//MSx9XVvsYKEBKr256R70Ea0m1A
         xLBQLOAqg/FrflGW9TSbRtCKd7VRMDEORx6w98zUhQAZpGRAH6WopfoHSQatNXqp2h3x
         LJBg==
X-Gm-Message-State: AOJu0Yx5p0LDP54KSymHaBPJkrUIKDye4YOo9u3h6Fyg9ClMYnNjyIzR
	NuVOB2GJhui7xT7qlz0Zp/Y+AGRXoXzJKlg8OGbdwjMSydFjmDi8tD5G
X-Gm-Gg: AY/fxX7R9Jhy4vNaxhlArbUCE9SqVERtcxSsJV4Xnzirh0wov7QJYwm9YJeIbnj2cjn
	Uqko/m7lGRzhMW+VHLHosTwa34xD7q6scacSayQjbr0ISnSV4D3pjyfRutMP0S4CTxk04FLpqhC
	yp19/1UtFNa9efkYlmZIehUocmL2jrWW4KDsAW3CSy0jiTVLapaQxkJN7soslvkH1DlF6dOJNL6
	b3PZpwXwf4fQ3zAnSgwIHXKrMa/sEXU1aFKTINU1jl2RdTxCBG+UCtkGNk0GmDocBLdFQAuUK1l
	SIfsW4eYIugGaqzZIY7BzTOTjCkt6E5azRa3+Lveu1ercLsLUC6KIKzlW+ZUHxM0GVTGRCGUuUG
	7sRuljzjelJurREww6XsCeM5Z/x8IByBvP+gJ4ZMLjhw6lUOn4/Ng5PhN/kSVi8+L0ln8gvonSP
	z3wqqD1DRN3o1yR9O3jFdJ+MW3
X-Google-Smtp-Source: AGHT+IEIsYHHhEprQ2ORDdeicbqmDQ5jEhfSg+KYvhUSTtYmMIW2K1iQ4OcbHgp/lPPdooMkrgrMIQ==
X-Received: by 2002:a05:600c:4fd0:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47d84b200d1mr76068675e9.10.1767876729909;
        Thu, 08 Jan 2026 04:52:09 -0800 (PST)
Received: from eichest-laptop.gad.local ([2a02:168:af72:0:58d0:2e00:f578:dd87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm16046623f8f.4.2026.01.08.04.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:52:09 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eichest@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Convert the Micrel bindings to DT schema
Date: Thu,  8 Jan 2026 13:51:26 +0100
Message-ID: <20260108125208.29940-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the device tree bindings for the Micrel PHYs and switches to DT
schema.

Changes since v1:
 - Change ethernet to mdio node in examples (Andrew)
 - Add table with skew values instead of a description (Andrew)
 - Remove - where preserve formatting is not needed (Rob)
 - Add blank lines (Rob)
 - Drop line "supported clocks" (Rob)

Stefan Eichenberger (2):
  dt-bindings: net: micrel: Convert to DT schema
  dt-bindings: net: micrel: Convert micrel-ksz90x1.txt to DT schema

 .../bindings/net/micrel,gigabit.yaml          | 253 ++++++++++++++++++
 .../bindings/net/micrel-ksz90x1.txt           | 228 ----------------
 .../devicetree/bindings/net/micrel.txt        |  57 ----
 .../devicetree/bindings/net/micrel.yaml       | 133 +++++++++
 4 files changed, 386 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/micrel,gigabit.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

-- 
2.51.0


