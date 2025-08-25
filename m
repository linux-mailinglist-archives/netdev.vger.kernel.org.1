Return-Path: <netdev+bounces-216355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92EB3346C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB404E1148
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30C22C355;
	Mon, 25 Aug 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOrnO3ta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485191F5846
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091420; cv=none; b=rfcbazJwD80B7IOOeF8wy8FSdHaNP0aarxdF4YMBHfwsV/PLb1TAvZZY+v30Dn0p06bnSJYxA9zOaf+aHd39pS2/NhEDfxzaZymv3ge6I7wo+Q+e9quQeS+4udyyg7TaMjrcxCWEldWsrP617mU2KftrtGuAxLd/JV+cpVUJ/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091420; c=relaxed/simple;
	bh=xDUY4/jFU5RkkZ99mOBJHPxTSn6N0wcydBX5JNF361c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5yx950enSfXSBwhjkggG44qvTGYeyE4bpKksP480J+Xmyi24c5JtC6XtlE/qvojWTVz4Uuo5ZOF46I0F88E2/ghQXlPhbhCMHvtZTqzHA4PNeLpw6J28nAlwqhM2mI0Syr8xktfV+dziHkJejIbfT0jnehgqVmNx2HX8YIr/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOrnO3ta; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so2746734a91.3
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756091414; x=1756696214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdwN0bDKAYL/bm42yxrxoNYJFI++H6rWDbDZ7avWO40=;
        b=IOrnO3ta2WV1MfZlk9j+g7s9DF9KPNAk386nN7ppyQpGFxbOKcuINJ1sDD6eeYwJFp
         tYvbs/I6+QKhYnSHcegxFTgPh2Bzr474EVfaKUPCtIOH2Z2r1rwVj2ymDwYveupoiKFY
         9cL3uCllaM+BUl/ozMiApdY3adHuU0Rf9WQUq0iGg2+wDRzdwxQAP7OiSbG9QnBSjS4v
         8HVFuFTBJa4df/WS3kPUHKrHNLThaOqe5QkJP9nDyOT8zmROxJ4YVEAljjftI6az5lpR
         ppOU2W+zxGrwfan65nwDJDs6eYcjOwW48eZ0KljsiZxtW6JTnEkF+pML2OSxbb0rO7yX
         7dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091414; x=1756696214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdwN0bDKAYL/bm42yxrxoNYJFI++H6rWDbDZ7avWO40=;
        b=JiMypAe3CmuFbWMnBgBByW8SMfSTbRzq93RFHw6F1+JIjjoYfUK+ebasP495l3Tee6
         Yqry7gW+ixp5ln1mH1JE9QoJpwlfKmLoN6TaV5ipe4hJz6oAmBCPH9poNMsfHKiqEaRA
         r4SdNIld/4/4Y4QmnSk2BEHh14M90B6A2uDolZ9s44Dv/EgJummPWh2AqwbH2bOuxMtc
         G/U82ywXt9rCZCGqsydiFbYfWKFzHLyPd34K4QAy9N0jnSUanohcVL77/NRvAVqHIDEP
         g1oK+WrVEQQezKW1HcV18//8GLl5DbP/1QcEl126+YEa9HWlfuiEkiyclj4uHw+J678b
         e1PA==
X-Gm-Message-State: AOJu0YwPGCOkcRLJ6e6YWEVmZ1f29/GUXncdtrjDZMAhqBu6+g0kZA0s
	CFIfdK6KxIaSO/TY0Yb1ShTzm47JtQP9t3G66MgVKzIB8+KEvPyBgCWzkj0G9ihh
X-Gm-Gg: ASbGncuF4FeXX1QOilR9yh+ixOL1GpO0qmxp2BzaMMg0anEL7PrR31ku4b9I7WvnKEc
	6kjPNfE5otOx5AO8/94tf+nEH6mov0IVtmx+TylfZgMNBbIAL8vGWG5MvI8a3MM/0kxjxF8kOpB
	9qSqiR2wG+tcxJwo5qwuaqVV5fn8SGjDtNdrgTyll0eVM3VFtZ1PZ10ceVgi975w1bn4nX+tWym
	A39+WsJ82vBy9V/yDzXuo9HhV17UDGg7+GOByRsuk2g08lX0xbBX2zsB2bS/9X9m7HRWpWM6Pr8
	g+wXbXAWjRzXzOpaT+OZKADnrVshUzCca3sS0RV/8Dk2QQ6/loQ+/YmV3HLMyQoO4fh6F2UrKpc
	EuGjAvC1OTdzXQeoKA51+U3MXRZd2or+4dRKAq4ZOqg==
X-Google-Smtp-Source: AGHT+IFIv8efG9mu/rCf9VCVwRltb3hMiHs9iOs0eMeQiaYha2eH6Cg992w3VGOY0VDewbyAtEkLbQ==
X-Received: by 2002:a17:90b:1d06:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-32515eadd32mr12762107a91.5.1756091414137;
        Sun, 24 Aug 2025 20:10:14 -0700 (PDT)
Received: from krishna-laptop.localdomain ([2401:4900:62f4:d6c0:d353:4049:5750:d5ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ebabeeffsm29162b3a.30.2025.08.24.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:10:13 -0700 (PDT)
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
Subject: [RESEND PATCH v7 net-next 0/2] net: Prevent RPS table overwrite of active flows
Date: Mon, 25 Aug 2025 08:40:03 +0530
Message-ID: <20250825031005.3674864-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As requested, I am resending the same [3] patch after the 6.17
merge window. It applies cleanly to the current net-next tree
and has been tested under heavy traffic for 15 minutes.

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

[1] lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/
[2] lore.kernel.org/netdev/20250729104109.1687418-1-krikku@gmail.com/


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


