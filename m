Return-Path: <netdev+bounces-305047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TNkoHk25S2rxZAEAu9opvQ
	(envelope-from <netdev+bounces-305047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:18:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C2711DC9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:18:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bYtPyQdY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305047-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305047-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56C173229F98
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA212BEC52;
	Mon,  6 Jul 2026 13:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB63033FE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344881; cv=none; b=tJblsQ9xSQYxPBvmcdQkVwLZpCktv5fSFw8AwY+gzVwttKJ5+F4EMz7WyyfvJv9R3z9rJyd0LCOH3YSYaYAtBiA4n/uwTpe/WVqFFyoQatAqUuFY/Alc2PLMwggO297yzkJI/ksFMU/UXsh2ZYUTmLhHa34mOX5NS5g5Ja0Pq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344881; c=relaxed/simple;
	bh=fwgmvkKPQBqOq5X1JUbObzAQUFrQH49yNVzsze80QK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AY3SW/AIAuqnR9sVqJ1ktPxDuYi/j5DWzeAuidqPmRvcEfTelckqHg+jVu2hFc60IH6ya+jH6O9RcZbeVxBQ2xmcdVkRdrDpffWwmfQaNMgNvRcpCyFLKrfaPZZiBp5Es743Sc2Lvqg3ZTsBzeX6Zy8ptBLCPfTM1z2M35ijjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYtPyQdY; arc=none smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6651bc57458so1861309d50.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344879; x=1783949679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uq26SOoIyTGHeDsOjuTjnwQxJZMXbFIik+DfAya0+/w=;
        b=bYtPyQdYpKGGRIWbFEtyefmLIJvbmoOu8RVdQTfwd1mhgPhCT3MAEII0WWZLKi7RhD
         fEpucYIgVEa7/5A891SZqXCMCWkDmzNydx28G75a/xsVYpIzrLBV867YAtwEcxiWucIj
         +F1q2yB20LX3GZOiBBrQs80wNrR4dmHsrgt1dw5gS21fQE7CbbkP13c/08auyYxYcX8x
         kMklEw/X7lQDibMOyi1uguAjt7V8RoZviVczDGbL2zhq9KRwO+okdL3mySTP3FCsCmec
         yr2Vpr56ymH8h/mgO+ajZFGp2pYEpgTuKZqJPrw2R/kUu3u+Ov+CJ/Lkjbw6cs7iYVTU
         Gggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344879; x=1783949679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uq26SOoIyTGHeDsOjuTjnwQxJZMXbFIik+DfAya0+/w=;
        b=BMPOS8QmCJybc6W70Uvt+BDRJjbBELLD2Bjy60JiyqiNFjhAmHQgzzPnX1JVCH+77U
         9Hnz8aqxnaPTRZLyr1Ara7n08NFAvKdmJnyHpzN5KEVB5AiH1l5YVZCC0oRQPgi65Chd
         85tUKsvIgLMhpVX0uwCsSpPqbKhcjpxBIlWiCj/QJlrCBorDmi+u/YX9ZxouiFALeWfP
         zjKHwgaugvF5W0yU+AqOanoSndZC4dkaCXblZ0WwcjVB6oU/2wfNRmxmJHCf812OkxF7
         XXTHK0EFFw0IVvhJ2zcZpHvl41M1D7mutaa4BJPWkdaIOkuX0VjAstkHOWmW1BKgcvE6
         WOjg==
X-Gm-Message-State: AOJu0YzO6Jh3gpM79wyIV9mnfD4JsOup644uTMS9jgvA/b/mR+p5HBop
	xhvj62QRB4wjHZRGcFoFMhLgvOr16nVbexqwGnKVcyi++MNB/RRnKqNttQNYpQ==
X-Gm-Gg: AfdE7ckeoVvUJgjEtPX+sxuPx489oPKeZfnZHFQtGSOrQbzyPSTXVv/c9aFiIPz/rYN
	3MVzZSXJ9C3PZyLSFGpsf1k20iNUhxG93Ddp2yL2i3mNZ+QPEKt9u/FzLyNxeJVqot+BGNdyO2b
	8nB/KBql/Ukyt2dCKVuwib8gbkssWsabKSSGN2QNnr8y9+4DK2LipNKuxALeW+dBtcnsnNm65BL
	2KUtpJkkRHz5oK5AnEbiiMY0dZjZcBLrCm9skla9xfRVrXDhX1KVfZwboFMQI1LHTYCOghhAbFh
	bLnaySjGoBd76LwxPZScDhnUdx7lzj39Da7YaAWN3Ap2dZWjp+xrA0t3kuwvmyxwNSqnUHSvwrq
	bVj9ofRHiGgt8fJIALykGOwZbkDIFL05ob8tLT2mMa8ztnoQv6XnHljEpnViRxSZZrvCrGuvBRw
	GKv5eT1cman5QkHKdeQdyc1Czhy/b1r2ldiLJlJ6WpVfaBHhr/iDprpGvb6Q5kyj1gZF0uo9jby
	/FEQSINPD7AKVKy
X-Received: by 2002:a05:690c:d8c:b0:80d:d2ea:452f with SMTP id 00721157ae682-81be319d89bmr1992087b3.46.1783344878970;
        Mon, 06 Jul 2026 06:34:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/7] hardware pacing offload
Date: Mon,  6 Jul 2026 09:34:02 -0400
Message-ID: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 635C2711DC9

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add ethtool support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details in the individual patches.

Willem de Bruijn (7):
  net: ethtool: add hardware pacing offload support to rings
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload
  net: pktgen: add support for SO_TXTIME

 Documentation/netlink/specs/ethtool.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  63 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 include/linux/ethtool.h                       |   6 +
 include/linux/netdevice.h                     |   6 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   2 +
 net/core/pktgen.c                             |  85 ++++++++++
 net/core/rtnetlink.c                          |   2 +-
 net/ethtool/common.c                          |   3 +
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  30 +++-
 net/sched/sch_fq.c                            |  21 ++-
 tools/testing/selftests/drivers/net/settings  |   1 +
 .../testing/selftests/drivers/net/so_txtime.c | 147 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  72 ++++++++-
 18 files changed, 399 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/settings

-- 
2.55.0.795.g602f6c329a-goog


