Return-Path: <netdev+bounces-269615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJXB1NDvGmAwAIAu9opvQ
	(envelope-from <netdev+bounces-269615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2B2D12A5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F553096EF4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568A30EF82;
	Thu, 19 Mar 2026 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUAa+f7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFB38D685
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945667; cv=none; b=fMqVE/3YR5NOZak483CoI49i1USekGYBTgqVkvRIlpPinBO3PrrwcfYphxRmuGLR0junnnoBb2PhTrkZZwJTXeVgEkliNVlcnUqpFN/O7DLIXpzb0M3kNkXi8rgxM/uix1ws68KcZ/Ne3KXKKVixOZSRbSO3FtgHL7nYshaCFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945667; c=relaxed/simple;
	bh=hiOcvAOZU+Go06U22CYBuOeWPiu1hvx3VQOdDsDJoTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqvhGVUxPHk1KikXiC9HrjdvgfYx3O9BziehzIZQJt4mwWPAbO6ROvyu6HK65Eg1dJEOZ1AQN7+bQzGN7D8ypQebbyAndgf+7ZpyOP8TLZNaRLkwB1DeGHqNA2St1+ZZFRLA7IqTASG23Py/tsz2WLLhd6DOsLj4qAhDLEZEgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUAa+f7l; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4be94eeacso1346226a34.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945664; x=1774550464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkL9G5F8IWfaZsPq/S8Wu6RBCXk3sjjW1IZ7vLbDtek=;
        b=DUAa+f7lUrgii1rf/txCsDqGBxksbLKo6kV6ocZyPcvyvEGW/8V0WQTbXmHBvwwIfI
         wb/trbi+NvL2gb2khq8onZ195Ie4BuhLqhajJmKhcUeSHqM59mB0V31AA2XgCzWMDHCm
         oh3TAKFtzwqY83kRH7ddptk0JaWh/oi+tzKcm4T86wtRuEFVrmKK4c8j9M8vT3MHLfX4
         4hZsx+/3aqtm718AKzyHWoLxRaUuq0tWbqvQg3u8LyNLLBGqheHnSkuvEemQlyjuiL3z
         +ebWQ/IXwh9m9oZSfJQ0JvPnVTbCqW085i0HIYuZLlMKlCwI0n8CX849SyC4K6n0vWkV
         SmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945664; x=1774550464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkL9G5F8IWfaZsPq/S8Wu6RBCXk3sjjW1IZ7vLbDtek=;
        b=UIzbyGAveM921cv/Q5SWLhOK4VpSxFiCRN5UkZq9oZWThCx5L1CKIAe0UoNivOGrfQ
         5s6q6Bfb5IAncVARHdb10wbYgxfiiuf+yN7lwWG8B10XpmvM2m5rt6b8H7J/JWw9nu+B
         0GChdNapcJnDrhRqkfByATPqD8tTxI57yQt9mFuX4YKpAc+pDvBQjpOH51v9deFmn4PJ
         cWSiwQ0oFLAc/XZgHHfD0nHx0cOqVNot5H7mSYRlUMyFezHlCZY/nV7Pgz+fzeGcSBzc
         9qNT53+9HsJHfq21rtKnPrE3nnkN0qjhpoCyfZhxiOP2hoXRu+FtuUHUpY3l/lkJzcEJ
         DQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl3TneQnHy0C9W40k0HbCruglOG8A1zXVVN6M9UtsszRnPsTzX8jSZphyeXDtQ9ZuHt5bfBA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRXncGLTaUockKs0WRcKwDUUcTCl4CB/2Sxs+IWtTTvzVzyGb
	OoU8NSZ/YnbOPdgLqm54aWlAgDUcPZ2jbkV056fyXKR/OWJj+DG4KVu6
X-Gm-Gg: ATEYQzzJth7/nRHJD1zvBmz8ZL8/kp3d3XWh5XT8RVV1WuqVgCYArirVYpCThAZihj6
	GlJlABQ5kwRXVf29HKfTPcWeW7GVld0Wyveyjcyky/1iv2+KZNfNm4cppSonFJBx/l4OF3NOc8X
	Rj3sWwUZCjTdbf2DfFQDyVyQ0UF4y14IKbSN/CXdnGplcuM8TzQu3qmeSg2PqeGtfOhfryn24kJ
	gkoe57aNuDd5K18GSej65LDonqnTqtzY2vQMrlI8E6RFrQiMOR+Y+Gt9LP1oeuDDFr9LABTSDar
	aceW/dBtX46u58lFqcqd/LxagenJ+urdjpllpjdSrCw9DkFdZTvmDaTgt4E6djOpUdkg6DbeNaC
	mQa9g8VXHKFFwO6D59GNqXmYwhjNjHAaKzCrSeYz5Ox7t9ok9V4CSaK6iZeokNMjjoaOK+Icjoi
	aQvWC4lVRC3Spa/CupKfE2ZNYuZMyEGd05MV4p9mSihykEI1Ctju/CGg7b2ct0votgXaNokcdZO
	kRMRh36SJQ=
X-Received: by 2002:a05:6830:3e07:b0:7d7:e8f4:4800 with SMTP id 46e09a7af769-7d7eae7e608mr222164a34.9.1773945664407;
        Thu, 19 Mar 2026 11:41:04 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm181486a34.15.2026.03.19.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:41:04 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH net v2 0/2] stmmac crash/stall fixes when under memory pressure
Date: Thu, 19 Mar 2026 11:40:29 -0700
Message-ID: <20260319184031.8596-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269615-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.716];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99E2B2D12A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi netdev,

This is v2 of my series containing a pair of bugfixes for the stmmac driver's
receive pipeline. These issues occur when stmmac_rx_refill() does not (fully)
succeed, which happens more frequently when free memory is low.

The first patch closes Bugzilla bug #221010 [1], where stmmac_rx() can circle
around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
a filled descriptor (due to OWN=0), and attempt to dereference the buffer.

In testing that patch, I discovered a second issue: starvation of available RX
buffers causes the NIC to stop sending interrupts; if the driver stops polling,
it will wait indefinitely for an interrupt that will never come. (Note: the
first patch makes this issue more prominent -- mostly because it lets the
system survive long enough to exhibit it -- but doesn't *cause* it.) The second
patch addresses that problem as well.

Both patches are minimal, appropriate for stable, and designated to `net`.

Regards,
Sam

[1] https://bugzilla.kernel.org/show_bug.cgi?id=221010

v2:
- Completely rewrote the commit message of patch 1, now assuming the reader is
  generally familiar with DMA but wholly unfamiliar with the stmmac device
  (thanks Jakub!)
- Added missing `Fixes:` to patch 2
- Moved patch 2's `int budget = limit;` decl per the reverse-xmas-tree rule
- Dropped patch 3: this was a code improvement not appropriate for stable
- Generated the series with --subject-prefix='PATCH net'
v1: https://lore.kernel.org/netdev/20260316021009.262358-1-CFSworks@gmail.com/

Sam Edwards (2):
  net: stmmac: Prevent NULL deref when RX memory exhausted
  net: stmmac: Prevent indefinite RX stall on buffer exhaustion

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.52.0


