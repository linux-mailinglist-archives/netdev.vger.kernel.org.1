Return-Path: <netdev+bounces-152100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582D9F2ACE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24C0161753
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184481B87EF;
	Mon, 16 Dec 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="lulfp9QZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCF1B4159
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333609; cv=none; b=OdG7Kf0guO0zYRJwx0oNMKG/dweL4/gxFAiF4C9Tngz599FR7FGzMAJ39Q74NXhI3cAakX9Oey8/KWJRdwZNh6EuJEZl/ZZcFnNs1PB2FMM4GXjTNFgKOhMGliyleQBDPYJMO37hIDnpuV+cP5ryTrbTliHj0+lUI5RH2jpGOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333609; c=relaxed/simple;
	bh=M0m6mS0qvuOgK4pqKWi4YcPmsudiy3imB1/B4ess3Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mscEiVbyQYITogi0rdZr9g9OxDl08E7SNbduqg6Y18Y4Fq6eW9bc0788yha+h1dOxkbtdYz/hOEcokd0p0+WhmZlU5JDIAOQ8n0/7q55FuG2PiIsHviMBUS6mkfv6Ax4wj2LoPieZPbmzBKI4PRuAMbm4BvWcxxp9W2HlQqFwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=lulfp9QZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401e6efffcso4427997e87.3
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333604; x=1734938404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saNfM3LJ/gXWUseFK7OkXZwpRXxJnebLh8Q4+xjWzoU=;
        b=lulfp9QZ5gsZQUCFTbmmzaAmRD0jU5ABrhB82MXxf7GSwH9w3XUeC5ZaP1zpWeA2h0
         34zmDPb7totrsm1Skihz4Mtjs2UMebq+xJn15xi+mIKJ9os5fVHccj/mFr/zzLtgdgkE
         NC6J1Acs6mAxHmXBAER7EgjO/Xb/aZQDy7vr/OtyVQYUC8zZZgpjPnZkl52ywgwQbhzB
         qLAhNW2Fs6PKXQb/zbnB0je4cvAs4FfdEq6T56kQH22sYw5zFsEcxaEtMXOyfSIeZuIC
         RP7zC1Gw4x79L5fOMubSXptnyCEGbGYZy5ObturcY7FckfrIJOzs9g5nFyZIxkM3tpS+
         BVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333604; x=1734938404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saNfM3LJ/gXWUseFK7OkXZwpRXxJnebLh8Q4+xjWzoU=;
        b=u3CrWbdARvYSWVkR7OK5kQRAcPqSy0puhOnqV6ueCGuFVg+3/8RqckHF1lX9IkoUra
         s2FG7tZ2ZqfcvDw8xzozD+bcRGPTFFBQCgzKKSsXT6I2AgV09qiv/cHB22VFVTDUtwoD
         +E8OYAp3ZoEbwqo24YxKOZzYo/TOyBKGr6fWTEJa8p3myhcP5jPnMhwaUZ8KlDtKGa15
         Zkim1viKziTC2ZSlb462FKT5XNrmxye7PZEssnO1azyY70UDTFdzUJ8QmlLqOflfeBET
         ekDgP4fGomA2HYlnAl/7n/FOczPywE2YTqIcxoQ1A3/RVDPYE94xeqHWrwrdiJN2KvQM
         uecA==
X-Gm-Message-State: AOJu0YwmXc7XYw9bTO/qt+qdJ2fAWu9s9rUMdZj1PZR1MTN7lMsU9Qq7
	fKZFMAxA8BFbBNzPXUBIqMDUeRz6PyMg87hTBw1A/tsETcX8o1lHb3FaB8Fd9mqBQhSo+AhEwJV
	DJVk=
X-Gm-Gg: ASbGncv5h5/naN+RXpk+L5LnZ2BzMMwlb5Ivr5z+fveSSDTonJOZdr0tQDT1D/u9OKM
	HU/ZcrI8zfaVEBOE1/ron826fzXor/YaOPVOrK0OciwRsafzU3b3cko7qrQXK8LXl09K8DnDlrF
	KgOuBUsxYWKsIK6ine9FWQ1KzJWRf1c1XGwk2mgSToR8o4D/tIDwPoxhj89oFTmBDBfVqKvSSkL
	bI53xg5P5Q2MQ0jUx3GzzmpE0HOfs5eLisbcjMdjcTRFDSFbvZRQsQJPntHOK9ZU1kRXkE=
X-Google-Smtp-Source: AGHT+IGDnuBu4pD61786Xbqg5/sZ4XzdhAFZbPTySRoKaH33YM2xTlfYrZazJwFQUY+JIVDFd/RY+Q==
X-Received: by 2002:a05:6512:238b:b0:53e:350a:7294 with SMTP id 2adb3069b0e04-54090595736mr4004062e87.37.1734333603800;
        Sun, 15 Dec 2024 23:20:03 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:03 -0800 (PST)
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
Subject: [PATCH net-next v2 0/5] mdio support updates
Date: Mon, 16 Dec 2024 12:19:52 +0500
Message-Id: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up rswitch mdio support, and adds C22 operations.

Nikita Yushchenko (5):
  net: renesas: rswitch: do not write to MPSM register at init time
  net: renesas: rswitch: use FIELD_PREP for remaining MPIC register
    fields
  net: renesas: rswitch: align mdio C45 operations with datasheet
  net: renesas: rswitch: use generic MPSM operation for mdio C45
  net: renesas: rswitch: add mdio C22 support
---
v1: https://lore.kernel.org/netdev/20241208155236.108582-1-nikita.yoush@cogentembedded.com/

changes since v1:
- rebase against net-next/main as of commit 92c932b9946c ("Merge branch
  'mptcp-pm-userspace-misc-cleanups'"),
- remove no longer used definitions for MMIS1 register bits,
- add patch to use FIELD_PREP for MPIC register fields, to keep the same
  style as in already merged patch.
---
 drivers/net/ethernet/renesas/rswitch.c | 84 ++++++++++++++++----------
 drivers/net/ethernet/renesas/rswitch.h | 33 ++++------
 2 files changed, 65 insertions(+), 52 deletions(-)

-- 
2.39.5


