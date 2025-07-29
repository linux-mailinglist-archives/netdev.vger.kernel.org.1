Return-Path: <netdev+bounces-210778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB098B14C68
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EE218A2A71
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937C289E13;
	Tue, 29 Jul 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZPtvRzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017452882CF
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785682; cv=none; b=NS4gakWmb8QPrIXSGAQcR9h4FBHSYOBfOHzb1AzNJC9VujFyVA3x/OE83+g4zO8aj2Qo0BxCltz8aWdRJ3WbDE8Jt+33muY5vfqkWlhFWHtvAoD1M7lsc5osz72kh1awuYhoui7Y4szuOHaWM284ZKd4IeRycsnd+IC8UUoTkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785682; c=relaxed/simple;
	bh=YiZZQCk/z65Bdi3KZgSMsnuNTlVDery4O3lMeV2rPuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDYDoXE20Wf6FXtfjcZ7OVVIki5vYI/hHQ5Zd0DojumfWIFr4i0kBe3affIEuLzYkPx7wbgJ3eFfM1GDSqPepm2J/JTRsglQKRiZrMkr5BW9t1DeCL4tAFwg5Yaw/58m93gL39YLpW0sq+ZGTv/A6aSMUxrOExluDB3Jq9kCn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZPtvRzD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24063eac495so8038725ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753785678; x=1754390478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IlYoXpQj5aPVyeu41NnwtQu0uq7nz0e4fhReMDIjPY=;
        b=MZPtvRzDLjolQGwr+AbIvRkEweT0nWdp+hTu8BIQsKJToaxk7T+c5w+rckk7PAhfnJ
         zdjcTu/NET7jkDCTgTEaAOytUwo5gMlNXKs2V7xfuReDKjGFxcGoQYTm6qDhTpJcHfSK
         uALmUXclJN2SUOAaRvozis0Ky6RfRVThTLPOgUTkcSTBQ8joVuwwOG0w4hxvFsVngDvy
         uQaKI34ZAIpiZ6SJ2v9JjOZptPvHmXiGjkBJB+EYN+8F0rrR53t+qqzklKn8OPZZBsNG
         oxIukcWAjs3xdntM9fbmYDlcnRjFmKD1sVvAfYiGJAAfZKeP/2Ft+3+1us5zEA4VaFcR
         TRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785678; x=1754390478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IlYoXpQj5aPVyeu41NnwtQu0uq7nz0e4fhReMDIjPY=;
        b=WwSxEDrbBVVMKjdk9YLlPikTem/66mAp6ziuj5n33N0N8DbKqQuLA2KQWBObTMhUZB
         +TLxec/w9Qxiig6yePM+C6ARpCX1aSFumnDkq6KcbZnSP29BKhndiFgMGNADOKePjmHy
         ST3pQX028CkqVF7roB/D5Qi/Gibyw5byKSh33JYJ9mlc87QWj/CaSZ7QyWvCCCxuoxqf
         PAHEoCAAU24AyI4tknLflpy4hX1GPb1CdVh66Ok891E2VsRHxnS0KM6agjIU2YBqI2Yk
         zpADwuV2hRsaKNldTo9vX8Js/ssJdpB66NXHj7GTn/ueJOR2+L2Ryz7ViFZMTnCifpsL
         fpLg==
X-Gm-Message-State: AOJu0Yx99hEZlbVZjO16vv0tYiH1EzHNnCW/Ua+hiUDc88dFJpgzI1y5
	kpnlcohlw3Nu0or1ob7/nfuEXGZE183Lt0/cOlrExQh9+CjqwQ89nYnPadJjVJkz
X-Gm-Gg: ASbGncsX+i/F0jNekj9IixgFSqGFS1lJWq2PU9I726WPTlZ+bqbWjo51K8Gd+Tj0wsR
	xgKyn5i5vg3iEshBLyyVOZls/W447yefYSdGw7828PD7+lTcFxDqOIbRoBKXxknulSLdRZhXZqK
	pE++HVJZz6m88TleB4S/M6f/mmGNO3ENYVXxdTPqOpXkVAfmSLb5rUfq0aazngDInxwNlGMcp/D
	M0WGcuQwu7MlApqPQ1IZ8KLlknGsSrIFrTfHga164IAHiNMx+7xEQyd3FZ/jb1DVHnjN8ZdDA0w
	rOy5M5V4hIi0yqaEgTN6XJcfuf+Tn52pTPiZqX3+4knz/dtw4Up955NGxCdQ4ZLx2/xhVt5MImC
	/8BLUTyLEyyEtd0gzZ4UanRD0MuhC9OraKFu5
X-Google-Smtp-Source: AGHT+IEga2i+hrZZq2Ondy88nXFrIZf9h28QCYXarRH2plhMLI44/vvZXmqWOnfIthsKI4BorAmZgA==
X-Received: by 2002:a17:903:2acb:b0:234:a139:120a with SMTP id d9443c01a7336-23fb315ab57mr254202665ad.32.1753785677870;
        Tue, 29 Jul 2025 03:41:17 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c9922d1sm36557855ad.13.2025.07.29.03.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:41:17 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v7 net-next 0/2] net: Prevent RPS table overwrite of active flows
Date: Tue, 29 Jul 2025 16:11:07 +0530
Message-ID: <20250729104109.1687418-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the original RPS patch [1] into two patches for
net-next. It also addresses a kernel test robot warning by defining
rps_flow_is_active() only when aRFS is enabled. I tested v3 with
four builds and reboots: two for [PATCH 1/2] with aRFS enabled &
disabled, and two for [PATCH 2/2]. There are no code changes in v4
and v5, only documentation. Patch v6 has one line change to keep
'hash' field under #ifdef, and was test built with aRFS=on and
aRFS=off. The same two builds were done for v7, along with 15m load
testing with aRFS=on to ensure the new changes are correct.

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/
[2] https://lore.kernel.org/netdev/20250717064554.3e4d9993@kernel.org/

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
v7: Improve readability of rps_flow_is_active() and remove some
    unnecessary comments.
v6: Keep 'hash' in 'rps_dev_flow' under aRFS config.
v5: Same v4 patch sent with a change in documentation style for "return".
v4: Same v3 patch sent as a new thread instead of a continuation.
v3: Wrapped rps_flow_is_active() in #ifdef CONFIG_RFS_ACCEL to fix
    unused function warning reported by kernel test robot.
v2: Split original patch into two: RPS table overwrite prevention and hash/
    flow_id caching.


Krishna Kumar (2):
  net: Prevent RPS table overwrite of active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  7 +++--
 net/core/dev.c       | 71 +++++++++++++++++++++++++++++++++++++-------
 net/core/net-sysfs.c |  4 ++-
 3 files changed, 68 insertions(+), 14 deletions(-)

-- 
2.39.5


