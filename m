Return-Path: <netdev+bounces-265360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNUJECIzrmlrAQIAu9opvQ
	(envelope-from <netdev+bounces-265360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:40:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96205233578
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C25A3008232
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADAB274FDF;
	Mon,  9 Mar 2026 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OgpYX3SI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ofVjdNKU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OgpYX3SI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ofVjdNKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4B26158B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024028; cv=none; b=G8FtJr827qwoETkRna9CpiwzizFbvYQaeT07cgNHzYbfBwtZe/e6I49KfgeymbujPUPibx3Zm0APIqs1Owa+TblwrCVBtxr0d1IaTic9rCwnNM4sCITdCMYFkuQ4vJBDJEFP4WfGQT3UmzAzAQMc50BywkAl200a49F/qIewIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024028; c=relaxed/simple;
	bh=+Nf18+U1HJJx8wVSJ/NQ5y5T6f6v5rgPmCqdHq7wzy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQi+OnLrbl/p69Be+b3KxCPReY2Z2A91ypol9ymez+dRi7KJfRP3h8V9JVbkLiGq11+vda43m7iT3nZml7WFlfei+X0fRRN+/dl3xRPaJ7yW4x75H9cXIjhZIbWaIWJX4S2ISdE7RFv37hjL6/qXwFcP+SUNyOMT+wlnONA2Qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OgpYX3SI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ofVjdNKU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OgpYX3SI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ofVjdNKU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 443994D1F0;
	Mon,  9 Mar 2026 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773024024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkQpJG7sPTss4WZiOQYM1mNFcW3IkNjlt84m09h5N0=;
	b=OgpYX3SIRHhBhiANSDHdyMOwKkSxKiLchDqTi78/UO9kL8itvXhpfoAUpjvreSLx8mJzKd
	EC4GlIUoqAGcrtt7jwC7ce1edBh+VwhqM7d5vpUkYFtxPJiJJkREZYFvuoktHWbcO+1iaN
	WkKxHXMC25Aolr3S+H7QG//M0n+EcG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773024024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkQpJG7sPTss4WZiOQYM1mNFcW3IkNjlt84m09h5N0=;
	b=ofVjdNKUIJQuzRTBYmVuT1QEBzgtVTm4Rt5MvVVxE2flo43pLM9kXxdX2k9UcCmXKdoDkm
	vsfAV3EGuP/qy+Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773024024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkQpJG7sPTss4WZiOQYM1mNFcW3IkNjlt84m09h5N0=;
	b=OgpYX3SIRHhBhiANSDHdyMOwKkSxKiLchDqTi78/UO9kL8itvXhpfoAUpjvreSLx8mJzKd
	EC4GlIUoqAGcrtt7jwC7ce1edBh+VwhqM7d5vpUkYFtxPJiJJkREZYFvuoktHWbcO+1iaN
	WkKxHXMC25Aolr3S+H7QG//M0n+EcG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773024024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkQpJG7sPTss4WZiOQYM1mNFcW3IkNjlt84m09h5N0=;
	b=ofVjdNKUIJQuzRTBYmVuT1QEBzgtVTm4Rt5MvVVxE2flo43pLM9kXxdX2k9UcCmXKdoDkm
	vsfAV3EGuP/qy+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 360EE3EC80;
	Mon,  9 Mar 2026 02:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LAmOCRczrmlxRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 02:40:23 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4] inet: add ip_local_port_step_width sysctl to improve port usage distribution
Date: Mon,  9 Mar 2026 03:39:45 +0100
Message-ID: <20260309023946.5473-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 96205233578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
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
v4: extended documentation indicating what are recommended values.
---
 Documentation/networking/ip-sysctl.rst        | 16 +++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/netns/ipv4.h                      |  1 +
 net/ipv4/inet_hashtables.c                    | 28 +++++++++++++++++--
 net/ipv4/sysctl_net_ipv4.c                    |  7 +++++
 5 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 265158534cda..2e3a746fcc6d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1630,6 +1630,22 @@ ip_local_reserved_ports - list of comma separated ranges
 
 	Default: Empty
 
+ip_local_port_step_width - INTEGER
+        Defines the numerical maximum increment between successive port
+        allocations within the ephemeral port range when an unavailable port is
+        reached. This can be used to mitigate accumulated nodes in port
+        distribution when reserved ports have been configured. Please note that
+        port collisions may be more frequent in a system with a very high load.
+
+        It is recommended to set this value strictly larger than the largest
+        contiguous block of ports configure in ip_local_reserved_ports. For
+        large reserved port ranges, setting this to 3x or 4x the size of the
+        largest block is advised. Using a value equal or greater than the local
+        port range size completely solves the uneven port distribution problem,
+        but it can degrade performance under port exhaustion situations.
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
index 4c249aeaf7f1..4a9c6bc5630e 100644
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
index ac7b67c603b5..13310c72b0bf 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/gcd.h>
 
 #include <net/addrconf.h>
 #include <net/inet_connection_sock.h>
@@ -1057,12 +1058,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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
@@ -1076,6 +1077,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
 	step = local_ports ? 1 : 2;
+	scan_step = step;
+	max_rand_step = READ_ONCE(net->ipv4.sysctl_ip_local_port_step_width);
 
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
@@ -1094,9 +1097,28 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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
index 5654cc9c8a0b..d8bdb1bdbff1 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -823,6 +823,13 @@ static struct ctl_table ipv4_net_table[] = {
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


