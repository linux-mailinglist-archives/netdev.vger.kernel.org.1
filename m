Return-Path: <netdev+bounces-256350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ks5Ak0hgmmQPgMAu9opvQ
	(envelope-from <netdev+bounces-256350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:24:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCDDBE4D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62D9D3120082
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E3D1CD3;
	Tue,  3 Feb 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCgA07oR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DD38E113
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135562; cv=none; b=oR3/opu/zdTf4Lw/MjTXeDoZap1SVTWN6HE9KXMgsh8UMeTlhxw5rND3IOJceJbCnyceUW0fBGM2qqK9/Eya9PbnVJGVyLGSv5MJrjEqpjIpsazKbtbKVWQrtRfXiAWDeyz6zLqKeKheDVX7KV0nRRj2Z7qxDq4ymJneSNTXxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135562; c=relaxed/simple;
	bh=IRP8FUXHNCOXetO0nh4WY/k/t263xs9goMo60b8/iLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olGIGNEibNOUMYl7S1NXZ9v0nSsY8cwtIik0Z4aQSeAcWSANu8Q4lqX3shCjsrgax3NEWqDqEG/7YGpyQAh26KtTp6qK5CL3e1n2pkHue6H66WxzffL9wxNkTGzUdoMWY5khi7KXzgn732HnLmUrlb+Q1m+stMN88+gzC6zqV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCgA07oR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so47638545e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770135559; x=1770740359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjxVuWnk5B9RXCQZJmoomXjLkYn+5cEbj6Ic+qFTg0A=;
        b=kCgA07oRU9vgzob5VyeLeD6JrazvrwEc3bsT+35mQRHrFdkswZaSqdLjDGxU0DtnU3
         HFvkc1bxTGt5G++dt817W0H0yQUrN+ToZWDo32vGl9S4IW/x4EcT8Fm1AzGROgXEuc0P
         5d8xKvfBWbjY8rQtyDqIYv1Zfq8vGkep/V95voKxqQM9Li1zCC5Qs5yUobyFAqyNr8Ya
         kqntfAPrjHyzx1cPlVvD22stxXj82iRbVkz35QxanH/tGLOBo9GRoA6SOnYYxOn7ZDaW
         I1WX3zYOJ+B8lg0MCRm/5/BO/6CC+bWxusR0xZXNZiLM609I2salArecP77jnUi/XanC
         qCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135559; x=1770740359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjxVuWnk5B9RXCQZJmoomXjLkYn+5cEbj6Ic+qFTg0A=;
        b=fJy2F+h7H5PfPzUgC4Mrw8rTy32VftDnVr4JrC/WuqxKWhl1zQpvwrkRLMZbzrU6YS
         Fg6f/Pru7QQ5D7x5JZWzrdNvq9EPX/R71JE2Cju5U/MuSO20AtC53xHw7abq9z2G22Lk
         j/woOG1oH3Rx59LhmqSGUkaO3WkJl+bTyO5jplaDL5JlCQTgSOR3ljAPi0utQQvrtphB
         1xU6iBsCEH8txYOFCQV+1LtsxxvFCaroMPhaQq6iRShCv9YZWiaXe9vSIk8+cUmng27j
         N4uCTPVOGU9yb19Fsaso3JNeUZNWPHVikwgk8mYI4qP9awNvuwGfnce6zkzCPstZdRY4
         zFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+BytfUouR5Zf/J+gj2m4hLzzE68GpkU0oPg4Xkddy8JpxGEyMO47V22MSiEsKwnfbKQWEbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4kGiiZW5g7JS1lxs1opaLUgMYw+5C7yBjtvxykpo4+Ybun+i
	6O5hwtwelGdhl+QRSBvGRlhwSTxL4UM+DPjQj6HHaH25JkCrdc9UDjcykpdWb0N66N8X0DYW1uj
	nqUtZ
X-Gm-Gg: AZuq6aIj7+YbjtEJiik8KX8R1wukU7apdvgyTx6gwySl8Lu5jDoTXkRFLxaBNOZSxfO
	xlwH6UK80WXoPKoOAvG8pF16Ih34ZmQ3wDHW8t0XZEnVI1qQGYWz2yqvFTys33vfjgFyZwlLebo
	+HjngDaoQiFQhwzQNBMewmeKwxV6iPSo5WhXlWf2aksbLKsU6EQVmOv6sVnjvvsiS82gavdG3vc
	dlsJ6+4WGL8UuDPE5ok+tDrY78eA3Om221rh28/+230ttAfm0ia6slNxl86VbnfIsBx2mbm2gJL
	3+XS93DjGPeqWer1NgUixYwjFlFZqVc/KCyOddTyeTIqvHtndlUUi5iamX19ymgmgBhpxbPbiYr
	ArvPNo9sWtPLpD71UJ6FtKGfSXk/w6dVyylxfdjYYN+ZwZ0NVX3ecoy1ahN61Oa8i2J2ibjS/xw
	K0aRHgA6IC8VhyXahsIpRTvd/nrLs3bg==
X-Received: by 2002:a05:600c:a00b:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4830e971be8mr1908985e9.29.1770135558650;
        Tue, 03 Feb 2026 08:19:18 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:81d1:b874:c1dc:42e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd21f5dsm144120785e9.8.2026.02.03.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:19:17 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	p.zabel@pengutronix.de,
	linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: Frank.li@nxp.com
Subject: [PATCH 0/4 v2] Serdes: s32g: Add support for serdes subsystem
Date: Tue,  3 Feb 2026 17:19:13 +0100
Message-ID: <20260203161917.1666696-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256350-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74DCDDBE4D
X-Rspamd-Action: no action

s32g SoC family includes 2 serdes subsystems which are made of one PCIe
controller, 2 XPCS and a shared Phy. The Phy got 2 lanes that can be
configured to output PCIe lanes and/or SGMII.
    
Implement PCIe phy and XPCS support.
    
Change since v1:
- Fix compile_test
- Use devm_reset_control_get_exclusive()
- Fix s32g_serdes_phy_set_mode_ext()
- Manage devm_clk_bulk_get_all() returns 0
- Fix s32g_serdes_parse_lanes() error management
- Move xpcs filein drivers/net/pcs/
- Add pcs_inband_caps()
- Fix functions in phylink_pcs_ops
- Fix MAINTAINERS


Vincent Guittot (4):
  dt-bindings: serdes: s32g: Add NXP serdes subsystem
  phy: s32g: Add serdes subsystem phy
  phy: s32g: Add serdes xpcs subsystem
  MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver

 .../bindings/phy/nxp,s32g-serdes.yaml         |  154 +++
 MAINTAINERS                                   |   10 +
 drivers/net/pcs/Makefile                      |    1 +
 drivers/net/pcs/pcs-nxp-s32g-xpcs.c           | 1006 +++++++++++++++++
 drivers/phy/freescale/Kconfig                 |   10 +
 drivers/phy/freescale/Makefile                |    1 +
 drivers/phy/freescale/phy-nxp-s32g-serdes.c   |  953 ++++++++++++++++
 include/linux/pcs/pcs-nxp-s32g-xpcs.h         |   50 +
 8 files changed, 2185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
 create mode 100644 drivers/net/pcs/pcs-nxp-s32g-xpcs.c
 create mode 100644 drivers/phy/freescale/phy-nxp-s32g-serdes.c
 create mode 100644 include/linux/pcs/pcs-nxp-s32g-xpcs.h

-- 
2.43.0


