Return-Path: <netdev+bounces-232155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CEC01E36
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611AC1A638CD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4632ED40;
	Thu, 23 Oct 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXR9j7CI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2330216A
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230915; cv=none; b=hekxsmGsd+Kw6eJeQTVwQBSthMndGhDz1slJ53rLcrdN8KYXY0A2kdX/NMzoiIA0Nfl9zrDjZ5nnw2EkYpXF7H9NEX3436K9PKZEMI0x7gwAtaDsbrnde5vvbvfCg4DDdxs2yKjqCE8wLABQTuQoLkcCOvvZRtyuVV/0Ues6vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230915; c=relaxed/simple;
	bh=1RLm51KmhDL4fPLUXOHnRQ9p9SNejUKMXy4N86leZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtg2EIDllu4VCvm/tkmRJwAV89t8+1Tg7M95uMwxecSxxp/mF65ywXxNX0IE2f/NKIv1scrQod+I3ML6QWRVQvsTstusfaCJcXwghZFYOFd49+FNlbnNb0FbEU1546+6gpIvAIdWqAs5YCPPZmarRe9ZoEV2UI1L+abizBNeffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXR9j7CI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78af743c232so927080b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230914; x=1761835714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtgf55Q8soB7lkjT4R/RfaWXPHzbko4ONHYYpSLOq3o=;
        b=dXR9j7CIqr3fzReU0Gg8RQwY/6p+mX3TzGwOz9/YPdc2azkpLpNBvhFNpokCXn8Sz5
         aaiUPd78mHphDJr+IqZvL1yTfKf/nxFBu/8rmgOGnleisthL4MQugkT5sjmbyPzqI0LV
         nAYjQxLIQNE64nsZbyJV0RswDt7DzwxoyTf3A/5S6dZM0CIBcFGgb/yPcgVlI6uSF8mR
         rm9spHCGw2tRSfQwnyNfv5uEY6HZckymjRtO90RvDz5Q2hrWa3aUXjtlGcW1/gJ6m6+x
         1Yp3VQ0LXmzLOsv1/E7V0gzIIGeZIYRugUbVwQCUsIo9sQv3Fr8S5pro140Ztv47UfTy
         GU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230914; x=1761835714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtgf55Q8soB7lkjT4R/RfaWXPHzbko4ONHYYpSLOq3o=;
        b=okYxcIspSEC5O9Agvx9WC5OMFGtaAK6Ox6KPr2bAPxlnYI1Zj32Q/4x+dlvUSlCYK8
         lsYge82tvbgZOpC/xI5AGKHvQIL0P4ECxsujQjMP9sOcaJTmApCxwEax2xhkGmsnm3OZ
         irJhB7VtwTWg6FKne/7Wa3kO5f9o/avlV8vLHjlfjD071kjZZnFdR/52PrW8Q5xSsLt0
         fAX3Dukn8godyU/ynTbfhacAP9DExS92qL3a9X4N0E6Xwrlq1NO9YJ3iafjJxkFjwXQE
         P77E1FdhnkYJ63mvzCM2jqgTMobkRGyc2GDaZLVev6u1zF6rT/3VRocuGfeVcI615vlx
         wKWg==
X-Forwarded-Encrypted: i=1; AJvYcCW+bZr8wUfltBxerBUkK0kowaWfuNSwuc3BjanlRQWiLEADwehjnr2Eibt7nrETacPgqsmldbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09mJckEG1z2oe5LR5oSY7u+Q/WUIBJAbvhH/2XsBfVFoNVuIR
	HvcmwQsyUeHhfidwlF9rufe8tOgRex3RaF27sGVrM3ykuAet2Sr8IUBeYqd80t34
X-Gm-Gg: ASbGnctevUKtNSEMhlMVrenzVRUEw/tXcljWJ990SguqO/o3Pinjx7EdNxcaiMiTSX4
	NyFBXtuh4c10XE/FzT5FuLgXMkUeKZWr6pgVHSP/XoCOLvwzHtlIHepxbBAvHI2z1ZD0RmRx0hv
	5fc4C89uKUY44FYgy07jAKjJR8QlkYj+sk1rG337XIscC3sMtZbmNl7as/lnW0wij9szG3Isq7i
	LXBqlwnyvAKygzGEa+J+J060M5yFRa4JnsUvey5kYH7kx7xziHFo8ybsxO2993IAntyF5i2oa6X
	ud3yzjvKwo/Mnj584QZ0Y2hyqmF65UQaDs5b+l2Lz0gnZAAYtfUFHHkJ5mLKkwIVMtzc+kwl30c
	QIsoDL0BKcUQEkwb/EphhQZLDMI7wNtCsxilMvsiy6mo/iWsC4S3Ggo/fniesxmSq5YlsAQICne
	zlPS2qxQukexf5RvGoVo79jzE=
X-Google-Smtp-Source: AGHT+IHzFewBHGqghBRejHizY3eX5Vsyf6r2hKKKFtbyXvSw4LFsDF2WHnt5wMD9J0AnknEoq5ezpw==
X-Received: by 2002:a05:6a21:3289:b0:334:9cbd:7293 with SMTP id adf61e73a8af0-334a8617389mr29937464637.42.1761230913580;
        Thu, 23 Oct 2025 07:48:33 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm6045716a91.14.2025.10.23.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:33 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [PATCH v2 0/2] net/tcp: fix permanent FIN-WAIT-1 state and add packetdrill test
Date: Thu, 23 Oct 2025 22:48:03 +0800
Message-ID: <20251023144805.1979484-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for your review and suggestions. As requested, I've added a packetdrill test to reproduce and verify the issue.

Changes in v2:
- Added packetdrill test in tools/testing/selftests/net/.
- The test reproduces the exact scenario described in the commit
  message.
- Test verifies that the connection eventually times out after the fix.

The test covers:
1. TCP connection establishment.
2. Peer advertising zero window after receiving data.
3. Local close() with FIN blocked in send buffer.
4. Continuous zero window ACKs from peer.
5. Connection timeout verification.

About your question regarding the case where FIN was already sent but peer retracted RWIN:
In that scenario, peer will drop the FIN packet due to "TCPZeroWindowDrop". The FIN will be retransmitted by RTO, not by the zero-window probe timer.

I tested this with multiple kernel versions and the test reliably reproduces the issue before the fix and passes after the fix.

Thank you for your guidance!

Best regards,
HaiYang Zhong

HaiYang Zhong (2):
  net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window
    packets
  net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix

 net/ipv4/tcp_input.c                          |  2 +
 .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt

-- 
2.43.7


