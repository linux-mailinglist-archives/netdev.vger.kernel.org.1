Return-Path: <netdev+bounces-278741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMYRANZn32lSSgAAu9opvQ
	(envelope-from <netdev+bounces-278741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:26:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155C403457
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1ADC300C00E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08B26ED41;
	Wed, 15 Apr 2026 10:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88245314B9D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248786; cv=none; b=T03UmMsVXMajTmlhhl59ZgGBgqxTKDEOo5k1amdDo0MM/vcfe7bhTMaAIddR5NyyzlVKDw7nGVXD+uOJgHkuqNxKCIYllyb6SJGwvFQ1HxGd5hLzlfMKa/N/ZH8tQPZ8ICKH2uzdGGCSxIQg5EOcEEiMjcNJ6NQ1gmPsS8V0NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248786; c=relaxed/simple;
	bh=7tc4vB5zCj5hmlaXaDObxb1sbOKPgtqcYEsOPec42RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qx/uCuBDmE55WQoEBd0d5aV4N7y6y9dcgD1WWvuh3Sd2aWfD+dPdsfwPykGyt9ZPHJI/CuwY/uiz5HBqZQ8ZbOk4fDCCXH7TqMQvsGGioi3MfO+RrW3tP6DpiwZFgCZbRMtfnXmxLPS8PvCVRdBr3ATbS7J60Um1/syIMD/vVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wCxRr-000821-2M; Wed, 15 Apr 2026 12:26:19 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 15 Apr 2026 12:26:13 +0200
Subject: [PATCH] net: ipv4: igmp: add sysctl option to ignore inbound
 llm_reports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-v7-0-topic-igmp-llm-drop-v1-1-1367bfbb898e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAMRn32kC/yXMTQqEMAxA4atI1gZaf8GrDC40jRpRW1oVQbz7d
 Mblt3jvhsBeOECT3OD5lCB2i9BpAjR128goJhoylVWq0CWeNSrcrRNCGVeHy7Ki8dYhF6Rz0w+
 6JoKYO8+DXP/1p30djn5m2n8/eJ4vW76tU3wAAAA=
X-Change-ID: 20260415-v7-0-topic-igmp-llm-drop-e4c13dbf17cc
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.trumtrar@pengutronix.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278741-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9155C403457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new sysctl option 'igmp_link_local_mcast_reports_drop' that allows
dropping inbound IGMP reports for link-local multicast groups in the
224.0.0.X range. This can be used to prevent the local system from
processing IGMP reports for link local multicast groups and therefore
let the kernel still send the own outbound IGMP reports.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/networking/ip-sysctl.rst                       | 12 ++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst          |  1 +
 include/net/netns/ipv4.h                                     |  1 +
 net/ipv4/af_inet.c                                           |  1 +
 net/ipv4/igmp.c                                              |  2 ++
 net/ipv4/sysctl_net_ipv4.c                                   |  7 +++++++
 6 files changed, 24 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6921d8594b849..2da4cd6ac7202 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2306,6 +2306,18 @@ igmp_link_local_mcast_reports - BOOLEAN
 
 	Default TRUE
 
+igmp_link_local_mcast_reports_drop - BOOLEAN
+	Drop inbound IGMP reports for link local multicast groups in
+	the 224.0.0.X range. When enabled, IGMP membership reports for
+	link local multicast addresses are silently dropped without
+	processing.
+	When the kernel gets inbound IGMP reports it stops sending own
+	IGMP reports. With allowing to drop and process the inbound reports,
+	the kernel will not stop sending the own reports, even when IGMP
+	reports from other hosts are seen on the network.
+
+	Default FALSE
+
 Alexey Kuznetsov.
 kuznet@ms2.inr.ac.ru
 
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index beaf1880a19bf..703afe2ba063b 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -140,6 +140,7 @@ int                             sysctl_udp_rmem_min
 u8                              sysctl_fib_notify_on_flag_change
 u8                              sysctl_udp_l3mdev_accept
 u8                              sysctl_igmp_llm_reports
+u8                              sysctl_igmp_llm_reports_drop
 int                             sysctl_igmp_max_memberships
 int                             sysctl_igmp_max_msf
 int                             sysctl_igmp_qrv
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e971c7bf1646..1453f825ffd4d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -258,6 +258,7 @@ struct netns_ipv4 {
 	u8 sysctl_igmp_llm_reports;
 	int sysctl_igmp_max_memberships;
 	int sysctl_igmp_max_msf;
+	u8 sysctl_igmp_llm_reports_drop;
 	int sysctl_igmp_qrv;
 
 	struct ping_group_range ping_group_range;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c7731e300a442..b8f96a5d8afdc 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1825,6 +1825,7 @@ static __net_init int inet_init_net(struct net *net)
 	net->ipv4.sysctl_igmp_max_msf = 10;
 	/* IGMP reports for link-local multicast groups are enabled by default */
 	net->ipv4.sysctl_igmp_llm_reports = 1;
+	net->ipv4.sysctl_igmp_llm_reports_drop = 0;
 	net->ipv4.sysctl_igmp_qrv = 2;
 
 	net->ipv4.sysctl_fib_notify_on_flag_change = 0;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a674fb44ec25b..3a4932e4108bd 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -931,6 +931,8 @@ static bool igmp_heard_report(struct in_device *in_dev, __be32 group)
 	if (ipv4_is_local_multicast(group) &&
 	    !READ_ONCE(net->ipv4.sysctl_igmp_llm_reports))
 		return false;
+	if (READ_ONCE(net->ipv4.sysctl_igmp_llm_reports_drop))
+		return true;
 
 	rcu_read_lock();
 	for_each_pmc_rcu(in_dev, im) {
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5654cc9c8a0b9..24dde84d289e4 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -948,6 +948,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "igmp_link_local_mcast_reports_drop",
+		.data		= &init_net.ipv4.sysctl_igmp_llm_reports_drop,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
 	{
 		.procname	= "igmp_max_memberships",
 		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260415-v7-0-topic-igmp-llm-drop-e4c13dbf17cc

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>


