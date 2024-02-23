Return-Path: <netdev+bounces-74339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19A860F41
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0EE1F22285
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3A5D49D;
	Fri, 23 Feb 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw9DRVpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE05CDC0
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684168; cv=none; b=rQtktddk3QWWH2RTAuIIPZvsL6m9l966A0uS7vJEfh/bIa24oHjNSKkjIk9JBR9zm9g+vCVDUNjnKcXm3PD4tNdUfO1wwuyh2f5MEQYjF8acoSBAHHGDqkWpiVNwbtwSqZIjeUTQgjCxQrxIxWtn8yTC2/UKKiyY3QMZtrQYShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684168; c=relaxed/simple;
	bh=CeRl+2LaGWblHX7TrJcXc3ZAsjfDyJQo4kd0PT1OlJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rs/3kLSC9eJidRg2ZIRtj4daHUJxHzKxNTmjt9SrA58peeiAJrY/JUHHcuYE0GtwzWdbdN4g89OS0qei1246NsaCc+tEJd35N2P/SioRmo1HLF1EeWfM2aC4kIrX7dK983ej4bmJoHUtPJQVw9R3jsR34IkZD5ke4/WszoifSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw9DRVpP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc13fb0133so4771015ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684165; x=1709288965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Up5BwsokweB6sptBLNG0Kpa9mvJNscaxha/V8m4evO0=;
        b=Uw9DRVpPd9KU+SPZFcy1lzcisyUwGW1g0UrkU9ftjrOAM4JDxZ0mlCaMzCHbSjijLf
         AZ/rP8zGLSoBA6jEcP+E0qG7R03JSyuydWV3LylCWKNpJdAR3uzW+7mbVR4l4FBvFUOb
         C0Gy1GhZ+n6BDpa654chRCz3mHCTeRVMAesnFNou3K/03A1x+3O/9YUx1MGj1dYUtlMg
         Y7YqTlUooyzVQf4W6SgOPm5ZsFd/wsDSeO9cwd3Q8HUCXce8Ol4qdrsFP8meEtwG9b4T
         RPjSvI+hwBbLCEzd0+i43LGVWlKbRxJ4taeqqvHnbRtdhkCvO1ePHsmOYIWznVaNu6JY
         RzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684165; x=1709288965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Up5BwsokweB6sptBLNG0Kpa9mvJNscaxha/V8m4evO0=;
        b=W9UYditfPW0TQ4iYNCtjDzN7YEdngA1oVq5/h7ZmHuIOp5Jn8yXO8C6dfcq7+7sXWJ
         2hc/hfuJCK2Ux6X5fpjlH26UpTu5lKuEd2yZnQx2sYi3PsBTh2ZhM9I8jCMTVL9UNGww
         e2K34cBOdtU3oc7Q0c3CCyly8s7gT/9vX+arZksGXzorJIF1R6UrYmypZJVoEYTfDGJ1
         TACY+8Ito+PjJqqt531gQ5l3TKGIrIZknROk8dphQQXxP4WhRJDknTWUbQc+D0rJhTjR
         49iH7ZC4TChSnkjxujd/YDn3DpaRZhcORyQwoV1zaIfbI0Y0obQScbTgnbrh8SwS3mIu
         l9Rg==
X-Gm-Message-State: AOJu0YxKNqgrrlHW8cQP9t52afwZt6QKjaFCz/11b/6XAKndJDlCRMXD
	h4WN6RzcJUdppTGstmg9HJdyeORewIml1toZm6RUsZYjZy1tI/dj
X-Google-Smtp-Source: AGHT+IFz+7Fo2CHVrWQhPEnYl/9acmKPJYjKGardp09hkbSFfUmuUCnE5sN6SuyMqXSn9urVuZacBQ==
X-Received: by 2002:a17:902:f691:b0:1db:be69:d037 with SMTP id l17-20020a170902f69100b001dbbe69d037mr1472404plg.46.1708684165538;
        Fri, 23 Feb 2024 02:29:25 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:25 -0800 (PST)
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
Subject: [PATCH net-next v9 00/10] introduce drop reasons for tcp receive path
Date: Fri, 23 Feb 2024 18:28:41 +0800
Message-Id: <20240223102851.83749-1-kerneljasonxing@gmail.com>
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

v9
Link: https://lore.kernel.org/netdev/20240222113003.67558-1-kerneljasonxing@gmail.com/
1. nit: remove one unneeded 'else' (David)
2. add reviewed-by tags (Eric, David)

v8
Link: https://lore.kernel.org/netdev/20240221025732.68157-1-kerneljasonxing@gmail.com/
1. refine part of codes in patch [03/10] and patch [10/10] (Eric)
2. squash patch [11/11] in the last version into patch [10/11] (Eric)
3. add reviewed-by tags (Eric)

v7
Link: https://lore.kernel.org/all/20240219032838.91723-1-kerneljasonxing@gmail.com/
1. fix some misspelled problem (Kuniyuki)
2. remove redundant codes in tcp_v6_do_rcv() (Kuniyuki)
3. add reviewed-by tag in patch [02/11] (Kuniyuki)

v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. Take one case into consideration in tcp_v6_do_rcv(), behave like old
days, or else it will trigger errors (Paolo).
2. Extend NO_SOCKET reason to consider two more reasons for request
socket and child socket.

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

Jason Xing (10):
  tcp: add a dropreason definitions and prepare for cookie check
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

 include/net/dropreason-core.h | 26 ++++++++++++++++++++++++--
 include/net/tcp.h             |  4 ++--
 net/ipv4/syncookies.c         | 21 ++++++++++++++++-----
 net/ipv4/tcp_input.c          | 24 ++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 17 ++++++++++-------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           | 22 ++++++++++++----------
 8 files changed, 100 insertions(+), 41 deletions(-)

-- 
2.37.3


