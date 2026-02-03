Return-Path: <netdev+bounces-256407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FvRNWM3gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:58:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A837DD36C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F001308267E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE335EDAA;
	Tue,  3 Feb 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vhtmqubU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hBWj/lGX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QFl8BakL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rF+k/XTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1021D5ABA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141296; cv=none; b=LpiFHP/pqo7rtQW/6eUGG4eFbRJQVsNaX2Ma/JF78RovztMLzBpLsofNH2+vyUXnRc4hAF/J9N1pEOGKusr0QMc6dSq1H/OTNrAhyuwfTWXemWn+K+KbyWX0DWO0IO/IQSxJLZDqJUFDMbKbCVvKRFrp4hFMd+Jn2bQDJgA5LiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141296; c=relaxed/simple;
	bh=fxJ/NyomK1aNHsH8VvjtwkFg+gQGQNL6KRXWgLp24dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDiugeeiewnjipZWEHXuImKhNXW7x2iwkWu9svMrtrf1ZDcKDb0q9bwNj1N4f3hoSI882UBhQBAUuk793TuRp99CFyJb00NpF1ztIiZ5oVVEaz2MUaqQsKqYSLDACtEy3yWRKEpkGro+cgQUbGst07ahonL+ZNcGJny3NrtWA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vhtmqubU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hBWj/lGX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QFl8BakL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rF+k/XTH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D38905BCC3;
	Tue,  3 Feb 2026 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770141293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PvsEqPcAr1Ruk25BgvXyWm3UGKGTAHXRP4htfGBnfKs=;
	b=vhtmqubUiUGk08dGnEXrBI0SmGdQVgoD+wRVokncPyFmeqspDutYaX1rwyUA/XVRIhOJMC
	W8fjS/fLNt0WhjN+zjDTgeyFhrRO/d7oIy+E7ulO7Im1RygBD2uPq50v2DyhSlC2hs6/8O
	dUCXpWyfeXUbk510AKfqTaIFNY8/cR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770141293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PvsEqPcAr1Ruk25BgvXyWm3UGKGTAHXRP4htfGBnfKs=;
	b=hBWj/lGX0RYRL4Q5DASjeY+G3DO0n6v6r+VrvLmD1oJCQKP3s7lG7KbjJhlJB3vYeiNJrP
	S/9P9YAyxmtUcgDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QFl8BakL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="rF+k/XTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770141292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PvsEqPcAr1Ruk25BgvXyWm3UGKGTAHXRP4htfGBnfKs=;
	b=QFl8BakLVNcDiNd8b8MosGWZY1EAQjxkfTnw6sD88/78X/2jrlxoRdoHP5XwtWXw/r09cF
	wU2QXaInwiroFQESjWVqKIWDeiKEr9B7E9v652jU/Q/ck9VSdX6WJuf06eFTlfU2/eNqJ6
	EkE099+u8uQ6vVfY+11OAVxsqcU1G3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770141292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PvsEqPcAr1Ruk25BgvXyWm3UGKGTAHXRP4htfGBnfKs=;
	b=rF+k/XTHTcLt18FqKsdaUbjIQSObe9VgLc/XvmPYtJ63TFzgc+LDwOBvMsQOhZ9f7+XS4o
	LfsvU2ydEC1ayuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74843EA62;
	Tue,  3 Feb 2026 17:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HTuNGs2gmlVdQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Feb 2026 17:54:51 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Thorsten Toepper <thorsten.toepper@sap.com>
Subject: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to reduce sequential port retries
Date: Tue,  3 Feb 2026 18:54:22 +0100
Message-ID: <20260203175422.4620-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256407-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,sap.com:email]
X-Rspamd-Queue-Id: 2A837DD36C
X-Rspamd-Action: no action

With the current port selection algorithm, ports after a reserved port
or long time used port are used more often than others. This combines
with cloud environments blocking connections between the application
server and the database server if there was a previous connection with
the same source port. This leads to connectivity problems between
applications on cloud environments.

The situation is that a source tuple is usable again after being closed
for a maximum lifetime segment of two minutes while in the firewall it's
still noted as existing for 60 minutes or longer. So in case that the
port is reused for the same target tuple before the firewall cleans up,
the connection will fail due to firewall interference which itself will
reset the activity timeout in its own table. We understand the real
issue here is that these firewalls cannot cope with standards-compliant
port reuse. But this is a workaround for such situations and an
improvement on the distribution of ports selected.

The proposed solution is instead of incrementing the port number,
performing a re-selection of a new random port within the remaining
range. This solution is configured via sysctl new option
"net.ipv4.ip_retry_random_port".

The test run consists of two processes, a client and a server, and loops
connect to the server sending some bytes back. The results we got are
promising:

Executed test: Current algorithm
ephemeral port range: 9000-65499
simulated selections: 10000000
retries during simulation: 14197718
longest retry sequence: 5202

Executed test: Proposed modified algorithm
ephemeral port range: 9000-65499
simulated selections: 10000000
retries during simulation: 3976671
longest retry sequence: 12

In addition, on graphs generated we can observe that the distribution of
source ports is more even with the proposed patch.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Thorsten Toepper <thorsten.toepper@sap.com>
---
 .../networking/net_cachelines/netns_ipv4_sysctl.rst        | 1 +
 include/net/netns/ipv4.h                                   | 1 +
 net/ipv4/inet_hashtables.c                                 | 7 ++++++-
 net/ipv4/sysctl_net_ipv4.c                                 | 7 +++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19b..c4041fdca01e 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
 u8                              sysctl_tcp_ecn_fallback
 u8                              sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
 u8                              sysctl_ip_no_pmtu_disc
+u8                              sysctl_ip_retry_random_port
 u8                              sysctl_ip_fwd_use_pmtu                       read_mostly                             ip_dst_mtu_maybe_forward/ip_skb_dst_mtu
 u8                              sysctl_ip_fwd_update_priority                                                        ip_forward
 u8                              sysctl_ip_nonlocal_bind
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 2dbd46fc4734..d04b07e7c935 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -156,6 +156,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_ip_default_ttl;
 	u8 sysctl_ip_no_pmtu_disc;
+	u8 sysctl_ip_retry_random_port;
 	u8 sysctl_ip_fwd_update_priority;
 	u8 sysctl_ip_nonlocal_bind;
 	u8 sysctl_ip_autobind_reuse;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f5826ec4bcaa..f1c79a7d3fd3 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1088,8 +1088,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	for (i = 0; i < remaining; i += step, port += step) {
 		if (unlikely(port >= high))
 			port -= remaining;
-		if (inet_is_local_reserved_port(net, port))
+		if (inet_is_local_reserved_port(net, port)) {
+			if (net->ipv4.sysctl_ip_retry_random_port) {
+				port = low + get_random_u32_below(remaining);
+				port = ((port & 1) == step) ? port : (port - 1);
+			}
 			continue;
+		}
 		head = &hinfo->bhash[inet_bhashfn(net, port,
 						  hinfo->bhash_size)];
 		rcu_read_lock();
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..5eade7d9e4a2 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= ipv4_local_port_range,
 	},
+	{
+		.procname	= "ip_retry_random_port",
+		.maxlen		= sizeof(u8),
+		.data		= &init_net.ipv4.sysctl_ip_retry_random_port,
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
 	{
 		.procname	= "ip_local_reserved_ports",
 		.data		= &init_net.ipv4.sysctl_local_reserved_ports,
-- 
2.52.0


