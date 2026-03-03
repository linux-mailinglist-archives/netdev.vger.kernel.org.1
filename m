Return-Path: <netdev+bounces-263340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGSrI7oap2m+dgAAu9opvQ
	(envelope-from <netdev+bounces-263340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:30:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A921F4A28
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFFE30484FC
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE947DF8D;
	Tue,  3 Mar 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mMqiFqbO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7AZbGquj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T0z4ahWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="24FGrHiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70603CD8DA
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559020; cv=none; b=qf0lBBgFjwGaXNlo7PzEHnAdDmfPb0I9Bcu+DDYKp0hGI4YlKkpKlboPWWkg3pj12weExgQlZ+Hx+/D8xO3HCbcsyCeNubzYAKsO5+VyVI0rwPPA4gcu1XzadueTdjOvJa9k3aHLHJkqi/MaZNpj4xheOIho+3QBppA6PQyNGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559020; c=relaxed/simple;
	bh=vcowiodaCksryTx7ffg2UYLFf4iwqM7eTdFIlNJe0t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=deSOM1Ldac9UKDTbNxlrSh99wbU8qk0pEgkcTBG3zExWT1neKBICsmwFkO0GxDkilfnIxrcSBIs5QFvhs7LOJn/dc/523EXXmFeGqOVBHfF46VbqyAmSJr7tK+v6ofUOc03eN1chJyq69ZvczPxiUyKYYrgrOjTMjz9iL0bfVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mMqiFqbO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7AZbGquj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T0z4ahWU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=24FGrHiP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F07663F308;
	Tue,  3 Mar 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772559017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=unZPDEvtFHRxhhWuD/uOyTVvTbYuoIbm8tCQtZ+ofvc=;
	b=mMqiFqbOlNLavAiXe6j7Jo3EyY/lsA0JTsByUuPxIp7e+S+W8rRQnjhKMNppqeR0+MoKNI
	p6NSxfmdowwoleEdLb8kP47LRz6xq2Zx3gqFpJ6hq5lB3hvae7ZdUc+XkkTLv1kxWlV3aW
	7Sz41oYemc2JORTEZmiZZFdI0AhTOus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772559017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=unZPDEvtFHRxhhWuD/uOyTVvTbYuoIbm8tCQtZ+ofvc=;
	b=7AZbGqujf3phxMlZAgzzH7wipmm9C607SP1Tdym+JGYY6abnZFwo6oR/pNPA1UYg6b0rDz
	g2r/OeLtBIzsarBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772559016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=unZPDEvtFHRxhhWuD/uOyTVvTbYuoIbm8tCQtZ+ofvc=;
	b=T0z4ahWUOsADO4qMs2mmTw9UPmLDwj6+in7ziHTgQ8j/YvqGTc0l0yaHPyCTSIgUaSWzCG
	0P9GVb2rqlEEUY8Lc7A9AvtQ3ERITpeA0OiPrNO3xXw0SmG1uYKH76a1553xfrpzCkY+gt
	TGa93x4/4PZrli0+IbqLQ8oVts+J2HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772559016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=unZPDEvtFHRxhhWuD/uOyTVvTbYuoIbm8tCQtZ+ofvc=;
	b=24FGrHiP06Magjf3I9lElE82spAFzxxGnFEugeq6GmNsvQ8bVRMPw1t1gWHISgG3dsscXt
	VQ5EgJWw3QwKRfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE7B63EA69;
	Tue,  3 Mar 2026 17:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vFw3N6cap2k8UQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 17:30:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	idosch@nvidia.com,
	willemb@google.com,
	dsahern@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v3] inet: add ip_local_port_step_width sysctl to improve port usage distribution
Date: Tue,  3 Mar 2026 18:29:49 +0100
Message-ID: <20260303172949.4741-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F2A921F4A28
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
	TAGGED_FROM(0.00)[bounces-263340-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

With the current port selection algorithm, ports after a reserved port
range or long time used port are used more often than others [1]. This
causes an uneven port usage distribution. This combines with cloud
environments blocking connections between the application server and the
database server if there was a previous connection with the same source
port, leading to connectivity problems between applications on cloud
environments.

The real issue here is that these firewalls cannot cope with
standards-compliant port reuse. This is a workaround for such situations
and an improvement on the distribution of ports selected.

The proposed solution is to implement a variant of RFC 6056 Algorithm 5.
The step size is selected randomly on every connect() call ensuring it
is a coprime with respect to the size of the range of ports we want to
scan. This way, we can ensure that all ports within the range are
scanned before returning an error. To enable this algorithm, the user
must configure the new sysctl option "net.ipv4.ip_local_port_step_width".

In addition, on graphs generated we can observe that the distribution of
source ports is more even with the proposed approach. [2]

[1] https://0xffsoftware.com/port_graph_current_alg.html

[2] https://0xffsoftware.com/port_graph_random_step_alg.html

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: used step to calculate remaining as (remaining / step) and avoid
calculating gcd when scan_step and range are both even
v3: xmas tree formatting and break the gdc() loop once scan_step is 1
---
 Documentation/networking/ip-sysctl.rst        |  9 ++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/netns/ipv4.h                      |  1 +
 net/ipv4/inet_hashtables.c                    | 28 +++++++++++++++++--
 net/ipv4/sysctl_net_ipv4.c                    |  7 +++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 265158534cda..da29806700e9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1630,6 +1630,15 @@ ip_local_reserved_ports - list of comma separated ranges
 
 	Default: Empty
 
+ip_local_port_step_width - INTEGER
+        Defines the numerical maximum increment between successive port
+        allocations within the ephemeral port range when an unavailable port is
+        reached. This can be used to mitigate accumulated nodes in port
+        distribution when reserved ports have been configured. Please note that
+        port collisions may be more frequent in a system with a very high load.
+
+        Default: 0 (disabled)
+
 ip_unprivileged_port_start - INTEGER
 	This is a per-namespace sysctl.  It defines the first
 	unprivileged port in the network namespace.  Privileged ports
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19b..cf284263e69b 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -52,6 +52,7 @@ u8                              sysctl_ip_fwd_update_priority
 u8                              sysctl_ip_nonlocal_bind
 u8                              sysctl_ip_autobind_reuse
 u8                              sysctl_ip_dynaddr
+u32                             sysctl_ip_local_port_step_width
 u8                              sysctl_ip_early_demux                                            read_mostly         ip(6)_rcv_finish_core
 u8                              sysctl_raw_l3mdev_accept
 u8                              sysctl_tcp_early_demux                                           read_mostly         ip(6)_rcv_finish_core
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e971c7bf164..fb7c2235af21 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -166,6 +166,7 @@ struct netns_ipv4 {
 	u8 sysctl_ip_autobind_reuse;
 	/* Shall we try to damage output packets if routing dev changes? */
 	u8 sysctl_ip_dynaddr;
+	u32 sysctl_ip_local_port_step_width;
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	u8 sysctl_raw_l3mdev_accept;
 #endif
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fca980772c81..86b0c6d2c25d 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/gcd.h>
 
 #include <net/addrconf.h>
 #include <net/inet_connection_sock.h>
@@ -1046,12 +1047,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	struct net *net = sock_net(sk);
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
+	int step, scan_step, l3mdev;
+	u32 index, max_rand_step;
 	bool tb_created = false;
 	u32 remaining, offset;
 	int ret, i, low, high;
 	bool local_ports;
-	int step, l3mdev;
-	u32 index;
 
 	if (port) {
 		local_bh_disable();
@@ -1065,6 +1066,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
 	step = local_ports ? 1 : 2;
+	scan_step = step;
+	max_rand_step = READ_ONCE(net->ipv4.sysctl_ip_local_port_step_width);
 
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
@@ -1083,9 +1086,28 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	 */
 	if (!local_ports)
 		offset &= ~1U;
+
+	if (max_rand_step && remaining > 1) {
+		u32 range = remaining / step;
+		u32 upper_bound;
+
+		upper_bound = min(range, max_rand_step);
+		scan_step = get_random_u32_inclusive(1, upper_bound);
+		while (gcd(scan_step, range) != 1) {
+			scan_step++;
+			/* if both scan_step and range are even gcd won't be 1 */
+			if (!(scan_step & 1) && !(range & 1))
+				scan_step++;
+			if (unlikely(scan_step > upper_bound)) {
+				scan_step = 1;
+				break;
+			}
+		}
+		scan_step *= step;
+	}
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += step, port += step) {
+	for (i = 0; i < remaining; i += step, port += scan_step) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 643763bc2142..c533374f656c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= ipv4_local_port_range,
 	},
+	{
+		.procname	= "ip_local_port_step_width",
+		.maxlen		= sizeof(u32),
+		.data		= &init_net.ipv4.sysctl_ip_local_port_step_width,
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
 	{
 		.procname	= "ip_local_reserved_ports",
 		.data		= &init_net.ipv4.sysctl_local_reserved_ports,
-- 
2.53.0


