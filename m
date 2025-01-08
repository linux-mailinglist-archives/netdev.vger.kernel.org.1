Return-Path: <netdev+bounces-156333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01903A061D1
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76413A6BFE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4281E25FA;
	Wed,  8 Jan 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkH68pNE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76E1FE475;
	Wed,  8 Jan 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353593; cv=none; b=TSNzADimrMOmN4KKSXjiKadRghKtzwXkimmI87/a7e0jncCKsBJ1GzXA325PRJhilv0PZdR1FYoJ3D1d0sCm3It2yrX27DjiWn2gWI90yFOjObwQoot4pjo2vdRCOgjNAtGtJQwGQp/bWgecTjAjSyvME5CmcZz3hewC1FKefmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353593; c=relaxed/simple;
	bh=PC/tWXwk6YdUlv0k9NMQFCtuVWZNi8ajMilaFyCJsv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSRYTjQGeqobomCzyP6t0DicN3v9WPxKQYJGgGEsgoiXHWZ2WF2S19mnd9Gn9P9G+wZhqU74vz214Vna2jbbF45hNvIvRHw7F0ubHH0YuVicYaBYGdQExZU+zkE25k2L4W+MZpqP1ZbIzLdYuLpI8UA7nIteMx1ixxlFfBkvJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkH68pNE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85bad7be09dso8757857241.0;
        Wed, 08 Jan 2025 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736353590; x=1736958390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VgGsE8CkYldjuaaPZ0lEWAgGeZarAzuGgsEmYnO42c=;
        b=CkH68pNEKW4g1RG1O28Fw+0htEsTs3+P5jwICl8Kl03Amx2gPDZXexyy8gJ7uVA6+8
         LF+cs6M8NLq8zy57GIVwUpA6U8KtjvRFbb/gUCO3Sj81LrltvdZoSWdaLEUkTKRLE5vI
         UL9bZR7GBFYhQcRKB2O0sBDw8Lr2yC84kEPBxRCQwEF181G14dV5o797DKTi+vnlM8SC
         B4RB8EgUzbrX0y1U4kiCKgJIV96YhXdJac3C9sCqbHugSL+I97MT8CxoQHk7KbAI68Cf
         FVd5r4/28CJ+gvUNYTeTuPEPEZAqtk4fe+qLDCqTK9reSoAaB6zC8hoPzj0z1ARRdzby
         UwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353590; x=1736958390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VgGsE8CkYldjuaaPZ0lEWAgGeZarAzuGgsEmYnO42c=;
        b=DeyCq+YwMY6xWqEEf4zmw+1WgXY3o8zgmoXyoWgPcjLuEpA7vH69HfV4GT11zZ8AsK
         x82okuxjDbtMb2ThceR1H5s+q4RNrLXDivY/56eaSOgUtbXyzAJ3FbM6wUS2sT+D3a74
         C97aGp6DZbwOVJRlyos10iLab4cjfyo2jcVta/+Jl8hzy0GebufaHMF3SRsjff02CdlN
         r+r/E4sdorWGmIEu4ppieGKTxP2gUKOHJ+3ONrmz5g7cxjkF9N24MkxmVlKXuTgddA/X
         5FPGEbtx2iGKqZIPNZzJyy9jqimaUntagmhENvhW/pYrHzcEh1vlpv4+aP75hsOz4LC9
         lX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5RUGrO+Xzrjy0eNpbNP5w5IK119N5DtoWis7Rn5FBSob7cQ2rrQ6ppm9Tfg1rMXFjLFSK5gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+1npqc5tWhfZ4KpXHVZCM+OMr8JqukHksjVyDwmhB29l0llE
	ROa+nWuEhuq60JLfygoMhXwcse9Sg2SQiR8+8uwt59t0Ni44+nEUNeICRaL/fDw=
X-Gm-Gg: ASbGncuHZyps2SQu0l6a7ir1whyFQdAORutENNmlRjCu/YqmOHffNb+/Nu9CU1AlvJK
	HIWMTCbFQKYNQ1CQ4ovuLSi3yG0WePFpvvmtkeewXJ3wsADkpBoWLq+DzIQjp3hdcO98znFc6Iw
	ofz2fgs+RpaiWzap5AI3OTr82uWci9SZQZP7PkGsM0SnwfI7q/CnsVDIztEEShbJfU8ErGUaYHG
	ABu6d+bHgUSZpYr32kaxQ/lSZTcTW+WGTc6MDdWUNldcMH5g7ScXLKLmO4Gw9LIF5R0pqEKWEJ8
	Rv3i4MIm5e3v+MIuhzxYWELEBc2N
X-Google-Smtp-Source: AGHT+IFGomLi5Ipkt+8OT5P1G3bBAg7wIkun5lGksQ0gdiVhfb5M5QtwAXoa1f4Mou/xTgQaSqfE0A==
X-Received: by 2002:a05:6102:509f:b0:4b1:1b41:ff5f with SMTP id ada2fe7eead31-4b3d0da4c1bmr2728054137.1.1736353590365;
        Wed, 08 Jan 2025 08:26:30 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bfa8d590sm8561846137.26.2025.01.08.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:26:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2025-01-08
Date: Wed,  8 Jan 2025 11:26:27 -0500
Message-ID: <20250108162627.1623760-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit db78475ba0d3c66d430f7ded2388cc041078a542:

  eth: gve: use appropriate helper to set xdp_features (2025-01-07 18:07:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-08

for you to fetch changes up to 67dba2c28fe0af7e25ea1aeade677162ed05310a:

  Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices. (2025-01-08 11:14:03 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmtk: Fix failed to send func ctrl for MediaTek devices.
 - hci_sync: Fix not setting Random Address when required
 - MGMT: Fix Add Device to responding before completing
 - btnxpuart: Fix driver sending truncated data

----------------------------------------------------------------
Chris Lu (1):
      Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not setting Random Address when required
      Bluetooth: MGMT: Fix Add Device to responding before completing

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix driver sending truncated data

 drivers/bluetooth/btmtk.c     |  7 +++++++
 drivers/bluetooth/btnxpuart.c |  1 +
 net/bluetooth/hci_sync.c      | 11 ++++++-----
 net/bluetooth/mgmt.c          | 38 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/rfcomm/tty.c    |  4 ++--
 5 files changed, 52 insertions(+), 9 deletions(-)

