Return-Path: <netdev+bounces-74802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670018668B1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D44EB21246
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA01172C;
	Mon, 26 Feb 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrPxBUgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBB11CB8
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917771; cv=none; b=XCzCd6iNGImzOGJ0oQerFc5swh6Cwaktc4YjFICMHygNFSTxL/FeeW7UnF+RycQVlO636TazEuRK4kxIeKrphl8Qa0ba1NkZRVc5Irw3hNaEJXSpJ+oWGFaxgCAQ+3wV0uiCuHLJ2XmpDFqSG1it3pQJU65KUroB6aDsHbEjx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917771; c=relaxed/simple;
	bh=6cywxhUFKRLRIWlt2hcZRemr/wzlTA6As+s5+BJ90G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lv3OAIDQqoj3yb2SWE3kjopQ/L2+Xm6vM2WgGdIE6E9XR/oCEltn+u7fLOt4aKhNScU/ZfCF0njXSLDKg4QyggkXqc+2oCTHNT/ANAfB3DFJk158RHeonr2zSxdfRudJthwPXMblc5ny9LlpvTUP937u3A59SSY2fBUJtXrohaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrPxBUgm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0f803d9dfso1717385b3a.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917769; x=1709522569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9I6IgeYUazYv7DOv6kxplCjVzc99EFFzjanak6vraSg=;
        b=lrPxBUgmPHJzd6pUCx4YwGrscO1EEp2CyTS75mj8CcDXGkZVcTDXYnQb74e/uqCBUz
         C1bAfhzEoxVvt6uQdarGq+wsrwpoAzG6FNGvo+ZTJaNuIQ3yppch/UKqG6vg/2JxxBcO
         0IhoTw/dDwVMqCzMZ+rgy7GKJJ1MUXhRy3TwYlFp8MerMCjoZqU2bn9DWjS9ydlemdxD
         aEe4cbThNkI1FYvIcjM5NwMrEpVNcyd3Cr12iEe94VzH7YV8p4P0Hv5gMafDC+ZPViSS
         HyhAqVR1gShehWINPh+3AUeEw56NZprF7n/ny1dgPfgjOdQCXJCLp1B2pL+4mhAC7NGl
         K4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917769; x=1709522569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I6IgeYUazYv7DOv6kxplCjVzc99EFFzjanak6vraSg=;
        b=oKVCDWtaVqEub+BwYi4Jk/pDjFm6PJ3tBSwNfx8TWyGZNP8b27x1HNl6NVqpDycPE3
         WzJnJRu96iP9nQbzRF8QoovF2iHlKBlOxXcjDW5Xcqy6zKK9BkI/IL74hPiPYuZjTmQ7
         pnOz3yajQg1WcZSH40PIcYuI8fTJV91xBQ4OpRK38tuqSpwLoMiJPli7MsaaM+dDPLLJ
         SIpOijqs+IIpx0VIeotefUKSrHiltg8NF2fqwGd4MmeqNRBM0QD4KsidcAo7VEZlnfSr
         SXRgd27MeebtWe/Ijs6hIG+TQvej5gKCHLJ7548S009mVc6RvE9jnn+uTQwMsNMHpP6O
         2O3g==
X-Gm-Message-State: AOJu0YxTf2mH7sMqrtJK5OjeEJD83UJjJjNSpr/KIjDF+7t6AUIfht+c
	NchqniBZyokW3+mua8oUN3X1WxO6bJpIwsYEk8WInD96YXVRe4N1fSnzOyxIg5E=
X-Google-Smtp-Source: AGHT+IFTzcplW7EGIQycHhHwBF7uAOo1Oq3cKuBWFhvVGKFng1KpjWsgtXGem6ExC57S23U2olcT9Q==
X-Received: by 2002:a05:6a20:d04b:b0:19e:bca3:213f with SMTP id hv11-20020a056a20d04b00b0019ebca3213fmr9356037pzb.52.1708917768662;
        Sun, 25 Feb 2024 19:22:48 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:22:48 -0800 (PST)
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
Subject: [PATCH net-next v10 00/10] introduce drop reasons for tcp receive path
Date: Mon, 26 Feb 2024 11:22:17 +0800
Message-Id: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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

v10
Link: https://lore.kernel.org/netdev/20240223193321.6549-1-kuniyu@amazon.com/
1. fix three nit problems (Kuniyuki)
2. add reviewed-by tag (Kuniyuki)

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
 include/net/tcp.h             |  6 +++---
 net/ipv4/syncookies.c         | 21 ++++++++++++++++-----
 net/ipv4/tcp_input.c          | 24 ++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 17 ++++++++++-------
 net/ipv4/tcp_minisocks.c      | 10 +++++-----
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           | 22 ++++++++++++----------
 8 files changed, 101 insertions(+), 43 deletions(-)

-- 
2.37.3


