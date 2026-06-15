Return-Path: <netdev+bounces-299594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id md/zB5NYMGq7RwUAu9opvQ
	(envelope-from <netdev+bounces-299594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:54:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E86899D2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:54:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mYLdmI/p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299594-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127D330DADEB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93493B4EAA;
	Mon, 15 Jun 2026 19:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB13AE1B4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:51:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553065; cv=none; b=luIf3zJ+ECL2sp9i5U3x1hThW48piqxWDVnxhcga++eWl5KkBATcrXLN28ikofNOnKG90eJjckTGTWCvdiA6xQMWoI7NvO2zni2nJnqWTpKUECcgS7XDlL5Fc3SK4z4kbunJ+fiFFaaae3Dhjfmuu8vNkfH8ldhNLGfqiu4qm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553065; c=relaxed/simple;
	bh=XiN2TAV/Jyt9rlfhH6SndFvcpYzd2iWP8XXKPVfWnAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvjeXX7ZeR7aHqS5QItS9TL+t7e4wVeW+0vfZXBJTxLyj9n2wrSH+CD2YdPcqcE2mpaobSDiEtRfofeq3+3HYvDTnaFSiWjj0hT9YeI3Rcb1asw7B3iiX0/TCOzmSq6219pAzQhhh/nbSxFjs6awEOV+JNG7DIxMUug9tkPBuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYLdmI/p; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso23393855ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553064; x=1782157864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kR2H058KfWptgCGHf0keM7qDW2F2uynpG+pGsuzFvRs=;
        b=mYLdmI/ptaO92JNih2lqipfXupiC9p5mz09Zxws9fwIr5bSBWjmQrwlRf95orK6zGE
         IJO8NMxCkN72ZJ+1dOqATWVndwkm/M5pYML58ZslnFH5eKY9CWboaR9TdLlYHax79RqV
         HVtQiAqkpE0dO/x8P15nWMKko2auJKGi0G0fyQ+fiZJUBRJTyuAksxdRt0KhT3GS/bsw
         Dph0IvAlk/rHBukqYbsbugPpMwV73a+EVoQOMe4AU4rV8bO7fHKkJgYIYowMCq957chP
         adko3c/SzEuUUOdE1w+gkUfLkHYwc/AmfgLUrjDxOp6s9m2NhPCy14yS/K1EGnMu24Lk
         wnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553064; x=1782157864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR2H058KfWptgCGHf0keM7qDW2F2uynpG+pGsuzFvRs=;
        b=HCYyKIhres79sHAMB+IIEtWfRWjM0a3hu2lizMPYsgXr/BFxJzm0BSX08e8h7Dwa45
         fsi0bdPi7a9OmvPMdJTuSpdzasDogwmPOcQ5YM/m44dz39hlhpN4tMi3j8mhua6qO0Pq
         j7BF2fuVh9x2hkJhL1xm30fF2v64LJp16xqqvn/VDjUKtPmGN3JdIwrpyrFM6nKO9md1
         Xj9YQNo6zS/oss9DxFN6+BvufEXemVDp4BIBu0pao4qW+qpnZDLdMgI9jVTd8f03aWhm
         ZiiTuVD3WpLGWdEPfCWSXCUorBMDT3Vo5La349WNh9h+HYnIclkRH4dZBODUCUhDy/zY
         M21Q==
X-Forwarded-Encrypted: i=1; AFNElJ/XgTnJ9P44HJDnYR4Y1rPrxb+duxmra822hppOV+obWsoqotoECIfLPr5YCms2Zl13W9rFUxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFXmIPkh5UyHvlexPD1C5i6QkX7BAG2kZEHlcmZmFtqV9MppY
	BqdFzf+pE54YyJGPrQPe5SzD6U/nl7wRamJlkBGxjanUs45qtwPL4cdL
X-Gm-Gg: Acq92OGeR3SxGq3nLk83tJQO127Pu7ufdvuC6BLE96pxDwlxSMmR2nTprBhh7ns83PU
	+oamjZW9xQ0xg3Vt99Dzt1ol1ClELhfn4/lriNyTdKyLA0dobpmpbeJLWT/jinUOMeWra51V3EB
	IfDzh7Qb1x/0GsLTwIPyWImYMnYuTkm1GRJ8npLnbgj9wkejZP+Q/xOeT+kWLyGdvWvcCndlLPh
	zjeb2AIOU/uR/cv/CHKxsu7dDwe4CAook2OQoxY39ptzpucGRNk4LrnUO/uu1ig0Ihm4EHghLIh
	RQYczzTcVF3VRUzOel7pJ3HcBkIoLP4amOhyfk2WLa7dacT9OuEhRABV2p9M+K72oRqlt4ED/tz
	e6N1WF3SKjzDLxoJGURQ2GN0zQOEUbOTt34Es3SJ77qipqbHg6Vtq4u3Nl1YtoQYLYZbMpZe/cX
	yPXI16KhZtQCsyQX9S3SllySNGrepD+HscnBU0MbQN9md10eZsKC8pbkonytJdFg==
X-Received: by 2002:a17:903:1a27:b0:2c0:c940:dc1e with SMTP id d9443c01a7336-2c4125593d9mr173197865ad.20.1781553063994;
        Mon, 15 Jun 2026 12:51:03 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5644sm113307285ad.4.2026.06.15.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:51:03 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node refcount leaks
Date: Tue, 16 Jun 2026 01:20:30 +0530
Message-Id: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299594-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 837E86899D2

This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
driver, found by inspection. Compile-tested only; no SP7021 hardware
available here.

Patch 1/2 fixes the phy_node leak in the remove path.
Patch 2/2 fixes multiple leaks in the probe path and depends on the
cleanup contract from patch 1/2.

Changes since v1:
  - Combined the two related fixes into a single series with cover
    letter, per netdev convention.
  - Added "Compile-tested only" note to both commit messages
    (Andrew Lunn).
  - Dropped Cc: stable@vger.kernel.org -- the leaks only manifest on
    driver unbind/rebind, which is not a path normally exercised on
    this SoC (Andrew Lunn).
  - Fix author email to match Signed-off-by (DCO).

v1: https://lore.kernel.org/netdev/20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com/
    https://lore.kernel.org/netdev/20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com/

Shitalkumar Gandhi (2):
  net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
  net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in
    probe

 drivers/net/ethernet/sunplus/spl2sw_driver.c | 20 +++++++++++++-------
 drivers/net/ethernet/sunplus/spl2sw_phy.c    |  6 ++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.25.1


