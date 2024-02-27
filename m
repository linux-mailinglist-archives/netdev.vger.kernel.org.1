Return-Path: <netdev+bounces-75212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C825868A3B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707361C21BE7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ACA5676C;
	Tue, 27 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUnQzSol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF054FA4
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020340; cv=none; b=r9OwxeP2XcMHv/rurYcsOr8/IYHzMaPINneR9dK8L9qKVBjcCL85/asfDlOjMvvojJjNwmXwTfNFpr/wJyLyKtdrUBC+AtcLnivBN7dYnu0pvQp7intSK7GMkgJrNK8HqwGjAj/fyWW48kzvvBhJWs4TsX80EgxSRUGlsZP9lT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020340; c=relaxed/simple;
	bh=biYd82PDEigmAvdh5G6NkcNTZbakF4ljEFl2XGnggjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEn9EaVD06yLohuVYnXGi4fHKvjfELrxnObVB3VPPRhuI67P6ydfT/NBKDJC836NjG0GL//hJPDe6YiyxuTe82f4Ah86VYY7OMSUj2pZ+Z1m2mxnYIjsGODpr6hucZ5PLxogqG+pUidJ0amy1K5o6ooQJyXI/AginxuCUDqWYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUnQzSol; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso534744366b.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020337; x=1709625137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1p6UsSs+EQQxO64HZ57uYteqPXE6zBiSjX5gQ9IKv4=;
        b=mUnQzSolzOq19pbKfm1RWQog9Yoe6JACvRLKg+3DhH3B9WeoZW6LrF5uovxQZY8HHR
         KunCFIoCRB988ELu39xWzsebY34QIe7OgcTyM5SDtRD1WKvUOwy8sX9k8brJMEyhQAs5
         BcqEauJb+ifZRBmmdNw81T2UmdSpinJfhpyrYiBFpQQu4VubeYNRpaVLXd1VfAVbSt/u
         8sI0KY7hxkgoT9wpGapRwORnlthQh+w2vp9QUWn/7sB9ve6b1Mn2SsbAVNzVQQuSyhif
         PKOT0xfqYFJPxsBglfafCzrtuJ0JdJmNWv7a+SwflrvrQfahiiBSl1A4kAT0An+/+8NU
         6oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020337; x=1709625137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1p6UsSs+EQQxO64HZ57uYteqPXE6zBiSjX5gQ9IKv4=;
        b=szdQWd54pkRHktoyv3eyzHgYGRzKHKubC+Ids+DUNMV2Yy8LfbSH4WmRL2d6PTNDhs
         wQw2sdh7VYg1E+fOE9ENDOw4jBTUgy06pKuikdVOxCcBD7DYW26DNQDDIOoRewMvAySl
         W807iNE8Qb6FydI9/oAoVxhKJBuqDCE3xqKyZfIF0/RuoTf5Nqb8lhQ8OGknvm/XnJqU
         azWvzza/TmWm07Ioq8sRmbkGymN3qHggINL1brxb9hkn+dxmhJbhUg/V5rRBA5ZqUJkC
         OUzy4ikSxnz8eE8DbzU9133HcONHL+L08qRB6xOsGuua0KbJxE6H8x4xT5WFvfe4wIwB
         EJ7A==
X-Gm-Message-State: AOJu0YwXum/Zrqa6qcI/bqYqpsSFPGzyh/wJSt1osc0Vy0J4LPVBV057
	/XzjaI3wK8ydi+d0XGuQuat8l+R/0EiYf/u/uUBm6WvusXtIaccF
X-Google-Smtp-Source: AGHT+IHTrcOrNV/7T58KkGuTM5UrA3VD3DpjVoGkDNCEKNRiK5KNQEHF1KxmH9cMpfjPepsVNFITeQ==
X-Received: by 2002:a17:906:f28e:b0:a42:fcf2:1077 with SMTP id gu14-20020a170906f28e00b00a42fcf21077mr5039521ejb.23.1709020337189;
        Mon, 26 Feb 2024 23:52:17 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:16 -0800 (PST)
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
Subject: [PATCH RFC net-next 6/6] net: sfp: add quirk for another multigig RollBall transceiver
Date: Tue, 27 Feb 2024 08:51:51 +0100
Message-ID: <20240227075151.793496-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227075151.793496-1-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
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
index 144feffe09f9..6d7dfbcda30b 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -513,6 +513,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("OEM", "SFP-2.5G-T", sfp_fixup_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.42.1


