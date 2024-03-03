Return-Path: <netdev+bounces-76892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877B86F468
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D21C20AEA
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84428FBFC;
	Sun,  3 Mar 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGmz01Ff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB9D533
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461744; cv=none; b=ZTHqR0hKfxSVC3Z3zqCAYAQnv/fk8UuwD1XpHzke5C5s8zxsHcnT984xins48ok6vN2CmEBrOhuHBTibrZzZ11y2WE09okDyNhICycWtUQfq0S2QWBIkFMO/qMoJvaPx0ivYWlGR0m78KXX94mvH7e9tDuLNpZnCaQZBsNDQJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461744; c=relaxed/simple;
	bh=/1jyHaKRxoe2gJnQbVyw3On1Pupt2uNMBdeMhD+Sm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpuxRKyKhu3Hb+F/r7k+rrRKkWI4Lt5Qtl7eBRu5Ton6A7tf3YxMIASsT3JO8e9MHDMvVryvLodMbWyEEra99bvHfam/88BAHxmuDg1bP+7o+U0MdB738hpcVMJdsCIRj3SgI6Ie41Xb6kkmCqWdxKqhmV7PzXVWPK1uj14Xwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGmz01Ff; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4429c556efso518129066b.0
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461741; x=1710066541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdYv15OqlzJBxWgsRDR/eNfMjbnPdFi6xhD8GveF+FA=;
        b=eGmz01FfqXkB45TssYgDSuDIPDiwGL0KZFL24027sFuOv9zNpJH0b7KmR7t/qtNN7q
         oY3HeiwRDj4Z3TOnM+90UJnybz3bu4I3hbGgNpWFgPX4zDn1tJ+KlIGYHt83E3gGNjts
         jHz6G4VCo/wyCrvggmU4ZeYPDQ2mAy2kmvOD83Lm28D0ePf7J8Q+JrH1rhGrwZq3+hQO
         Mb6bo40u7KSkcaWeeJKShVbWu10aiNW7o8u3+ZN0UC6bfJ3zbS//Ig/ht4Tfweq+70Vd
         4G4iImQGX6dBBuVDNHrf1kxTVBJMwMnNyK4V0L25RHUmYRB+mXbRE8DLj5Ucx4RlgxYp
         M0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461741; x=1710066541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdYv15OqlzJBxWgsRDR/eNfMjbnPdFi6xhD8GveF+FA=;
        b=f7r0iqPW6DeZILDg/4Zqya4VeY1bhZK2ESBa//6dII8VQjuUslksklASD2+PxBWD7T
         PoanF2A7qfvjXzcITvrg1FaI9Zkgd1s/6HFAQBTaqXzsd4OeiAhS4/aROfzl9E9206Fg
         ONnF41SVD605+Q3Ww/D8uCvf7glMGIlKevYCQGxG0r7qRqLchLBd1a/rEZsh9OxG3Nmq
         bWP64uVcru0jlwlEzwJQ983b0i/pfiytw/EApOST2YAeVwVLKsNyl8QR8gzFnvT9lr6C
         5Q2nIdmKuk45UZp2a70GRV343CXRXL1+BJaiBSjf6D56l+jOi1GcWZqsZQTiZnNIiJ3G
         QFnA==
X-Gm-Message-State: AOJu0YzfLJZp0bG8gUdhYncLFzFbRjUQiKPfJSWMc9+yHJsNqJT1JinK
	tZG5bqeLtc/XlFmbkUZwsai3khubE43JMAZvNAlKbbDFcyWpz8wM
X-Google-Smtp-Source: AGHT+IFcNLmNBJAqhxRjDnbeKVm4OVvH7PkCOyXgQRWHafQPCeDex5bORKS3npAWkmSZyv3czqOnig==
X-Received: by 2002:a17:906:34d7:b0:a45:29f3:6cc9 with SMTP id h23-20020a17090634d700b00a4529f36cc9mr465909ejb.20.1709461741275;
        Sun, 03 Mar 2024 02:29:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:29:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 7/7] net: sfp: add quirk for another multigig RollBall transceiver
Date: Sun,  3 Mar 2024 11:28:48 +0100
Message-ID: <20240303102848.164108-8-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240303102848.164108-1-ericwouds@gmail.com>
References: <20240303102848.164108-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
containing 2.5g capable RTL8221B PHY.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 191a6d5dc925..0476624bbca6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -513,6 +513,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("OEM", "SFP-2.5G-T", sfp_fixup_oem_2_5gbaset),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.42.1


