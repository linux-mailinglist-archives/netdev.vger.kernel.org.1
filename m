Return-Path: <netdev+bounces-251614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCYeOKr8b2mUUgAAu9opvQ
	(envelope-from <netdev+bounces-251614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:07:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 545444CBE4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6919A8BD77
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3926059D;
	Tue, 20 Jan 2026 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AelkI58g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87C3AEF5B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941552; cv=none; b=ZLBPn7HVqSqfEu1Fi+IOIpxgCd+rEEzFhgdXAtfTRYjcUwROyj3CqOY+0EOhsDFl8OuSf+HGFNum5uLaR/It77LvqrPU2AUp+hywRs1HI/FngCIhrL7YrOpCK9GnOBoAL+QMt/xvJVfFlVP3EqQFbYl/Bc7JD703YrnCruIjerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941552; c=relaxed/simple;
	bh=mMtTD74lHWGhMPk0VhK0pFoRiy76ELQ90jr0VFXLeVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgRfskEU9QSigS7J8zTNiqpOMjKQtx3d16cr5u2ZlGGP+Q5ejPZBNAwK05CYxHSQX+3XtnMk9vZXb1onLu9y+iGJQ5/pVomVW2giwD0dfib+u5UsswFZD8fFwqZRfsTUhu6JC4fkYeJyECofe8Yar1EtVsEcfiMAmHCnU7Ttlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AelkI58g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so53563605e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941547; x=1769546347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrKCUKKckHcjjuwU+EHrOyUAQd4woAILl74Bd1qw4Gk=;
        b=AelkI58gwaQ75UdNxzl/DvqSfPJq2jw5VqF/CpT89xAunquj1i9yoGDQ1Wt6RELyoL
         xmCyGQrfO20IlFVPv+eMFZUW2rC6cadg8pGJejRGq2r320nTdg9GyFPD6EaNCRhK/QbQ
         eOg9gmiV2X+aERUWumvrfr6CWjJRwOtOeOpyzTX/uAtuAModxBPONu2R2S88Gi5/Z0Hx
         c8s1BJhuIfz/JEHHWFL8lbW55D2acm3KyMyNtj+aRViIcI21P59dVY1zRlSF644BnAnA
         PQ54amdfGEptNmgwhXNTR0iULwwIh2yeOog3+ZfJU9uUCobeRhaRn5X9k+k9bCbPGNKn
         gLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941547; x=1769546347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrKCUKKckHcjjuwU+EHrOyUAQd4woAILl74Bd1qw4Gk=;
        b=a/rGGdFmfVgNOUwGTL72ncTj2wVFGbCR1Em29XGEAYYa3vDqizoPd7EZVBhTGMVBZa
         v7BckEOYtfspv/g/Cfax3zO2NuRiDsceB2OmgHOKJiUwa3Hgi3SYfHdldqKnhf55152D
         GXP1XD4c0p8rZWYZHOX7wAyASxs4txL7BEIysfHD+B3xEGK3SwTvOi34/QGMJF1k65k0
         QxT0zRos7TFtHNt9rFt4bC2j1DqSoUpKSdsBpjMPWbvWOm+tLSUHacZBW69D+bS8VuPV
         uFlLdtmBPiTsokzKxPTOvm31Lp0NYUQPd/JbK3HkwrB08FHK6uqdmSv3T4NGRQX3bg6L
         1/fA==
X-Gm-Message-State: AOJu0YzD5DR2h0jWZLZkJw4q+6HGD4SFScgUl7jd9FdMTuOJCGD0Dxjg
	kXPiKbpD/agt01Wv++XYL4JS7bMXB7VgtV6HICrDauj90cySXLamcyl8
X-Gm-Gg: AY/fxX5ILzQXslfrEMRM82g1Bov9aYZkAOAjqGjZd5vxSXaVOfuF9EU7YJ6Nv3lksLF
	InuQGsXQGb7/E3K4ul7GKeWMXYeH/2SEwSiNCaYGb65bj2jjDVjk1P3zSQwJVBe8xPYn/c2Q3o1
	Oh8INupvsZmR+tJbDaIE3KaRvz0bzhzxkxe6AdYszS5rVYbivFKQv/ypG03OykPiQ1BFIzKiQIe
	NhkHW3+c2F65DnwxhqNJMA8HV8/7m9Q/xvLojJhXgadxLk8I7ow+HmdqU6KZmjKqTkVMM/6F/GM
	TTViOqiQz7fVyP28CrI2GIbxGH4EcZ1scKtrzdMti18Wzi8TB23ChfqDOGytR4HVhXfV/AZ+j4r
	ngcxsXqZ85xRAkWhh4mULm8S/t/vERi8SUrxyrvptRSblVhXFm+hXvr16lnGd2uoygqWQAykvAe
	wzrrHx3m+5kwcWJvI+
X-Received: by 2002:a05:600c:414f:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-48020f17c12mr160684545e9.31.1768941546639;
        Tue, 20 Jan 2026 12:39:06 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:378b:c660:2f9c:b651])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c3a7c1sm850425e9.13.2026.01.20.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:39:06 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: stmmac: dwmac: enforce preamble before SFD for i.MX8MP
Date: Tue, 20 Jan 2026 21:30:01 +0100
Message-ID: <20260120203905.23805-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-251614-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 545444CBE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a new phy_device flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD
that allows a MAC driver to request to keep the preamble bytes before
the start frame delimiter (SFD) when receiving frames from the PHY.

This flag is set in the stmmac driver for the i.MX8MP SoC due to errata
(ERR050694), which causes it to drop frames without a preamble.

The Micrel KSZ9131 PHY supports keeping the preamble before SFD by
setting an undocumented flag, that was confirmed by NXP and Micrel. This
new feature has been added to the Micrel PHY driver for the KSZ9131 PHY.

Changes since v2:
- Instead of using phy_register_fixup add a new phy_device::dev_flags
  flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD so that a MAC can request to keep
  the preamble before SFD if needed (Russell)
- Link to v2: https://lore.kernel.org/all/20260105100245.19317-1-eichest@gmail.com/

Changes since v1:
- Use phy_register_fixup_for_uid() instead of adding a new device tree
  property
- I will send the conversion of the micrel.txt binding as a separate
  patch series
- Link to v1: https://lore.kernel.org/all/20251212084657.29239-1-eichest@gmail.com/

Stefan Eichenberger (3):
  net: phy: add a new phy_device flag to keep preamble before sfd
  net: phy: micrel: add option to keep the preamble before sfd for
    KSZ9131
  net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 +++++++-
 drivers/net/phy/micrel.c                          | 14 +++++++++++++-
 include/linux/phy.h                               |  5 +++--
 include/linux/stmmac.h                            |  1 +
 5 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.51.0


