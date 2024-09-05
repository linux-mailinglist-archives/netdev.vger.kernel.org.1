Return-Path: <netdev+bounces-125678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D696E3C5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB70E287A4C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC5192D8F;
	Thu,  5 Sep 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9Qh+5Er"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF549443;
	Thu,  5 Sep 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567311; cv=none; b=r70gcWQf0Koe58Bh8eNKnPrZlKhQje4l3ksIwVEpOoP4Dhw0b9F4DXpVr3AcSRjnMMpBol5Wh6KJWSUNO+qIfdnEah/EHIJkUu41RSk9XY8ddTVaf0DQgosYbMlxAuKGfKrHJdL2ct5BuIvkL2/NFMTdZBldLgGLOcZh/n4inow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567311; c=relaxed/simple;
	bh=EGKGdxnnQ3tg7C6rXuKMXOxf0GC7RukIwe5gmgsaB+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlA9ojbEeG0lB7wWBz3NRDbdKm48ChNi8eBEVaYiCe6n9LWF1RxH8TN+s5OX18UzRISOYuPhoDv0tZo7kT8F5Cm1LjvFxIUGg/9Os1Jta+4bm9/UOJD2qWsHSFPBlP/5BETbqZBmxH6jqgu05h5r7mpS4iuVUxYNof7vS6VgIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9Qh+5Er; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7163489149eso993228a12.1;
        Thu, 05 Sep 2024 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567309; x=1726172109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1I8VdvALN0321tmy95wm8V7Thns3UaIkgyaiWhp22w=;
        b=G9Qh+5Er6nc4PAbAKqQn2nRf1QgGZFxBKSlrl+HiZpFPXl+p+YxdKHn3wxd/wkBROK
         aoc0wSMq/DmnuMUWRHyxBFQdpbDqREmsBGq5c1g8ZIIe6iaLsZehDU3AvHEHBRf6Z1uL
         WV9g+9QqjEM0krjO3cSDUaL1rGfJCH5YuA9nmAecuvKGdMPJbNDcb7jHQXzQq1VK0ytO
         yIzFmpmjH+PZuwQE0N0KPhzHU6JiWo6ndO1c6297+poaCA0Rhq+hYTZzMffZBXjCKMq2
         F9UBkzTOecxeiLd56ak+SJ8PyOlTSp/IoyitObgyk+ZFTbq8FQEyj03oZXpMaEfv15jU
         jr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567309; x=1726172109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1I8VdvALN0321tmy95wm8V7Thns3UaIkgyaiWhp22w=;
        b=Q+5wHGyJMqiCksVf8Tallc6r0rhHT8iVNym7UetqTRD2rNrjIxzGDXnWK689b4f+Cz
         QsmZN98jbvKZRvBGcEN3F0gQRaJpbKHjtFX7V+7pBnX/dmFOV6n89xjP67fXywHIn1bS
         0Xk/QCXOP8ua6iGyrWze/NzSPx74iChRW1lk8iwC30Rz6WqYaRLoonBSDWqkguEOqm+M
         oX5LZF5yNsqS6IvJ1zQQXY63T6n+rJdb4HdtgjGkGUAi/bZFTOu5B134uZvdVIVm7o1i
         Tblc0n6bRRKb66gx/hJUasLxgSU9XBL7jsuFf1SYF6mYaeOQujweNZ6bRDyK1foxtvIy
         T/OA==
X-Forwarded-Encrypted: i=1; AJvYcCVGDd2bC2G/vpwD+ogd52vU9mXx/h0YEdcvadqMTV9ekTwYREhzSF8lUPN2DiTnoippDzcAN3y7tMpgNVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyjYT2vkrjYnd6M7ec/UcUg2nw8nVoFfAOnQCEzEb6/kTETP+
	3fg8EIbh11ACDoSmtxbALUCsYSuzZa/G4fyPLIOS3YusbNyqyXzZS5vE6DUD
X-Google-Smtp-Source: AGHT+IGYYZbBmLva2e2YHp9YJm6aVlsbBk0XBLDjmjES/voq72Cas3iw5JS/Wday30OgejAfxbJWqg==
X-Received: by 2002:a17:902:ec83:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-206f05afd8fmr2580655ad.44.1725567308967;
        Thu, 05 Sep 2024 13:15:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 0/9] net: ibm: emac: modernize a bit
Date: Thu,  5 Sep 2024 13:14:57 -0700
Message-ID: <20240905201506.12679-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a very old driver with a lot of potential for cleaning up code to
modern standards. This was a simple one dealing with mostly the probe
function and adding some devm to it.

v2: removed the waiting code in favor of EPROBE_DEFER.
v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
EPROBE_DEFER fix.

Rosen Penev (9):
  net: ibm: emac: use devm for alloc_etherdev
  net: ibm: emac: manage emac_irq with devm
  net: ibm: emac: use devm for of_iomap
  net: ibm: emac: remove mii_bus with devm
  net: ibm: emac: use devm for register_netdev
  net: ibm: emac: use netdev's phydev directly
  net: ibm: emac: replace of_get_property
  net: ibm: emac: remove all waiting code
  net: ibm: emac: get rid of wol_irq

 drivers/net/ethernet/ibm/emac/core.c | 214 +++++++++------------------
 drivers/net/ethernet/ibm/emac/core.h |   4 -
 2 files changed, 67 insertions(+), 151 deletions(-)

-- 
2.46.0


