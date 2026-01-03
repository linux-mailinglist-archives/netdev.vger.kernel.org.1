Return-Path: <netdev+bounces-246648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C643FCEFD74
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963C330249F4
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19B299AAA;
	Sat,  3 Jan 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShMfDIrT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5A3A1E94
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767432615; cv=none; b=gCLSaSTH+n734y2u4ni4+Z0MPbUZgQcuDsu3s28bnJWBP8sZM46SBYqr2bK3QbjzqM4Lq0zDK1MwPKPpNg23qbropIKh3np7AFCF29JqHfEKqUquH70Z9wKKo/4oVN9mM/ESm301LY1qsH1ECrtbRQRKuLCulF0H1XE9HqN41lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767432615; c=relaxed/simple;
	bh=xPBhV3xf/mEOLNuM1+djpRv2cyMz8fzyttuoGbo3704=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFgT1hqq3iwwC3LM4Y3CWUNvM3TGrVB+FInqDW/3Qs+OL5hm2EhMoYGxVxR0yB96RzSyVNZQPzbOg3oalEnECmonb7AvbGKXh364NWq7PoDoC5OxTR77XSpZzvyqJ5vQtTnk/cuydzxUm+XabN16EqC43XPq8R9Vtl0W1ucsPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShMfDIrT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso16881639b3a.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 01:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767432614; x=1768037414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt9tJYP4C9GkuKYSjvH8xQ7Gj8IEbQo1GeZTVx+trAY=;
        b=ShMfDIrT9kJHvQ9U234fvxLmd8cQjvS9cbTtwY63aasR7XL9QrARVtQPraAD8vUDpV
         1P+zgHtEaKXJi48xPlaTzSzoS+gBIIqTpSv49sgZZPpIEECfPxCCmKZ4rDo2CC7rm3Le
         t0bkfdzUjKpE0vrxtxU8hreIeMs2w7Rj2ZQ0IiWwcHPD9P9oOL9YV+HjTv4+kzWd4Fpi
         U6hiSrnuvqo71emA+8QFHSzSjx2irh/MD3+PIuit4sq08QQLIGf/oMPWrlif+BzEBRDR
         GZGm10TzW8CQogK6gB093h6sVxdOIwOxgS7z6Jr8lRn1KOSw9UNcf/xyFkEGCk8E5t8Z
         3YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767432614; x=1768037414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt9tJYP4C9GkuKYSjvH8xQ7Gj8IEbQo1GeZTVx+trAY=;
        b=p6Nu3yy8hSowJtXKjoisv/8jm/VpE3yK2x4jl18lYSl5/7q7QCM4wfjyZiACT9bGPx
         7fxNHE0+D7Z5zmCfLixNnIVCRjeR74+3nAFtJfe7y8N2V7+SOsY0tvOGzqx8NlcGpMHm
         4HVW7FmuRdZLfTvp19n2jzT2JxYET+Vg6Tg1A84UfYZkfQ3k0LHLFrgVOY8kFU55juh8
         xfvkIKS1O12q5Vlwa2WrSfac1dUTOk6rE2gc5NpWV0DOLfLzJo2iLKWfMfBk+ODw29KG
         2shKfefggznPF4IKT1LZzWT+B8cwFIJQn6ESc4YL+vy8rsstbZv/GorMlCyFYt+jh29e
         J8Ow==
X-Gm-Message-State: AOJu0YyZd5PvP9uIHjdyOZ1IJhMWt1meg1Z8AXb1bHkYq4acuTUgfVP1
	FXX7fOp5ozS6kBygeQM+zIX998OvPz1AfaL6LOKMF22n1Azd5y4ZvUJf5m1GuA==
X-Gm-Gg: AY/fxX6bV0Hj8TTWPMSBIQEeu9e7zaVahacDsjzUzrGWjn8Boq7myX0Z2S4UOspJs21
	79BKJREJy7MOspNRr9FSB6ulLfvLYy/7t13arYmIVXepqehwJdNff+Vgqpu9dtw4uq66m2rGG2t
	0usVg84lo3sFIKBkDzBHumz0T+6SVp6qO0fG0fFOSe96sJzPuji/ZIdfy6/wJgQi0yK8TnNdjVL
	0INQWLFd5Gnqx8rnLCEr7jcfSfWA9NfL/jvu4q6U4Y1ny8/UjLD6KFIqlcaF+xQqFLQsKNBLIpv
	phfIF+0Ni59MJGohmYxyyVxiChThA/LuNVaO0Sh7WWszZKOkp0Qua9CG5gort4hKQSxIpLe/Vez
	3FwHh0l0BP23St2SFkrOuK618m/qC7VzxCO3EiNrYPwl8yupVdODho1AVKLo705/8QmpsbVvpoQ
	O74P6Wjis34gvncRnuZR0=
X-Google-Smtp-Source: AGHT+IH5m1iMRPHgBJ6TJtBzdLg/1Zcz/w0B39ddDknVSCVCLeF7pbZ57H5QL0PYLZNutuZ6eRJTVQ==
X-Received: by 2002:a05:6a20:1611:b0:35d:5d40:6d75 with SMTP id adf61e73a8af0-376a7afad8cmr35575798637.29.1767432613559;
        Sat, 03 Jan 2026 01:30:13 -0800 (PST)
Received: from mythos-cloud ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec31dsm1331875a91.3.2026.01.03.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:30:12 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2] net: dlink: mask rx_coalesce/rx_timeout before writing RxDMAIntCtrl
Date: Sat,  3 Jan 2026 18:29:05 +0900
Message-ID: <20260103092904.44462-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RxDMAIntCtrl encodes rx_coalesce in the low 16 bits
and rx_timeout in the high 16 bits. If either value exceeds
the field width, the current code may truncate the value and/or
corrupt adjacent bits when programming the register.

Mask both values to 16 bits so only the intended fields are written.

Found by inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v2:
- drop unnecessary cast
v1: https://lore.kernel.org/netdev/20251223001006.17285-1-yyyynoom@gmail.com/
---
 drivers/net/ethernet/dlink/dl2k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 846d58c769ea..74e0fd08d828 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -590,7 +590,8 @@ static void rio_hw_init(struct net_device *dev)
 
 	set_multicast (dev);
 	if (np->coalesce) {
-		dw32(RxDMAIntCtrl, np->rx_coalesce | np->rx_timeout << 16);
+		dw32(RxDMAIntCtrl, (np->rx_coalesce & 0x0000ffff) |
+				    (np->rx_timeout & 0x0000ffff) << 16);
 	}
 	/* Set RIO to poll every N*320nsec. */
 	dw8(RxDMAPollPeriod, 0x20);
-- 
2.52.0


