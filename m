Return-Path: <netdev+bounces-112706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841393AAA9
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 03:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE92B21914
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FAB6125;
	Wed, 24 Jul 2024 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv5SKB2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AB5223
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785628; cv=none; b=G5xgvzf1DOJfkFN3Je3i3nu8KIxXmMvzBtLAM9umSrDQvq2WnR4suvys1+p+4TnAHKTmW9VX8uv/QURcmG2c3fyaB3WVTR++9SQ62iLoknqTWcQacwiG02wwuFSr1yFkom06nr6xYp9Boevgg93GAU+LgHGhTWdCJ67UMz0r26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785628; c=relaxed/simple;
	bh=hlwUkkR6ZCbclLtRWSJQO+QCQGfy1tVxwlEOvNxIor8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZg8Z7YznEZJ5YvGeD2y5eYLU9BmlfmuQcr3gzmwDTYDWRdN8KDhOg9ZrQ4656pGqZcd9avUmz9CVIN1+xl/plJxG6QQOHOk7535GNMNtOwOo6N6zBvdOGEoqNiGvfLBfVpgNAKUThcUMeZ+5T6QyFTWqru2rNVRcSpVBoHOfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv5SKB2E; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a211a272c2so271690a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721785626; x=1722390426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAZGFPaCPLEld48/O8CI5jp6PH5A8pSV1pKBW/RDN10=;
        b=iv5SKB2EGv47DJULnwEgN0XGQz868xbRDNdFDulyK98n9pIGyxbXH1N1cefALSxkc3
         g1xaR2qeSOOr3ILdh3ooCX+Vqa4ootpviVeqfOWhu3pSUXNz4FSee/O2Kmk2YWMPw+IT
         aO7EvwQimMfzr5Lc9WxAPaLmnvdxAdtEMof9FQDV8uQuO8XLZa62CDfewkIoweoZZ0oK
         7JsrX8ZiV7wE+BbJb0KzH/OzleISmwZS6jS7OyBa6dgFuDQQTQgm/krmaB2TToxk6TOq
         oazI9ha4UP84jmF/4HSynJ0yImC2z6hC/PotSQy6qDOP7pq0zuWoPXtIQ4qaxGxf013y
         3LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721785626; x=1722390426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAZGFPaCPLEld48/O8CI5jp6PH5A8pSV1pKBW/RDN10=;
        b=DIWDEZOL9cxm6BCpbTCeiLGamQJuF4pJ+idyPcH8/Sf2wO0fDatUZG9tRePvgb1sdx
         bjRrNDzhbwhX4g9cp0hpsyxqU/k0sNO1TUHIxK0dtBhpLn2oBEVepk+VwYEU4ykpXdvL
         y4DhXhYdPNDHzqgCc7cV5on/IiG+YvNMXuc/guykHPpgfG4bhy8PWaKw8Qb/9SA2KlQ6
         WXrAe46UpswM2hyx9F3rY1gfjzOUKaoK/yCbTOfa2y9MKegJisJ4PlyzBsyhZoWPv8iY
         7baqERM9my64A286IsrM0TzV7exajWMrUbUYFE9S+xq43ipcJ/4mBzy9ak0ICxvAFz1P
         hodw==
X-Gm-Message-State: AOJu0YxwpKlqySg20LIibSaSmMvWDDITAyLWBhEB8tcSgIF7dfGA8Cdm
	gjS0JVXcUkyGWGOjstUD458AHT8wA5kEL9RyC6MMQ96CE+cZoSMrb7WVlfFn
X-Google-Smtp-Source: AGHT+IGrjhyzWzCniMSoCRepn7ol1wEpbCZ4070LYzTFsVwaCjCE3d0QU1AJ6ZnhVtiJ7AlGoS6zCg==
X-Received: by 2002:a17:90a:c213:b0:2c8:5055:e24f with SMTP id 98e67ed59e1d1-2cdb9397a98mr761531a91.2.1721785625652;
        Tue, 23 Jul 2024 18:47:05 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a5f5asm314564a91.8.2024.07.23.18.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:47:05 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Subject: [PATCH net 0/4] net-sysfs: check device is present when showing paths
Date: Wed, 24 Jul 2024 11:46:49 +1000
Message-Id: <cover.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal.

This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
check for netdevice being present to speed_show") so add the same check
to carrier, duplex, testing, and dormant paths.

Submitting as separate patches to make Fixes reporting accurate.

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Jamie Bainbridge (4):
  net-sysfs: check device is present when showing carrier
  net-sysfs: check device is present when showing duplex
  net-sysfs: check device is present when showing testing
  net-sysfs: check device is present when showing dormant

 net/core/net-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--
2.39.2


