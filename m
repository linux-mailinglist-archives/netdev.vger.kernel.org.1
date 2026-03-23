Return-Path: <netdev+bounces-270460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMm9IUAUwWnkQQQAu9opvQ
	(envelope-from <netdev+bounces-270460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:21:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 349DB2EFEC1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCB6E301345E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545C38C2B0;
	Mon, 23 Mar 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgcNyhNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6F38BF91
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261204; cv=none; b=lS/tHBclBpS6p0zr50gLKtSlacSikfX6M1nbbeUKDrdFZ2/h8XiHgstuMYb61Pq28EjiWS/4wPQLonFUBIJQwzYwY12qVZScrfSeEB9yNKbFaki6xx97LNfrRmdH4nJP091YvsoVNguJmD2Y55kgtetEaeHiGH09czhC4egD/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261204; c=relaxed/simple;
	bh=rJcgrPWQRRkePOO40KXIXag2fQRkomt6sRhCEibc6tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvwkcXwAnnM9t2kqUtWGUdqKQuwnEMhkXyqSULAKKpavItYdPsS5kz4OqazeYaeNkV8AUeQy02SyhdC3b2JKUi2fjvSiUMbuS5bCM3wKl1x/rQIKpJ3wrv01PbAV9yzUzW2pel6j+Shx5INJ7UXpf/sTxE3cUTp0xeOpIgJd16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgcNyhNI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358ed696623so1232222a91.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261202; x=1774866002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPISEH5msRmrdt2HTDD7YCjNoxtWOm3MOnXL7/GvkTE=;
        b=KgcNyhNIfV05hBU+9CKnt+dPnvzPfF/k6rqaHim4eEXgB+CYnjenl4rnB8QOSlQenl
         mIKkEpbTaikdWEUOmnz16VAZY7MlvbjZ/aj0I6TZnHdqIC0UKqG0ac57uK3ZSKFP4nqQ
         vCMWkHrOYhU8dWIx36QEQzsHlMXbpkOnXfA3ATykbgHIeLYQk99p9xLJP5AX9nj9q/J5
         OHwYh13ULh3PlIE4n8okJFS04KbuKr3R1xYfCkHX6dLUyeEHEbvBAo425nfC/VNBmMY2
         sDKUTiu+At0/ano7pKEbXb9A9grBqo3SA+RFuE9LbFYybga2n3sNaBfNbtpPem3m9w4p
         yoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261202; x=1774866002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPISEH5msRmrdt2HTDD7YCjNoxtWOm3MOnXL7/GvkTE=;
        b=YzITsAmHufw3CuqlbXUiTNJyW2CPzig3FloOk16ZAkYeoYl18/XY0hksrJlLqJeSgT
         VuwjotNwFItG1Py1lvBDhMiFygTiwPKRkYER+5JD7VtbIOlTS+B/FEaTYeLdjW+pLePY
         55XMnkame0U+A/Lx+9XVEcQaKiB8OJ3DfdaXwAJyjILl3pFhZKrR6VyqUeLKllvhJerG
         YjD+fuFToAtmFfDrJZH4+crju0nbPpTiKw7EWBQrD383g8bGASfF4x44LYufHGWru+1d
         zAEaU4OhMVZyK3uaX8URhjatbpm5YYDTbLEMx9Bo+ZWr6iZnANCKdKqbRD/U1hYidyei
         zoqw==
X-Gm-Message-State: AOJu0YzrVkCenynuay9ZixelrdOBD5hQFVp0r0ob8IqxCei4RIAl/6Iq
	Kr7/RV7DO7GiEwtQDGWnj/HItMjJ8BWasibTFUdz8/PNUeZKB8dlNyRN
X-Gm-Gg: ATEYQzwx9iI/CVhngbD9IUD6iCHfpuJYSk9YEANc4podljIYBCvIh94jp+evVe08OfS
	9jUDqVLIsAt0RPFklovAJnGCDAGwyL8Wbh8anTfPPMk7sdDkBEKPnsk9KuNKnGyjr3wvpHEg/LN
	oMDG4nfYbQppSJknWGGOqwMqgOhK5YCwwSCBLfhj3vFfI5vcsW/wZvnByVrpE2k1Dy6TLs6tObv
	/oDxmYnicguvEquOD2Rkdoqu9+pp0LXXU+F38Df0BrRMU/ymrZ7J61sJ3HT75cfoT4e6yqUYL0V
	j5ntu0/FujhGCjyX2hCT8Fc5OEAeUnqQ4mj6x4g6KzbLxGQDhqbdzTzy3YpQoZJBcPRtwZanijQ
	/7Vf62Xq5vftA7FLDkmQpucpwh7w5kba65XP+O/39SQBl0AlBEBTF3k1cURBOO60RiqcozvpLDq
	DQv3z+tC/kyaV4s5Db5fqz8+0NQ7YmuEsJImi0ODVLeuWIK67wgubJRlAW2FRhj9314PiblcDiE
	mIsyIgs7ig=
X-Received: by 2002:a17:90b:3d48:b0:359:fecd:1cd3 with SMTP id 98e67ed59e1d1-35bd2d1cf08mr8744522a91.23.1774261202396;
        Mon, 23 Mar 2026 03:20:02 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4130765sm8937856a91.16.2026.03.23.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:20:01 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] vxlan: fix NULL dereference in vxlan_igmp_join() and vxlan_igmp_leave()
Date: Mon, 23 Mar 2026 17:55:47 +0800
Message-ID: <20260323095544.3311285-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270460-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 349DB2EFEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vxlan_sock_add() tolerates IPv6 socket creation failure with
-EAFNOSUPPORT and brings the VXLAN device up with only an IPv4
socket, leaving vn6_sock as NULL.

However, vxlan_igmp_join() and vxlan_igmp_leave() unconditionally
dereference vn6_sock when handling multicast group operations for
IPv6. When a VNI filter entry with an IPv6 multicast group is
added via RTM_NEWTUNNEL on a collect-metadata VXLAN device where
the IPv6 socket was not created, the NULL vn6_sock pointer is
dereferenced, causing a kernel crash.

This can be triggered by booting with ipv6.disable=1, creating a
collect-metadata VXLAN device with vnifilter, and adding a VNI
filter entry with an IPv6 multicast group.

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:vxlan_igmp_join (drivers/net/vxlan/vxlan_multicast.c:40)
 Call Trace:
  <TASK>
  vxlan_vni_update_group (drivers/net/vxlan/vxlan_vnifilter.c:573)
  vxlan_vnifilter_process (drivers/net/vxlan/vxlan_vnifilter.c:976)
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6986)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  rtnetlink_rcv (net/core/rtnetlink.c:7005)
  netlink_unicast (net/netlink/af_netlink.c:1344)
  netlink_sendmsg (net/netlink/af_netlink.c:1894)
  ____sys_sendmsg (net/socket.c:2592)
  ___sys_sendmsg (net/socket.c:2648)
  __sys_sendmsg (net/socket.c:2678)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

Fix this by adding NULL checks for vn6_sock in both
vxlan_igmp_join() and vxlan_igmp_leave() before dereferencing.
Return 0 rather than an error code because all callers treat
non-zero returns as fatal -- vxlan_vni_update_group() would
abort a VNI add that already inserted into the hash table,
and vxlan_multicast_join_vnigrp() would fail vxlan_open().
Since vxlan_sock_add() already accepts -EAFNOSUPPORT as a
non-error condition, the multicast helpers should do the same
by simply skipping the join/leave when the socket is absent.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 - Drop unnecessary sock4 NULL checksjjj
---
 drivers/net/vxlan/vxlan_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index a7f2d67dc61b8..a442c9e6d1a72 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -37,6 +37,8 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

+		if (!sock6)
+			return 0;
 		sk = sock6->sock->sk;
 		lock_sock(sk);
 		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
@@ -71,6 +73,8 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

+		if (!sock6)
+			return 0;
 		sk = sock6->sock->sk;
 		lock_sock(sk);
 		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
--
2.43.0

