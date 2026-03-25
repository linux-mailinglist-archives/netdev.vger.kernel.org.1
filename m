Return-Path: <netdev+bounces-271713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLxyH587xGmMxgQAu9opvQ
	(envelope-from <netdev+bounces-271713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8DF32B747
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F97A3019C83
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB13FCB1C;
	Wed, 25 Mar 2026 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEX9SAxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AE331A4C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467852; cv=none; b=mUwfTVLpQQLKv+FcIszNOZyhy08alpjW1jtBssyLsjR+kO/xBDXIAu+vPJTu5hNou5RySNzkbFlbi5KhCkbtUwlzhVxSrRe3nwB2fZJtwvPvfE1KrpaZ03GyrZmwFgM7Ybwx2TvA5BgHQYHnPQC22NTuNEkEziMztBHiQ9roODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467852; c=relaxed/simple;
	bh=78c9neIIAyWLevt4ozwWCiA4bTLgXpJDR+RWtdoP8iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1MlwKh+2tCr4qEnNwCYE8d9+16qQcMAmmW1iGOt9CzE/TSEJ02f3Iv0auBgqs6X/gq2Tke0R3qdzncZ8OBNFMWJ0CDCwLJCh+poJscyYO113DvKI1YpFm1c3ktJMYZZnUhn4wlcb6vyQ7UWllZv9nb7AprEYYmDLy0MztX6YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEX9SAxp; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b6c7c8d00so201031e0c.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467849; x=1775072649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vG63buxikYzZRa5bTcoW9Euem18H8lifInafLz0wjA0=;
        b=JEX9SAxpy4edbn+QLPPcSaZLrTpl5he6WE/GqwC4wMl+p02yQulTExeyDS2GROYZMq
         JjGlKAMsEk5FpUYoyHMOp6u3w5I/LI5KTO0alNhBZH25WD32VI0q1iftimECCjpmVIzP
         4czU/MuRKvucu5w0x7fGYTJeb+jB471Zm6yEIbPuqoYtzTdUrHv46CxZ3fjhibXEyD5+
         yYV840EZoIy008adJnPzhTnLFPMkobriRnH/AtwtalVe+6up7L92GcELY+tqI+JOWkp0
         rQgeyfRB8XqnB4xEWjs5kdMvvo/gBuYPw47wNgGFDpSxhLnii+0hqiqCOX5OR6g9Ndv6
         Sciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467849; x=1775072649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG63buxikYzZRa5bTcoW9Euem18H8lifInafLz0wjA0=;
        b=nPDEG0k/0T9hCYz5ZhJ3gxiVVkLaRF5+Mg0NJ8peyHnLXw0z99hJF8AgoSYmM579LX
         lGTmR46w1DFnYiWK9gdJIOnTNY0KafMpu1N3kgNqGl4+nLXJV+djvt4AkD+5jLz6nl8M
         6G+nomDugQEtaOd/3w9oS0vMdVEKEwYI+PMTYI7JzcwZywGL20YGFS8Cu/wuXryP4v9V
         se15viGFLihVchBjwnAx/6E9cz3VvxK2wGIArCzKMMI2+hMs821hH0hShCZeXh5Rb67p
         9gUfqthsjzX7kT3FrRtjoBwvwVf7EhzANUFRRUJvY0flA1PrD3Lp200LIDFtm+vpZLf+
         LmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTXLy76lRtXgTe6/MKHO/oFOqnNFr/SFPtKxg3xKJrdG0w9yuO5HRAFcGScsIUYelZZpR8ZpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesCovzm6LhFXmORHKkyd/39O7AOUPzBltED/D/uNAJKZELdHB
	qUFF5o/AKUHZvZY5KnNaWTj0zhgqBVP7MhsvcKcCJpVM68hDGk1bSNwd
X-Gm-Gg: ATEYQzxvjG3VWlybJRrkVh2RubujWx7xOoKQ+n0Ab7kupXcbro598lO/YiMRQ2gLUzt
	zPQ1USyukAz6xZjTmW2tXP6QW83W1HyGCidfJ9hL63tdY8DZdB/9TYzkuj0ufFAE+C5qPvTJ1Ng
	RJA0b64OQHqqbrnR9hsEmt4QMyLPikNFFlIEZ6qL5o1FnoP/PYpIsTFMmQsv8Dy5zqUoDD4V6Hd
	ZTgHUAT3DSmcVNYtnvMNq10JQfldHqGLjYhRO4lEGEjP85fWqku0wTrBK9N3ttdmKG7qiPps42m
	TxdGGehfN1QHY1ruKsnv2LCKVsg2VEr89ldzdd9YoX6erS9DhXKaO0sNieHQGysftp+iZmryfkU
	xWsJS0xhgtMRAO1kEWbRHT/LU0k8RSNhNS9VmM4rSVDtjSIWWcJe2KMrel+JgBus9K0yPptN2eA
	rDLWVimlQevJCgidO82KiIwYM5ckbK+Zco0VQwIqkr/ljYKQQZG/XH0kbHVcbv8pBVd4ApY14dK
	DREmNyIKqlE8OwLxEab9vXGiVjs
X-Received: by 2002:a05:6122:8289:b0:56a:fcbf:8aa4 with SMTP id 71dfb90a1353d-56d21f3d2c7mr2718324e0c.2.1774467848270;
        Wed, 25 Mar 2026 12:44:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d38abfsm1312353e0c.11.2026.03.25.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:44:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-25
Date: Wed, 25 Mar 2026 15:43:58 -0400
Message-ID: <20260325194358.618892-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271713-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA8DF32B747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:

  net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-25

for you to fetch changes up to 129fa608b6ad08b8ab7178eeb2ec272c993aaccc:

  Bluetooth: btusb: clamp SCO altsetting table indices (2026-03-25 15:32:55 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - L2CAP: Fix deadlock in l2cap_conn_del()
 - L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
 - L2CAP: Fix send LE flow credits in ACL link
 - btintel: serialize btintel_hw_error() with hci_req_sync_lock
 - btusb: clamp SCO altsetting table indices

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Hyunwoo Kim (2):
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

 drivers/bluetooth/btintel.c | 11 ++++++++---
 drivers/bluetooth/btusb.c   |  5 ++++-
 net/bluetooth/l2cap_core.c  | 31 +++++++++++++++++++------------
 3 files changed, 31 insertions(+), 16 deletions(-)

