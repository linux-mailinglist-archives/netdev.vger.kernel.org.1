Return-Path: <netdev+bounces-130566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6698AD95
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CAD28248B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DA19E819;
	Mon, 30 Sep 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RJyXOf+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60019DF4F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726188; cv=none; b=qSIr4lnNOS7Va4o5/mubnXQxksObUlAM5EpDTi1fq8BtwI5nVehPa5n/kDBVdjDZ89iGjF2pZN3uMZ82SC4l92+9gO0GdeAeJHeH54fuig0LDNKmZE6h13VsZC8vb58sSiELqWDiG190G413RiSjfZUwoVZZAyHIQC4usGmvYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726188; c=relaxed/simple;
	bh=nsUO0zUQmPXPPHgAa7TLcCDNB56tC1YTIiQbChsZvV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnPnv0ubudjUFbTU6xlajUcqWuPM3h0jrJa8zwuDqUyYksgVZt1sI97SGuOGygRjCqMCW+D6QO7xeFTGxOd/06bvY/asLBcs1pbzw6neiHVo/uRmUGzSMaau4dJTMJScuTnrmZ/25HKmgVzaIUDfJ8KzBaiock2jZgHJ56ogaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RJyXOf+w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b20ffd809so3448913b3a.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727726186; x=1728330986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04aIwQhVG9kkwqyptz1spBSbHv2X9I/9d0b2JatFAhQ=;
        b=RJyXOf+wXACz9wnyeVNKgTGVV3fzalT+WhJa1AVnTxUyU4NWa8H8IeltV8esdbPxuE
         UB2FDOb/e5Hoklbs7w+GYb2eafcZM9CRTC0pYq4gGoDaiuaefa/xJoy1+xzU9ZA9NZwy
         3ptLPjRGfDf5ixwornc7Wxr8gl8Jd935m6mns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726186; x=1728330986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04aIwQhVG9kkwqyptz1spBSbHv2X9I/9d0b2JatFAhQ=;
        b=hjEbGD2QveaekiY4s66tl84UbHbssaD7Q1McQck+wbjkqiCThn9i6lVgDlbVBPnVm/
         GnmatJERdrJ7+t4uSGdRFcMu8T9y6uadV/smqUH+4wTum9OcOR5mSSK5Nifl20LZF4fo
         HGPGsQZVK9fxPDamtqr4mTxbW2rpfbYiK9c30TDf8KCATQs6LrPZHkwK9lqNlXi6BJOw
         Q/QIW+uI0XB1pidTC2kXrQxxNNyrljeJT2jsYFEdWfMuCfWw1z00MCXo96TQNs928oN2
         EnuxWSFYegLFLp6lZkrD0SXypy61R24MJrpfslTxL2hE+0l0jhtw04HfJY5aw3P+xI1m
         ZzJw==
X-Gm-Message-State: AOJu0Yym//LSeRgLZFIxp4Wj/mtVzUvCjKEEUDUstkdOXzbJBVhM7wZv
	bfn/Oo1+L2pNG8Cr/mt9vjLhF6mlymiTBZS0nLa/LWC9GnswkRD0/US89n6zkjGala7qHfLw4hM
	ogsrULNuZTZ6RyBJz5u5ZrH7+XHuduDVxbuNbdGGOoVhRne0H0FvTIQcn7qMOb1fARqj86Ep2zE
	RlClOKf9uw0qzXopZeyKha3lCJtxqhAkKh5go=
X-Google-Smtp-Source: AGHT+IGe90vkHUWOcUodfCwsCtj3m+WHIqgqWMT4BLw6euSWP2mWVdam1jgwx+7tGd2QFCKQcm2lxw==
X-Received: by 2002:a05:6a00:198e:b0:714:3a4b:f78f with SMTP id d2e1a72fcca58-71b26057a41mr18282679b3a.20.1727726186115;
        Mon, 30 Sep 2024 12:56:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649a2cesm6604450b3a.43.2024.09.30.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:56:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>
Subject: [net-next 0/2] ena: Link IRQs, queues, and NAPI instances
Date: Mon, 30 Sep 2024 19:56:11 +0000
Message-Id: <20240930195617.37369-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on an EC2 instance with an ENA NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

I noted in the implementation that the driver requests an IRQ for
management purposes which does not have an associated NAPI. I tried to
take this into account in patch 1, but would appreciate if ENA
maintainers can verify I did this correctly.

Thanks,
Joe

Joe Damato (2):
  ena: Link IRQs to NAPI instances
  ena: Link queues to NAPIs

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 38 +++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.43.0


