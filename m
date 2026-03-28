Return-Path: <netdev+bounces-272810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGR0OG4ryGlWhgUAu9opvQ
	(envelope-from <netdev+bounces-272810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:26:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA5134FCC0
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2009C302514A
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD533260C;
	Sat, 28 Mar 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhdYDT8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B72874ED
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725925; cv=none; b=sTbq5gA5VRYQOPd2KSh6Zwq0PDqznsmvHrYOSL73dGNSbEUJEfGCtLBoV2xcoxdlxKfH40xrw56WisofRUM1DjHlMid/bogIxzgwpKlxNJF2dLyEwWclHArXeIgqn4g+zMA+AUwk4yUxaA6Rl6zzuobqyGNGS7LDgs5CxQUpQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725925; c=relaxed/simple;
	bh=GX6C0QQxueCW0rbOg2/Ph3S4K0whxx+6VAt0qq0Aloc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQWyHtNn2NqbQ7UurFMNRHLiukQMGY24jR0cWVRJyMNPFWzx8t7Asx7FNOywrOn+pxlqJXLmWUYAIKY4Ugf1ccmP+da/AHm7+A+31VD7/oxeUEKCajKhSciHmC9v/PmxpKBAmB0ozooZVIQdNi0fOe2ZxxAUn46bJjiJPlsq1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhdYDT8A; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128ebee22caso1606395c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725923; x=1775330723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sL0ml+VWm2YV7ulhW2wYXZxFABQP0IsIT5aunFSXxAc=;
        b=FhdYDT8A09IaLDI+gaAo98rEy8UoOwbNXlll1Tiq0N5+y3LtOjeyKIlDBR6gn+266Z
         qZTt3MSGrBY1J93G3Ayys2YX51kNJ3VVYQ4D3/pHSXNX6rB7MtNbXtJRWBQ5TgpsmhIU
         Fm+OGFOHGTm46+cr8XiKdDzabf+vMwso0v0GmOZVzbSmRMqNjHEaC1YDo3h/grMWQuji
         DEd5Oaqn+7N0oFW4g1JqBHEU6OMQHVuJUWD2cENI/H00GzCB8TSwTUx+OkZ+G6jZZbX4
         sHBNUuuhVnea/F12/PuzMAqn30ulAqCBJelv7iwtbuNsegXEkoDAbnts1zcZdjagJCwA
         EjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725923; x=1775330723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL0ml+VWm2YV7ulhW2wYXZxFABQP0IsIT5aunFSXxAc=;
        b=CDFexsQgX3KRrPjuWkpOUKjMRmPun6MxNWpr/4X5eZBpV4Jrv6zm6au8UKnqudXUMG
         f5PHs95tpHOnD5tLZcL8rtUzn6EQ3REm6Qq9tQ+BwJndAMXm1Kkckd7RXOSTPNIwm/yF
         c4DyjXWUvShlqRYtJFTTPNFnyRKEeuoihUViqF+1+zM4B3k3H+eIg5tl9dAYaisFY0QG
         LDZgyqF9pr2tqlY7rjYWa3PNe11oaxoSzEu/62wIZVQMVbchM+x9di1yQlEM/H7+mQDI
         GruMk7rdsm+tUYfVYO3VsFZ9y7iRMcJgFn75mqj5b2mJRZkkdXpDgWBKeSTMKlAmo7sc
         sXug==
X-Forwarded-Encrypted: i=1; AJvYcCWsvoAc8QCj+GZPF7RyXVRk1arO4xsL3BwbvEk5EbsCYJji5feK5ek2nEsC7SvE9CwA/fnEkes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDA2aodORaYAdqOI5T965PvZN/bTWGnMx3Lk8cgyMTuJPgzYJ
	CtoaPQw+IjJKD39Xs9c/InItzTao3dtrj0JkZW/SorJhRnaaxurZ4/fZ
X-Gm-Gg: ATEYQzxDi7r4OaqUcq7XUTXRG8DYPLaH/9XsT40nohi/4wb/MgIHD5zlIhPIyIQ6xNJ
	lyDCD05eD2X5CHD2tzVct6M/kD7Ec+nJVvB6yEi6zdLhYMAqdBZm0Smr/dYDYHdUAjdCihIK4sE
	YyUB1RVPID3CwnZSPucQuRzbne0e5wzz9vKmx3tks1cBotbcMmlLWQrDsZnQolrwBRVHGQHwfpz
	llBt9QV4tsNO1HgQPZe2L99cciImwAz5gLVfI5F5i5d8K6J4y2uvA9Lrwz7DLTTS/sHdFFURWKy
	OsUwvQ4UcajI0iix9sNudV5z+sjK03IDvox4SCIcQ9U6Val6laqBCjwv5Lne8X3iPchr3xN5EH/
	6+hP2PflX4IIDhWvsfJJy/aQazTZNhHHuufvGJoNqVD7I1qhubluXt5tTHZjzuN+/OZBI+a3hWW
	Nu1hbrlNecqCL1z3W1HbvhtNiIG0+tJRGGRn15r6hMQeUCpxh0aiOaV9Ru
X-Received: by 2002:a05:7022:6707:b0:119:e56b:9592 with SMTP id a92af1059eb24-12ab28e4f04mr4498030c88.23.1774725923210;
        Sat, 28 Mar 2026 12:25:23 -0700 (PDT)
Received: from localhost (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12ab97d88c0sm3993488c88.5.2026.03.28.12.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:25:22 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [RESEND PATCH net v3 0/2] stmmac crash/stall fixes when under memory pressure
Date: Sat, 28 Mar 2026 12:25:01 -0700
Message-ID: <20260328192503.520689-1-CFSworks@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272810-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EA5134FCC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi netdev,

This is v3 of my series containing a pair of bugfixes for the stmmac driver's
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

Both patches are minimal, appropriate for stable, and designated to `net`. My
focus is on small, obviously-correct, easy-to-explain changes: I'll follow up
with another patch/series (something like [2]) for `net-next` that fixes the
ring in a more robust way.

The tx and zc paths seem to have similar low-memory bugs, to be addressed in
separate series.

Regards,
Sam

---

RESEND: Oops, my subject line didn't have `net`, so I'm resending the series to
fix that.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=221010
[2] https://lore.kernel.org/netdev/20260316021009.262358-4-CFSworks@gmail.com/

v3:
- Rebased on latest net/main
- Changed patch 2 to require that stmmac_rx_refill() *fully* succeeds before
  exiting polling, to reduce the chance of rx drops.
- DID NOT use the CIRC_SPACE() macro as suggested by Russell: I fear that the
  perspective shift (first think of the dirty descriptors as the "work" that
  refill "consumes" -- therefore the "space" is how much stmmac_rx() may loop)
  is too counterintuitive for a stable fix, but I'll do it in v4 if reviewers
  insist.
- Updated the recipients for the series, which was invalidated in v2 due to the
  `Fixes:`
v2: https://lore.kernel.org/netdev/20260319184031.8596-1-CFSworks@gmail.com/T/
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

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.52.0


