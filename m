Return-Path: <netdev+bounces-250367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB13D2972A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C913012BD0
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239430E0C5;
	Fri, 16 Jan 2026 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZilpU7kQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3425B2FA
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524645; cv=none; b=POMgiNm58Sng4s6rNAaXVRPdZY3Cl0r90PmRKlJ03KMmzMBfZbuZL7SA3oFKke3R4Pmsr920ciyiZj21IiXFCMEDdSvD1iL+djLvW/82V/izQMvvumJOngWrw25bTOWlybTEqRlx0KjAYT1J9hRR9kQajG/jIeuk3hPT+cw+bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524645; c=relaxed/simple;
	bh=IekgESYso/VtdysETKoepRWZW11gku0FO7gxlycP314=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNK5GeoTB4+CDrihxbxc3crnFW+hhKmAIZJVmp3gnp4/s/ZzrC+jzvy95zy00rbg9smuXHlg+axQJtIFmCBYb180oFcYeMcGElaqHRXND4fbW5ZCBHaYtBXbEyw8n4gZTtOur5m2DJiFUV1ZMMZYledxptpa00YgWRMs1QECpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZilpU7kQ; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0d5c365ceso11219125ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524643; x=1769129443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i5vPsV0v4d60Fj0kMz4pVvhTuDiMO22qBG7C6Zic+Q=;
        b=pkeitSOKRKSdGE/eVpDxbdm5EJpoINJ/JHc/lspiPfNczBjO0AmzpdxefUqsyE7bzL
         PPSrShecF5egzt51gRyaQNQGdrJScLtzoF9rqvDc0DQJAwlJBTAREydDFWXvZJaOqw92
         4Ns9eLo+fPtd8wBrHz/2K2KdDj1YhILGzTr7BkwXO9ZtHRLfrh0L0vaqdc18zMQQ1FB3
         yWOXCyB2u7Dh8g/B/TrU1Ar/+ejbzbb9o/kIIUc3rGpLINosBU1ThWAX2mbzDCOjY3QF
         ediEyEcDzwF5CBsamN9RecEJAXoDdRih/Hq7WLACDn3wxHX2yWa5kIwxmyMKOWWTLppS
         5bwg==
X-Forwarded-Encrypted: i=1; AJvYcCWTvDtIQBGrvgdNKQJi0hHrslqwG+zmt+Vx/4uY3/2F4EFh4AlBJgRTvzkAX/6ho5Xlx0ctA70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGFT+TyK4WoMpOTr5pd+wboXwqbc7Re1/o7JofObDkFgB46UC
	RsSJW3QJucDJPGN49wTuztHjh8vNyJvysc9jEJykuQYuehp0GU8J1UgyWcNUkV3pWZa19vy7KAn
	zVTc5sjM96wFEEv/Htgw5X+icJXgTmXhMTX244dPd+QrgT+XkGeJyqZ4eKOw0MQFTOBN3iHWj3J
	hOyl77/5BTggPB/cmNLnQfSZo98y+h60vmKlqMKYlTOGtGJCiQNIH1hmrmjGoFqBt9jVveMPlcy
	tuLR/Uh3A==
X-Gm-Gg: AY/fxX40vtM92S2+2JMHWwlenkOj1P60cX0U+8qyjW7wqAOatNDKPREHL9ZVbF0DJbW
	J+DlCNumFBuDw0GyVYBAx/1GN4CYlZ1ghLIcGMy464fqeaffO6CiMtmN73/O5Jzc5PMIRhQ0zpF
	C15ZWmptYD+AdJpQOKaM2gVtUxeZ7JaETG4NinUamiFQZcL/Z1YA8a3QbhH4xFVPhbuDQNnXmhW
	XsS58csyriCPSh6xSRjtkLjnmAEWl22rwAJBzHq6m9T6YLtgf/yBAeJXyAycOPgJN+7FnXAvbRC
	cL6Ely7iG5Il1nVSjV6pRW5EE3cPhMB6XCdbyDto+l3DcVFxGvguUqZbuW1RxLBoV3XKNuakRMs
	yefF0ooCCXQVjqZ+3VKMv4qerPobpFv6B/ldrIiPRmQJbsaUQVRA5XATM8cB1niBikVG3edg4NM
	qs4O9N8hpXoyvu5Wi6ErwlyZxn/JIIYu5w/Il55VWwQmM=
X-Received: by 2002:a17:902:d490:b0:29e:9e97:ca70 with SMTP id d9443c01a7336-2a7188beff1mr9325285ad.25.1768524643487;
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a2bcfsm1191545ad.1.2026.01.15.16.50.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12339eea50bso7999069c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768524641; x=1769129441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3i5vPsV0v4d60Fj0kMz4pVvhTuDiMO22qBG7C6Zic+Q=;
        b=ZilpU7kQn4VnSqU3kwoJFKMPtt5AhQ/RUYh3h3VliZRX0I3e81pM6anT/wH8rI6xky
         sPRYnMQ9wLPGn2+87Cn9F4x77NrYWoOC9au9h8L4qmB3wPpZNtheIam6BdU/T2RWm+BM
         pd00W0DO8IIXf5mflUnjktHUYa12VV1QtEpnM=
X-Forwarded-Encrypted: i=1; AJvYcCUFhEA6ifL6ZSG4/JKcqvkpF7GiL+bZMuVUNySKevwvncwWJd0gLedpBigrjlHIbziJA0QuVbg=@vger.kernel.org
X-Received: by 2002:a05:7022:2514:b0:11d:f440:b758 with SMTP id a92af1059eb24-1244b3705bemr1243508c88.25.1768524641214;
        Thu, 15 Jan 2026 16:50:41 -0800 (PST)
X-Received: by 2002:a05:7022:2514:b0:11d:f440:b758 with SMTP id a92af1059eb24-1244b3705bemr1243489c88.25.1768524640704;
        Thu, 15 Jan 2026 16:50:40 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm1162305c88.5.2026.01.15.16.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:50:40 -0800 (PST)
From: justin.chen@broadcom.com
To: florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 0/3] net: bcmasp: bug fixes and clean up
Date: Thu, 15 Jan 2026 16:50:34 -0800
Message-Id: <20260116005037.540490-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

Fix an incorrect channel network filter channel configuration and
an early exit cleanup leak with of_phy_register_fixed_link().

Clean up and streamline some code that is no longer needed due to
older HW support being dropped.

Justin Chen (3):
  net: bcmasp: Fix network filter wake for asp-3.0
  net: bcmasp: clean up some legacy logic
  net: bcmasp: streamline early exit and fix leak

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 37 +++++------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 37 +----------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 63 +++++--------------
 3 files changed, 32 insertions(+), 105 deletions(-)

-- 
2.34.1


