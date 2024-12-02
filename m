Return-Path: <netdev+bounces-148058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016259E03F7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176E3164FFF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE2201021;
	Mon,  2 Dec 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="3dsDRb1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43771FF7A2
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147368; cv=none; b=KTMBUFGNS4quAzBWgghXMHRnR6OfIvUjB2wJD3g0EngmvK+mozj15UUC/lXEJ3sDrlR6h+OtvJGE3W5i5LlfP2DXST8NRNXa2k1HAhyV0YITp08iSbHoiiDn9q9BpquZHX5ZsvmRRrdWpCMZqm8hQUIONzfsAClhV+ZeZ4uZRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147368; c=relaxed/simple;
	bh=cJZy9S1FMCngEJ77urL3TJUprQtUSEK6YQgVA1pcvq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lo6IIIv7/PY+c6et2VaWJNrg4EE2CN7EUHBRIn3bFCsPwoLyr3ry2fwD+N/MK/XJb+J6g0U5tGFQFZ6ykJsjIxj8jmDgMJibhktTT1VDiWmgKDoFGnArf6fGImx7e2sbIPYaj3qJZUY2UXRWgfDmCZOQgtfC1hblCaM391pjnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=3dsDRb1e; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc1f72a5bso43655071fa.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147365; x=1733752165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpiwpXSnfuXnIooq0y/4KC3bfGsvvfydq/7tBkpGdBA=;
        b=3dsDRb1e1tUA9XGpsV6v7d9nykNzFRfdoBNP5STwNb+0YtPt1CsrHwjER8cmGv5mQd
         1lt9UGkD9ESNFolJULXCPoUqk5E6zRljHFJ2k56OMR8zbrKqAbY51nIJBWX+TylYWaIX
         PQQ/gjDfIgFdTMdLl6acp2axZOZv09NNuzUoHg8SwDEYOvjorbXdRUor7bqaK2/8r+Lb
         KT7VKuRyAinyjXxEzxyElxwm5TwRIaTilDsysOUxau1mzom28iQSrrEJN/IaEprqFJwT
         /5jtZSApHtEKY++kV6wSF3VMB1MlkKrjdY/XZcLTUrxNAZotB8ezsQffqc0BgAEnoAXt
         vPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147365; x=1733752165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpiwpXSnfuXnIooq0y/4KC3bfGsvvfydq/7tBkpGdBA=;
        b=HW9afJ24e7P79r16Hdd0M8oz11Jo/tWSqMfKm0uxGuhkzSKJtJswlbg+zxMXITV5ZK
         DESfBV3HgykVMPLOCU2UJLWaMGWzU/B6vCYfm83khX/oJkSJYB344zxbMAv/a2zpuerN
         9+PTWaDnqAvli96t9M2xsBeJVrsWnNlMsSLjoLhcggNiPdFhoKLqRbUiAn/wCM518aCC
         zCassU77PeqwCo26Ij2RBXmEy0Q17cyR/aslkcPw7UZr0CxJFB2qqbfuY0VN9M9Qx/4P
         rY5nAAAdjB9DRUlBpwJLTy3Oao7HMnGrB037tnXJazYOk6chwg94fVoHIwDuuoxfUAyF
         cVPw==
X-Gm-Message-State: AOJu0Yz9NfwmP+AWyZSMvrJeLpFwy2W+9gX08tpVzC6rc/fO4x5Y7RM7
	IEFC/uKdLx71B5aiIxtxqNPdigK2m7fLQfq+UIOaIA4L9Oc3jbhuoiwr14vXQjU=
X-Gm-Gg: ASbGncubFy70wbGeD3eG38pj97Mm3EW46fq2dsfnf40wnryLqqUw2dlsFEoroxfy26X
	w/IsblQmhqIDhswyWgDZJaClbAkrBITmJUR6RxZ35GGctrsATdUmF6EoNlfthKoWl9IclC8ARR4
	i/ee+IUflZM/m70rTyRE9VYq+e6WbGKy66sx0Te0l7hecFsWvgEHT66uq4YqaZLqV6WeklJ4IxC
	Ei1iU5leXzpqcP5uT9Zhno2xTYJErQTyI0XdLjh5URQJUpAGnhvr5yN61nx3LmD
X-Google-Smtp-Source: AGHT+IHMltc1McJoIBtx24nNlj7xLYEfgMGTNoTB0c8hxfeup/9URrE3WWd5lDfPJXd6xm1RQOYP0A==
X-Received: by 2002:a05:651c:154a:b0:2ff:e2c6:e654 with SMTP id 38308e7fff4ca-2ffe2c6e6fbmr57320641fa.19.1733147364585;
        Mon, 02 Dec 2024 05:49:24 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:24 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH 0/5] net: renesas: rswitch: several fixes
Date: Mon,  2 Dec 2024 18:48:59 +0500
Message-Id: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

Submitting them first, before new functionality currently being
prepared.

Nikita Yushchenko (5):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node
  net: renesas: rswitch: do not deinit disabled ports
  net: renesas: rswitch: remove speed from gwca structure

 drivers/net/ethernet/renesas/rswitch.c | 14 +++++++-------
 drivers/net/ethernet/renesas/rswitch.h |  1 -
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.39.5


