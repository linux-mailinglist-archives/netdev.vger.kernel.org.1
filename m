Return-Path: <netdev+bounces-153586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750B9F8B13
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 05:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95D71620B2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165F7DA7F;
	Fri, 20 Dec 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="M3L6Ozy/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1672F509
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668229; cv=none; b=gW1q9NqQrSa5l3KYbMlNqLxvujV1cT0Fi9ZXMLTerIQAxcQjwbV+tfvYDoAqIAlLCrDXZ/yZQRBTIkd5BNlDAW/zpbLxVgBObrUg5n4WnppI4Y+xZ8IveP8t1tn7V3F61+jOCesxQdB12fRTVuIInsc+SCZ67pfMsLuvaDvkfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668229; c=relaxed/simple;
	bh=RT07yzo82VgnOLgnzIwCLH/Ph+ly8TDmbW5eT7fDV64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FEVHpAoAN9cxlqd0fXUa1n4FiQqshR20cepxmqt/mRbxiQPnCedZ/3Xi7ibbw1lmQ4s5tyKOg52zsJqCT0kPWsD0fQuoMVSI90DdZ/NAlnHimSL+fnhAkLQp0CjR9cokl+88Bpj+kdBWeuFZP5v2mtmcQ3p63dXuBi78y1hZN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=M3L6Ozy/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so1497080e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 20:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734668226; x=1735273026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUR6QxjH/XKpq6/uxgbPtVelmv0GEa1mOlsKd9dqvck=;
        b=M3L6Ozy/Wgaq5XwFrRXOPhRu9zB40Ofg6Z0PohX1qEQQwUiVXcnrI+PoEryTGdWBvg
         PK3OsvWeh8mPk72VnKSbdWHpqCT2/69Z59/6pywy/STpRv2TlPsJHmEbkPrmUa4yPQ5F
         UMoEpIWVNE2nXQthrY5R79T6nrU+tj3Li3TXNuxV8zomFBoIZe2ITmJ4D4CtRsJHZQj4
         V2DOJ+ieXLkaUhhRnjeFmFKbXj2Lt+krDHN6hTe3ksmTXyMDgc4E9XqIgr59cEEurMl9
         uFzmyY81J3Iq6M4WZFn2wwkhLlLlnPqaK54JWq3r/XRlqtaBpCSnYU1jyddL+p1Py/QI
         JsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734668226; x=1735273026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUR6QxjH/XKpq6/uxgbPtVelmv0GEa1mOlsKd9dqvck=;
        b=p8dJNojkUvhfMF7Ni6r4BWtrwRCambOBkkBdVcfqchhvdNqxIcllXn3WLDYIu3FXPl
         hDjdH57/FkRB2jKuGuBzvheeqIlJuKzeoYT9rhDLcFXg0yLYfAey6KcYwyLgTe0Itkki
         OLRC51uWdQnu5K+vryihuSg3a5dZqOgvnVHtA5VRJ3kyPbVTc0IpNHHGpcADZArF3cn+
         q3wTi4L+nEafndTPPrrLQ8gXi+vlNegL+hpC4o+G/2bQ4ffAehpmjuufkxB9y5fNxXpG
         gYkNxc+CMq2HTPDZpvjrbOUTtMOYx738nPNGuflk5xCPlejJ6zZwEQdT9ksAewHzR7Wt
         wadw==
X-Gm-Message-State: AOJu0YzcIacNORhMaQqCqUmtzhGCjN6EOKTvooIwiogfidO3djMUrcVg
	EJRY3u4KUr+txdz9bbaH3yl7KpkSipfpHMfZWBj3cb1gExqEZ+VuMt63MlKo7qw=
X-Gm-Gg: ASbGnctKScXizd8GaGxIg9asFzMutvmm6fCyrgRriCHzgve/fJgJCc7/lzs6eLRwnaz
	CDcsKrsaOcM6EEMHiXgzD0DYCFwlyNyhZlk7MsblFvJqxhglpRffgoR2ld42e2SzOYdxM8mycmK
	I1MtiV9U1vUKlNBX9C6aqW/7tl1JaAwn1yua+wBmtefzvOSgnE2zSl58QDCqQlGYyWqp2X6TCXI
	GWQuTR16MfcmjvsK3uzSt1wRw//OByihGqKQ8dHLKS11I7w57p+xekAauHePtCU9HLNCnE=
X-Google-Smtp-Source: AGHT+IFou583DBvKBiY/GjCG1N580/eBnCfNksmDMwsIjhIaqx1DSBeDG7vU0yCMAN6wyGXxTRsoqw==
X-Received: by 2002:a05:6512:1246:b0:53d:f769:14cb with SMTP id 2adb3069b0e04-5422944350cmr292136e87.9.1734668225237;
        Thu, 19 Dec 2024 20:17:05 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832c1bsm357078e87.280.2024.12.19.20.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 20:17:04 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 0/2] net: renesas: rswitch: update irq handling
Date: Fri, 20 Dec 2024 09:16:57 +0500
Message-Id: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series switches rswitch driver to per-port interrupt handlers and
does related cleanup.

Nikita Yushchenko (2):
  net: renesas: rswitch: use per-port irq handlers
  net: renesas: rswitch: request ts interrupt at port open

 drivers/net/ethernet/renesas/rswitch.c | 223 ++++++++++---------------
 drivers/net/ethernet/renesas/rswitch.h |  12 +-
 2 files changed, 99 insertions(+), 136 deletions(-)

-- 
2.39.5


