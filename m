Return-Path: <netdev+bounces-168136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4942EA3DABB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889ED3B81A9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72941F4169;
	Thu, 20 Feb 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EoyTY9dx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2251F1508
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056620; cv=none; b=oRpJamq13mXXOb+h9E6a/fGqf68UMXumZAkAqMyXhD7Z6Y8NNUHX6sH0/1YFHjZ7j7D83NXlOsqO9veKScvyynYMUe9MG+mCHRiz9h0f5/ESQ35OtVsxTIzx1hykXUJ5qIetvFmkVEOaKLL3SnfrcT6zQeJz9knjljj/2k3McbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056620; c=relaxed/simple;
	bh=0H3l3YFJnEiMph0KSoceHDc+zdpjDERLeESwmnjB+SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4snVvKec3TNOvdVGKSHO/cFxXh+kt4ZGsnKFSF+oaJSuGCJn6f2EhH0wyxFs0gtOwHF9tbrkPnbnZ1GkkPKevw9r+PRd/BUzsK03kOs1v3Vw3tQWZbnzS9IdIcrkexJQiYonAb0hw/V9UXF8mnZFjDAkcoHit5MWkjvm2xRfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EoyTY9dx; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5452d276db5so158103e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740056617; x=1740661417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1t1rJgI/4GE8HWJWG6bhFkmBD3ERFn2czpxfS4zACM=;
        b=EoyTY9dxqdTByGDJwojQSYRCAEOA3G1lU1fAb+10uCEKTrPgTJ36XvyqEcMp3NemvZ
         cKBlk0hIpf3JRf+dhdtELoiASWPTKDD/5ebaVmKxgTl28yISOy83HmqH2hzWSc1hxeLC
         OxkFEBmJcGuCSHcc2VgMX4mzMNQgBprGERGMGVAn6pyZL0iaOU65ARfSiCNKbhCTi9p3
         EPOBE74iF/Yn3HUCEZB52hc07iCnRXuoD5HP61G0eHRkEDtmR+VPA/JKJwTf5BVG7vtu
         IRvFGcBBcfGMq9ulrvLlPFt8QKzLRl9xvCu6S4SPYO88DVgk9Dea65Sjr+e8Y9f30+AY
         3UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056617; x=1740661417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1t1rJgI/4GE8HWJWG6bhFkmBD3ERFn2czpxfS4zACM=;
        b=NjnpTUc3weRh8T+jI939fgdZNndBwxtKLcbdjiutceJhPUc7kM7GEuv1a47uE0YqlE
         M3+scruSyV07GukrTnVg5cHn/lju6lVkzREPChu+1Z2lVXandklog4tq+Caw5loTxoFd
         DSr3k9L2A9W+MbCEQNG5hD1ey6Jcb1bPty9e5Li9JAHeFl27uJDUMVeRNPwMjfJ5CH5/
         NYrg57KhqgTedySyzq0MMrGwbHWnFIkfxzq8Xi2uHU1WXEsWZB9EiUOXMBikPI6Q++HR
         pV82eSr1Tq2gIMiNdnwaaa+T7LBGbCtAxOkgjQBLp8nQ7M6ZQEz8wkdNpThoz6fxze7F
         DASg==
X-Forwarded-Encrypted: i=1; AJvYcCUuiGUkWvPEkeuJvuNwoWmJxRX1qj59BKki2rWHLVwlh7pETiNMJlBYa/N/iR9ZfF/YWOq4kK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8ld+VDrcPzdJja8PMmMb50FAzIZDqvbuvYkrdHrSLrlVHr1u
	RgGzPOLSBnxX/H14iCHYRjYk+RcWL4R3LRioJ+v51TCeC9N2WFOogolUk44daR6uYyjKKgaUnm4
	l1uVa01EnbMLMcCNrCbPQlctNJj+gmuX/
X-Gm-Gg: ASbGncvYlqGCaQDqbqph3/Aog+SAEJAiFbScF1/CPKKieSp9eQ+3pscpeXgwUeOvYzo
	oNxZ8d4mZMUsrxFBvZdlEBcN1x6GPyHo6OGB79iO4FiPwRZRrAFqvSIVXPT+HWSxqdIv6QtMGh4
	HkmVaNK6nQJZN3NICv/bxmnrIHGR4TBOyFVcE3/Kp2KAR35HmU7oh8lUmW4jpyIqqlTEm+iSY3V
	4vGwPZsvA5GVibsNr4u0GF8TUifX13y/mHDh7GUcSRL7rAse4zL7PlclGq36TgTNruXcUB5uvc3
	w6u4vIOsk14RZh0qauKjmFLBYzuezIAT1y3U7mGmVem6MTJ3I9eVk8JmtKJ8
X-Google-Smtp-Source: AGHT+IECJpjvThpE/fie6u9vECZg4zo4I8DJwteXfp0EJQJqE+yZwfskcmYoVpCBMnNvBA1ppXoT5SQokmxr
X-Received: by 2002:ac2:4e05:0:b0:545:55a:da39 with SMTP id 2adb3069b0e04-5452fe45e76mr2650955e87.5.1740056616660;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5461a4008eesm422671e87.78.2025.02.20.05.03.36;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4283D1352D;
	Thu, 20 Feb 2025 14:03:36 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tl6DI-00F2Dh-0d; Thu, 20 Feb 2025 14:03:36 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: notify users when an iface cannot change its netns
Date: Thu, 20 Feb 2025 14:02:34 +0100
Message-ID: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.

v2 -> v3:
 - don't copy patch #1 to stable@vger.kernel.org
 - remove the 'Fixes:' tag

v1 -> v2:
 - target the series to net-next
 - patch #1:
   + use NLA_REJECT for the nl policy
   + update the rt link spec
 - patch #2: plumb extack in __dev_change_net_namespace()

 Documentation/netlink/specs/rt_link.yaml |  3 +++
 include/linux/netdevice.h                |  5 ++--
 include/uapi/linux/if_link.h             |  1 +
 net/core/dev.c                           | 41 +++++++++++++++++++++++++-------
 net/core/rtnetlink.c                     |  5 +++-
 5 files changed, 44 insertions(+), 11 deletions(-)

Comments are welcome.

Regards,
Nicolas

