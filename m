Return-Path: <netdev+bounces-238283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D99C56FDC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECE5C4EB055
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF022A80D;
	Thu, 13 Nov 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du33CBkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F672E1726
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030787; cv=none; b=FSyd7kLHenVlNeRNEZJEhxY1rkrSPWkTLirlEIls/so2IOxDdJUlgqAcf+C+JCBQI0ELAJQkyREDyikEKytz1p4nIbOM0Es9JH4AAIPtEhG6+MjAjNCkwPF76U84bQFmVBnjlZut9eqrpcWw59X0I0XLo0+hRxNH8ylVDAzPXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030787; c=relaxed/simple;
	bh=RChdl1eJd7KY+noSvCnJ/Qu2STwchfhjBNa5XjsTWJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFN5yu09INVrsAD9vdt4IZPsWJUt4n9+9jHdk2xd+lMNbvY5lXbkRr5crpDEGYae1qsEx4x4l7OPIiksWpZC5xX138qKVHr/Igmw4Bf2igLio9UCHqaz+QF2CSnliFBflosLMADcLX1dP4cpD897l4JTwxtIgteJNrcgMa4SMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du33CBkH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632cc932so2856895e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030784; x=1763635584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qOs4GLQJ2VFbWu//EYJrZ/inCwLhP336M8hfSCkQ8A=;
        b=du33CBkH8GbN+b8pAi1eSHVK8rQe0MUpF3Pb25i0Dj112YB9iBGX30nKpajvtC57fE
         icgP1xgn7dmfCKUFQexgoZ28Wuq2hlL9bDvnLYoLkeRR4Poa/OgXYr4z6YYkb7JSYKuG
         96hKHYX/9+yaDwnT4oRkC69JHCfmI8j7Y7uizvZ/6eqlJf2mRmcOIEoQ76QApOEb/0k3
         QVldkvfbKKQBAfpZtEY1F5/3W6x9yBYDZzbsj+5AK+le6kUjW+B8Z+IZFol7iMxlQulG
         YEz+npArF6c4QTWNnCzUrijnHw16oHBr2Ucb/Kjc5OmMW0pWauo9v5gf2GZRhB4AkPEb
         AMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030784; x=1763635584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qOs4GLQJ2VFbWu//EYJrZ/inCwLhP336M8hfSCkQ8A=;
        b=tzLbJHqHFDjIziNvE1ypjJV4UT4fF4iN/g28rSfZXbWkGXZG2gO0C8+XNeCd5lm+8N
         3g7zLrh8/hMiGCKSMhCTNFnGFlNFVrzOiu+94SaF+ty0m9kcTWqSbZbQqWPP3ivFXAJx
         tb/odhevLuGiNfZQHcYayNqrtRAzcU6l0FL/aVZwzIAmzz4ukL7GZHrodcPWiJ52NLKQ
         +MIRyKd7tBV5nGbgwbpwy6HTk97cTjj5choxHzlIawRZ5IuUJoSeioD9qxlJp6oGw7Jx
         r2lxiRsAfl/jxwbz/skvQGQ9+GhzUTD+3AB/7vj9Qag24i2tVvGPAdb0XW5J70lB6ZRI
         bOPA==
X-Forwarded-Encrypted: i=1; AJvYcCU2PJeZyYb7fGb6By0+Mcn0o06tRSTWC2gYkyaWaxUcA3f+Rxx95n/HLmSPdqGmGzMWuW3MqJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfHaPlmDtfnCZMFYdpn6Cz6U1kmvIFHSCfz4XZKTV6MiAhii1
	y3hZAuxmpVxkfuiKO5Z13weQOhImkgEU3ZfZdqFwvjPu0JhWIfnLU2x9
X-Gm-Gg: ASbGncvmkMvHhUcstZw4sAQqi7xahpa12mPHnoNn2E6QSL2h5YJKJ13pJfi3gWY6AV5
	vtv52+mV87J75P+317oJL1PDCMHK8AghHwRFOOpPAlAKEcqhOI+vq7Ca/6MZEJMVJyTMMUKrY6z
	TOlGNALx91715HcD80yZoIVrVa7rFhVJKAUm3mGM5Ikm4cXGK7B//DBtIfPfVY5kcOGvc0e7o0A
	ktioMP/EIvnasEnRqECHT7ky5yFj3f/h/7zihkmZZda50zLa2lm9bzgXV66b0sQ9Oyue0WHK2RH
	E0ye6XXbt4mrdxHm5aU/A3M2+c/BiBukBA00bjOEknYjiNx5Zb5NrrXHx7ShpcKYuMKzihb8mzc
	R7+6zpL5laH9VRXTQm34qWIIF250w7p5fw5DuAdoWWm2M3zgn1FLijqQMzzw=
X-Google-Smtp-Source: AGHT+IHJ4zr/CWZnlRsOE13f6bVCWWIvaDS08niPPy91dFQIoYsEP825VBFnjCRpzlHR6+C6tBlJZg==
X-Received: by 2002:a05:600c:1f91:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-477870c657emr57235695e9.19.1763030783588;
        Thu, 13 Nov 2025 02:46:23 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:22 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 00/10] io_uring for-6.19 zcrx updates
Date: Thu, 13 Nov 2025 10:46:08 +0000
Message-ID: <cover.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: it depends on the 6.18-rc5 patch that removed sync refilling.

Zcrx updates for 6.19. It includes a bunch of small patches,
IORING_REGISTER_ZCRX_CTRL and RQ flushing (Patches 4-5) and
David's work on sharing zcrx b/w multiple io_uring instances.  

David Wei (3):
  io_uring/zcrx: move io_zcrx_scrub() and dependencies up
  io_uring/zcrx: add io_fill_zcrx_offsets()
  io_uring/zcrx: share an ifq between rings

Pavel Begunkov (6):
  io_uring/zcrx: convert to use netmem_desc
  io_uring/zcrx: elide passing msg flags
  io_uring/zcrx: introduce IORING_REGISTER_ZCRX_CTRL
  io_uring/zcrx: add sync refill queue flushing
  io_uring/zcrx: count zcrx users
  io_uring/zcrx: export zcrx via a file

Pedro Demarchi Gomes (1):
  io_uring/zcrx: use folio_nr_pages() instead of shift operation

 include/uapi/linux/io_uring.h |  34 ++++
 io_uring/net.c                |   7 +-
 io_uring/register.c           |   3 +
 io_uring/zcrx.c               | 326 ++++++++++++++++++++++++++++------
 io_uring/zcrx.h               |   8 +
 5 files changed, 317 insertions(+), 61 deletions(-)

-- 
2.49.0


