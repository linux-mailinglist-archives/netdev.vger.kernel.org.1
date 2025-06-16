Return-Path: <netdev+bounces-198326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D128FADBDAD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85686175B58
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E92264C0;
	Mon, 16 Jun 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InKxTY85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA932163B2
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116881; cv=none; b=U/IBgtVZWqZq6Yzlvhf/UDJukRJejoBjP4LmPL0buss9S5d6KYM+5sA2fZKCTbVPlIsHe3VYaLt3/fIJuldmnUl6A0rt5ooxFPM1jyad5oHscLhhA0YfaBYWzWNp6Yy/+mmktCYrmuqIrT9NXeZZWDdRlu2eYy379TZ+wsxfBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116881; c=relaxed/simple;
	bh=PGKrvzXdBGv41uM6xQnaoQPoElTpPRhY02l1Rum5oTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fo7xFUWscbdnV60Of6+SZuPEAtjn/du/9CdMsFabroMsaM8RL4Anys2DVDJmZEFQfaDG7VXCRtzOMqMgOfb6t+v/tCk7j5RY/X/Gp2mr/ST4TteXx1ayZS96UtuDIKK1ozmyYgcRpABt21cpVFuQPWVly0cY6SjyCMp0STTL55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InKxTY85; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d366e5f2so65780065ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116878; x=1750721678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMC20MQPqA66JaNhPIxwLAaQFam8GRiJ4CG1MfEhrsQ=;
        b=InKxTY85QebgiqeerltSRrWSsAarPs+YYqyKFc5Cq7j1E95c/lf5R2y12gUDlFOg1n
         7DF+O21t7v+qx/VdPApQqM2q8JXR9D55qq3FKcOgTsewHAEdymnu2QCfgIhJmUx2YseE
         A2P07qN4tmWGdGkV5TRexcCdBtLW/uS4j8gZrOzS+79Kx3qoF0VkyDs1+Zo2rqiMmJUd
         mFtG14Cfvt3cyjv/HprsXRdKnxTLThQGAMSGJoUrCEnzk3RnFOjd9XoM8BDdRAsR+vd7
         dMZ3FCms3K+jjUo9Amb0nCY9P2tWJKUgJuU0vNKfVGheSPojaSI5k0QGeEy7mFf7EFzS
         P8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116878; x=1750721678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMC20MQPqA66JaNhPIxwLAaQFam8GRiJ4CG1MfEhrsQ=;
        b=d1AaYSoDqpHk1e/6uk2/FBs/tjTphT5weu5uiOPRxXXFwMWOC2aXw+gExzTx2Cw5vF
         O76Ep0TmcbIKoIdkkf832fPKSYHkldZiD2gcUZ7XTqp/SYrpp7FvAbaKMNdu7Pfm0cE2
         sCjMA0XL/lWXpWMQ8hJF9TfdlWwv+VEO4S3zXq3kWvXwwz8wEY8QK09q1BAhxlKQfd0M
         eygFxGNUX3O7VVQGSTOyQtVMp6BMQjM+NyyKg74pB7j0eq97f/II34mcQW/74r+SEkH7
         FHyqE/12FFnpRiUmOf0ZsVvsESldgMpoQppDomCdsvF2bjSySi35B7AzrhKrwwlJjkjZ
         IiBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyX9LghE0T72b4nhaUJxpAlBHNdDnASdBxCQVExxQQgej5anayXIaXGR9ZdfpK51qUighbmrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlguEb8GLCIDo2N+cKp/aRB7bzIqBxa8j3fNZA+zZshZiAOwb
	QvuMMHCj4Iw/GDqyxYnn9FmKSI8dsjRXj0Cuyziyl50cbytltgbuq0U=
X-Gm-Gg: ASbGncuP1MwxpSNVCTUBIOZHrzg1KMBMd0YbSlZgigRZ9paMnoLQBdDCThWpWP4vuLP
	jsBwmO6wWmbreFCaYqOIzvIh7+2ou8H5Ghu5bjUu8auH9hLFlF2pRvD6P4wU9D8DJq0Xj7rP/ik
	vRmvQZv78q02akbxBRC8vTr8WZzxLxnHrJIpcToaAXKLgCuMh/R/wK0qrdWR/QPHau6tk+lz+bU
	jhhxczdp16D/49dz9Zh2ERyf7Aknq/oYxOWquCHV8fG4JjaVdsTzBjY670CjrRALF2vN+/8YSPr
	2XXUHOQlGR6V03+mZ8hSFpwUuV+U9mqVlkTA92s=
X-Google-Smtp-Source: AGHT+IH6H1rk3QcwfgrXN8SlmejMWKyq+dylOuzEbCbCIHblBptxhPnKHr91x8BDL7WH+IqjxkNsnw==
X-Received: by 2002:a17:903:124a:b0:235:f3e6:467f with SMTP id d9443c01a7336-2366b3138e6mr174155565ad.2.1750116877774;
        Mon, 16 Jun 2025 16:34:37 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:37 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net-next 00/15] ipv6: Drop RTNL from mcast.c and anycast.c
Date: Mon, 16 Jun 2025 16:28:29 -0700
Message-ID: <20250616233417.1153427-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
multicast code.

Currently, IPv6 multicast code is protected by lock_sock() and
inet6_dev->mc_lock, and RTNL is not actually needed.

In addition, anycast code is also in the same situation and does not
need RTNL at all.

This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().


Kuniyuki Iwashima (15):
  ipv6: ndisc: Remove __in6_dev_get() in
    pndisc_{constructor,destructor}().
  ipv6: mcast: Replace locking comments with lockdep annotations.
  ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in
    __ipv6_dev_mc_inc().
  ipv6: mcast: Remove mca_get().
  ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
  ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and
    MCAST_JOIN_GROUP.
  ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and
    MCAST_LEAVE_GROUP.
  ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
  ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
  ipv6: Remove unnecessary ASSERT_RTNL and comment.
  ipv6: anycast: Don't use rtnl_dereference().
  ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and
    IPV6_ADDRFORM.
  ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
  ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
  ipv6: Remove setsockopt_needs_rtnl().

 include/linux/netdevice.h |   4 +-
 net/core/dev.c            |  30 ++--
 net/ipv6/addrconf.c       |  12 +-
 net/ipv6/anycast.c        |  92 ++++++-----
 net/ipv6/ipv6_sockglue.c  |  28 +---
 net/ipv6/mcast.c          | 321 +++++++++++++++++++-------------------
 net/ipv6/ndisc.c          |  10 +-
 7 files changed, 242 insertions(+), 255 deletions(-)

-- 
2.49.0


