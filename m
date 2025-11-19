Return-Path: <netdev+bounces-240000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A6C6F0F8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1AD7F2EC50
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61431364045;
	Wed, 19 Nov 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAutWhz3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQAH5RXp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965A3559C8
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560455; cv=none; b=VNb6R8zGRqQ4BbW0IlG7OSINkwged7jrMoic9brFrTS1J59u+9znfXm6gwhM3Gmoz2vR3sCh+cLI6ENdu42kel+cKIlC3GrdiOXWA1ee+gIwr1sA/vSoggbB2cWdmF5bwMezDqTkh1QmQ8e9j4jirVk/HE1E1wtV11Itr3b49+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560455; c=relaxed/simple;
	bh=vdD/z1H/NGSD2CgcxQDbI9+TnzdvYKd67NdxZFVWUJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X39BCiWpM9tSlvGDurxgz9s/oYUNR7DtwnDzXW+oZ7n1Sdi59i+G6bnWloXBFAfJfBN0KMSaMaxrie8JP5IPlfwMxQA/wlLRkIWhqsS5CCZWLt5JF6Kn3eMvIHl1fHMCrvMtqBTPHVLBG4NTose8FWqRPeeNW5Dn0G11RRIsCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAutWhz3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQAH5RXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763560450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LMQhc2GyWc9uyu5idju6PCesOmACkvvX3yAV0Jzw2sk=;
	b=VAutWhz3x3IMA+tJjmGW3XnOrm6HKGAYLUFJmOUs4aNwziT1b5+Jbbwcb8uAhw7rpqEgnX
	fYLTxRTphtl2XDu0tXjI3nDyutRnlpmQlM6bY/nOgD/GF+lDExGDwakmLtuKQm69HtMYPA
	io5PMHclOlFQqyPyygSm7Wf95VILBBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-dbW5tuMkNSKuP_g0fmsTig-1; Wed, 19 Nov 2025 08:54:09 -0500
X-MC-Unique: dbW5tuMkNSKuP_g0fmsTig-1
X-Mimecast-MFC-AGG-ID: dbW5tuMkNSKuP_g0fmsTig_1763560448
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so33313855e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763560447; x=1764165247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMQhc2GyWc9uyu5idju6PCesOmACkvvX3yAV0Jzw2sk=;
        b=RQAH5RXpbSJ1rT3ZV536B+ptOLv3KkEMQE9+8k+MPevWf3aeRpPlpe7Hqet9FdBycb
         keW6hGWHwfIFJRoXQsoouNZNVgbYprveOOzxngc8msPqMbeME5EV5JSuTj2TZIP+Zunx
         n6TdxtE1hRk7tBnx4M6RqLnAG3LuEtqYQu5YGpv3oBM0mYiZVt8j2CPzo7EIelDMhoED
         Sc64JCQQMTiaaQ24iwE3qV+bu5zrJdShQ8+AJyGSd8tPZgtKpp3J1fmc+zyY4zxVY2S0
         0NJrs8BZ3Sddv4dE4AzJ0Gc/V13XJtuO/rgl6fSwDrvQazokkHdS6VT5nfRHVA5ipqDI
         82oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560447; x=1764165247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMQhc2GyWc9uyu5idju6PCesOmACkvvX3yAV0Jzw2sk=;
        b=herXF/xkuBqfYE6Z9KKaLrVPC2ZhkqHxFTRMp7cjYPU5OPJAYkalrW6SRkHP7AmezY
         ceHyRZ23hap9xBxJ4vUwMbdKgYXOJrrn81M//EmgDXAXqiDO0FCu0cOjxVSG4VsWnMAb
         7IS2jITtbc+37HkAjD97JAMxXXTMbgnzcuajftdSH6wScthn4hoiyHMrNwA25Xc5seSI
         N5mOdWz509zCDewPUCzT+QLUXcDa8RrdmEMa5DXDx6ZKC8h6ofpk/Ho1ccL4DuuFuNpk
         U31H8x9sV05uFvlWtKNsUBuAPlkR7BqiKaJbvCgmwvLvjBZHk8k/Xq+o0ev26+OrDn95
         MN4g==
X-Gm-Message-State: AOJu0YwIiLm4mQMSqoKR3BuxVKvORsfEWjj3iFDo7mk2DI53XK4kfAiU
	3zl174mK6R1/FXepUE2IUrnscwPr2/s8bdRrVKR89NqrXIDYhm8rmWRZlAR6A/zuALcTwovPDpg
	Wr9y0S+fEZKmKsRW7U9ZD0OZqcGCu41PMinpweLh6IkSp8WzgV97TR62ho/I30h6eBxGWbLwxWv
	TlHN0kEQg3uPuyLHiQhGpt+nSaPtgsfp+6ln0DZYab5Zjg
X-Gm-Gg: ASbGnctd5sRJmDKYiJ0907px7zWVvRjG9FWsfnVPWQJhcsQZ2WJxwXNGQfF4TCtZsLI
	d6UXZGPFC4ihXDW/OqnbsMI1798h0DEgsR2lJ2j1XTJo0A5DILgicO7ZVbtiitIUwxjw63fHLqh
	pQuNPvwX0eV62aGTYVQGPpJkt6VZw06gMBzs0eRvzxgKtRP7aRtw3EQXR3YQVBsNvWElfh+/ILe
	//FAFdiSJ5abzFcQICvNiByGdAFs4Be1A6Y6MGIQRUSVX8AMfuj5NCboK6gS9fQNippzHbDB0FM
	nCauFGQBSpxQ9CJ6tVyjNmQAqWKZJlxF4heRe+06ok7P1pIZT9HlpvLlANgBb2KTehp93ruWERq
	4b53dhIgNLjZBDXVS/A4k7YUAhBZkuNcYXAC0PgvLmRFEXt/VKQ==
X-Received: by 2002:a05:600c:a05:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4778fe55465mr177259505e9.1.1763560446951;
        Wed, 19 Nov 2025 05:54:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpKwklYtjYG58EPBtrSyHrM5/GRdUfxe+KtacxJxPjhTsatzjqf5qMBg22UqZ+NYappiYBLA==
X-Received: by 2002:a05:600c:a05:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4778fe55465mr177259125e9.1.1763560446508;
        Wed, 19 Nov 2025 05:54:06 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9deb126sm40145975e9.9.2025.11.19.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:54:05 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page pool integration
Date: Wed, 19 Nov 2025 14:53:24 +0100
Message-ID: <20251119135330.551835-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing were performed on Raspberry Pi 5 with upstream kernel
and all the changes are intended for gem only.

The series consists of two main changes:

- Migration from netdev_alloc_skb() to page pool allocation,
  enabling skb recycling.
  This also adds support for multi-descriptor frame reception,
  removing the previous single-descriptor approach and avoiding
  potentially large contiguous allocations for e.g. jumbo frames
  with CONFIG_PAGE_SIZE_4KB.

- XDP support: Complete XDP implementation supporting all major
  verdicts (XDP_PASS, XDP_DROP, XDP_REDIRECT, XDP_TX) along with
  the ndo_xdp_xmit function for packet redirection.

The driver now advertises NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT,
NETDEV_XDP_ACT_NDO_XMIT capabilities.

Paolo Valerio (6):
  cadence: macb/gem: Add page pool support
  cadence: macb/gem: handle multi-descriptor frame reception
  cadence: macb/gem: use the current queue number for stats
  cadence: macb/gem: add XDP support for gem
  cadence: macb/gem: make tx path skb agnostic
  cadence: macb/gem: introduce xmit support

 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  42 +-
 drivers/net/ethernet/cadence/macb_main.c | 680 ++++++++++++++++++-----
 3 files changed, 567 insertions(+), 156 deletions(-)

-- 
2.51.1


