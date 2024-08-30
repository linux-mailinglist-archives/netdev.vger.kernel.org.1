Return-Path: <netdev+bounces-123740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B49665D9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA821C23DA8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188418FDAE;
	Fri, 30 Aug 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/7mIESm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC671C687
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032278; cv=none; b=bUT00DmQ+okp0FOxm5OKAaBzEKrxUGCorK+xt4L8Z0J/QoW1pxug2RRCmw8SKUqwRoFIrksTr8OYs0ih5WHvQSH5hS/uLK9F2guzK7D+LVvQjlmLk2cpqagLTG1n3I0J38H7DEf3c/yVJnoke8ua61AkpYBaYT6rD+eEcWpbKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032278; c=relaxed/simple;
	bh=+jmeeyRkVT33t0SMjEYm1TPRPBG5QeS4hGSNJ40a5KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrnLYtbzlDZJoupLKPvfm7ikbEZQ+YMZcujfcktyW9hIYba/auk0QczHnMgQFyTUuaa+CFaPB4qVeksbIGyY9MLJu7yz0ON3CiQ+ri8aRv4gJCdKWPU2DP2ABp1uS61NLCkm0+ZpINUlbrokHaAglitL8zDpFJ/PbPVWY5iAHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/7mIESm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71423273c62so1635079b3a.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032276; x=1725637076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFS5hGpAty3SAa/AVlyXUuDHkmicGxmUKDiWrgMd9qM=;
        b=g/7mIESmB6/obOto2m7mvY2MrlKzuOPTeSSozD8UJ8H/C+XGtfq9KEMuroikHvTzRY
         HqhFWkG40l9flyoZOIi7vsq+RaJisT2kdcY87OfaWJ/im98XZvW6tFdFl2IxMHNTcTAH
         VSob4mdQfGjc2Qu1FwVgLykac056wDqqk1SS9lxasuc57kYxA+HK7vlQlJO2p+bRoKWn
         sn2xElzcxrq+RLpGHKRCc61lEIEmA1cvVuJwBD5Uig8JqIVs8ogBGmTabfR1gdIStoCl
         oPzoeAb0AF9NhbEoD9O1bbh8b9xWlhP6rS5AmKuACxGxEHFc/zh6ceeCw5uhUCaqLB2M
         21dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032276; x=1725637076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFS5hGpAty3SAa/AVlyXUuDHkmicGxmUKDiWrgMd9qM=;
        b=oZc1HeN3mJESi1PZiSHbInwzX5HAnsZx/LPBv/jnlVN1edkaECDPD4e0vJ6X9ggtma
         rV16vji0L1BXIF9wb7PdhYOzleSOQYgJgT1TDvlUe0MxAu5xAAg7/DivJvYbNoKe7jT0
         ufk+2j4HLhGFmdspEBme4iFTcR07B1n+C+rEzgxmKBai/Ic3qhU70mE/KlqIYjaMPI8a
         C/23x/wMQEiVt5H9DU3YqhmAsz36PrJxC0jczb39R62CP3ZTVKyv9ehHf8bQh3mYPtwg
         cjmKdfn8z2brAlNhDB2Oy7VYSqhO1yIaZ4faa/kuE9Zi2FZCJky+W/ce7B4Eix8XH9qX
         F2HA==
X-Gm-Message-State: AOJu0Yzatktg26PbRurInCtooZFhzLWXzcMdETSVuJW6af65FkNo+lTi
	QmfO1XCzi15ciIMQgjYYPA1hXVITRj39/V79N5swxMK8DIkHhXeC0ssOyw==
X-Google-Smtp-Source: AGHT+IG5wVTarmDPua3N0m3dX60p6VAibTbYK0UO7+us0h3avLmL6+E07ghKMCXCV7PqZ4xj/mHAxQ==
X-Received: by 2002:a05:6a20:bca4:b0:1cc:e4a9:9138 with SMTP id adf61e73a8af0-1cce4a99150mr4774485637.29.1725032276174;
        Fri, 30 Aug 2024 08:37:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd59esm28504795ad.81.2024.08.30.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:37:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/2] net-timestamp: introduce a flag to filter out rx software report
Date: Fri, 30 Aug 2024 23:37:49 +0800
Message-Id: <20240830153751.86895-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When one socket is set SOF_TIMESTAMPING_RX_SOFTWARE which means the
whole system turns on the netstamp_needed_key button, other sockets
that only have SOF_TIMESTAMPING_SOFTWARE will be affected and then
print the rx timestamp information even without setting
SOF_TIMESTAMPING_RX_SOFTWARE generation flag.

How to solve it without breaking users?
We introduce a new flag named SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER.
Using it together with SOF_TIMESTAMPING_SOFTWARE can stop reporting
the rx timestamp.

v3
Link: https://lore.kernel.org/all/20240828160145.68805-1-kerneljasonxing@gmail.com/
1. introduce a new flag to avoid application breakage, suggested by
Willem.
2. add it into the selftests.

v2
Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxing@gmail.com/
Discussed with Willem
1. update the documentation accordingly
2. add more comments in each patch
3. remove the previous test statements in __sock_recv_timestamp()


Jason Xing (2):
  net-timestamp: filter out report when setting
    SOF_TIMESTAMPING_SOFTWARE
  rxtimestamp.c: add the test for
    SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER

 Documentation/networking/timestamping.rst | 12 ++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/core/sock.c                           |  4 ++++
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  7 +++++--
 net/socket.c                              |  5 ++++-
 tools/testing/selftests/net/rxtimestamp.c |  5 +++++
 7 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.37.3


