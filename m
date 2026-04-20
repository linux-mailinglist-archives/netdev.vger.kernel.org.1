Return-Path: <netdev+bounces-279908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPtXBTN+5mklxQEAu9opvQ
	(envelope-from <netdev+bounces-279908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:27:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6FB4334B7
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 426453015D14
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512903C6A5F;
	Mon, 20 Apr 2026 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWK9L9cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162863C3456;
	Mon, 20 Apr 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713221; cv=none; b=NWBVyD86+Erzynj04QSsPd2kJI3KT5Fkz7ZW62NDQ15Q2bWiZpfasjWHfUTQ4J1YubxMGfUWSdGzXPtUc0IZdIKssQ5lNOf/41KSujuqHxJSQkJ/i0IwTzUBsnbNbTF4Ey2dBeABNRJCYv2YzlkdyXbuP/HSNuGfnhPXuxfvuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713221; c=relaxed/simple;
	bh=9OSHuZePSrTe460DCMA4DIILHzJARLfaMLLe9QELeUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4QVfyd+J5xOu0cJRf9DuRf8kU82xQ1Upc37CxzPPGsv7Pq0nKYhhX3sP/Tz/FIVwMhZwGocQcZuS6v9HBOUWnHXbPsf6+0SIWdw9UdFz+UY5vIwu3Sa8/vZmWLyPtcNLKq7sWum/lfi8CpCrebrpXbu32xZJ3IalfvSDSaK/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWK9L9cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EAAC2BCB4;
	Mon, 20 Apr 2026 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776713220;
	bh=9OSHuZePSrTe460DCMA4DIILHzJARLfaMLLe9QELeUk=;
	h=From:To:Cc:Subject:Date:From;
	b=CWK9L9cbbg0xJ8FShogiVwFuEs07qbpT27CU7iRqhiBPAEdaz+o40J1+aJq73MHKS
	 LxFgg6lqztBg96qOLANvhpPTi5+qpFmSX4MlUkOltsUi35wjYiM/VFxBDzADEGbByT
	 GZd10GNOerPkF1gfKBCfrzATvFVss4ICE3W0s8zM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH net] ipv4: clamp MCAST_MSFILTER getsockopt to optlen, not gf_numsrc
Date: Mon, 20 Apr 2026 21:26:55 +0200
Message-ID: <2026042054-dime-spectator-820e@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 68
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=9OSHuZePSrTe460DCMA4DIILHzJARLfaMLLe9QELeUk=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPav+dZt28e56KrofE2unGr7fO6nA9x5tWunXrz/eLN vufv63A2hHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT8W9lmO99tFUkN8bq8+qm 79J5dTfZFQLC+BjmivAsDp79RFnuTk6kDyPj7EnBM+9zAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279908-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D6FB4334B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_get_mcast_msfilter() and its compat sibling read gf_numsrc from
the user's buffer header and pass it to ip_mc_gsfget(), which writes:

    min(actual_sources, gf_numsrc) * sizeof(struct sockaddr_storage)

bytes back into the user's optval starting at the gf_slist_flex offset.
The only optlen check is len >= size0 (the header), so a user can pass
optlen = 144 (header only) with gf_numsrc = 4.  If the socket has at
least 4 sources joined, the kernel writes 4*128 = 512 bytes via
copy_to_sockptr_offset() past the end of the user buffer.

This is a kernel-driven userspace heap overflow: the user told the
kernel their buffer size via optlen, the kernel ignored it and used a
field inside the buffer instead.  On a real system the writes go into
adjacent userspace heap and copy_to_user does not fault on mapped heap
pages.

Clamp gf_numsrc to (len - size0) / sizeof(sockaddr_storage) before the
call so the kernel never writes past what the user provided.  The
setsockopt path already has the equivalent check
(GROUP_FILTER_SIZE(gf_numsrc) > optlen at line 790).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Reported-by: Anthropic
Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec93..c9bf5d223f21 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1456,6 +1456,11 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 		return -EFAULT;
 
 	num = gsf.gf_numsrc;
+
+	if (num > (len - size0) / sizeof(struct sockaddr_storage))
+		num = (len - size0) / sizeof(struct sockaddr_storage);
+	gsf.gf_numsrc = num;
+
 	err = ip_mc_gsfget(sk, &gsf, optval,
 			   offsetof(struct group_filter, gf_slist_flex));
 	if (err)
@@ -1486,8 +1491,12 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	gf.gf_interface = gf32.gf_interface;
 	gf.gf_fmode = gf32.gf_fmode;
 	num = gf.gf_numsrc = gf32.gf_numsrc;
-	gf.gf_group = gf32.gf_group;
 
+	if (num > (len - size0) / sizeof(struct sockaddr_storage))
+		num = (len - size0) / sizeof(struct sockaddr_storage);
+	gf.gf_numsrc = num;
+
+	gf.gf_group = gf32.gf_group;
 	err = ip_mc_gsfget(sk, &gf, optval,
 			   offsetof(struct compat_group_filter, gf_slist_flex));
 	if (err)
-- 
2.53.0


