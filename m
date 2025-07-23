Return-Path: <netdev+bounces-209373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3AB0F687
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A617182E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6B2F8C46;
	Wed, 23 Jul 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPRXoWI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23372F7D07
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282849; cv=none; b=RW3EmBqbBN9jen9OKUi1PFlEZPB81GP9adsn6PwWyoml+SCgpdtCfdTNNh5CUcdBAwuhDjnm6z15s868b/SnGRAV7zRtC1AwlBLk7ZViU/eu4IfTxmNsrXRBRUW2QjM8PcgtZ3OZjNp3V08FmOnhrHi/AI48XpB8v8FGBXvh/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282849; c=relaxed/simple;
	bh=8+4wU/AKf6FxAw8KMPm9Ieo6oIroQXBb7k1qeVO+pjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRYPNgYij1eF8Yt5nMRL6hXAjxRcvUnDUdCh7BGBhdo1UHKNU9FOYp0rzh1OLIoVs2xAFQ6RzeD36/KA9tBFjVCIfnooNUchK84QfTlP/SLr9R7EPvS07of+qIxQ24Qud7RqUCLCf1//+KKDtk+lkbS/fNnb+i1hrI/kqnhOsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPRXoWI5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso4109829f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282795; x=1753887595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EATVEWEyIrBZVuReDeADJE7pyE3EaVWtV4LWHr06AWc=;
        b=NPRXoWI5iyEFBzU738WIwZfWsPATAOHCIh2fiMdPL0HYA1Kae/VNovas0zpSDIN61x
         C9ElJ5t54kBH7ismnogBlgxdTfcJVhItFlxqwYf4Lu11O6diJh63P8yo3C+OoCWy1OUH
         SiknRBMsWDy7jZISVkjMPapI2D7McLJExznJMlMcCX7KmsUgspq7dDtxJz31IRh7KlQM
         seyP35HwZWhS23hR1G2VKq89T0W8qMKM74t3sv8DghqCQ46x9zJ8Q2l5MwwIyx2YFSto
         f53oEOJEfobt6u743ffYdh8rLIfEElB+mUaR2AgVYIFIX0pdBuK15RTMQGeS1GDPAYlf
         gcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282795; x=1753887595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EATVEWEyIrBZVuReDeADJE7pyE3EaVWtV4LWHr06AWc=;
        b=MbfoH9jGEmotABEMScmOkqzSJcDsCj3wrqf7NXsJld2i5oN+XUyjLOp2Ke2iS8uK1H
         zYxhe9X0ub6SYTgpMBQEY3MvOxC2YJXYbkC92tWVFUUvyqoHimuZ3g1eso33lmSrm6OT
         xr6Yros6zgpw6ZsyNtAHLNg6/D2H994Wow5eNIxuhtO4vpINUig5f76DbKErGBC9bQnz
         jxbUM0z2AkmRa/u+x0jF+jdVR1XdmCDB4wXqgb3MvJXmhRHQiNNjmn6M1yrKZ9FU86Wp
         Kl62/2CNH1br9nHgnwt1xjTBWpkr7LFN2ARexGqSly95+AEPmhA/bBIlxOneMOrjEldC
         Eb9A==
X-Gm-Message-State: AOJu0YxblO1KxJnhos5wj2sWYTS0ncy/c0w9GzJlBkWKIGpNBtQPzL/X
	8rsS3ALIdY2sNvQQpBlzFwdgQRy4x/2jE4rd9EcmI2VhHg9tMZ1d0o6rTkIo0u87
X-Gm-Gg: ASbGncubvmlw6qf2rUCL0c6iRnzc9OYA/QU8cAPqCuwPsr5AXAh9D9DQNWth+sd+6Ip
	SZDrG5Z8LhCHYyRjIq/WVK6KWdqH1+FF51uCJ3SIsliGvhv6/6YYKzocFKBf+gfGlYtlkA0r7qP
	ySruf9YW3c7eHkMqnUj5JU0JIMBlksI0W68BnR2NfaTwu20pba6MJtz9UR6hfX47RqY0MTVZpcz
	+LIE5561BHHf3PBK5Bih81evaBzPcz+vuLu+snRiJwkJefBoPMTVGYjd3sNdgE9Xb/OuXJSB4wf
	oTgipSKuctR9Agbq0vDiFYedhk/YEJNlvoiPMOEvtCc9aWhvu3d+DDleKvSJSW0lOc6z/HQvfJd
	j1XCmSD4qLBgGswzJVh0=
X-Google-Smtp-Source: AGHT+IEPrahmfvTgBu0Hw5eo2UOUVYlrfEDZlvrvdRXe6FgfJcRFOdMo7HtV7oyP4OVgXReOYn8Lqw==
X-Received: by 2002:a05:6000:40cc:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b768c98f7bmr2899485f8f.12.1753282794997;
        Wed, 23 Jul 2025 07:59:54 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d74asm16382949f8f.63.2025.07.23.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:59:54 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 0/9] eth: fbnic Add XDP support for fbnic
Date: Wed, 23 Jul 2025 07:59:17 -0700
Message-ID: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces basic XDP support for fbnic. To enable this,
it includes preparatory changes such as making the HDS threshold
configurable via ethtool, updating headroom for fbnic, tracking
frag state in shinfo, and prefetching the first cacheline of data.

Mohsin Bashir (9):
  eth: fbnic: Add support for HDS configuration
  eth: fbnic: Update Headroom
  eth: fbnic: Use shinfo to track frags state on Rx
  eth: fbnic: Prefetch packet headers on Rx
  eth: fbnic: Add XDP pass, drop, abort support
  eth: fbnic: Add support for XDP queues
  eth: fbnic: Add support for XDP_TX action
  eth: fbnic: Collect packet statistics for XDP
  eth: fbnic: Report XDP stats via ethtool

 .../device_drivers/ethernet/meta/fbnic.rst    |  10 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  82 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  69 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 441 +++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  22 +-
 6 files changed, 555 insertions(+), 78 deletions(-)

-- 
2.47.1


