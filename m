Return-Path: <netdev+bounces-197849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9911ADA05B
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 02:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905DC171F5C
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C3367;
	Sun, 15 Jun 2025 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG5fiqar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E31FB3
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749946483; cv=none; b=o8X5WiEXKTCKroUv+x7LcwmKVD4st8wiNoIqz6hNa61g27tb3zNQYoxjCsxm5NdMKocSdZI6vQmFEYGlT15seXOe4Ri6jEfT2qw/Rbf4yXgEBTIh32amL2t1fEB1fCWakvAX2TiYVOs7Brlw+GYNaDJPIxgB85SUUtv8qwWVGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749946483; c=relaxed/simple;
	bh=+tCQ3P9TPoRlf/tTzfAtKlVXyOipTKj2QVEP9BL3cBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt9k4Q0qMGCgA8zNARhTeosj553o5l3BuTXc/zEi+jGMxklMrSDVId35WicFzSChNp/wCP66z1lHNz6BnKa8zrsA8iU31962f1ob4QFbyeA6otXjjzI/et9kZA89jOAfXuBN7Zn/xNXx5Q8bcYkBQeaSA1rUO+IxsWNDVxcJEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG5fiqar; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5528c98bdso75241385a.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749946480; x=1750551280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTu6AnQCVjbQ9CcUMHopei2i+aiRYuv0cBQ7uuUnmcI=;
        b=FG5fiqar94h6B7XOOkKwA2o8uB2ptva6KIVTAtAilX95kVHlkn0joE3/HL6KC+2F3H
         wgLeEOrRblGnF3+o+kLmUhz5C75Rmv9p4Hq83gcDeGYx7gupFtfpH493/9f5DjClPOax
         Y2d6vPN53qWRR/4DXIEyEoBBj8TkfQjsZAg0D361PfgNjZeE9lhPiN1QaRyBRkTcxhmr
         +lQhdZUI8WlM9UKm8hyDmgiImnfmgVWsQH5w7pyUZdFF64WI0BE2VbNtIvY5DLqANB4O
         aNBGltcW2sOBA+LFc+uELLfjMGJJgU/K1jDaID9X/hO9qVsf2zShFBDFnvgyLXvxvWg/
         SGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749946480; x=1750551280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTu6AnQCVjbQ9CcUMHopei2i+aiRYuv0cBQ7uuUnmcI=;
        b=n+NhyXP6TxQ7Z8VYCz9uxC64nE/vzXo5zw+5tzZyzkZ9U5z0IIYKi8LzHJY5tMs3h9
         M7BTetdKl4ryl8pLju39kC64o4AWkWnf6i0cfThjOMVSpVwwu6WhfWWMoMEWjZr0+IA+
         dIjWY9zvNm9F7AxxPP8pIyCcXVvSDskjQpjB4mrrkPVrGdHSWmgSxzrwKTP8v4rm/6Le
         V62v8Kwj601x1m2r5ICO+KO+ZBFR3UBJn91JrRsBT8UkqHyCbYB27gjFwBR3ciBwFEUK
         o9I/lUe2MZn6zh9KMSQipmDpmAQSwklpcU9ucjjvYtZ999U6gR8O34h835ifwhqtz0SN
         wOKQ==
X-Gm-Message-State: AOJu0YzZhlbPU4+Y86kyS0gEzUMNkuXtDpsF9qYp/rEIKTFI++TrDmpn
	cIExhAfJz6FPe53+dD4CDol/1DuOTg0RetmUdw1z9dIOsdI4K590S2T6
X-Gm-Gg: ASbGncszd+w+8zxUVfJy/fjkpZsHFY4UzkV2Kv8cWqrSUskusOGGbFi6MfurFphYvLN
	6ma/YIUpVYJrLO2dXZTxnSKU/CpV78SSmJZRALAhhUdXgA21VCVd2XhQpMY0tXY5+70hd41CDEe
	UFkSLmEkyWeqmjsVPCUEu4tOZoNGbhR0lgxM7yAnPPtrnqCVXLQVK9F20bRkWW/5L3x1SiTeVbZ
	bQE+z2WMh6K+n/yQJCMJB424qb37T365qj7XnhgDixlMzEjpIS6PZ2fcu22rxR2rl/koNLEyGzL
	dSwR0V3dlGS54cW6sXQazkC4xWSlLNpufKoAUExDQFtX0RqqV83o5f/KHwAqUcfJJy9QABETn9N
	nLj623u4Nwzaaug==
X-Google-Smtp-Source: AGHT+IHLfqZLnbTMGkjCbyDDg3CgnLvZXDq8qp9X0b1i1LqkH5knTG5PhIuIGi8b9hoTvjE+sesh0w==
X-Received: by 2002:a05:6214:319d:b0:6fa:b83f:2f2a with SMTP id 6a1803df08f44-6fb477a5f17mr27990526d6.9.1749946480235;
        Sat, 14 Jun 2025 17:14:40 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:5a93:3ace:2771:a40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c322c0sm36194686d6.76.2025.06.14.17.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:14:38 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net-next v2 0/3] tcp: remove obsolete RFC3517/RFC6675 code
Date: Sat, 14 Jun 2025 20:14:32 -0400
Message-ID: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

RACK-TLP loss detection has been enabled as the default loss detection
algorithm for Linux TCP since 2018, in:

 commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")

In case users ran into unexpected bugs or performance regressions,
that commit allowed Linux system administrators to revert to using
RFC3517/RFC6675 loss recovery by setting net.ipv4.tcp_recovery to 0.

In the seven years since 2018, our team has not heard reports of
anyone reverting Linux TCP to use RFC3517/RFC6675 loss recovery, and
we can't find any record in web searches of such a revert.

RACK-TLP was published as a standards-track RFC, RFC8985, in February
2021.

Several other major TCP implementations have default-enabled RACK-TLP
at this point as well.

RACK-TLP offers several significant performance advantages over
RFC3517/RFC6675 loss recovery, including much better performance in
the common cases of tail drops, lost retransmissions, and reordering.

It is now time to remove the obsolete and unused RFC3517/RFC6675 loss
recovery code. This will allow a substantial simplification of the
Linux TCP code base, and removes 12 bytes of state in every tcp_sock
for 64-bit machines (8 bytes on 32-bit machines).

To arrange the commits in reasonable sizes, this patch series is split
into 3 commits:

(1) Removes the core RFC3517/RFC6675 logic.

(2) Removes the RFC3517/RFC6675 hint state and the first layer of logic that
    updates that state.

(3) Removes the emptied-out tcp_clear_retrans_hints_partial() helper function
    and all of its call sites.

v2: fix compiler warnings from unused variables

Neal Cardwell (3):
  tcp: remove obsolete and unused RFC3517/RFC6675 loss recovery code
  tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
  tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()

 Documentation/networking/ip-sysctl.rst        |   8 +-
 .../networking/net_cachelines/tcp_sock.rst    |   2 -
 include/linux/tcp.h                           |   3 -
 include/net/tcp.h                             |   6 -
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_input.c                          | 158 ++----------------
 net/ipv4/tcp_output.c                         |   6 -
 7 files changed, 16 insertions(+), 170 deletions(-)

-- 
2.50.0.rc1.591.g9c95f17f64-goog


