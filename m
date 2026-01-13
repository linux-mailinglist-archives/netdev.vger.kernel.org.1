Return-Path: <netdev+bounces-249338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC7D16DD6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4813015ECD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A535CB8D;
	Tue, 13 Jan 2026 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGtT10iG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE354ADD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286433; cv=none; b=Xl4YJKNZ7akKBYq0EvkWnppNhJ08oTNKVx2ta81kZEq2D0fewTtXYpZQEKzzpCERubUlXKlrwa+mjUld/2tg8MbAE5U73dV0mq0OKDEqpOm6DqbtdLVlLhwdQukAjwG5Ao+Owla3K1u0XQjfgZtK/Ke+cbJpMpHJGHxVEssgkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286433; c=relaxed/simple;
	bh=+Z3tflR0QPv/AtHYde2Bbd0mWjOrz9fOlEL9zrZ6pJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpAk6CqH437jx3rsUjKc4/3Y3IDdnlWnPm/kdZoEcU4HTBdxJ3SirAEfFYNXtxBjCweCBj+VDU5TvHBfGY8wy2E3AR/OawMBgrKKJUSZJHxNJJF2DAou4B4lJ99xC9XfqJx8hYxhkivzcK656PoTGyDXoK/B688Ospkqs+8xSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGtT10iG; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso7393718eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768286431; x=1768891231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whUZoFPva/1DPSFs6qyuipXE3Qp8iIeejIqod2xKLLQ=;
        b=QGtT10iGg83mPq5E6j8L5Ut2OpbR3KjCYOLbtX1bsP6ERkDICTZyq0c1Bt32teoiqu
         JIwl7sFhcYarGmEcxiYn6EYgByfX1QSqawNWP6FokwiKEJ1DQDCzPGx1WRWm2/hAiopU
         yQGD7TAyyz6SpESktYIDy8W20XjB6muKkjycbKjYr41GufK2a2oCEm0c++OSbwpbZ4hF
         I+hVfjdQFKy2Go2tJyGWOULua3xMdpkPtGf0nYZ4Ilh4nnc1fcdxUWUYFVWWkjCNBXVh
         VT62ZC6aH6cxw7W99Yt0VbU5XT/1RLBrDo52VpeYNnPFcdAE0Ll1RLjwUXIcbRrFQfIj
         zeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768286431; x=1768891231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whUZoFPva/1DPSFs6qyuipXE3Qp8iIeejIqod2xKLLQ=;
        b=A3LVqaKI/cozX9xXvEFczRsPvtPzGH9pZhJ1D2FyhmoUCx8VLjp04f7xZpgSCTcqls
         /4aIDOaXHjoNtM7FD/m7oRhlybwOhK+I/JA26BiX2wtnf4GAXu7/GmufiYYcGphth95J
         SVdks9zWOpBtDaW/z4OPdpRFElrLXPKoSw1D8gpYKGhmfdhyzsrchLloL4CVg3tex0Gj
         XbyeFTlu3KDUF2OmVbJX5UleN1i7H9832M1DpbWKwjJTCA28gnSr5adjdzd/4c7b3RvS
         oq4wmXcsVyA6xj1TfXFHjRV9/fKwEH6XSQXo4HM2NoTJbrz3jWhkx3fcjC5cREr4Qx2/
         d77Q==
X-Gm-Message-State: AOJu0YxL6hgWpc3aSSiri4U3HRU8Rij9ABptLa8tYZoQowe48HjVDsW+
	klveI+WowPMaiBHhFlx2G+tpXEkzdnvv/27fWc466uVs2w0lytWx7nMuVpeuUaxx
X-Gm-Gg: AY/fxX4vCxtHSi0DDyO8OwJYJapDMZlMh12P/66zTroDfLzGF+ixOXZP2Yxc0ZTzXyH
	dTv+3a6a7i7RgWevrzcfmSUQ18aaT6G9g4sPc/xkTMygL/P3VCWRhly8ZdbGEyXOjhwlKrsR5gi
	vNdZ8OUHAEL2qFsQxV9BZWNKOwSdvXB5tYFWRWD0LvinzhIKsD19cyiwzFt9Eo2NUkBE/P6XQza
	WfYyhNtNB9XRu6AyPJAl4AdfrbcLeHNEJghtRm1e28Eh/heEiV99Ke9J/HQY91cyK13rTLgf2nk
	ho8vaUr2+xKNfqyJgqYoqYfFbgv99/uRp4LPkQV51HrjsladI7MepyHLl9n18kD55sCyKg4w7c2
	7Bepc4AEs492ZB97rZNByekrQoUx4GfXQV+LESJ2I9dnmLoYuWcck1AXBHmtIoIKnK2CiIacSXT
	kIRSRWI36A7AHzM76oAYfWFNJGdh1sTHtg4m9NSALvFysSWMjMD8iDoiTyrlkOvAUKNfRVcAVNh
	X2xCIOblsQ6ioEUUSpD5CQ+8DLUD3CTA9KrAtF4hfXWfPpPELZOx4ZJb3eV1mrHINU6iejqq8ZI
	HVU7
X-Google-Smtp-Source: AGHT+IGPO+RR2k2lWqN1OBFQOL1/b6w1FynFekD9M3vfPiG17tDe926KBgpNLC1VR/Gl1O4Os+tcQw==
X-Received: by 2002:a05:7300:c99:b0:2b0:5342:e00a with SMTP id 5a478bee46e88-2b17d251c0bmr18093494eec.15.1768286430816;
        Mon, 12 Jan 2026 22:40:30 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd78sm16913729eec.19.2026.01.12.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:40:30 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Liu Junliang <liujunliang_ljl@163.com>
Subject: [PATCH net-next] net: usb: dm9601: remove broken SR9700 support
Date: Mon, 12 Jan 2026 22:39:24 -0800
Message-ID: <20260113063924.74464-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SR9700 chip sends more than one packet in a USB transaction,
like the DM962x chips can optionally do, but the dm9601 driver does not
support this mode, and the hardware does not have the DM962x
MODE_CTL register to disable it, so this driver drops packets on SR9700
devices. The sr9700 driver correctly handles receiving more than one
packet per transaction.

While the dm9601 driver could be improved to handle this, the easiest
way to fix this issue in the short term is to remove the SR9700 device
ID from the dm9601 driver so the sr9700 driver is always used. This
device ID should not have been in more than one driver to begin with.

The "Fixes" commit was chosen so that the patch is automatically
included in all kernels that have the sr9700 driver, even though the
issue affects dm9601.

Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/dm9601.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 8b6d6a1b3c2e..2b4716ccf0c5 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -603,10 +603,6 @@ static const struct usb_device_id products[] = {
 	USB_DEVICE(0x0fe6, 0x8101),	/* DM9601 USB to Fast Ethernet Adapter */
 	.driver_info = (unsigned long)&dm9601_info,
 	 },
-	{
-	 USB_DEVICE(0x0fe6, 0x9700),	/* DM9601 USB to Fast Ethernet Adapter */
-	 .driver_info = (unsigned long)&dm9601_info,
-	 },
 	{
 	 USB_DEVICE(0x0a46, 0x9000),	/* DM9000E */
 	 .driver_info = (unsigned long)&dm9601_info,
-- 
2.43.0


