Return-Path: <netdev+bounces-302342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OGEXOEIJQGprbQkAu9opvQ
	(envelope-from <netdev+bounces-302342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:32:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3746E6D2679
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:32:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dzydjqlF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A203007E10
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5039A314B6D;
	Sat, 27 Jun 2026 17:32:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140C4D8CE
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 17:32:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581568; cv=none; b=QUx0Rzh35O6k9/kpFuSkpvdl8+Nb3MjNNpyH/Gu0SgTsWMV7cJqofvzgX9pIdMgJfz+LUvJLljooELAXSpKNIfMrLL97CH+aLxjLM4Otm0sCy9AG1qmR+tpx1gwg+f1+ZnkfSHnVTkxNrgw0995M+TC1a7EB8bjZQTk8yeWM1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581568; c=relaxed/simple;
	bh=WJrdKg8xcgS7V2gOO4hQuXrVRWuj9f2sTjUXwXLY6zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOUvNxoQguPZLQAClAEIoC30wUyZ9CsZ5MwqsBss57SdMMmirf8B+FCPTgCkwphQGIYieeClj9Y0nri2W2MJZyy+AG8wFUsT13qQXJYrBWIEy0fXsNY7oAMks5A0FrSsxjeQGkrwt87xpmj3Iex9ToKdWWwxVwAMI9T0yrvn4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzydjqlF; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4927014c0deso7052925e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581565; x=1783186365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cM/pLIVt1BlaXM/xDvt8+QTdVXwM5yDmKDhwIbZHwi0=;
        b=dzydjqlFhSRjVi+rxC0IT2mAhGOiQPyCmpGIUqNakCZFbAgE+3lLuTPUDg7gwGSjgP
         jgeqyrXR9qOhCs2+Q38OErYHQ/t5Li0fcCSgeqR7Pp2QCVAwFpHPOFUVcgdqL3JIcgoo
         db2b731gmPXPJmfS9HBvgDiwWzKcyvLgixyPyuLdCvuCU1dy/CFZ+ykTLarAtPGL+nIK
         RRNckVVRt52Vdlg0wOz+QtTLHWgF3X1l8sUdDy35NzS+TKO81OzNUozkCKMhNCEQ4gev
         weVJtX1TtKRftX+yGc03u66Qx5EpzCWaHdaskvOlnCQxx2mS1oouMFAYpKkTR3mJbLFz
         LWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581565; x=1783186365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM/pLIVt1BlaXM/xDvt8+QTdVXwM5yDmKDhwIbZHwi0=;
        b=cQtkx55dv5xrV8VEJ1S/tH9tmkblHhjjnnlinnjp+VKyKH/jddYHPAzRKXeZyOtpIT
         mnZObBX99GDHh9/vos+V/DEs61hB0E5jainjLBOlbnst5O59Z+DtKQhPbXpay9I8OzR5
         93JPOklXBV+1Jn7Szib05O3MCOQFSwBQRmflakjHUOaHjh5SPbY4oJwS6ckIZ4oK1z+6
         XRsXkJamBrcsB6fZxQBSFA3trMYw1M4PjOds1Q9+pe2z1/pbtgkVsoevOydaZTj/oz+r
         yjzyVzMcPQ3DFpnni6HY3zUofEVVc+jycHtKq0O5K4UiIvqDmn61yKnFVaj23uUqxtLi
         YOEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/T3nTw9TIDNxazCQoUp+4SCDSC84Z7NDJwlfq0zkGp5P82DXT9MJNrkxfuLqVVlMVs//Y7Pe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OUxYdcRiOXHqwHi7XHYuWaOS9K+vL24xjh0iyJ5nbeHGdpIW
	bNYlJkQkEFTuqIOABVEA1ApBiSg9HDaDTdgzq49hJ+32ws08BrddaM+o
X-Gm-Gg: AfdE7cmdamsTlEYSytBPJVzh6XT360ZztUMDuPHdpIN9DH4LnUDREnfp1MjrxCkO2DZ
	3p2+1d4fS7vpLIkExh1hlYGuBtfc5zButHgjaRp5YH3I+JVjWkxrfI2uZ1EZYiA6VonnHcRm869
	X53ZdP7K29qHCVZFbdM2bJBQNhbrYv+BaWLhB1hJMr8/7QtHwx/kGODm8hXBwDuFZn8NeUNDOI8
	f3fIO+mR87M3F/Se+YL64gq1/OxaAVJ7xNMx/nfAPOiA+XYvQkrSNDWkyQ4PxCKIHbExSYIofkR
	52QNctSxjiX2eQTieO7Bi/umt5lUPBLyoGigBtbfdDeUxRtqqBz3jhECkeadnioRk7MhCHiJusL
	ZRALH1BlYOOKIpW18ULTzV2gqDCiqbJwmZ9S2cORZoClKHUIaWY4Cf33Uqp3/o5uDocC8HFGJFs
	1aCh113kJLxgK0mpKUy6YaJG9vaeYAWkDUNrCAoErEDkLZEKx++X6EDfCGvZieKhknuenBDHqxO
	S9lRMk=
X-Received: by 2002:a05:600c:4b9a:b0:490:c2a3:23d3 with SMTP id 5b1f17b1804b1-4926689acf5mr119984125e9.35.1782581565131;
        Sat, 27 Jun 2026 10:32:45 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4932f100e4asm64505955e9.1.2026.06.27.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:32:44 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v5 0/2] net: phy: sfp: fix mii_bus leak and revert RollBall bridge probe
Date: Sat, 27 Jun 2026 19:32:40 +0200
Message-ID: <cover.1782581445.git.petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302342-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,wp.pl,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3746E6D2679

v4 tried to fix the RollBall regression from 8fe125892f40 by deferring the
bridge probe to PHY discovery time. Maxime Chevallier and Aleksander
Bajkowski both tested that on genuine RollBall hardware and confirmed it
does not restore PHY detection (the module still is not ready when the
probe runs), and the Sashiko static review flagged the same path.

So this version drops the deferred-probe patch and instead reverts
8fe125892f40, restoring the pre-regression behaviour for genuine RollBall
modules. A proper fix for slow-initializing modules needs per-module init
timing (a longer module_t_wait / a per-module quirk) and genuine RollBall
hardware to validate; that is better owned as a follow-up by someone with
such a module.

Patch 1 is the independent mii_bus leak fix, unchanged, now carrying
Reviewed-by from Maxime and Larysa.
Patch 2 reverts 8fe125892f40.

v4: https://lore.kernel.org/netdev/20260624084814.20972-1-petr.wozniak@gmail.com/

Petr Wozniak (2):
  net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
  Revert "net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in
    mdio-i2c"

 drivers/net/mdio/mdio-i2c.c | 59 +++++--------------------------------
 drivers/net/phy/sfp.c       | 15 +++-------
 2 files changed, 11 insertions(+), 63 deletions(-)

-- 
2.51.0


