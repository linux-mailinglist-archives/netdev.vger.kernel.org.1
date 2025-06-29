Return-Path: <netdev+bounces-202297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEFAED156
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B491894FAC
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711B23C4F5;
	Sun, 29 Jun 2025 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vIo9qEYP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64773224AFE
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233500; cv=none; b=lH42v+uxwLv6ywWeADZ82OB0YGUblJFku9VJC2/mKy3bnjd+DOwc/HYFhJInZvqmDZ5L6Hu/pVluR5ThFDiijLEln3hgtRe2lPlsc4Ss8Yo8JlLZ+r/sqXpwdjrG2QdSBwzYjM8RjhSD0uT+fEYbQtxddBeJef2yF9daUat5eJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233500; c=relaxed/simple;
	bh=SHlCEPtJ+mGpBteebs/QxPWTja798xKUaQPyeGXszDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsNyHKUNdnxwFB1xlZvqV7jPJvI+zBWnRKb2ekRTqdaXq2ZIBX61Z6r/zxvb0Gr612nKlK25d1a1oHA7SeNVNobZskld7LYer/6pcuc8AzSxI319Lsd4cJ9W4E2KihCWPXMAjB/uL3MByZpGu58fVhEiVkyRUu2Sg8IZgHRhUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vIo9qEYP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 737613F52A
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233497;
	bh=LxBoabtf7quwflXNyrjXQFRsM9Lks4N1hnfCJHIwSNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=vIo9qEYPM0tbG4EU9SyTbuujaQzuFJ16HoQcr6foQ92AeQaUn2H311KyBWutglwHI
	 PH6VU+Hub8NwhSmhlYbLDM7WRSk/DiJCnZUGfxKG+yXwLJgiNq0OcVktEiLAkNrA8f
	 dgG53NHnoMEhOoB389ctYFaxzGUZeGHz7bsp1Dsmvzb2uuVh6F2jtGHIvrMLS17TeD
	 FowIYicT6hyYeihtaPGzVd3KJhwE9PfA7W2wXhRKeTrH4RRH0X0iKH+nWOVdo72Lt6
	 PP+18BXmPUbZ1FoQrBf95RSemJZS7ltOUn4pC0kdqlsBaOIpQ4zgu9HTy3yoCQBDa1
	 /6SxzR6XD3Big==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-607434dbc78so1418652a12.1
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233497; x=1751838297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxBoabtf7quwflXNyrjXQFRsM9Lks4N1hnfCJHIwSNw=;
        b=xTeYh8S8BQs/OwMbeoevFCnnehae+mo7RW/ZsY++OJIamzrk028Yoe733gLA30HO+s
         5sx09+nujwklotmgE2zejLgleCPWRbnD+Wm3yQAA+kdrYfgZzkDMn3Qb/Re1xNfwDps5
         mX5fbOmde9F8xLiVR7xgbb3Bk4+p6+5hnNolCO5zjPsodu5obzuYjAkqkffUc3MnFG/B
         hC9F+OOA10uW0J7WmG+XQzRxOc9K3Af8Jeg//lrOGKVt6cZLICeBoLV1I5kzyEIhmih9
         xORHAqhgAqpodi8DFo1V10Y49TFtufPs+kYpP/mIR+su2bRxI3r63AFvOY5X04Pu8q4m
         h3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvKunr5nMtD4kvyz559Ce6LwyukvMecrWgULc6e7eNuy2B88myay0EL8MpBLU2euQDJnwHUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgdibo3ldFJDyX4SshYC1oABUyrEv9/FBttbZ77/b1Vu2VHTV
	+zeBw+KNAGM5Op6HtnpmOfWbLGTCmQZIfKHWcOTDWgSY2GUGMOUsqKRcPyI+qbAeWhoo8HSnqS9
	WuydqhqjpFWiuqEOMwZEprZZWXF/q9yjNS632BV9gcaEUL1suIGEwhNY8+1DGjjbI56SHOmcZtg
	==
X-Gm-Gg: ASbGncuRCVe18rDhGmowyFFKVNcesDBowm7cJxUtDEKqSlQ6/EMVdn1FCRusPPESMhp
	LRh46JK22Xv4LawXIFP9cBAtIbmyEkRmLKMHnwdqsvtZjnvaXRV4aWEwh+aQxhuy7Vyi8OpLpaA
	Nqp3N69TB+tv9preIL8lw8M1wek2oRVWutVbKkw0YKyV658tGqgo4raJYCEfm0RyaxdJ8KEWPCt
	FlpPEsD3uhY/cHnyBDXg9Rkm9H2IbE2IpWGa9YuIsbMHiqydf5GoPkCHWBHPy6d0lP7z2WxXU5k
	wihQmG1s4wbsmshX1KjeT6whRWPV2I1EH81EigEJV6JC4MUjuA==
X-Received: by 2002:a05:6402:518c:b0:602:a0:1f3a with SMTP id 4fb4d7f45d1cf-60c88d5100fmr9545281a12.13.1751233496783;
        Sun, 29 Jun 2025 14:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Ta19pv6AlU6JZPOMN54E0R1qHJzn/YSHm8EEl7rjRn41u1/8mTDp0f5nsGYygF2IYKDUaA==
X-Received: by 2002:a05:6402:518c:b0:602:a0:1f3a with SMTP id 4fb4d7f45d1cf-60c88d5100fmr9545262a12.13.1751233496419;
        Sun, 29 Jun 2025 14:44:56 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:44:55 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>
Subject: [RESEND PATCH net-next 0/6] allow reaped pidfds receive in SCM_PIDFD
Date: Sun, 29 Jun 2025 23:44:37 +0200
Message-ID: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a logical continuation of a story from [1], where Christian
extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.

Git tree:
https://github.com/mihalicyn/linux/commits/scm_pidfd_stale

Series based on https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.pidfs

It does not use pidfs_get_pid()/pidfs_put_pid() API as these were removed in a scope of [2].
I've checked that net-next branch currently (still) has these obsolete functions, but it
will eventually include changes from [2], so it's not a big problem.

Link: https://lore.kernel.org/all/20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org/ [1]
Link: https://lore.kernel.org/all/20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org/ [2]

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>

Alexander Mikhalitsyn (6):
  af_unix: rework unix_maybe_add_creds() to allow sleep
  af_unix: introduce unix_skb_to_scm helper
  af_unix: introduce and use __scm_replace_pid() helper
  af_unix: stash pidfs dentry when needed
  af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
  selftests: net: extend SCM_PIDFD test to cover stale pidfds

 include/net/scm.h                             |  46 +++-
 net/core/scm.c                                |  13 +-
 net/unix/af_unix.c                            |  76 ++++--
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 4 files changed, 285 insertions(+), 67 deletions(-)

-- 
2.43.0


