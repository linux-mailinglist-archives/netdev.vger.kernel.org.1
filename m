Return-Path: <netdev+bounces-223680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD405B5A089
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D28A1717DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC026FA5E;
	Tue, 16 Sep 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFhBGG5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814B245012
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047603; cv=none; b=YHOwq89mLcFL9T7Nl0N8w9/I/KbdsUWRND+kfP2Qi1m5d6BGpGEIcDqHkTSIIKmunIroRTjWmGOZ1xQ9RZXJhHwuJ6Ot9tAbCDIi7cPdcOlfsQgubNbrQDk3wv4IDidiCcFFn+ueb27pZzZ3AUC8Quh/EDp8yGJa0b6BEzvl3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047603; c=relaxed/simple;
	bh=3UYdzezrnAbWicx/EkzOHKw8TZPWI8saYWaHMqOH29Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LN35+yh2m6E9sc7f6QX2qV4PRhSvHUlE7HXUB1xP7OP5HIwgtiN3n59ZfMyiinau85xb7koJVsgZC34io2/NAIe7I3aN4LJiBw206LtLPfqPbYrspajCRbUKw2nM6R84KFRd9P4Gj/JcM1HqJe/AlbiMkGBdhek5XH91jQT8Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFhBGG5Q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7761bca481dso3181112b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047601; x=1758652401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dZ9MXF98QAzc2XsUubA8DhGV0oGfqHkurab3qXPRaw=;
        b=VFhBGG5QFPBjjuhbpy8C7wR/9GkokesW7cG/fnEplvZcMoOZFF/O/nBmi/ASPkgh76
         fN729lMtQNMArpXcYS4u92RhkC8p01c/ZqjHIJj25+uzIsT27lkXxq2oqeRbZHJqh1bm
         SqCbNMijvcZYDd9lFGfHXCKBm3JtlT9o8sBPo4dGG1nVePKrZ1tYgDZ6eB5s4cQ6QeBv
         RqR19XjtPIjD14LOIgXVbhkcYIPC6/xyJ9y4lpuykTdclxX6jFTnqpD6fGVj81LB7QJ5
         oTazWE7p92mhP5DJu5hZ8D7AXLu25W46W58JZ1OLM5yeAiGVd+wOb7pUd9sGjMz38Jf7
         ZbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047601; x=1758652401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dZ9MXF98QAzc2XsUubA8DhGV0oGfqHkurab3qXPRaw=;
        b=MmGnj6HEvmRsJafXCJPNjPYjBGEAIxnyGrz3tYjBZ55MBJzf71ehqV4s3QbLKj7ZW7
         juG3wUgPUw5ppTRbnBgNvIrBNl+WKXBHKGspj9Ta05FPTG+dSgACslGSM3T4kNoSRlky
         /0eXOv6AN6tdOs/2bp9c6qcOqak/N9xcnIiVrnWPEaBep719B2HqsrLh3ZoTTblNV5vx
         ckTMPKv9ZhYX7SIvdOweW/R8UZSjX2vem/WzOE0BEeVYCpVHx77XMwx+EbKUFowikKB6
         rfdYRTe2MsDDNKaSAL+3sAmR/SLMw7x2EZFIp2FzJ3jzAoaldWXsaB0HgTdRO09gOh1d
         H84w==
X-Gm-Message-State: AOJu0YyBkdiJ5w32+hgT//mhhYRJv+2mt6MDpsIABZLMljXO2i0Q2Var
	vYw8qot7LVZB0MBDKMpwrkJODAlPePJYkOLucnsYNspjg7r9/x4sssZP
X-Gm-Gg: ASbGncvLrYfAjRRjCrBZ3Srq3L1aSO1gWgFWGo5RCkT00FYQh4Lkp9GO+4BSuHfbcBd
	8NnFMT90xZ56lfvNwIyR0z5osJp+7sogRi/ivUhlFVrEPQj3jOZ4qzizQkZlE44Tx59TlOt0V+f
	oGPv7emwFT6HBcj8cC3k8fUBK2BXii5xH5UdoyqOD36f/drVi8dj2EokxBcbg+Q88nLJ/qGdFon
	9MPYoUULCA0zyTQ6dOZsxLjBEaPz3IJ+4BUBQochPQOKd9rE7/M96gJfhI9xDdrjB0QNtM4cO6O
	+FoxqkBqTeFWIDB2NqfbHijFpGaW2imSSwH6zUauw2uff/tPObFCDpFx2i5Ka3tL2rZOseiPSYn
	PjF00AHfm8YP83PZIurRt3h9he0NPUwq8pbfVTdRjXhH/Fd4rZFjiFjHn
X-Google-Smtp-Source: AGHT+IE3Kwjmnkly+bdnBWDnePVbr+VLoHO6JP0k6Rq89c063UHcBeWsHjCbOuj/rEGtZxW20QBHKQ==
X-Received: by 2002:a05:6a20:1586:b0:240:328c:1225 with SMTP id adf61e73a8af0-2602a49d995mr21766555637.12.1758047601511;
        Tue, 16 Sep 2025 11:33:21 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:21 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v3 0/2] net: dlink: handle copy_thresh allocation
Date: Wed, 17 Sep 2025 03:33:03 +0900
Message-ID: <20250916183305.2808-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches:

1. clean up whitespace around function calls to follow coding style.
(No functional change intended.)

2. Fix the memory handling issue with copybreak in the rx path.

Both patches have been tested on hardware.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
v2: https://lore.kernel.org/netdev/20250914182653.3152-4-yyyynoom@gmail.com/
- split into two patches: whitespace cleanup and functional fix
v3:
- change confusing label name
---

Yeounsu Moon (2):
  net: dlink: fix whitespace around function call
  net: dlink: handle copy_thresh allocation failure

 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0


