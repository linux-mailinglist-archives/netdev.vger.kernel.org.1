Return-Path: <netdev+bounces-73952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C601185F6D9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7F1F224D7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1B3770E;
	Thu, 22 Feb 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh0uXjYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7643FE4C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601412; cv=none; b=vEfEqNCrmTqC14LJZJrTYnKKAicDi4Gb/Jx1xbU3aBstIIvb2+TkzcvPGU5QPL2DYIGtNRs6ff4W0rU546A0l5vhhvBm5/SEnfR8mHnTyeGll3D7VvAYME8K37vW6DZslAog1fO3DQB0XlJ2S3WIBSHoC8m+sL65+Z8oBPnompQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601412; c=relaxed/simple;
	bh=v0rqxPxptnLQv5a/Jd0WX74CKbZ3Pi0Y50lCaDuymiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkMsmPRa0ivA1jU9DeIanDQiTvUyWhSA/MQ/URNwpAhuiWjBCKIhoT2aey4CRiTuHN+ompAqoe97rWjGAfJIRsrNbrwVPqu7yuaNS9azxm9La3BJZIhVxpviFZvYZXfYBmvJ59uOMlwzFHsN2nCAUZYfsmvX3Bt+ZsWW/J8Pf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh0uXjYg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbb47852cdso15341715ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601410; x=1709206210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YevT1qrGHzVuvuX4mpM5AnAm8C2dXeB7Wku9ydzEWCk=;
        b=Rh0uXjYgE2gD/0pul6CHsZ3qxJEvaTqSBkwccj5/4puqQnS3X6Je7ZE+2S+iIU/tcK
         jM3SkAfLHR9gnfdsLnTZP6EyDuRWECrGNDYQf06oZEIih4mvQRXjILfKdwUwA44N82n2
         hVW3xpf0kI5vHk/oo0DNpOgP0BoSNVt57XxPyckVbTsuFNA+FAJ8X23tb8H7YgacMUKl
         1qaLYBpHbpyFwm5rfJVHyND25HLZBItwIwPlwNtZLpop5VHFYGYJEvdhv0FBJN3/MxzC
         dibozcse62T/KxVPKyR5rioojRoWdGByLtL8PF7lskVnYRh3nsPZVGYA1ZsdMRWVkk26
         LCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601410; x=1709206210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YevT1qrGHzVuvuX4mpM5AnAm8C2dXeB7Wku9ydzEWCk=;
        b=c4EhLaVxV3mppFpHRDjIBn9W72wgpamG1J4+ftPpBL+kOmZOnzDm9nxmFdXMDD2rSH
         syjVmLrryEd35l34vf+CPOHr8AbZ9wKTBVX1f5+63q2i2QpfqNKfi1oW/eHFa7+W1gp+
         d0oeg+3Oe5Rdh/cB4cTpUmUIjHTmZCqnJCKxycCRFCjTQ8rs/05gX1flxcKmr/SznDVH
         8vtUMA/qx3N/5FzAnjQTotChVohjIb6TXfz5UOxBET4nunGwD7Fq0q8+8KaiTM50sxZ8
         FuruoCEFxi5fT5j/jDma1eQD52wzNsjVqv1TAy+7u1HojK84WxmuqeGEpC6FbGbpNvll
         CmbQ==
X-Gm-Message-State: AOJu0YwE2IpifRuk+dbzMaWQfcldLhWwA7PlHfrt5fYAog4U9cXGnKDm
	icaTd441rttzPZ+cPCMARHWHXBrfxUZjG7TgRuecZRb/+lpKXMtj
X-Google-Smtp-Source: AGHT+IFBZVrHYU5JX9tCwglegvmYSII0tFZsyL9blbQcZ/BA37QtDNjG2djhlz7+G9SmrPjoq9uQMA==
X-Received: by 2002:a17:902:6e08:b0:1dc:aea:10f2 with SMTP id u8-20020a1709026e0800b001dc0aea10f2mr9219064plk.10.1708601409819;
        Thu, 22 Feb 2024 03:30:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:09 -0800 (PST)
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
Subject: [PATCH net-next v8 00/10] introduce drop reasons for tcp receive path
Date: Thu, 22 Feb 2024 19:29:53 +0800
Message-Id: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
 net/ipv4/tcp_input.c          | 25 +++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 17 ++++++++++-------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           | 22 ++++++++++++----------
 8 files changed, 101 insertions(+), 41 deletions(-)

-- 
2.37.3


