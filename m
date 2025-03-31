Return-Path: <netdev+bounces-178280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A360A76526
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD20169E49
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7E1E0DFE;
	Mon, 31 Mar 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLl7euxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962241C5D7D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421661; cv=none; b=jMlkLsgNkCnax+v6eH3ZKst6kw0N6ZB3GlTnQg+w4c1RYb2Aw0+qIiQVGAcmJtMdyB3zWw/dedKoYE7Yge9TBynARVsj/M+bBDYzj/fvB5serkhDf01yXL7cdSuddadP/J82SJ6ffxKRLd3fsfWglJx99C8DFCht3GdcECfuPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421661; c=relaxed/simple;
	bh=50/sugDP3rqvTsu/rsB4NNiI6YaQxq7IY+lqc7wetr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTkuhJDw4ih9Hi7daCyDCtEXtgi3OS2lsJk5+1tRlLWwsR8GdwQMN2ryjIlUGrsktuNFdm+K+G+6ukoTBROrOYy1XJMjlqDON86zqZP7580je5CmyoioOSqGo8/XhhdbdvrUWWO2sg0iiS4oRJRxeH5pHTpfNLoCsMcS1Ecgmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLl7euxS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so96256835ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421659; x=1744026459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ot4ljXVdHLU7FPl6qC+yZNIZwtv0vKcDvGytdVqXOIM=;
        b=YLl7euxSMopdjPtURLvSgIDafa6a14mJj45Y+y+5clVo7NDa0CNaHuLqu/JA28Pnm5
         qpMVGGVFQ+JJFv7RDZM9rs3mHDGt5MMhKa33RgK8uEU3jZNptK3GF7EPJPmdxhxs6b4f
         TszqVJNNkuM3j80pJ5D4tQHGmvyrXlRQPTJGjb7g8Kj8Us9InnLDARUABRtjzxhA82wH
         JtOYJeI9vNMSETt02qs73AcWWiBj9/BJbn0ZYpdIUA/dmI900TEOlMdgBuckkmgDusRd
         Jzp1GL/e26R+zyyFJfl6zjW/VXwGsM9H8Bzt/KlGCFnlAvPNkC2w8QNk8U1bVEGqMca8
         YYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421659; x=1744026459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot4ljXVdHLU7FPl6qC+yZNIZwtv0vKcDvGytdVqXOIM=;
        b=JrneBBufV5TzeY8ckJFes/ITrxgWcROYEVbblwpc7QsYxLubI+1aEj+Xbsz7VNRJfM
         SvQBziNVvCA+jOaV/D033IQMsQwRV0FNrgjW19YWDAqUvewy0NpRkHxha7CpxA+DUJyB
         o2yyj/YBc3ID6Gdh3Jq031TG9iV5RnK6nwanZPh/wwq2SMGPF95WzbLGIvu8ueNyqqQo
         kTB92v5EZH5X9coMW8dSReW0efgV+uY+ipqadSPYiCgraHLKDR39XBoSOaRX4Uv/NK9A
         5Dgs5ucduuHTxXytBGDeshJH/zO+8YHCFAg7W+4b6/zdKXKMnReF00jY0/qLsqBujFEc
         HN3w==
X-Forwarded-Encrypted: i=1; AJvYcCUv6GthQqtsI5TB+9ZP09S82thddIRSIVW1rDq01utWNkTh3ed6Ej8KH8i2OGoBkJgyRXNwFXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtrC7iOFXpC1HtiyzrrR9GQCzC7MKlHxST77UEJEZ5l/EgQwF
	wE1Ryv7Z+We5+0ruouQTZOMOQdQk5JOeeEllXxengxYUhN6swqd+
X-Gm-Gg: ASbGncsEi/wBuoCLp3r1LuipVX/v7moCeZC93GDoTDNxwGx/nXBtR3M3EODJAHH1z3O
	u/pytrgWvLMjo1m3/DkOyhDt3OEJl7EpEzsdC99cLfw7krJgfJaRi2SBD9NsXaDFAbcWb2Lw3aE
	r3EuGNDpoYkAULndvxl9V51dXeucokL80M2eVuoXBSYnzR5wX6rC5pn6kX6o614wBdw5ONg4+l9
	ffOkBUZO2m8Yka22F/hrKBVKTwHUvrd4hrWv8ekXELGliaNLhCiAedhRU72fWwT8rJymZERRDwz
	qwl9Is6wa4fD033PFLAp8QuN9Ff8b+K7JA==
X-Google-Smtp-Source: AGHT+IGbiYtf61hBERFnUg82bwlIr4ZnPWsHkIREAVYUa9YRLuaadzGifikxCgvFo8U90tWdBVKTLw==
X-Received: by 2002:a17:903:2350:b0:223:628c:199 with SMTP id d9443c01a7336-2292fa1adeemr109541295ad.52.1743421658888;
        Mon, 31 Mar 2025 04:47:38 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e222f4sm6724881b3a.41.2025.03.31.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:47:38 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ilias.apalodimas@linaro.org,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com
Subject: [RFC net-next 0/2]eth: bnxt: Implement rx-side device memory
Date: Mon, 31 Mar 2025 11:47:27 +0000
Message-Id: <20250331114729.594603-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements device memory TCP using netmem API instead of
page API.
The bnxt_en driver already satisfies the requirements of devmem TCP. The
only change required for devmem TCP is to switch from the page API to
the netmem API.

The first patch refactors bnxt_en drivers.
The main purpose of this is to make the bnxt_en driver use page_pool dma
sync API instead of raw DMA sync API.
page_pool_dma_sync_for_{cpu | device}() doesn't support virtual address
handling, so it requires to switch from handling virtual address to
page.
It switches from virtual address to page in the struct bnxt_sw_rx_bd.
By this change, the struct bnxt_sw_rx_bd becomes the same structure with
bnxt_sw_rx_agg_bd.
So it makes code much simpler.

The second patch switches apply netmem API.
This patch adds PP_FLAG_ALLOW_UNREADABLE_NETMEM flags to page_pool
parameter.
This flag indicates if the user enabled netmem, page_pool will be
initialized to support unreadable-netmem.

By this patchset, bnxt_en driver supports rx-side device memory TCP.
But Only Thor+ NICs support it and recent firmware is also required.
We can test device memory TCP with
tools/testing/selftests/drivers/net/hw/ncdevmem.c

This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
232.1.132.8.

David Wei tested this patch on the io_uring side.
Thank you for testing, David.

Taehee Yoo (2):
  eth: bnxt: refactor buffer descriptor
  eth: bnxt: add support rx side device memory TCP

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 520 ++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  35 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  41 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   4 +-
 include/linux/netdevice.h                     |   1 +
 include/net/page_pool/helpers.h               |   6 +
 include/net/page_pool/types.h                 |   4 +-
 net/core/dev.c                                |   6 +
 net/core/page_pool.c                          |  23 +-
 10 files changed, 344 insertions(+), 298 deletions(-)

-- 
2.34.1


