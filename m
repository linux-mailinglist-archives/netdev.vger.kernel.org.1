Return-Path: <netdev+bounces-281480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qABTIjzF72lsFwEAu9opvQ
	(envelope-from <netdev+bounces-281480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B1479EF8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24152307AE4F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F3367F3D;
	Mon, 27 Apr 2026 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI1//Nvy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57A322B9F
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321014; cv=none; b=Lvc6JT7soybPWupMtW/Rn4Q3SvRP8XfmuF1h3qSL3IDuj59zfjkmwTIpySMTMk1cI5ULUNiaV4AxKzocO5neoHc4Xt+zqnRbqAw3uQH0QzXHxqwuOuE/fmCltfzOCizJPyVxJ+7VWFNdtz/S5wS8iaGmqiGAVOK0QBdpo0DZhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321014; c=relaxed/simple;
	bh=6IRZDJj+r5sp+QVknT1l4Md6WM8TiqCR6LQHlxM2R3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOnSUAWHcQXHRpntM3hby5Tg7Y3rK3FTFvKyLhEfsLzgov8pUEK93kEiT0BKGGrn07hFqL4vC5WLBs8FgrUHga2ett+MBblh2utKeiSoBWHGvV46CjAWV2DidHNLz2g/iHiLZkD+A6ENfNEaUiUZKfEBuHd4EhL/d2XWlURtDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI1//Nvy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a74765703so99542987b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321012; x=1777925812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey+vtW5zGSIcS5Imm4MD7T8reur80NswJgiOxTbyp3o=;
        b=ZI1//NvygfoThiHFa5mMXAVuiXJgbH3IVO0NnmJKbOHbmJdFy4DkWi2sWNy8NBmjsN
         Ovwbh0I3vSnRZ4kPYpnNHjtGTSh0Mbjw6/NkXGfSVOCCb1wNkQH4teVyCykWgW0YXmzM
         9dpAUujxjmZ5/cZFVofiDGSlfbBbT0XqcZH8ietwe53Mn6K1SA7qFWawn70kFhEl82Eg
         arK2VVVKVNZgS75G18vLzr3vtYYKIMd7FYeRFO/e/p+8Um+Qxaw1OitLSSFTZTrvb7zb
         DsWxrHY3ytz2dEreeuxzuzKLAj7OQgSPi/u9KiwXxn3yQStR9UfBQqR1sVExq5pBmXWk
         /4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321012; x=1777925812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey+vtW5zGSIcS5Imm4MD7T8reur80NswJgiOxTbyp3o=;
        b=VS8uIwyt0M8itw/Wvhgz8cv/Ou+liJBhzB0phHatdrqkCEIvwAbI4VDBk3lq/HGhXa
         xfutNe8oOfYDSExQ7882m1Uq7n7ACzTXzbmy9E8J9DHU8+ocPNq6zwd/A0fX7yCcOEHm
         Al8pzCKf8a0hUAvlp0xToKOxAGwr8K0pd/P6I8MtyWJhMeJDMPOOvWvl4DJEPj2D+FBS
         hoFmNhL7trEPl5Qn6UtRybtd0GNhG84W3pRikIYy09E1AoUww113NvPDp7EqmLu6bHBn
         f7sGWtopAWQqzTuyRFpUNJgXLhmI3Atw+CIzWpAdh0nXO3iQmjr0CZn8LWzUZh98K05I
         HUFQ==
X-Gm-Message-State: AOJu0YxWUS6zzXPZvmXx59wij1kFSLs1nGgPfde7Qt062KOaGRqx5lXc
	6yRKi+ks1XV6N4gWFwQ2Ga5fUK8/mjNl2dm16E8G9eZ+CvpL9frFK6J0Gkz4Dzvm
X-Gm-Gg: AeBDietoymY1pz+S25wgCwvIapDnsYZEDC8QHZwbGg2AD7FRggSC6XZp2jXIECQvyaY
	Es5J0UMZm3bFmNBX9qTJ32nOTUyUSq5IkD8oWz7+flBCeKD19UbEGGTAIi1Hzkse44sAbKSG9HH
	paNv0nwfF6ej0BaA0sSRxiFr4wa7U6SJj1EAvAP7fwTDfVJiqDPnTp2IA29TwWYWwBRTlJzhf5J
	L+PCl4iovTqdpsvR23vNvmzml1lzfFLp/hNTceBX4gOovrLti+mOyKK97sqy5VQtMa7B59yOezE
	DiYTM44lKVqrpe/OPwQJheTLItOKnjsdMY09ayTQLXixn84hePuYK9s+vcyzIzMeFpdQNdlBnOJ
	QQ8nXyUIbQsX15HpZp0oYQ97+d1/O3SOdTbzQh4bTUI3j4H2yHrtvVbzEO4oZCnTsKAAPU9Pysn
	pUU+RjptCUAMVM2Sk3Ct1oXZuEuyTvJAj0A17rHtBa2Jp20HvotVoSpNmE9RkKyKBLiCEbK9OKo
	sGVFI8iGRBgI84dX81/Dhea9v6mwheZ0+sIWA==
X-Received: by 2002:a05:690c:c1d9:b0:7a2:f14d:5a1 with SMTP id 00721157ae682-7bcf58cb7e4mr153787b3.49.1777321007663;
        Mon, 27 Apr 2026 13:16:47 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e6149sm1753387b3.11.2026.04.27.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:16:46 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 0/3] selftests: drv-net: convert so_txtime to drv-net
Date: Mon, 27 Apr 2026 16:14:32 -0400
Message-ID: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 078B1479EF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281480-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[so_txtime.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Two preparatory patches
1. support negative tests, where tests are expected to fail
2. add a tc helper 

See individual patches for details.

Willem de Bruijn (3):
  selftests: net: py: support cmd verifying expected failure
  selftests: net: py: add tc utility
  selftests: drv-net: convert so_txtime to drv-net

 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   2 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/{ => drivers}/net/so_txtime.c   |  25 +++-
 .../selftests/drivers/net/so_txtime.py        |  95 +++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/utils.py   |  18 ++-
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 11 files changed, 141 insertions(+), 124 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (96%)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

-- 
2.54.0.545.g6539524ca2-goog


