Return-Path: <netdev+bounces-125828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A396ED2C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF931C23B5F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E3156641;
	Fri,  6 Sep 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSqvS5tw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E915624D
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610080; cv=none; b=Kh/gfT4SFE5BXvFaTh+2CWBC4yABRgM9a7S/3SZ+QyswOlvUBFWVSfraP/nOE9qBHQirHoYruGPqFDXEcHvpsLW3X9Y0xKSNbJs2pBwSli1IxRJ9gtHLzvI/Bq5Rn/wyT6mmWSG8Nnw8DLsj7KdG+U84vj/EaR5Lj3sR8rxw5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610080; c=relaxed/simple;
	bh=U+GT4kBvput+yec7Zhw7I+cDWhRpXkzd9O8tXU/2WKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plYaTdyPGcJ1hDCRNlQgRQaCYNQdYpytK//8voc6sHXq58hdQDqDa8oiACE+BKOh5s3B3q9ds9A8ktnAb5sqOiHU0/MzR61ga0W/IFXPZ26rVqBYUHcorPYUbeYvUu7n43fBis2j/iq6xPvq6ispu1Aln71KvhPluKN4BaB8S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSqvS5tw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-205909af9b5so14094215ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725610078; x=1726214878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtoHX9JYXc1JCi6KnNTaPMSU5N6tGAXxBcUN5QPyb7k=;
        b=QSqvS5twKZISpK9Qx/hLtgR4Xg8caXdPXxegB6KBSP3g1/9IxYyokYbqMAw5xkNW3M
         eV4lagsuMIpbXqW+wclvFecSF4A77M4FNJyQYvUyGBAklSVO4f8qrg578GBUctgsW2/h
         U7x0mJR0KljGmYN3KYU9sOESzIxz3lQ0uxThIjwyDPQp/S1GFH48aaDNtqd+DmJJMqfX
         XLpMFwEM05I3PIgJAA+73FoI7k+AD8/UKlVEl+Maz5u06BWBpU6LLpdqQ4Obx/IvKPT0
         mp1P3szlNmn5zFPF6EV29anUNCW25+uQ4Zziuee0pWSIB1fikDoMY5I3Dvg88+O+aJRD
         PutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725610078; x=1726214878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtoHX9JYXc1JCi6KnNTaPMSU5N6tGAXxBcUN5QPyb7k=;
        b=Jq+H4D3E9S34OC3s9hSkVWdduKctQk/3GSBF7x+47RQ+KoFD5lP468ATrMEYkJukDr
         FqIRV499fZvYSGz0ZqGgcukLjzLHnlWkWLJ9Uk77Ev8W4BS15Y5awYBNAe/qbEtV+xk3
         7dMqEqFib30CaxEMSxN4gBcXH9V20eCD60/Wn1OB5qyLyILQS6yswswzh+BKkS2PdibL
         NNBqeCAD+JMXoOSymxpO5GJB1jkJRwwI6eP8gPfFy1dPApLMyJdHEDHyXPMkwtg9641E
         Np55ZZm6ei5wLHQg4WmP/Qa5alPlxVPZYPk57pedZZuKJKhKFGAFWZeyn/wmentEuXpw
         Mz9g==
X-Forwarded-Encrypted: i=1; AJvYcCVSG9woxfdLpW810bhnv++EHpPgIeJOJto0wy4RVn/dCLQJrk8Y9bGN8943X6biXy34Ek1mWOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxov4As1oPf3s5tMlyLZ7Pq43QguEp4jNMRd4HwtQNu2WveVXhB
	cL/q3P3wniQ1UXa1NV1Pk7V/orIYAFq3fZngy/C+Tk4oCdP1r9vB
X-Google-Smtp-Source: AGHT+IE9A/9u9cskDli7738QaIxcpCFenT6w9wk2s6Jas/4GVqCQEPpZDNXVtyRzaASV7TFRc0yKnw==
X-Received: by 2002:a17:902:d4c2:b0:202:13b0:f8d2 with SMTP id d9443c01a7336-206f05afdb1mr22512505ad.46.1725610078240;
        Fri, 06 Sep 2024 01:07:58 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912facsm38965205ad.45.2024.09.06.01.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:07:57 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net-next 0/2] bnxt_en: implement tcp-data-split ethtool command
Date: Fri,  6 Sep 2024 08:07:48 +0000
Message-Id: <20240906080750.1068983-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NICs that use the bnxt_en driver support tcp-data-split feature named
HDS(header-data-split).
But there is no implementation for the HDS to enable/disable by ethtool.
Only getting the current HDS status is implemented and the HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows the rx-copybreak value but it wasn't
changeable.

To implement, it requires decoupling rx-copybreak and hds_threshold
value.

The first patch implements .{set, get}_tunable() in the bnxt_en.
The bnxt_en driver has been supporting the rx-copybreak feature but is
not configurable, Only the default rx-copybreak value has been working.
So, it changes the bnxt_en driver to be able to configure
the rx-copybreak value.

The second patch adds an implementation of tcp-data-split ethtool
command.
The HDS relies on the Aggregation ring, which is automatically enabled
when either LRO, GRO, or large mtu is configured.
So, if the Aggregation ring is enabled, HDS is automatically enabled by
it.

The approach of this patch is to support the bnxt_en driver setting up
enable/disable HDS explicitly, not rely on LRO/GRO, JUMBO.
In addition, hds_threshold no longer follows rx-copybreak.
By this patch, hds_threshold always be 0.

Taehee Yoo (2):
  bnxt_en: add support for rx-copybreak ethtool command
  bnxt_en: add support for tcp-data-split ethtool command

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 10 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 70 ++++++++++++++++++-
 3 files changed, 91 insertions(+), 19 deletions(-)

-- 
2.34.1


