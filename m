Return-Path: <netdev+bounces-294837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rsY3KG9eIGoU2AAAu9opvQ
	(envelope-from <netdev+bounces-294837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:03:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301C63A03B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C8t0gMMy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294837-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DAEA32213FF
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A93E959A;
	Wed,  3 Jun 2026 16:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF43E9595
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:27:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504051; cv=none; b=J/jdyHJNQfhgxm7EbYtQEq9OArWiz3Nh16wWTd4FQVQnYKxfMHVo7vqaCZc9bDQtgrqwPl3PH7UIVrH8CmBwSWHCtRaPWN/wmlpRl+v89RpQm3j68XZGwUHnzFTsJ+Nkt8VP71e2eRvbg6AbISJHPjvREkbYcgOGky8QMUm0OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504051; c=relaxed/simple;
	bh=KsALnQ7OjE26KILk6ZSGe6Ke9EgzKl/HnCEeCxpI3/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHutQfHM3u3tuj7XFIt3sj9rJ1LWS81H8FMbyn0u5GTW/5oiAGMq4rfmtrnz2J9xZ+f+wqzLxoGoRb7PqUnvyYmmYZE8f7sPr++Avak3m/gHPTOu0c1ksfPcLavaFJE7/Smny2ZplpN2fIDOflS3/wsdP1rPQMe557PnZEHRdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8t0gMMy; arc=none smtp.client-ip=209.85.221.174
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59aa414167eso2026351e0c.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504050; x=1781108850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LdSRb4C5c5f23VF8YFsFSRCjScwvrWEISBSuouPkOs=;
        b=C8t0gMMykGqM1sY0tLLsRMlHsYkL4xV5d299oDJJKM2ka2SpckhPX8Ug6u9ykn3Qjc
         PzGqH3EVquDTG28kwFlhOJSPxdy30yo45HJtoX4E/m6oGMozpUIwSi2E0DV86ZXUlvri
         FLBvbCuhw80EpNqRAR0ZLPsBwcrngD9jeVfTJjgjxGcEzUmYAEthSVvI5soxEqi0iR10
         1owDkDCoEV+soYcoj8GG4hF9+Z+ZPeDAzGDb1I+y19BRJYd7hbnFIzf5QIa2iOw8MO3a
         QwNDkmUg9NOaLSvltslEjT/tCBHtcg2Hp4d57eWAIOuEJ4ISWfAigNQU8/dhV9hmY5gN
         kiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504050; x=1781108850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LdSRb4C5c5f23VF8YFsFSRCjScwvrWEISBSuouPkOs=;
        b=RRPuDX0IuWcmfEZSop8S45Mt6ZR1KxTR1EMXV5v4m4qVDqllJTLci8h4cO7fWa0jT/
         ZY413Cygj6jALLo4ubnyweP21HmR6f78OU8IrDViwcxhEpNzXwVN4FPpTFNkmNAxmbiT
         IkZFsQAO9rmQtugP5xBpDJ4Fm+63c4rHXvs+Oa9UXgPjWCPTfM4a8lfUMjBadDEDLFxi
         CSmW8DlVq6vI1mBpOBSWyB3XOPjkMSGgRhsKTIWnbF2fhxeiNGn0LuqxoeTfYNCwlR3J
         uWRVbJ271cdwifIeN0+jtYTXEPOkpZQRe8pVJJ2sYRp6vpWANWAKppxI7Rl+t0//SRZ4
         d1pA==
X-Forwarded-Encrypted: i=1; AFNElJ8cLn8aFEwfr7pbWbjiRsLOmqesByZZS1mwstTGMHGFdKngSv8I7WtS37uNA+3k63cxNxRXepg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ctdBV899z+UWHT6Jl/65L+4I7PxJiBc8mmMe2bdC8U0qRLow
	qwGv6UnOWEXzN0lRRj1FuqIB0+z9Q3r7zWEsoSoseO1z1hlfketVO5TH
X-Gm-Gg: Acq92OGdsgxVHEDeon2Cl0fLSNcaALEkUjQjWb6vu82uj0cNPr4Axass7Z6IeasqFhJ
	itFSiDpZ61Se15yjJM5aDtA3eiA1rSRFUltCP1SwEnKxaL1hbkcR2RuAd4UarTnyoqNyRpm1XKr
	9vMm6a9NLbxzJmCyAvz00jGFjElgJr49F6g4rsw641bW5VG+hIgsgogXhQYrKmU4mHSu5RwGmbi
	+2DUgLbGtGCxnMyOzxLELgpovC8ta1Y1ScL0qODhDuDuBJR2KRwLulBlFVL/qRdxa4/zquEZ03N
	4/qC5+znVvdQFE2h3eg/oyCSCeqUaC5aYfEI8nNrqQpMdsCc32AGNGQEMFYEw1N9oKvUuV4mhno
	0L4gNtjGWx2lvI0L27NGM3KYmtv9Kga6tsh8qQsSDEm2aYCFFaasPGeFxI39JiVGoe6e2MkEnKy
	WNhRfQYJ7pxlc0ljFXMj1MX+vtvl278LyeqkEAwGge3hiwKbw0IXzOiszDlAf2qBB5FBC/1fJOv
	FWzwrMu5E8cbfFtWJH11pWQLUKm
X-Received: by 2002:a05:6122:1814:b0:5a1:fbbd:6bd0 with SMTP id 71dfb90a1353d-5a6e5612e27mr2148393e0c.5.1780504044819;
        Wed, 03 Jun 2026 09:27:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d777a638sm2752657e0c.8.2026.06.03.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:27:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-06-03
Date: Wed,  3 Jun 2026 12:27:14 -0400
Message-ID: <20260603162714.342496-1-luiz.dentz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294837-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2301C63A03B

The following changes since commit cdf88b35e06f1b385f7f6228060ae541d44fbb72:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-03

for you to fetch changes up to 149324fc762c2a7acef9c26790566f81f475e51f:

  Bluetooth: MGMT: Fix backward compatibility with userspace (2026-06-03 11:24:12 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: fix memory leak in error path of hci_alloc_dev()
 - hci_sync: reject oversized Broadcast Announcement prepend
 - MGMT: Fix backward compatibility with userspace
 - MGMT: validate advertising TLV before type checks
 - L2CAP: reject BR/EDR signaling packets over MTUsig
 - RFCOMM: validate skb length in MCC handlers
 - RFCOMM: hold listener socket in rfcomm_connect_ind()
 - ISO: Fix not releasing hdev reference on iso_conn_big_sync
 - ISO: Fix a use-after-free of the hci_conn pointer
 - ISO: Fix data-race on iso_pi fields in hci_get_route calls
 - SCO: Fix data-race on sco_pi fields in sco_connect
 - BNEP: reject short frames before parsing

----------------------------------------------------------------
Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
      Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
      Bluetooth: MGMT: Fix backward compatibility with userspace

Michael Bommarito (1):
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

SeungJu Cheon (3):
      Bluetooth: RFCOMM: validate skb length in MCC handlers
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
      Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect

Yuqi Xu (1):
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend

Zhang Cen (3):
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/bnep/core.c     | 57 ++++++++++++++++++++++--------------
 net/bluetooth/hci_sync.c      |  5 ++++
 net/bluetooth/hci_sysfs.c     |  6 ++--
 net/bluetooth/iso.c           | 63 +++++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_core.c    | 46 +++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          | 17 +++++------
 net/bluetooth/rfcomm/core.c   | 67 +++++++++++++++++++++++++++++++------------
 net/bluetooth/rfcomm/sock.c   | 26 ++++++++++++++---
 net/bluetooth/sco.c           | 20 +++++++++----
 10 files changed, 233 insertions(+), 75 deletions(-)

