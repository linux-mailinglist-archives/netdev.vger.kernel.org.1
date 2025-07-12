Return-Path: <netdev+bounces-206382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DACB02D06
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22339189E885
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343851DE8A8;
	Sat, 12 Jul 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ1WRbrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D203594B
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354279; cv=none; b=M5DVwlFxUPbvreqOd4YiEVQoFiA/1vxFl95u+SKT4u02HuWM6icuImN+UYFjiR0OpB4Bf8W4Uk1MKT+gFcX2VOZPMhb88fus/5HC0kPpRqRlc7dSYlxtuHuDEXsObG5u0hNcULWlj2OqN2zt5OgAZ9Eb9n+XaRYsaI5vbx96/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354279; c=relaxed/simple;
	bh=JaDfFc1OkxkkhhPGJCgJpBSsFLpVROVnM9WzXAv/Dl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JxIQIuhsJhwcBU/9RBNdzaL4hudI1vuKXMZdMmXknzuj44T601Ik5y+XBcjcgdikPivLl1TduSbooO60vf7PfIjvRA9jKaeT/cMMAzHu1KOkVCfy1w6vDOcqlZklYefuqKObstGFME0fglYiIjwT6qk5CR3T4FgJd3qH7ISc6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ1WRbrl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167afeso28198665ad.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354277; x=1752959077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfLL9MbScUSlOSjyWm24E58Y3rU7LU4fcYrGg0K5EsA=;
        b=KJ1WRbrlhgLseSliQB7Yyy41y4jMw26xJQF/XOWQ7fJD+Se8/9US1zTJU9DCGES2QB
         CWXUhkbowM98uonkyl3XesIVP0lN0cM1E0tweiJ1RhiVz08Ou8Y2hWndaYwNQ8kx2bfE
         Ia1YQZksyo7U93X6Or1RgL8Sxe/DocyLKEV5ZtgxOdU7mg2mOj5Wi1E/74nQqyGdqpWs
         GAjnrwzdJ/42cO3pq++rdq2DR2/jHtGNmAHoz2FToqk3+adthfJmr0ff6UAYfTQ17up3
         Auxm/NZR6bvzTq0IOIxax9i1AupCAF9tsb1fGYhJKNOV3TZ7rNp/BclYAl2YTwo09e1O
         W2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354277; x=1752959077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfLL9MbScUSlOSjyWm24E58Y3rU7LU4fcYrGg0K5EsA=;
        b=IycTqbl1ZbF85/Y88OW5+xY0IFj6DkWSlcDdEsnx8QyCKFRtHpnmPCZMLSMXiIxUMF
         +QDMcs3lKp3bJkw1zy0r7mihCJHv+a5QzpqOl5rDvl0TsB3Zxty07lyxG26G5XINuNdp
         KN7DRf60ZTNuer1Fmpsv2CkDtoBapv0zWh++WvN4L2snMcHCuB525ytvpW5uwb0pPIZu
         Yi6DWWnCmx0VvqVWZfVjmXopRVZ4BBwsvRhDe3s/fvH3SGBMsiK3TI7/NuwZ6dMtvm2b
         sGbqWl2OwFQD7uuty9isCtBSA+xa7cD8BwMHUau6+GTEsjIIakC4qAcbryb99SzNjjin
         wTbQ==
X-Gm-Message-State: AOJu0YwX6pNz6Bev8BgjEfFkPG0yCFaELZvAb+x5OVGugfH0lXlYgLh5
	YuF+FGFq5D/8j3CxXeIYMeVgfnmquxsGeuPS60ll13+eBthAT8ovdDll0Lx8Di53
X-Gm-Gg: ASbGncseG76p2UbS7/wQ69Z3Fz8tc4R5KqveXFI9h9YO+zprs+iM9UcJFPLrRRGi5S0
	SHxTDi67iaVJd9/98kLRuvmVbR+bPwRi0i09CD3YTNW1lwpc/kWNuNDiJmIj3lRXZl/aIG+2Jwa
	vhgLgdfe5MR+mjP4ffPyKypniZTitR1Mflv6S/OfFN62Zdahb6YJv1IxtJLpEizxFqZB72/BNiM
	Aoqc6J0X3izpWUq1eWGVWE+3ID8Hp/BBQlv5xkHZgsU5DRZxhmiHDH5zBqiBZi1truFDBSNUT3g
	OCgvwsyUhkLXd698WojAzNpzJXDNDz1eaVltJpmOvjP2j2OWtJ6hg5vZ10G05IHJq20DBpKBJD9
	1S2o=
X-Google-Smtp-Source: AGHT+IH7kEtM/8PQs7+wHPnnS8rGa/R+bxhtVW/3i0sQhiqvOYfWz1MfPGgihaNUd3wAXb7vDIQr/w==
X-Received: by 2002:a17:903:3c2d:b0:235:737:7ba with SMTP id d9443c01a7336-23dee293790mr122581225ad.44.1752354276668;
        Sat, 12 Jul 2025 14:04:36 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435cb63sm66828735ad.235.2025.07.12.14.04.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCHv4 wireless-next 0/7] wifi: rt2x00: add OF bindings + cleanup
Date: Sat, 12 Jul 2025 14:04:28 -0700
Message-ID: <20250712210435.429264-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't even compile. Added OF bindings, documentation, and other
stuff to hopefully this doesn't happen again.

v2: move all of 2x00soc to 2800soc. I didn't realize only two functions
remained for no good reason.
Fixed typos.
Slightly changed probe for clarity.

v3: fix wrong compatible in Documentation.

v4: renamed documentation file as there's only a single compatible.

Rosen Penev (7):
  wifi: rt2x00: add COMPILE_TEST
  wifi: rt2x00: remove mod_name from platform_driver
  wifi: rt2800soc: allow loading from OF
  wifi: rt2800: move 2x00soc to 2800soc
  wifi: rt2x00: soc: modernize probe
  MIPS: dts: ralink: mt7620a: add wifi
  dt-bindings: net: wireless: rt2800: add

 .../bindings/net/wireless/ralink,rt2800.yaml  |  47 ++++++
 arch/mips/boot/dts/ralink/mt7620a.dtsi        |  10 ++
 drivers/net/wireless/ralink/rt2x00/Kconfig    |   7 +-
 drivers/net/wireless/ralink/rt2x00/Makefile   |   1 -
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 102 +++++++++++-
 .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 151 ------------------
 .../net/wireless/ralink/rt2x00/rt2x00soc.h    |  29 ----
 7 files changed, 156 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h

-- 
2.50.0


