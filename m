Return-Path: <netdev+bounces-72799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248C859AF9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED96F2815EC
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E106D2107;
	Mon, 19 Feb 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z849lMyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E413FD4
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313353; cv=none; b=nByJV57SdghXPVV6Eya/1tyJ5kFB3HpuurnM65vxH53EKE1PWuHDPhsuWgcT147S37Kgd/+LWNmmKrccnM+KS0pNDMGPxpawrYxD3A4GjjCTzbmi67dv2j9gEVvIOdCQIDJ6SuK3ReIySCR5cUwAZXR3F10To1UYczmQTKD4p9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313353; c=relaxed/simple;
	bh=QwBHPpEG3WmLT7vJce5Wpssnhq6gk/vUBrlGIYiji9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWQQrWkJHd91XlWh2ovl5yr94gspGL665jzHDlOIIN2a0CkP4t3bDWBhMn8rHZV8TbRN1lW3Ix4ez9E1DcpzfreriXIVF7MS1f4uN0lRzsRXFC5R5TpjakVDdt4Clns6spLUZfl6RRppO4hbkZt1Dcle2C5DkH+9oLnXge5chn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z849lMyB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746ce7d13so23340295ad.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313351; x=1708918151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TM1KOjxB/yB/SVRBuwBX355/E+uTs9OH/uvHPRBpTT4=;
        b=Z849lMyBTdmN5ZnZ/ZlC7arAzmZhJibJXQNgN3lXmINwrYfJp27c8tzlXa13wqkuew
         OOt/Vg46TDBaidPKbP6VAC3a7wQzQQjACr5AuMnB05oM/TqBrt4hV26te+RzX0HNfEMo
         apRAhXZezUqxv1JnkJmd2hjMJ3oePVnx3EyCNKGuQB6Z0PQstY8VAEgF0JHJOgUxKhAB
         Lj+ZESnwEFPWfVF4clcUoTve5a0Ao0hJiXoUifM4h0uYSbGC89duv2nNtWA+5AT7HC51
         syngaDvI7GevE3D3M7k9260XVmr3+Heq9mrz26DL2UsH0yXISduzekV01C6PPkcGkHQ/
         Gyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313351; x=1708918151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TM1KOjxB/yB/SVRBuwBX355/E+uTs9OH/uvHPRBpTT4=;
        b=nU9izAOkbNMzJfO8TpMs1S9PUnUzo5vy2BwVZZ30xl96aON1iQ4W1zOYt9xC+04t8B
         7+oI3QThZVDmrFFAEDduOwgIKEn/YDcRntcaSdfSjhbYhHXLT67W0wX0bagNb3kQnu1R
         D8YFCEUT1jWl4r4iTL9rVmlD9rnCNM+RVw0MnGGKb8PZc+VMgS6jztro/SMc875XA7q7
         ypKFNdOVDuB+2vWhA0JzbKI47zjJ0jSjtG6C3OeXAy9ZSzcbJjdyo784dE2ibUNQ45gt
         YlDObA7kHgR6NXZxGnuKAksGnem5R21nEMYUKL9bgVJwPH3ygMlWvEkb+agIj5IjSw3F
         W8pw==
X-Gm-Message-State: AOJu0YzaX719rFN8DndYMcTe4Twv1MdPa9Kc+jkQPD7osiFyuknnIVGn
	QaKLUNTVijfyLuFoHyXLaewPR9a2yKsTE9oN/KYcRIP7te0O+9lzes1A9Aopsn0=
X-Google-Smtp-Source: AGHT+IEQRGMOOd4PL6BJ8iLL6jRkpgGyXO1TP372eeD7WgFYq/btVa+Jw/kpOs+qvYujkNcgh1XbGg==
X-Received: by 2002:a17:90a:bf05:b0:299:58df:5827 with SMTP id c5-20020a17090abf0500b0029958df5827mr2898695pjs.4.1708313351455;
        Sun, 18 Feb 2024 19:29:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:10 -0800 (PST)
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
Subject: [PATCH net-next v6 00/11] introduce drop reasons for tcp receive path
Date: Mon, 19 Feb 2024 11:28:27 +0800
Message-Id: <20240219032838.91723-1-kerneljasonxing@gmail.com>
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

v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. Take one case into consideration in tcp_v6_do_rcv(), behave like old
days, or else it will trigger errors (Paolo).
2. Extend NO_SOCKET reason to consider two more reasons for request
socket and child socket. About this, any suggestions are welcome :)

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
  tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv

 include/net/dropreason-core.h | 26 ++++++++++++++++++++++++--
 include/net/tcp.h             |  4 ++--
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_input.c          | 25 +++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 22 +++++++++++++---------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           | 27 +++++++++++++++------------
 8 files changed, 107 insertions(+), 44 deletions(-)

-- 
2.37.3


