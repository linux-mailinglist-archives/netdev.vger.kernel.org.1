Return-Path: <netdev+bounces-107106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69039919DAA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2750B284C00
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82EAC8F6;
	Thu, 27 Jun 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KZH3vyXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C16FC6
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457335; cv=none; b=FOsprBZa76Dqatf0q16VzXSLH83iIbqr8f0Tzkk+skh06aP4OdFtVKt07uoMAmSynhlL0k4ufVAMQZgbpEs44ezkNKFhtxsaTlnYinfRTetHJiiOl9xYLDmuH+Jsch1n0d+SmleILLWNNeEPu/Od6ueBBBbMawC4GFW5RUauErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457335; c=relaxed/simple;
	bh=08YwaB3OZXEvjTxCKyWO35fYeltVdCrg9OwyfkGI/zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFp/baXOTyn+IVtd2J5nHepRg2OGWibBbqI0IS0PlqhxiBpWu79/O9oOElR9+19jEPdA3mvIzPXR0B1CLzt3Tb/IyYz3fwujyvPxrJrKzVvVzQbEDVVnM1sso9uGMItxQcctGq5puwfoqw3V/ZzsEXTGsjVnm5zneIoYTZoT4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KZH3vyXm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70699b6afddso2166276b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719457333; x=1720062133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkMSIwLTA/wEs8M/fsEz/xWFGLP/rMgEAV2SKuXjLDo=;
        b=KZH3vyXmSfNi5+TQQwTKdE6zOyeAfvosOqM1PfPoJBa1XvU7QCJWmMAoeu74vfamn5
         CS3qHb3egpCeSSh6hDdhOAHYMOrfz94WPO9vrhp0+FhnwPhm7B2SA7b9E+Tv1xRSYkmj
         UhtceGZRXdWo847VkdVjDQgwAX5XfbA329cSyxcqDVMR3jMmQE2Yf3h6iBqrNGktQUWd
         eUU/q9H5dh8JU/SC+Vp9ZjDunXLeeGj80rFE+62xt2m/xDF4EA0uws7SGPajdls3rK3L
         JLmAdqY7lUWvOhgNJvMsuLSvcc0kDsafvovTkDGoL29MvNw+wVulEblZJmyH7x8pgHoS
         OxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457333; x=1720062133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkMSIwLTA/wEs8M/fsEz/xWFGLP/rMgEAV2SKuXjLDo=;
        b=FTaDYjaQTpOBdG3Jz5p30H2oJ8FuRnLyO+MMcyXN1kfHqY98M0l8wNd6yBlJB6vMzy
         r2VgHl4BNadxQ06jkeBp9TbRU3PcktL/SHGfPffkGcGPrkpY6BjqAaOI4QQkdT65yhQt
         syPBiCGmBe5Fy01u73u4wyswdadBvalIeZZSTHqg2fcCIwCiBPNEw6k6Z0XL21uHKWe4
         fJUD6IZZFpWLacab9gVQZCAH2WAppeWMLIQqfWQ3gaup6H+vycViC89QWPN2r3FWXjcL
         nKe7s/UWdctnOdvk0aTejvvz/xeibXGiDf4TXmNKaNB/JsiU7XtwiWJXNSHUQnAJBbUI
         Ov0g==
X-Forwarded-Encrypted: i=1; AJvYcCWoChHJAvGTZj9HYVoxaCzdEW/iLUCToO870rAg05mhpPsJCdhrI4nrtH+0HYm9I+obKc6QwVAxUmGu23sLkgdMWduc1DPp
X-Gm-Message-State: AOJu0Yy0A4EMicPrkxeyd5oL8miiFNcKI132utnryxT8Nh4enKpx7y+E
	mODGI9tXLZK9AADCdhahKf3KaJx8M/63lmtDdPXt3IqYb/RPM0oProDfkPDHu8s=
X-Google-Smtp-Source: AGHT+IE6/tqT3MmgaARpe3xIBtKUEIc6lV8Me3Ll8si1QOiAB7BOE1oWDWRG8+IkT8oJhtJJYlxLrw==
X-Received: by 2002:a05:6a00:2e9b:b0:706:5e33:32d5 with SMTP id d2e1a72fcca58-7067105a820mr17402980b3a.33.1719457333517;
        Wed, 26 Jun 2024 20:02:13 -0700 (PDT)
Received: from localhost (fwdproxy-prn-039.fbsv.net. [2a03:2880:ff:27::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a07a3dsm215841b3a.123.2024.06.26.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 20:02:13 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] page_pool: bnxt_en: unlink old page pool in queue api using helper
Date: Wed, 26 Jun 2024 20:01:58 -0700
Message-ID: <20240627030200.3647145-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

56ef27e3 unexported page_pool_unlink_napi() and renamed it to
page_pool_disable_direct_recycling(). This is because there was no
in-tree user of page_pool_unlink_napi().

Since then Rx queue API and an implementation in bnxt got merged. In the
bnxt implementation, it broadly follows the following steps: allocate
new queue memory + page pool, stop old rx queue, swap, then destroy old
queue memory + page pool.

The existing NAPI instance is re-used so when the old page pool that is
no longer used but still linked to this shared NAPI instance is
destroyed, it will trigger warnings.

In my initial patches I unlinked a page pool from a NAPI instance
directly. Instead, export page_pool_disable_direct_recycling() and call
that instead to avoid having a driver touch a core struct.

David Wei (2):
  page_pool: export page_pool_disable_direct_recycling()
  bnxt_en: unlink page pool when stopping Rx queue

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +-----
 include/net/page_pool/types.h             | 1 +
 net/core/page_pool.c                      | 3 ++-
 3 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.43.0


