Return-Path: <netdev+bounces-307198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJnpLkX0VGq0hwAAu9opvQ
	(envelope-from <netdev+bounces-307198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:20:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79674C4DF
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:20:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AN7w3NJB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307198-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABD383034A2B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31F437127;
	Mon, 13 Jul 2026 14:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F21F099C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:19:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952393; cv=none; b=HBiAfZXUuo1iBwLDks3Xgv76XPV76D5RMGk91pi/GMfCpTyDZfMftASMesX51pJBANzzQ3YME+ojSCHO69HiASFWSdgQB7wvdA5GEozNndehyrLMfVF1bU+LJyrV0PHzpL11oDlw1C/5IOQyxUUEJ3riTZF5kfwSrv1jOGMlzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952393; c=relaxed/simple;
	bh=HSlD0G+1NO1J804SwzOhBO53801rZi0eAjWh+vAbNjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtkcDDxyAZnCgQIreX574oqmvbd0MTlx0GDOjimXHXN6kDeX07jm3N0IGSntZrFyM0rSo5YjQXyNFcq328m8QmQsjNvplrRuRH1Dwcm0uRYr/cMSCMQOb7jdUu2HmTyBKLgP9433v5kpN1rb/14PTYk+vcNaHn/s5vCLRoOQOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN7w3NJB; arc=none smtp.client-ip=209.85.217.51
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7380954d1c6so1141127137.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783952391; x=1784557191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHRuq+0PlV02iNJ53ayTa7ZvWzJi1MCxKOTZd93rI6Q=;
        b=AN7w3NJBz1dMUQtNIMV5a9gSaPc5m/Vh4kf/3o/gp0Y3zqU6k+vYflYRrA2u5gHaTq
         XYC33u+CM/SwfzMUEZVXUY2IIk/96V+Shm3EsF6xPIshu9WxXJB5Xq3Ik42ZCuuQ8Gv4
         k0VsNuQm6vxTHTI1e+in7iB57dTjnNInYIuuXSItFuKfyCpoYWV+ZJEOJkzgEGdRDVUI
         lUoEUDjQd/qgVu9awhXAsNTXq55qPYxCb2YSIzdynckGq0JxePKHXtYAKUgmiOas+VhA
         gdS8gRyVGBEnupfnaJBqcBn6ydeHgZuqyvy5DY6XO+faxkvc45I1u/+MntFLS5wFPFiV
         CFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783952391; x=1784557191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHRuq+0PlV02iNJ53ayTa7ZvWzJi1MCxKOTZd93rI6Q=;
        b=jGMeMv1s5VtXcwlkwom1uC3fSjw0sH3baSgxhMvegTgOCxAKJVerPFJXf+iSjB03Vv
         q0HhwwphqF3WYBELoY5lFZP/nQvr8J8IKA0VWZKuV/X12CQAAZ36h8av5DJmIrHUlyyj
         6LA5y/cajgVHDWGO73Wx6JlXnfFjQtn8/LXVc6gV2/bTwllGwghQEYMfhfCVVzPctRWx
         l0se2ExUVHufEZr9vlK47/FsU59dmX/dV5iCJy7GWS/0OJpiWuokvRkAGkEBvY4yDASz
         cPagzskPpR+VERyJKnJjXm6XGB2CrumpEHaRolDT0XDc7JVZ6na0KOnYovLUxNT0txwy
         DJOg==
X-Forwarded-Encrypted: i=1; AHgh+Rou9WLSwJxqISVbD8plHcQY/ehJvve7dN+ylxSLlAIcXp8i0a9BlH75DqzoaSKiTYP08RIGOSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseZW04lVGMf3qkJbft4bzUjt3VETihmNWY0KHaubSU+NIuxAC
	V6pTnmGnVPiLOjiv2lwYu4892ihdVLtbfzSSK9+7jKBw1U+LNY8SlFj6
X-Gm-Gg: AfdE7cl9P/BIcKj16sr1GbfFPR9AKygbyN3uzF1MpN/Ioq7xJ7WndH5dV01E4UJS/tA
	3kt7AiV/Z5sMJysKqmsKJJcYafYG2Gsz+BDxpVZixCaoz7fcKzr5qjE4hqnXLGpeK1hPJ4MndS4
	LFBd8opGtqwJvHshgifQ5nF6h5cz+o22Mp292Wavykq2oj8KsFHpZmrKJKz4+5BJ4EDYY3nSVTt
	t8wY0TidWlp+FA+IydCtHoQFy82kejMBMne+QgXgeh1/eG/h2MtOE3/KHG2KSyEJS0FmPSJBlAN
	jINCSCJM5t5xDzv7MfM1DGzfPsU/fLPwk3bPXgL03y6NK70cPvTxaf8JygXYnQS5n8VFBqnHy/I
	6epS8O9OyvU+eBQM8PGIylqQ3PAzLuuky3vWb0iEYGvymTeSSercJCDQLcCBXL9y3iykWwry2CJ
	Xxxc78O2Sbj5b1SgjD/d/VZbKcxXt3QMrbzyv4cX91vZSHTyYclJdwN2LRjmwxj1EQ+hYjv9Gwh
	HzgcKY=
X-Received: by 2002:a05:6102:4487:b0:73e:9fae:5841 with SMTP id ada2fe7eead31-74533ea3581mr5049701137.29.1783952391050;
        Mon, 13 Jul 2026 07:19:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6e38b3bsm8980017137.10.2026.07.13.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:19:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-13
Date: Mon, 13 Jul 2026 10:19:40 -0400
Message-ID: <20260713141940.954317-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307198-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E79674C4DF

The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:

  net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-13

for you to fetch changes up to c1cec2bbbeb5922d42d28c6af1707c4f3f8647e3:

  Bluetooth: mgmt: Translate HCI reason in Device Disconnected event (2026-07-13 10:10:13 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: hold hdev->lock for hci_conn_params lookups
 - hci_sync: extend conn_hash lookup critical sections
 - hci_qca: Clear memdump state on invalid dump size
 - MGMT: revalidate LOAD_CONN_PARAM queued update
 - MGMT: Translate HCI reason in Device Disconnected event
 - MGMT: fix locking in unpair_device/disconnect_sync
 - MGMT: hold reference for hci_conn in mgmt_pending_cmds
 - btrtl: validate firmware patch bounds
 - qca: fix NVM tag length underflow in TLV parser

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Mikhail Gavrilov (1):
      Bluetooth: mgmt: Translate HCI reason in Device Disconnected event

Pauli Virtanen (4):
      Bluetooth: hci_sync: extend conn_hash lookup critical sections
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
      Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
      Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

Ruoyu Wang (1):
      Bluetooth: hci_qca: Clear memdump state on invalid dump size

Xiang Mei (1):
      Bluetooth: qca: fix NVM tag length underflow in TLV parser

 drivers/bluetooth/btqca.c        |   2 +-
 drivers/bluetooth/btrtl.c        |   5 +-
 drivers/bluetooth/hci_qca.c      |   4 ++
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_event.c        |  18 +------
 net/bluetooth/hci_sync.c         |  66 +++++++++++++++++++++---
 net/bluetooth/mgmt.c             | 105 +++++++++++++++++++++++++++++++++------
 7 files changed, 160 insertions(+), 41 deletions(-)

