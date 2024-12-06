Return-Path: <netdev+bounces-149796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B559E7871
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BE41887CEF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F61C3BEF;
	Fri,  6 Dec 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="vn4CRw9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4513D516
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511644; cv=none; b=nXW0QZH7vXt9PuRifwGorSfzgtI0n0bGHhXl5jrQPOP9pXz1I8eKGwH/kG0WLmuojdEkpAJuu20gdScbWBitBpzdkiWLF82JAIcrixCzIQXtEfvG5AEFShGJxa6LlTKxM9+7TGDju09QZ3IqiQTSnDJA0loxTBRZ6ryS1UpYdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511644; c=relaxed/simple;
	bh=fYGGX/ZIjr25jHps8aP27kpRV4o8UzLZ5+Xqi8vgWes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mkMQvjj0EJblMtoWbSjpcRLrGSbj7WnKiFe4kSQ5i8VOK27zYyMoX42En0q7wBCI126uWn3n42bLftEHap8wRR3gTbxFwff0lE64CraN2yLqEPj5FDtvF9epT4dkLXf6hBO6TnccRwuOEe9iF2kVylUFuT169A4LVBtQ+RV61PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=vn4CRw9Q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso26641541fa.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511641; x=1734116441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq340wsMOiDxkES6WvooIBHYHuwTpA7AHoxGHwGVI1g=;
        b=vn4CRw9QZF5bvD+tU4sNHa924Gat4RAYVE7QH/bNfJ6taNU3h1Y3eMfkoYgqKcX8Ss
         uGJjTXCW8L3u8d9hFJ2i3PHchhHytSbiVbJnGsoNzTcx1pqFIcHax8lRMtW3/OrhFCZK
         AYIZMPTgR/Xavd6pQ5yEpEx57hTQxtZ41oTVsyqXGCOR/PHuSQgYBuARbJHQRQWizlwI
         of/FLN/9YyB/SMnApPY4hfspnrHhruuTJdrtq2lWcDjCZOsvL4lI9VpjWbGj3q+jXeTd
         qWA6TVqM1/Jki3vAgXUgLGQsb/JFNLpU0RM6ZMgTpnsLnnsRVDD54hqWvO2yCwq9fXtj
         rDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511641; x=1734116441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq340wsMOiDxkES6WvooIBHYHuwTpA7AHoxGHwGVI1g=;
        b=KfBEgF8yNJ40GrkS2l+GBuW+SF4bz/HJuDlcg7F7QEmsUEfTcMiv7ZghvUI+2bSKG9
         sJk7a/HnNKpwgmVzhFic0cf8A9riNsQVycq5mimjuwyjhqTh2VGZ2kcpQG2wGC5yQOHc
         hwJg1Zn+DgyztyCT3ztDBgfurRkJSRVNlILLCtiilmokvcELCjhNPM+CC6SJVj2UjORx
         rusYwsRdp87FyGIvj07S5mPjxncv7mcWSXJ6pm+Xe1Wk6KsQRMQlCKfJLyIxJUTCvXMF
         R0ETAwdJUTUFIa00/Za0R9Pvp6vQOA+ERH5FSl+qrUJvBeVDFkb1JsFBgpme7uBfpuoI
         cy3Q==
X-Gm-Message-State: AOJu0YxRDiOUjyXwvHzHIMBEMd2xzSMsQYECr9hgU40czm5GvUudI0FS
	rFy0if/y/rNn76Mrwl4RN5A+r/zO0NZoqG6TFCEHyOaST3sXzig66q15nUGh8gw=
X-Gm-Gg: ASbGnctlJxMidaVLyLBoeidLsC/5EwmBmNnPCEU/pBcJv1lt3nPQJkaFpOWLv/rg7x3
	jGGM+LoKNdZMDQ/+9NdU3s+my95JJWrF7QGGH3sME56lsy2gpmBxRfpf4SH6shVTtKbiKtc7xXo
	Ay0s92xUM4vfqaoZrn6w0/ZUsravyWZlqgRnTVdrCd4L/75RkFMcpZCZyXzdC26XRDeAMZz7qkw
	E2ihv6toW9Fy8bLNKAxnyI4/k2kgM2SqQDXGxuPlmI16XwzrJ0B1QXBH+HL7oVK
X-Google-Smtp-Source: AGHT+IFSZlnyUJt9yV4TtsQshdUhz5mox7mBKmBdxeNkbktuFfubOANHhifT2kzCUe5QBoiQybC1PA==
X-Received: by 2002:a2e:a807:0:b0:300:4028:b6cf with SMTP id 38308e7fff4ca-3004028c5aemr965581fa.24.1733511641309;
        Fri, 06 Dec 2024 11:00:41 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:40 -0800 (PST)
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
Subject: [PATCH net v2 0/4] net: renesas: rswitch: several fixes
Date: Sat,  7 Dec 2024 00:00:11 +0500
Message-Id: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several glitches found in the rswitch driver.

Nikita Yushchenko (4):
  net: renesas: rswitch: fix possible early skb release
  net: renesas: rswitch: fix race window between tx start and complete
  net: renesas: rswitch: fix leaked pointer on error path
  net: renesas: rswitch: avoid use-after-put for a device tree node

 drivers/net/ethernet/renesas/rswitch.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---
v1: https://lore.kernel.org/lkml/20241202134904.3882317-1-nikita.yoush@cogentembedded.com/

Changes since v1:
- changed target tree to -net,
- do not group together bugfixes and improvements so those could go via
  different trees,
- added a new patch that fixes a race.
-- 
2.39.5


