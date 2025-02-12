Return-Path: <netdev+bounces-165549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A78A32783
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7936F16662A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B972557C;
	Wed, 12 Feb 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1kExGUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFF20C486
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368172; cv=none; b=XdMkgA30UO7iYPURMRYWpB8xR0udaUZtHWuXsAPzssamfb7oB3M0sf+EWdzQuKFK95Wgnch4ujFBuR2BtoEO9Zpy/hcGGYwax6ZUx0u853FEXkfMTxD5kjOVezKMYinvFD0ZmHFJmpX4fUC+eZRFDwt6ex6QHfgza2gUKMo0iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368172; c=relaxed/simple;
	bh=NMPgm5OMwf3n9weZp1TxbKed38bQXqHFwnQAbMLEKlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R2800lmJ5OsH22VhKMx3BmMSP9eXdPxvOni4TJj5BpUTTtplg8JDvBNTYK1mbcoDYBqSHCcBw9LeHlgOA5AE+fwnsYAFseFYSwCnwhVl5Lnn8w5k19PXcp5Kyg6AqhMiAr0jvOSlWcE5bm+TVWd8hghj6ymrd4IL3GyoTsIK+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1kExGUR; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471ab7a28ffso26704171cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739368170; x=1739972970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDTIthgMrpiZ25ZjoNGTU0lPgxoC8VXyyPrdTE2yfFg=;
        b=l1kExGURXenOn7QHbDxd0MGGEbJ29i2ciUjhgbIbmKoOCE+o2hO8hU9bwOpxHyrolp
         nfLGqZM+nPRsXe44/RdpbZ2T7aY6lrQz41lQvQB7zMCGo5Td09o3tBjBVc9LooXJ+pRK
         cWSKYGf1c+U5ZPZit3p1rewldLl9n9ErKlg58esSFPAht2GIc6PYNjkeMfe9aiV1i5IS
         ZAhshbV4jzfhkn2Z4zv5q/l3PiB44HLPh7y6swsMFyiaCwpy1GPFPoVg/ov9aUrY5+xG
         RuYePzImpIaY0RHaP5aMBNCgfMHRsz2L5/TF2U2h5HbcFfxaQ2gUWHliEjX3huYKiExN
         2lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368170; x=1739972970;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDTIthgMrpiZ25ZjoNGTU0lPgxoC8VXyyPrdTE2yfFg=;
        b=Cx5sY3k3reZfvNcU8vL+r4PgiDwha7xcM8hrBxKsF5XFlRdW/CPfOjC/IUMyE3p/XV
         PAlF0fZMKpxjcQnxYKWr1+iHDm3nqQLW+UNj+D1elirSIlrUxc8rm6cucg3GUguYk0wG
         qVo6pE3ALb+0XYIYEJeDjwUuYq5tJX8GOuBbm1GloLOZlVbndpr0KmW9pIB1G2iCsq5k
         cjDAyjAnSmWYSiu2XY1Vm+53cO2IMnPowevwNIOQqelgU60ZeB7LQcU9mICAyV93VJom
         5vmh0awReZW7ZggxM5O7Oxj7OFNxdTGAmN6hvzU4VntJQbNxHGIh0ORiS55Mhk2iwYrq
         TQoQ==
X-Gm-Message-State: AOJu0Yw3noPtB1btOomjGU1DpRUaVJypIZMqfZZ+LqalHFQTmP5IrXR5
	qWiKJkUwtrS9IuFAC6TXUPueG1QFJOpe7qohT8E/D+/Ivdf27oZZocMnYLBAn54FEB2CtCwfnFi
	0lJswyDy0sQ==
X-Google-Smtp-Source: AGHT+IEHQn5LQQKXJfPb9EfK8MfZuPhcKsKwbREjmXDCnQjZkea85CJ1cdNhJ/SGp0J6x4gDgmR/9Js6KpWUUg==
X-Received: from qtcw40.prod.google.com ([2002:a05:622a:1928:b0:471:83b0:b5aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:311:b0:471:94b2:340d with SMTP id d75a77b69052e-471b063f75dmr48926221cf.31.1739368169890;
 Wed, 12 Feb 2025 05:49:29 -0800 (PST)
Date: Wed, 12 Feb 2025 13:49:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212134928.1541609-1-edumazet@google.com>
Subject: [PATCH net] team: better TEAM_OPTION_TYPE_STRING validation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported following splat [1]

Make sure user-provided data contains one nul byte.

[1]
 BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
 BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
  string_nocheck lib/vsprintf.c:633 [inline]
  string+0x3ec/0x5f0 lib/vsprintf.c:714
  vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
  __request_module+0x252/0x9f0 kernel/module/kmod.c:149
  team_mode_get drivers/net/team/team_core.c:480 [inline]
  team_change_mode drivers/net/team/team_core.c:607 [inline]
  team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
  team_option_set drivers/net/team/team_core.c:375 [inline]
  team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2662
  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
  genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:718 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:733
  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
  __sys_sendmsg net/socket.c:2659 [inline]
  __do_sys_sendmsg net/socket.c:2664 [inline]
  __se_sys_sendmsg net/socket.c:2662 [inline]
  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/team/team_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index dc7cbd6a9798a7b09422c0bb1bf38b74dc113b1e..f4019815f473617708b4e0662b355c7738c64731 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2639,7 +2639,9 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 				ctx.data.u32_val = nla_get_u32(attr_data);
 				break;
 			case TEAM_OPTION_TYPE_STRING:
-				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN) {
+				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN ||
+				    !memchr(nla_data(attr_data), '\0',
+					    nla_len(attr_data))) {
 					err = -EINVAL;
 					goto team_put;
 				}
-- 
2.48.1.502.g6dc24dfdaf-goog


