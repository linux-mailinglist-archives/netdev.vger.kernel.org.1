Return-Path: <netdev+bounces-147700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7249DB463
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CF5B20A05
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9B1509BF;
	Thu, 28 Nov 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nHnwgYBE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GbCjlMad";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nHnwgYBE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GbCjlMad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89413FD86
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784395; cv=none; b=NwQWT3Tdv/nihtNKzDck+LmKyReQzQktqah+CAON9177WMpn9FWKYzLhyOoF/S9aZGsY7i7U9r6sQEqos8n3Mxz14aw282hc8kfedYiZRaGIZrGj7RxZY80bRaeB0bzYssE8vNtXp/loOYbWDtVCDNGvVSqWKFMbzDVC4GLmp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784395; c=relaxed/simple;
	bh=/RENQxsOS4R9PKFl6Xz22qa3PZpJRq5n0ypRcjT5YPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EIxqqsJY68B/mUGf0jRe+cdKlP+aPy6ZVO5iRYnmXjhXY5CsX/AHkIMfU/5ycWn5FPlJw2ENWAmXblHjgEQmssvrWJAN8/g2W+3BkhD2U9ZZnhbWSeLvw1azSBLA/aTWs6gtJHvvHNXZSxR8uZ0GdMoTNuahu+QdScYdOFAg2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nHnwgYBE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GbCjlMad; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nHnwgYBE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GbCjlMad; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCEAF1F45A;
	Thu, 28 Nov 2024 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732784391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kgOlLwSv1kOC2Z52qz70SjMx7DpYJmIR+zH41tAEFQI=;
	b=nHnwgYBEgbE1spDdXWoy0WtyEwZcBLX2LSYtAyh52+dcnE17QZWbhFbnLrFVNPC65sfvKQ
	rLR+lKD/xdGm/lPvgeQl8blDiRTtIzR7HK+fSCP2TYodEQ+Ezr5sLk2aDmGUCzWBMF/y4w
	E422PAehI7fZUduc69IeD5OsJSoqHCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732784391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kgOlLwSv1kOC2Z52qz70SjMx7DpYJmIR+zH41tAEFQI=;
	b=GbCjlMadDvFbBlOU3gg/BHunB82djxPDAc8KIhZiMuTP++ORmGZBzzAr1YjTIoX8LyemuL
	vUEpfUlQDXaEHhBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732784391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kgOlLwSv1kOC2Z52qz70SjMx7DpYJmIR+zH41tAEFQI=;
	b=nHnwgYBEgbE1spDdXWoy0WtyEwZcBLX2LSYtAyh52+dcnE17QZWbhFbnLrFVNPC65sfvKQ
	rLR+lKD/xdGm/lPvgeQl8blDiRTtIzR7HK+fSCP2TYodEQ+Ezr5sLk2aDmGUCzWBMF/y4w
	E422PAehI7fZUduc69IeD5OsJSoqHCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732784391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kgOlLwSv1kOC2Z52qz70SjMx7DpYJmIR+zH41tAEFQI=;
	b=GbCjlMadDvFbBlOU3gg/BHunB82djxPDAc8KIhZiMuTP++ORmGZBzzAr1YjTIoX8LyemuL
	vUEpfUlQDXaEHhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A838B13690;
	Thu, 28 Nov 2024 08:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jJ8eKQcxSGdyLAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 28 Nov 2024 08:59:51 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id BB039B74DB; Thu, 28 Nov 2024 09:59:50 +0100 (CET)
Date: Thu, 28 Nov 2024 09:59:50 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>, yousaf.kaukab@suse.com,
	andreas.taschner@suse.com
Subject: [PATCH v2 net] net/ipv6: release expired exception dst cached in
 socket
Message-ID: <20241128085950.GA4505@incl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

Dst objects get leaked in ip6_negative_advice() when this function is
executed for an expired IPv6 route located in the exception table. There
are several conditions that must be fulfilled for the leak to occur:
* an ICMPv6 packet indicating a change of the MTU for the path is received,
  resulting in an exception dst being created
* a TCP connection that uses the exception dst for routing packets must
  start timing out so that TCP begins retransmissions
* after the exception dst expires, the FIB6 garbage collector must not run
  before TCP executes ip6_negative_advice() for the expired exception dst

When TCP executes ip6_negative_advice() for an exception dst that has
expired and if no other socket holds a reference to the exception dst, the
refcount of the exception dst is 2, which corresponds to the increment
made by dst_init() and the increment made by the TCP socket for which the
connection is timing out. The refcount made by the socket is never
released. The refcount of the dst is decremented in sk_dst_reset() but
that decrement is counteracted by a dst_hold() intentionally placed just
before the sk_dst_reset() in ip6_negative_advice(). After
ip6_negative_advice() has finished, there is no other object tied to the
dst. The socket lost its reference stored in sk_dst_cache and the dst is
no longer in the exception table. The exception dst becomes a leaked
object.

As a result of this dst leak, an unbalanced refcount is reported for the
loopback device of a net namespace being destroyed under kernels that do
not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
unregister_netdevice: waiting for lo to become free. Usage count = 2

Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
patch that introduced the dst_hold() in ip6_negative_advice() was
92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
merely refactored the code with regards to the dst refcount so the issue
was present even before 92f1655aa2b22. The bug was introduced in
54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
expired.") where the expired cached route is deleted and the sk_dst_cache
member of the socket is set to NULL by calling dst_negative_advice() but
the refcount belonging to the socket is left unbalanced.

The IPv4 version - ipv4_negative_advice() - is not affected by this bug.
When the TCP connection times out ipv4_negative_advice() merely resets the
sk_dst_cache of the socket while decrementing the refcount of the
exception dst.

Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually expired.")
Link: https://lore.kernel.org/netdev/20241113105611.GA6723@incl/T/#u
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
v2 changes:
* a comment describing the lifetime of the dst was put in place
* the steps to reproduce the issue were dropped because listing them
  does not make the issue more apparent
* the commented trace was replaced with a description that should
  be more succinct and easier to read
* the word count of the changelog was reduced
* a link was added
Paolo, Eric, thanks for the comments.

 net/ipv6/route.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..31b4f97d7728 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2780,10 +2780,10 @@ static void ip6_negative_advice(struct sock *sk,
 	if (rt->rt6i_flags & RTF_CACHE) {
 		rcu_read_lock();
 		if (rt6_check_expired(rt)) {
-			/* counteract the dst_release() in sk_dst_reset() */
-			dst_hold(dst);
+			/* rt/dst can not be destroyed yet,
+			 * because of rcu_read_lock()
+			 */
 			sk_dst_reset(sk);
-
 			rt6_remove_exception_rt(rt);
 		}
 		rcu_read_unlock();
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs

