Return-Path: <netdev+bounces-249974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392FD21DC9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DBA3300D4A5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6E7082D;
	Thu, 15 Jan 2026 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntS4J018"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E738D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437240; cv=none; b=ntkyTCJOenTB9iADO0LR6vKKHHeXbp/wxS/M0iO65mL6Otm+FGR4BTddeUaE4ZZjhWn1DKme2qv4KOMtInNJGApu0BRPVa0MYtPsudE7nrnRJ5tOXq8OpcNMKAjLfgqnZ1sV1iHi/6ZjpJAWT9Y2JAN6lqtwlwnccp4y21DKbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437240; c=relaxed/simple;
	bh=RIuLlraV8PyUQdyDZrTeSGBCQArt+TrxzvVoTFxyWs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trF5jLwtRTA7vUtZY0JF1rsmHIv0zcqzbc3bcV2w7vzghFDzL+73Gv4v584k282YRT65DA/K1HCONI/zCoJgCTyZd4RJ+8T6v4FWczwYQhzAVSRD7Mj3McGvqztFzEbHFiNcZi5fY/NTNyu20Jf1FWqvw6DFgs113lF3L4kJtoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntS4J018; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327555464cso185907f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437237; x=1769042037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tL4zsbsyBR0+QsH//xrBWIwRGH/yuT7gAyHQkW4uuWU=;
        b=ntS4J018ptK/iTOJ10vkGiKWuar6CxHCVuECNoAaYmJN5BwDdu8za3c1WEXnXmLgYH
         v5bDbp+YSEdexd9AQUKDD6LmjEyiGqhgRCJZy6s5QOgBWpsgFHbzZZzqBVUBIXcaXtNZ
         X/6xXMp8Ifp3Zu4uluNW5rv+OcawugN/YG8wnSpPYfTVPAkktdnKZaSqVLTkoRHyIbN8
         LDWr3y01wMZGNQfKdq9Cil3Wtoq4luTZzwWu2c2pJivPDYVkZtExwwn9DXdQQ1TJ7qT6
         4OuwcO+1sSGp0CzlIVD3v3JMfpiwu1KiJf2sLBLQkm7Rf6kr/hBXdI20KbPgxAJpEggx
         vinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437237; x=1769042037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL4zsbsyBR0+QsH//xrBWIwRGH/yuT7gAyHQkW4uuWU=;
        b=uG+O4gyn7PICYFbln5dM6jnkWUPF+VvHXUd4nbr5Piby2MVMglsH64wK/1RVfGzZlE
         Lu3xz+oB7mhdeHM58UYgtbyFRVGAv457DblivAK86sJwlnH3kRhu7QgR7PHccI2UQeHO
         x2BvSupV3eHFjbVe1m5w0iGJo5Df3gnoO5uDkbZtXLZGbweIcSo7GiZVaZ3kZw+wm5Vs
         E6Pbi6rylSI/12LXoZhpEQyKFN9kTJau9ko5OjaLC39VzN5Uy5wAop+SOAt5zWAcJAco
         nOptlpUuaboPcboSjHDwqJ/HxgO1boUXVQUpv2p3w5Wr/ejEtqbUiPETItb+vfEf3CY1
         tthg==
X-Gm-Message-State: AOJu0Yx03MwnNy4vcuH4WKQuBIaZLWCzOZaulQQkrFutW8ThBeLs/We7
	vIzkdGUTTB3t7d02n5F36p7WNwXJJLbzKLSrwL08uo6IwRCzNIJHQIJZRljmD6ym
X-Gm-Gg: AY/fxX5ZrIXnBTEjB2CxQ/OdgolowzhO3rCWeRgWjc9flBNuTAdiGuyToCexo14onV/
	11BnkkHsBATcONvzsUmpSqnWAQh66jyg+LhTJm3IA7cMlpiIPZnDhpNcBjMEIX/vMDAQMWxyJIE
	r4STLQOseCNkA0xZgcFYqRvhkSJD7fe66sSMWAn8y0MsbR1VgTSN9tbn7Lu27XyNhmiSMs5vo2i
	bD921GC+LthpBccJv984+RXlrS4EOi6ZJb7jDVWPv9LhTuIs5LOrKYZ/+hQUIFEOl1dUJBfTenY
	xEBqIbiMEXktsWA+hclnJ6Nh5Ni3xJt0jXwoB6E4D+05gRI5NBh+26zWRW1NzY0t/O7+7hHmSyb
	2AkYiYeZLdPfa4EqHXb+VDpLu90z71WsRCjRo6u7XiY5vkF6dy1X8cY1GNgG1PzZ3s8Zi695uN8
	9v/wAL
X-Received: by 2002:a05:6000:2dc8:b0:430:c76b:fadd with SMTP id ffacd0b85a97d-4342c4ffdffmr4948727f8f.28.1768437237242;
        Wed, 14 Jan 2026 16:33:57 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b143fsm2204644f8f.25.2026.01.14.16.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:33:56 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V2 0/5] eth: fbnic: Update IPC mailbox support
Date: Wed, 14 Jan 2026 16:33:48 -0800
Message-ID: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update IPC mailbox support for fbnic to cater for several changes.
---
Changelog:
V2:
 - Update P5 to handle regressions with the use of
   fbnic_mbx_wait_for_cmpl()

V1: https://lore.kernel.org/netdev/20260112211925.2551576-1-mohsin.bashr@gmail.com

Mohsin Bashir (5):
  eth: fbnic: Use GFP_KERNEL to allocting mbx pages
  eth: fbnic: Allocate all pages for RX mailbox
  eth: fbnic: Reuse RX mailbox pages
  eth: fbnic: Remove retry support
  eth: fbnic: Update RX mbox timeout value

 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |  8 ++--
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 42 ++++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  9 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 24 +++--------
 5 files changed, 45 insertions(+), 40 deletions(-)

-- 
2.47.3


