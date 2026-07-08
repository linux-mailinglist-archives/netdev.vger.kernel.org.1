Return-Path: <netdev+bounces-305747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bR/nBKUmTmq0EAIAu9opvQ
	(envelope-from <netdev+bounces-305747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:29:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60E724568
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:29:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pAHsmSho;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305747-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96BF5302836A
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99C397331;
	Wed,  8 Jul 2026 10:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7D38C2DE
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506232; cv=none; b=VIXk5Q9HR7Mtuuvya09fPWLNd2VUHQF/X1cei5RV//3Rp0iZQE+o/tpDpslOG55mZHfIOPbW/W28UTRaDBmzZ30WfuQI9gjVr6US+Z7ymO/I8CqW0ME3p+0XTRdLEPG6K7cf+qoQ6MGPphmyknufiCcqeIN/CFE4iYpUgJ6unAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506232; c=relaxed/simple;
	bh=9m0y4H4r5/3hPBW3NKHyNggNGD3S4E9n4qeQZk//GpE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RAgvytKSaDYFswcHzzOpT8OdTpastI7buU3QOADMWPLSIerO5hpp6eKJ9dbkPIJVSf+McPpJz8JW+SKXnn+PUkLtUUTPiN5Mnqd5pQaRlzP8F1/5+OdCqxytarD4v2o7j8HvVMmBGwIbjq3JraF84Fl5JYUxIolgEObUFipSf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAHsmSho; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4720d22c94aso475916f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506229; x=1784111029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ULPXPFiSOdZmCJgGf8LxNKIrP883dRhcYk2KSZlt2Y=;
        b=pAHsmShoAtAjTK3HoD1yACB4kld0hDJiY1tAobwxkNxAARCsAxXPm5PQBHx9sHALd9
         ggtH3IKMION/2hqKgbpAWFjP+/dB77nf7avaZgEUpuJiBZvWVSwix7U0kG/GUPY2U6nU
         r2zqGBzVaXZp73vz1LZKFtYSK0xNL4b1Ajq4qSqEfPcdEczr+Vjf9wOKNSkhUkX0paPu
         LZpeNneI+EH5fFEw+/SvTHzEbSojDOLoh73fIdB4VLXh1f57Kv1OE5k7b0ZbLHmbCb1D
         uJWAmUcmu6bW2GtGGKEw88jVXpnLgePnNJmSj+CKWAVtk9iGzLpkfoCfESH8qlzCGnzf
         KSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506229; x=1784111029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+ULPXPFiSOdZmCJgGf8LxNKIrP883dRhcYk2KSZlt2Y=;
        b=ml1vjXophikwMxE/TIefROqICx8+H+P5EsyhFR3CcReqZL0H0/Hxf9JNZiMubHZ6nD
         /OLZ0h/z8ZSrs48h2TKaLvxxihC4BGFbkdmDr81p2aWbNJT8gpg0rvDnpkgxcCow8bIB
         uHinnNcGqTl6yqPhQsWu4SzjSiYv7yaS7Sl2WgxAOV1mEwRtFw0jMR6lQRZqP+bdYgWn
         yYjKNj0QuOzO/EobnGQdwVGPW5/dIvIgWciNC080MACRhEFwth7hy8T9vgIGylPH7Kz7
         pckGwcqyUDiUIevPZH6AumnZPsO6+lwEnAPdcxsiQUt1YBNbqtkEbeCNfcFi/XNZNv33
         I8Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rp93N38ZLE0B+okr7u/K6diibixoDtyBtZ/jAFM6cifG6svgehlMGWKL3+IYTMo1DTYI/pIJTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/e3cVRWcYFe4uk5V3IfiAldX97zxiBxlQ1RhxZHm89gKDqocB
	3rorfi40Z5gMArLZ8y+J6El6k338giB+KaDMxSOVmXGFZZ5O80k09RR/
X-Gm-Gg: AfdE7clBN25c1CW/cRxutyU/cD21MQm3DcmEvuB2M8ivCk9RD95zyNOyqkybn78TSnX
	IGan9c24fQBvd3JOj+tKQDz0uGDNn7qCwJ72s4XgERpIYa6sPmBJ2zLfWAaD4cbtjO3YGTaW7JP
	3W/z3CYP1Xdght/VZ7wDZLAxguQVzYypQyYw+IjzkAYbHmiBQT1G3BxCUcncWzC9dlaHeNFncPR
	/vge87uYrSa3RUBw7t4dKSpLZrbLsCPBzuYNLrHsXOnQp76OB3y0uSL66CNUlIsHSXUsHKGHUXg
	8K01r73KW0eJ7OzE5cvs4UFLj/LnX2x8BsPEGBDr6XeqEyloMZmXIGgIHsj2X5HxFDKFJ9QLJMD
	O0IQHxgU50IJr9oD7wHf1aLmKH8qaiYM3CN9/tYgjGOnJO0Zk9a1dAK2M1PXfHbTCPTOLK/DhrQ
	sXj0Xt6Dhfexpx0cICBU2hd1mm8Pk7Sb6xWiioBOdUVi/50DDwQ5PFJYEWu1320qtxPoZaYx+I4
	cbcHS6l
X-Received: by 2002:a05:6000:2481:b0:475:f0d1:eb5a with SMTP id ffacd0b85a97d-47df07b9659mr2019348f8f.53.1783506228883;
        Wed, 08 Jul 2026 03:23:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm40660248f8f.36.2026.07.08.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:23:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 0/5] net: phy: mediatek: calibration for AN7581/3
Date: Wed,  8 Jul 2026 12:23:26 +0200
Message-ID: <20260708102341.53919-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305747-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A60E724568

This small series adds calibration support for Airoha AN7581 and
AN7583 integrated PHYs.

The calibration logic is quite big so I decided to split
the driver from the mediatek one to keep things organized.

Minor change were needed and just additional symbol to use what
is common between mediatek and airoha PHYs.

I followed the naming pattern of mtk by calling the new source
airoha-ge-soc and related config.

The calibration use lots of static table and software calibration
at runtime instead of using efuse to calibrate.

There is one pecularity where some register and calibration needs
to be done on port0 first and then with the related port.

This is O.K. as port0 presence is mandatory for the functionality
of the integrated switch and it's assumed to be always present
on the MDIO bus.

MAINTAINERS is updated to reflect the changed code.

(this was tested from a long time and also verified by Airoha for
correct order of calibration)

Christian Marangi (5):
  net: phy: mediatek: export __mtk_tr_write
  net: phy: mediatek: move MTK GE SoC registers define to dedicated
    header
  net: phy: mediatek: split Airoha code to dedicated source
  net: phy: mediatek: add calibration logic for AN7581
  net: phy: mediatek: add calibration logic for AN7583

 MAINTAINERS                              |    9 +
 drivers/net/phy/mediatek/Kconfig         |   16 +-
 drivers/net/phy/mediatek/Makefile        |    1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 1812 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  517 +-----
 drivers/net/phy/mediatek/mtk-ge-soc.h    |  364 +++++
 drivers/net/phy/mediatek/mtk-phy-lib.c   |   77 +-
 drivers/net/phy/mediatek/mtk.h           |   15 +
 8 files changed, 2311 insertions(+), 500 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c
 create mode 100644 drivers/net/phy/mediatek/mtk-ge-soc.h

-- 
2.53.0


