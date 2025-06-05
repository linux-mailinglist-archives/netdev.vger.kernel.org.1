Return-Path: <netdev+bounces-195330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13EACF9A3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BAE16A92E
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05120C03E;
	Thu,  5 Jun 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLZrWFPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDE20B218
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161996; cv=none; b=tYmdH89FawXNZtiawQyxa4BDKrZ+W/QTqXIBnlixYI9b+fweqBvhnuhq8X7Vf7Y8LLAPOLabfTxgW7lYXxEP8D1wgTjyz5v3S1n9wBf8uqk0C4P1J+EZdLToJ2TDbVVtZLCkogv3F67pJTxC+hE7irz5yL9BUVI1/4Kryu/8Vq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161996; c=relaxed/simple;
	bh=iXzpIhf5sIIBcB5CRBarQg9nLAlM1haiPq5gmJTlX3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqWX6N59PmhMviBYzF6A7DVl/AikN+xnWoyNkSqlLBD4Mb9U69yhdR78iq7BWA30CxKYvWq3bIKYjJuLIhfWmeoH5fcYCUSK/jDRGneTdNN99Oij0qpwF/Ch2Y9zVvquPdH+20y94z5LfuVHwkkPvJbuNV4XY8xd9UD3Zx2t8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLZrWFPL; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e8ec65078eso1089207fac.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749161993; x=1749766793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqriqOLmXhav7QMryQGznfW6LiOPgFCIm9IOGP/jzP8=;
        b=gLZrWFPLzIgf0nDHug6p2wI5zpXqlCQTW7kRAYBXZST2W4ZZAjHnKugtXVXr344me/
         6n0S/cP50NlM2725SRrGwJYQIZTib93sTqnv6aYCpuGwV4E3Od3PswmCu/KWH3hWrTsO
         +pBCRUuOKfHj3ZuebOiGM7+B4aOiOyQrTW7Zokejc2D8O0XvmWIv+iXgFFOlV/uMJJXm
         cdd63GIL9C2+R9bBTNH1BMU7CXmDNz4cWBOILU8jCDYs0aTg6uPTvjJA6Q5AVz0T6t+j
         StBT7NhmaAYzXwdiDq8xLF7v3MxfglW392r148OOp2UhGqmwxTnzkm2V4ofK9Ya6pd4+
         39Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161993; x=1749766793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqriqOLmXhav7QMryQGznfW6LiOPgFCIm9IOGP/jzP8=;
        b=iu3L1vW8Rfn3rmVBmXjy4KE4l6UtV87q3AP9MW4QXlu7j/KB+aB9Fndu6E9ws4IwUO
         jS0HxdF8zFkehv58cLv2bPaXpUq+6ePz/B6ryq52Ss6fIx6TeGuVL0ziEUGrNoWkWsFT
         sgWzqhYin2/a83iNRmMwNeUwSR9nAabTDHwjfqN+vmlsde9odre+Nco8fyIXIqedwAwN
         UZcCwsGC3uw7Tu0G0oFhvktBk6po0yBTm2G3kkkj5seDAYRGd4axUYC5op9MjdMnAqlr
         bSN/ztX3W6UzYd4AhC7iHJGt+Vghp+njNIS/hEArY/Z5Zz9H3ZzNhFbQ0tbZorIPB2Sw
         KZAA==
X-Gm-Message-State: AOJu0YwU7TgOrrR3W+Dor/lwVVWmvQhx0LR0Ukjf3Aew+aDiovQr6b3A
	/rhBVn74S2EuzM/XIb5WxiQpp/plHwkv6wro3sP3zbIShCkilsQ04othkR6K1Q==
X-Gm-Gg: ASbGncsQQJdXMj0FiuZzi4WcJETD9uBhXL6qRXNO3hXYzDpEOw2tyeZpAM7OYugwvTp
	JJf8njBB2PfZaslRA7xjYvs/8M+n3U4yS1j43TFiw0vY3Bj7uqiYS26uyzSwjlwqKLujDU6lwUY
	RdbrQGwUWESQNUwM8eCsaCFXFDSCwwio6D35CMHbliS2XNudvJbBP2vfcqVAXgmv0Zid17eH4k4
	H/uVeuCjyFPkjyHW5W1BHYFSB6KbGKptccpFR3FYrx1fUn88z0Zi83AqY9IcVl9lNL3y+bqmmBG
	+eB6H+ytxVcF1DeYnEP6IeNil4MoN6Z3BbXa+7akIEJXpSnbvIxBddWM9SMpsd7wSS/Uv5I=
X-Google-Smtp-Source: AGHT+IHHPFv6nrdYL9SWex1ao2p29TzJBG2IIrSKFmwAdBQwIY9W1lZVXFe4TN3VJ2Ai+tKstBnsvw==
X-Received: by 2002:a05:6870:44c9:b0:2d5:714b:f661 with SMTP id 586e51a60fabf-2ea008777f9mr746299fac.12.1749161993184;
        Thu, 05 Jun 2025 15:19:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c121:baa8:78d3:f2cf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea07004806sm67728fac.7.2025.06.05.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:19:52 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Date: Thu,  5 Jun 2025 17:17:30 -0500
Message-ID: <20250605221730.398665-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).

This device uses pins 2 and 7 for UART communication, so disable
TX_FAULT and LOS. Additionally as it is an embedded system in an
SFP+ form factor provide it enough time to fully boot before we
attempt to use it.

https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/net/phy/sfp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..b15eb60a0382 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -412,6 +412,18 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
+}
+
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -512,6 +524,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-- 
2.43.0


