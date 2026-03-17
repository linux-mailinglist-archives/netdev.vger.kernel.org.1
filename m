Return-Path: <netdev+bounces-268372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADRnHrOouGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:04:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4102A271C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A27306814E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A058248F68;
	Tue, 17 Mar 2026 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Hpah+D83"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AC1EEA31
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709378; cv=none; b=HMUo8LHpu2p2HQfV8Nk9YoqUZtSO5pZu9CkYyApJJUxVb9Dtu76R57RLH29jgtmMVmjeLEJdc6+17h/SIP4yvNCrpCXm2DJhnnDvf+sqlR5gqzUI3UmLnc1odn9XnG3nsMmLqE8rBaQulf57xPxKdspBOol0TJhXKjNoEIR8pTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709378; c=relaxed/simple;
	bh=qDNEzauro0+SBrAy62SvRJY9fbSOQ5Uj3v81Q/YVXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jer/FSN0kvak/yj/AY6s5iUQx/f2i09w9vidq749OfMRWqOagL52IuUZkLpjPSVJ/6Bo076GurpPzU+0Qu6Z4D2Oh8RXEz3/xqiN1zmNYffw+XzRg/RM1ISccur791murfg5CFYs/lZvnjb23bPOVjhuBs/aSqFBF7M8YN03xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Hpah+D83; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4b77adso6333065c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773709376; x=1774314176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1t/fBFfC5j2uQ+R+/eWNtya/cuYmhJ8SyDP+c8BXEVI=;
        b=Hpah+D83A4tvz9t1ZM8xiH7L+5PE3maksAuDNIyPpLrLd9Zyoge10sMKVrbeAd7OkH
         gBqM0kCKs3RVTNDvGhH2PMhm7JB1d1nMu020ifIfxcWcxMDHINr3CAmQ+/9I4hej0tA8
         Mer0xcCVMaxffihuExnB05vKYeqh8LdGJU0y9hI6rkaFjP1n6LbQtDrDd1sE5LMp/+To
         16o38HRx8C9o1ZosoG0XXXzwf0/KujAR/VlpxVFReT6jfT3yjZ4vsMfV8Z6Wu6+YyyBH
         +ZyToZ/LsIaKgAC0qTIeFqqYn6zcLquZT+NwWW7HbhtiM+Dzkbe3G54V7tXG/9rA1kpJ
         lwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709376; x=1774314176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t/fBFfC5j2uQ+R+/eWNtya/cuYmhJ8SyDP+c8BXEVI=;
        b=YsUkpyOlImrzvIbDqRnQ696kn8alrS3atYp6ZUFknHtRzeK5HnACnjfZ7GzV6nk3ss
         bdBC41h8aktt0utlirIF075nJb5y5/OzDNDP4fVY9RWOCqua57dPjOWzXBak7byJ2j9g
         Rfm6isX4t9Im/GQmi6WTUuWpv8dVRpSsQQRPdVPE/sRU4r7IUMLKGZxuiRf3SWpQl+nH
         6BupMOMvzVzGdvBQHlOVXUYX5fPlBKXwtzjA+ow5qltkeL8otBFD2JutrDV7jWZ1fsVc
         scGyOIrR4SEmqzTopFN6eHayRlx27jmXRNl04S853xEyzBVOpqfR1vFqz+XRXS1u8NYk
         zQ4A==
X-Gm-Message-State: AOJu0Yw68ls+4H7ZMJnMWeubFjwGQFqa0i5nBuzPd3up03atGQCaewp8
	RDCoLPuj1j8Ai9GgBVum1kamEFWpna6CzIcwtLSYtAeiOxR4Q7+yDNwyfuDG5XhdXl428c4g4UV
	dYreAuQ==
X-Gm-Gg: ATEYQzxLhJsCksfDkJLStnOni6/nop5nf2PBbVdjEbM14aO0+vN2IKl8QdI5VxWwx8Y
	90Yx30HDtbL8R5ibKUJB+VdlzdmYDD/lNl/5UovZoTrnOs1eyOUaqb2gqvtrsetEpzp18GynWvs
	EYN7CTLET+WD9PDrhlnBezxzbjUOmZIoJ3QTFQvBD1xXM+IRReOSXjrXjHcZwl05UWO5LBqbKGf
	f0cQzAqBqPUWSKtpaoyXH+RfRLe+Fh5d+tsHvynmbE+88GBXIW3NEYzFQJbskq8tvQJnORfF2+a
	CDdCYxwkN17OsTpDhq5/OhoGDWiynbQ5EkSmo7qv5o4TLYViTGUXUiOoDo3242AxN7/9OqkT4lP
	qJ/F/X243naG5vOkG7WOLAnX23+T+NgGagU3V1MtZCtHNljHxdnRKGzNGPx+8Dh+Fw/h8Y0PF4n
	CcNt9Z/G2UtM+DeGAJYg3higIPGUOwcsp67iAvbfJFRHxgdxOcrzxo9Q==
X-Received: by 2002:a05:7022:688b:b0:128:ea68:27f1 with SMTP id a92af1059eb24-128f3dc5fd4mr6067455c88.23.1773709375725;
        Mon, 16 Mar 2026 18:02:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0b3fsm17813510eec.5.2026.03.16.18.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:02:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
Date: Mon, 16 Mar 2026 18:02:41 -0700
Message-ID: <20260317010241.1893893-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268372-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE4102A271C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
(success) without actually creating a socket. Callers such as
fou_create() then proceed to dereference the uninitialized socket
pointer, resulting in a NULL pointer dereference.

The captured NULL deref crash:
  BUG: kernel NULL pointer dereference, address: 0000000000000018
  RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/ipv4/fou_core.c:764)
  [...]
  Call Trace:
    <TASK>
    genl_family_rcv_msg_doit.constprop.0 (net/netlink/genetlink.c:1114)
    genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
    [...]
    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
    genl_rcv (net/netlink/genetlink.c:1219)
    netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
    netlink_sendmsg (net/netlink/af_netlink.c:1894)
    __sock_sendmsg (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1))
    __sys_sendto (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:2183 (discriminator 1))
    __x64_sys_sendto (net/socket.c:2213 (discriminator 1) net/socket.c:2209 (discriminator 1) net/socket.c:2209 (discriminator 1))
    do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
    entry_SYSCALL_64_after_hwframe (net/arch/x86/entry/entry_64.S:130)

This patch makes udp_sock_create6 return -EPFNOSUPPORT instead, so
callers correctly take their error paths. There is only one caller of
the vulnerable function and only privileged users can trigger it.

Fixes: fd384412e199b ("udp_tunnel: Seperate ipv6 functions into its own file.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/net/udp_tunnel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d9c6d04bb3b5..fc1fc43345b5 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -52,7 +52,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 static inline int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 				   struct socket **sockp)
 {
-	return 0;
+	return -EPFNOSUPPORT;
 }
 #endif
 
-- 
2.43.0


