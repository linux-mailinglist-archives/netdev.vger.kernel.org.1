Return-Path: <netdev+bounces-130648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56D98B016
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8C283764
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0B188929;
	Mon, 30 Sep 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8tIsMnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF421373;
	Mon, 30 Sep 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736061; cv=none; b=dvTYn4WUDkexcnUcELmlEtTtgb8WbpyXvkd79UCuH/tA/Vc1tNUO/Lsmrkp0Zvpiiphwc2xytCz6tLDLeSLMnkMFn/3GBda1TgnwiHgj8ttCbIj+jGopMpdvD+cyQUe0g3o2kELmZgPr44CQpDK5uw0ae/SmuUQ64eOVZk7OFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736061; c=relaxed/simple;
	bh=o1Zu6w4Iw09n/cOM6Wq3Vq238B+WtzBcg31YfTQPacU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Suj2BTDJTkDF2eYDBrgqeB99cSW2DjnSZHbeLRuYkQjzXMvpwF1fTgxTfCl5LcJahWwe5Rzophx8jsrVjQOmtPOLakx1OUNY/mL1nA41pNggekfQbk8LzbMlwqr0S8wzXFsOYTUB87p7FOZrmcDDW2rmCh27qtgktOVruNFUnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8tIsMnx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717934728adso3735370b3a.2;
        Mon, 30 Sep 2024 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736059; x=1728340859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRkOcV87s6az5YpOkLdvaYPED568xUK0Wegd+fONFX0=;
        b=O8tIsMnxVrIKi1qxKtuyvke1IDOVOOLNhaa/4m7WctfMHzEv7sSlojRO6ku4uqUbNp
         ieD0jbYW3/bpmkhoOiOYI6CdmdFXi16ppjIiPYF29JnaTHf7IXSMkqn87ytDDuJNkrZ1
         1O5x4x2LUhTmYWo4E1cgNlvAF2guhT4D4bJt76Veh0lWywO+ifBdhC5uAGFXkj9HZLaR
         OROnVqIgrJMCrkw3B4iTeQh3tMuOTGCReuxPGylvVm8osWU2SiOIBi2TXgCPl7kMFTd3
         +PZTLoSp7b0vNHQ5PeZA5ly6ZwaVyJ8016Itipq76acWPAvm2IsTuBCbdxGl71cYTv1I
         7Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736059; x=1728340859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRkOcV87s6az5YpOkLdvaYPED568xUK0Wegd+fONFX0=;
        b=sSN5W/Znx8VV9pOHpnPgWKU4WPHLVIVzZZnLtpn0shPAoC4F7f0LHmjiAoH3adXpJK
         1TSAaSmFCW5IgwnzUpgI76mFJoJB9qvg34rMu19xiRlX9E9uD2rfN9Ck8CB1PXyg+Ubh
         /jxALnUzdhBCgciBPN6MTUAKeCPfzpx9SOIsb9oZV+g0ZbMWphDQYY1mz/FVd97W5m4f
         LgvNl+umQHTa4300Y/6Hob8zEIeR1Ih950QRoYFwtL0hnQzLq0eDz1xg4SAiy0UUvnv7
         zVTiWLPTb78zOD0eqMiKhybk2ECQW7y5vlczXSnf/7u9p9RU90dDnF4/4fts1XzkK9+e
         kXZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+qmY3PxRKZCdTsx8CKrE3qHoKKqfc3ugLiC0dHUZISAEeXsj70/LXTGr9z0sdBFoosnLx4rNjmzogecU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSk61Uofb1pkzLEc+5i7JkvxkTG4/7hfCGx7vOTpeKAX1muj/o
	usKjoFyoCC1vMXZGK6drPVRGM9N3jigvdgQvem1x8L6ewhcBmPxlS9P6T8N2
X-Google-Smtp-Source: AGHT+IE4Rhy53+h1DFVY6PGq7cx5dg8ErASkS2q6w9oTz4AzQaf0GGGMgYmW8BpMyJ1qD9N7mWfMWg==
X-Received: by 2002:a05:6a00:1403:b0:717:90cd:7943 with SMTP id d2e1a72fcca58-71b260a6d45mr18618832b3a.28.1727736059459;
        Mon, 30 Sep 2024 15:40:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:40:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 0/8] net: smsc911x: clean up with devm
Date: Mon, 30 Sep 2024 15:40:48 -0700
Message-ID: <20240930224056.354349-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It happens to fix missing frees, especially with mdiobus functions.

Rosen Penev (8):
  net: smsc911x: use devm_platform_ioremap_resource
  net: smsc911x: use devm_alloc_etherdev
  net: smsc911x: use devm for regulators
  net: smsc911x: use devm for mdiobus functions
  net: smsc911x: use devm for register_netdev
  net: smsc911x: remove debug stuff from _remove
  net: smsc91xx: move down struct members
  net: smsc911x: remove pointless NULL checks

 drivers/net/ethernet/smsc/smsc911x.c | 216 ++++-----------------------
 1 file changed, 28 insertions(+), 188 deletions(-)

-- 
2.46.2


