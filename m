Return-Path: <netdev+bounces-73529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD985CE61
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5FC28218D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4E282F7;
	Wed, 21 Feb 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W28vcdnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD73883A
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484271; cv=none; b=J+nKdHt+ky05OvGNufdEWAz5Y7iTlAM9GFwIcvTsL6yAasov22x7osMPVpZ2BbfUiPCLHGsqoQHyxccrkMNox8Y+8BYtBMlOsCW6jBvO19HmnxUVAPWo/qfHUYXObmthUiWsbzduHHxyKGdMTw1nKlCJLwCBxdR0DDGI5BE+RGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484271; c=relaxed/simple;
	bh=QxtS/4fcF8m4LhYO/p01C+eDjUInXRKSFY0B262eQQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RzqqjSGmP6NFgVys0NtbjTb6XWzBUc0iqelkb1xhQ6VRh5ICzQmzjmSNFDkfpiTuB2jxZ1O90jKeMlkkTQMoa6tJXkychBPhVlt6pLOoq+aK8XXHGd62XUy6y0ux9ogDTgyKzI4hA/Lt9oQLKmHXrL0YRQZetxaubDVkMZPv0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W28vcdnq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dc20645871so3902138a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484269; x=1709089069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2dissOQg+zp1skhkBSBSFgAs0T1pZcyrfCXBho/RDc=;
        b=W28vcdnqryuxmSOZXp9udRLdnduecboXEpeB5m4F4HCZs0oycZkVw64zZp3yipkg1V
         iSu2Q9tbkiJoe/UNoSDwcbOU5eNHP/HfeDKgMz+XDWmq5GkjpPx+PkfN9M4npjigat1o
         7xSdXt82JrDlLWK3lT6m1gtOEqy7hbusaW07tDnVfdzphwBvfljAYdt6jaMjcGVioYca
         UgwNA9t2iN5/FZXN8TtDE+ZK+PZHm5fg6frPKDTR8Esjv1IbSwYa1dBNSukButtr7uRq
         giF+cToCB8oa+IixUMLq/jBsQa+X7YlbhM7MtgtCw9ySzwp0PHF189I9O/MYf1GyiIgU
         hQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484269; x=1709089069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2dissOQg+zp1skhkBSBSFgAs0T1pZcyrfCXBho/RDc=;
        b=bGG+udiiUTDTd6aWl6k1w3nJr0OxuCEIxOmCbeUWVou8FBAZH2REIjrBWG5fmysD0j
         f1XuqJYEmNALISeAyNCurvxyZXb7D4mjulmyjqMoeW7RWtD1VBH9mC1XpDehRp7Fhh5O
         GFiwNLvIwzUKOCStMZuplQYi6faslWkG4YtLrVRcvzoo3pxZCflFPEZTj6KXM5XxHLWg
         MHVvSvBL2ef6qW6ok4dwT5SyYBMXgfd5Notig/PGrr3+5tiuf1BXKzjBLNkMA74F3+Un
         vRlJcFgxriwY09Rs/+nWprLr458l8baSbAWCPHLe66d8rb8Bf8qPJEm6BaFmAHZ1EvEi
         NTiw==
X-Gm-Message-State: AOJu0Yx7mLL+RWOGSzwE4Jw9cM8aqCshxq5kTyd7PFG6tOKLbyUl160g
	yGwqKPC0S0701iyOtZxMVoMat8y7GwPRrt1Uj6U1mLQOJFWVpf7W
X-Google-Smtp-Source: AGHT+IGxwpOKz2v7avZdt963w0jrYe5LZ/8wy4lrJ1Ym+9Qo6MWITeyIG8LK32Bnv0McBsNvK/TmXg==
X-Received: by 2002:a17:90a:e54c:b0:299:4649:13cb with SMTP id ei12-20020a17090ae54c00b00299464913cbmr18274103pjb.9.1708484269279;
        Tue, 20 Feb 2024 18:57:49 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:57:48 -0800 (PST)
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
Subject: [PATCH net-next v7 00/11] introduce drop reasons for tcp receive path
Date: Wed, 21 Feb 2024 10:57:20 +0800
Message-Id: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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


