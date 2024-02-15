Return-Path: <netdev+bounces-71897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82B8558A7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCFF1F22A18
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C98ED9;
	Thu, 15 Feb 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdbbGHfF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB510F4
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960043; cv=none; b=l+V9PI5nOayUAZkxa6j77WbxkyG8oS/UtVxshXvoE+tKmtNRAf/y7z3lQKlrFTCLRc7PL+PoU2qVAg1hO/wov/pydwU5DQ+bcaB1ys2VYHesjgwWoGeSI0VnEusIbGRiyKRvO5dyeFOLd6NV2IRt8lVMmZ2jMVxFdUpo5Qog7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960043; c=relaxed/simple;
	bh=tW+eM214vytfuMse3Vi8a4JbBlkEH0l71dTH0dxerfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yd+ePyUXuZq9gVSwL0oEzrcXyWC564sUthA06kOT7/JY/v7kf5dGO9mJ4U6I3c2jIwJ67iPaTMY+gEwfIDtzhZvHqYYrpvbQbxQ88+iei749wUe8qPE2ghq5ayUGDJcr7HwU6BV9M3dei2brD9uKrdWpEJpvA3fLb7ewA4qNU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdbbGHfF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0cc8d740cso325913b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960041; x=1708564841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsIYqTWohie9r0p3rl4461g/nQRorRQBhl2+g2oJ+2M=;
        b=kdbbGHfFB08UyKmS8JCkJrKc63iaJISmr6pCQyE5ZLLupe5lkT9OoSliec55bbyUx1
         ogjSRQzUq/o/5Sw2ZuiaWR+Mva1lZLnZCJ0pZdtW1K7/XttlZKVQTMDTFQCXdI44r8mI
         Qb7PqaoHU74tzBw/m7A1ewQFBrHuIgH6YSMBMYx9/10MVw+RWSnAmS7n37RznE0KQnaI
         rzddrvSeTr1/6zY2V3j8bEuiwIlMUxCoiGMZALJseWTOL0U3+Y1tHKef3cQz+r4+oqIe
         zg+kpn8M2h09jCW2HKMA3nWnqEsfYIY5HCoc47csVV5ZOtj8jbHn4B4+BZIpbXJUDp8J
         wLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960041; x=1708564841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsIYqTWohie9r0p3rl4461g/nQRorRQBhl2+g2oJ+2M=;
        b=mx5acjRJrdgCY3y7IDTRIGKMkZLCkkST3S74ZxjVY2eGwiGCgvIhOj3gwVd/mUhbKU
         xGfOy5joDE8S2lLdN8YLbkSaa0ogz542Uz+B231oHUxn0bJJ6xYgvn1KWap2q8dkv+gE
         vXeBi43c3WMtZ/5QEnsR508mjjzr20Q/tA8hcjRjM04vcQsUJwzdzDaTUR6iCB20D3JK
         9ESWamE0+073wmPO5sfO7sG8oliss1zm79n3z8Vrqu0t3T38nvscJB/nRdDDd6FMQVqY
         NCZW2965BkDYBxI6viQPGPdryvHbDcRnT2YhQJ94yeGM1KxDzZxXTxHhMfKR91navmP2
         rMog==
X-Gm-Message-State: AOJu0YxvhQRfQwMhipKDgVk6LsfgSS8X7UKq/7Xji6QnQn4pInZ6U3jU
	FWJPxQrgAN02NiI4A8kuxh0Mpac+uHsNdzPIqUM1e0UYkK/QCz0k
X-Google-Smtp-Source: AGHT+IGBuWMKbKwTSOW4SDcSrDRoBm0sXk5NH8Z8qHfQF/iToFBDxoyQYkeShGxnY+uqwM81/9k00g==
X-Received: by 2002:a05:6a21:3489:b0:19e:a9e6:bfd with SMTP id yo9-20020a056a21348900b0019ea9e60bfdmr584629pzb.0.1707960040908;
        Wed, 14 Feb 2024 17:20:40 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:20:39 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 00/11] introduce drop reasons for tcp receive path
Date: Thu, 15 Feb 2024 09:20:16 +0800
Message-Id: <20240215012027.11467-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was debugging the reason about why the skb should be dropped in
syn cookie mode, I found out that this NOT_SPECIFIED reason is too
general. Thus I decided to refine it.

v5:
Link: https://lore.kernel.org/netdev/20240213134205.8705-1-kerneljasonxing@gmail.com/
Link: https://lore.kernel.org/netdev/20240213140508.10878-1-kerneljasonxing@gmail.com/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new
   one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket
   allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
4. avoid duplication of these opt_skb tests/actions (Eric)
5. Use new name (TCP_ABORT_ON_DATA) for readability (David)
6. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)


---
HISTORY
This series is combined with 2 series sent before suggested by Jakub. So
I'm going to separately write changelogs for each of them.

PATCH 1/11 - 5/11
preivious Link: https://lore.kernel.org/netdev/20240213134205.8705-1-kerneljasonxing@gmail.com/
Summary
1. introduce all the dropreasons we need, [1/11] patch.
2. use new dropreasons in ipv4 cookie check, [2/11],[3/11] patch.
3. use new dropreasons ipv6 cookie check, [4/11],[5/11] patch.

v4:
Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
1. Fix misspelled name in Kdoc as suggested by Jakub.

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.


PATCH 6/11 - 11/11
previous Link: https://lore.kernel.org/netdev/20240213140508.10878-1-kerneljasonxing@gmail.com/
v4:
Link: https://lore.kernel.org/netdev/CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com/
Link: https://lore.kernel.org/netdev/20240213131205.4309-1-kerneljasonxing@gmail.com/
Already got rid of @acceptable in tcp_rcv_state_process(), so I need to
remove *TCP_CONNREQNOTACCEPTABLE related codes which I wrote in the v3
series.

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.

Jason Xing (11):
  tcp: add dropreasons definitions and prepare for cookie check
  tcp: directly drop skb in cookie check for ipv4
  tcp: use drop reasons in cookie check for ipv4
  tcp: directly drop skb in cookie check for ipv6
  tcp: use drop reasons in cookie check for ipv6
  tcp: introduce dropreasons in receive path
  tcp: add more specific possible drop reasons in
    tcp_rcv_synsent_state_process()
  tcp: add dropreasons in tcp_rcv_state_process()
  tcp: make the dropreason really work when calling
    tcp_rcv_state_process()
  tcp: make dropreason in tcp_child_process() work
  tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv

 include/net/dropreason-core.h | 21 ++++++++++++++++++++-
 include/net/tcp.h             |  4 ++--
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_input.c          | 25 +++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 22 +++++++++++++---------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           | 31 ++++++++++++++++---------------
 8 files changed, 104 insertions(+), 46 deletions(-)

-- 
2.37.3


