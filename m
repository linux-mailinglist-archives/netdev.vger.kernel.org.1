Return-Path: <netdev+bounces-260135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD+KJCGQnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:36:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA117AE71
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9E83304137A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A6331A4E;
	Mon, 23 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JD/231jT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC8331235;
	Mon, 23 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867961; cv=none; b=eREUihoukV5Bgnrjfy7QWfIhpJyUzawIA4PPDWJk0AnFnwwocliCpc9rbWSRwureaT+EJI4b3vxDe5CWdzWN25F/jPh4hwST3sO1SPtSHnOLUYpSEcSsntsf7+b1h3ANGtrjOZk2sPFdZbfSOJ3WZlf59Lj58x34Tmj+wNv/BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867961; c=relaxed/simple;
	bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LieIInypWyxoFNZb9HXPwDCjOgkGfbPrbtGFAbcbNkhbzwwhCmIXzzOzrd5XfU/sKmESdS7MqRqvMUZxDGLgcTL6w5PT2PxvdC3nbKk0FWzygsvM6GOYaxjPcBaO1AJteT3DwWBb+YMKazpS9kOzgMDRTlcmmKylRze2i7Nkrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JD/231jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22305C116C6;
	Mon, 23 Feb 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771867961;
	bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=;
	h=From:To:Cc:Subject:Date:From;
	b=JD/231jTxPt1IAs9Gn2RCYJBzoW1dPU6UqEzFhOevj+RaidoCHPDvf4hHO+TOkfyz
	 nYBSsiONVK8TDmE7sXU99OHv1YK5v559sUX1ub/12quAgprNgb3SfaTdfBo/tOqKy8
	 KnX8tCyVbuHxd6sS2HbUVkT/0K0Llma09HOvzPyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] vsock: Use container_of() to get net namespace in sysctl handlers
Date: Mon, 23 Feb 2026 18:32:18 +0100
Message-ID: <2026022318-rearview-gallery-ae13@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlz+pWVk+tVK57L9P62LWGZx32tcvIt8bMTjnLsZj5Y2 naS6/HVjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIx2GGeWrb235vWTAjwzr6 ziKl5DDdmp6UuwwLjt/eo17XXPXEtszs7jvmYK45DqU+AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260135-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 86BA117AE71
X-Rspamd-Action: no action

current->nsproxy is should not be accessed directly as syzbot has found
that it could be NULL at times, causing crashes.  Fix up the af_vsock
sysctl handlers to use container_of() to deal with the current net
namespace instead of attempting to rely on current.

This is the same type of change done in commit 7f5611cbc487 ("rds:
sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")

Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Note, this is compile-tested only.  Some of my scripts found this when
looking for places that are missing fixes that were applied to other
parts of the kernel.  I think the af_vsock code uses namespaces, but as
I don't know the network stack at all I figured I would let you all
review it to tell me how wrong I got this change and all is fine with
the original code.

thanks,

greg k-h

 net/vmw_vsock/af_vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..f4062c6a1944 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
 	if (write)
 		return -EPERM;
 
-	net = current->nsproxy->net_ns;
+	net = container_of(table->data, struct net, vsock.mode);
 
 	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				       vsock_net_mode(net), NULL);
@@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	struct net *net;
 	int ret;
 
-	net = current->nsproxy->net_ns;
+	net = container_of(table->data, struct net, vsock.child_ns_mode);
 
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
-- 
2.53.0


