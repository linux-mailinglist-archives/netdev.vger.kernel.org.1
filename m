Return-Path: <netdev+bounces-295337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6cCRAhGuIWqYLAEAu9opvQ
	(envelope-from <netdev+bounces-295337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:55:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCBE6421BA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=NUzI+k8P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295337-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295337-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E0B3024448
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC83B4E95;
	Thu,  4 Jun 2026 16:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD383B47F7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:31:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590674; cv=none; b=Aw6dcr5g2XyrOg4U3uWtC8lNwe1M6sf2nGXhYlOjsrX1BOg3vtJnu7KFMxSsBfND8mxX8FboUtVPoQ6xqmdB2L0KHeT8rwXKfwUwKs825mLC2JK48yYUfCO7K0d5OH9nH2vvbP6ezoNCMuO+B1XXTPbgbRh5oKvrHC7tNrLCBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590674; c=relaxed/simple;
	bh=E+CY1M4wlSS+01/WXaewcF4d2P9oQida5I0nhuFHPIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8LnDw16IHCPTgi9tjK+Gu4sc6GxJ0fVFpCPnUsg4+5e6Uti6lmERnMauMP/Bx87il6Ug/FW8LjxCGpAafbetfL2TSNYGdNr7fU9dLSmbOI2o2BSGLtXct1/LeAP+CMHwmpvzx73QAZF6twWZ/LoCPqRaC1s1JjV79bNhz3jrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=NUzI+k8P; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1385601f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780590671; x=1781195471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/GEJPOLrP92/aFR0MWS+Y1Uq69OUcBYv6uQ0YsT5bY=;
        b=NUzI+k8P5Zwls7EyjHD88tj8+O4YO48ZQEx5xTH0Tmn3QBVsdHKQRA2Ez5lIfLdT97
         Pzr54+7ZCX488AtaSiRejZxhBBG40mQIxBBdyy2HTv/Fv8PfDzgalyp+3w7OaDHfYe5o
         GF+mGY93AnRE9vW7I1adhHWYpizQg8cU6drJcYPYVgHTEUzERL09LSwk6pt3dXuLCCkZ
         izIPxeiU4ITy5xiQ0psVyvcGlHYsIqsODpWDKEWkfXLQ6gKjt7QzrmxXuPTSvioHfE3V
         alEuv5K2tvs7bUzMxrNajs9IxYzNFVgJGMKRBj0sWVECEIji8CysJRbvAxuN2ATczH69
         Zsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590671; x=1781195471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/GEJPOLrP92/aFR0MWS+Y1Uq69OUcBYv6uQ0YsT5bY=;
        b=CRQ7h7jtaINeU2BSVrK4RMOOW0uoREDQSXqz5WXhXfR92fH7wUszGdWzVcmmQZBl8r
         zLTn3HpExSI0oL2CtoFBBdWBHEnfR1kb/XkuA+009t+flew1lPliG9ZYuTiavuiGFjUA
         ErV0HkSw0NyjMuVkJMR7A/TQm/PMlAtpiTVXqM8Csxu/Mq3pNkpFoyrOMhwHPeMaYUDp
         hkrAz1WY3KGtVtTyuvho+coFdjzkJfD90h2uPCQK1oZKfMpRDkz0QXJAT1WRVtck/P2l
         sjA0VNHBY1sdpTwFBcdcxnYunua2g6Ypbhf54X4G17nnhoxKgk66S5kdH82Ilmpo2GH9
         87+A==
X-Forwarded-Encrypted: i=1; AFNElJ9iCiE9wjCba9nwxKUrKZ0+tb46UObjlcX6eJEUYbQjkVr62NjVvRtgwpkaMuUJ6V7FqX0Y0w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxmzUhKGlop2c1PlK7nyWUkH9l4ZSPS74ZLm+8V9G0HicZmeK
	FozUv3a4s3KYLu6brF0/WfYWQFufK3hM5K8VkFysgRyJ4Q/9/QgcDbTIUtTcFE0RXjI=
X-Gm-Gg: Acq92OHWa9C69OPwgE21wm3ZtO22NKjxiAMFWJLw5ZUdQXWpQuSQov/vg9tA8QinNnf
	ICn3djFjp3FO1fN1wSAyhbotdi1yPz5l3Q17uiZPYJeK4EnMqxVtW4qm9lBt9zSaIHJ/fVE3njM
	WG+RAhog8X6SXSYfzcNB+AzZuOLy52vWH6DtnD/bq5SytCo0Te/m1JHJlGCG/fR4syz+7fyH9GP
	dkdLuLGmLyPe79/a+rPoSShGG9NEI9or+4mOZ5A8dL9D/QbwViOi+tx/Co+gi6y/1/c/CI4zQpz
	8CshnhPea8RbdhTT3Z6W4uD79WxSfdzqgclB4pka17qr5sFXQjC0o1dlaUQZwDIFdTvBIaZA9r/
	hJkajHBHhPbHKutIhPtQZpf8Xbv0+PJjMGyn3JXOFzBYIzZFn7NJ/dp8AwRk+w1RwF9NEI8tHQz
	fm6uDUS4Vlo2nUis9cCQx8h3MPtEFtmNcvJH6e2Nrq4W5LQbRcT5ogeSMAfg1/TZHC3Io2mrwhW
	uZfcQ==
X-Received: by 2002:a05:600c:3155:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490bc4c4b62mr64777715e9.4.1780590670952;
        Thu, 04 Jun 2026 09:31:10 -0700 (PDT)
Received: from localhost ([46.101.197.76])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46028a6dcbdsm8063435f8f.7.2026.06.04.09.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 09:31:10 -0700 (PDT)
From: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Simon Horman <horms@kernel.org>,
	Richard Alpe <richard.alpe@ericsson.com>,
	Erik Hugne <erik.hugne@ericsson.com>,
	Ying Xue <ying.xue@windriver.com>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: require admin privileges for TIPCv2 mutators
Date: Thu,  4 Jun 2026 16:31:01 +0000
Message-ID: <20260604163102.2658553-1-dominik.czarnota@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[dominik.czarnota@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:dominik.czarnota@trailofbits.com,m:horms@kernel.org,m:richard.alpe@ericsson.com,m:erik.hugne@ericsson.com,m:ying.xue@windriver.com,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.czarnota@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trailofbits.com:mid,trailofbits.com:dkim,trailofbits.com:from_mime,trailofbits.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CCBE6421BA

TIPCv2 registers its generic-netlink mutating commands without
permission flags. Generic netlink only checks CAP_NET_ADMIN when an
operation carries GENL_ADMIN_PERM or GENL_UNS_ADMIN_PERM, so callers
without CAP_NET_ADMIN can invoke these setters.

This allows an unprivileged caller to change TIPC control-plane state,
including bearer, link, network, monitor, peer and crypto-key state.
TIPC_NL_MEDIA_SET is broader because it updates the shared media
defaults returned by tipc_media_find(), including UDP MTU, priority,
tolerance and window values, which can affect later bearer setup.

Require CAP_NET_ADMIN for all TIPCv2 mutators. Use
GENL_UNS_ADMIN_PERM for network-namespace scoped state, matching the
legacy compat path and normal netns administration semantics. Use
GENL_ADMIN_PERM for TIPC_NL_MEDIA_SET because it mutates global media
defaults rather than state owned only by the target net namespace.

Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
---
 net/tipc/netlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 1a9a5bdaccf4..5bbe134284ac 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -152,11 +152,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_DISABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_disable,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_ENABLE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_enable,
 	},
 	{
@@ -168,11 +170,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_BEARER_ADD,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_add,
 	},
 	{
 		.cmd	= TIPC_NL_BEARER_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_bearer_set,
 	},
 	{
@@ -197,11 +201,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_LINK_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_link,
 	},
 	{
 		.cmd	= TIPC_NL_LINK_RESET_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit   = tipc_nl_node_reset_link_stats,
 	},
 	{
@@ -213,6 +219,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MEDIA_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_ADMIN_PERM,
 		.doit	= tipc_nl_media_set,
 	},
 	{
@@ -228,6 +235,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_NET_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_net_set,
 	},
 	{
@@ -238,6 +246,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_MON_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_monitor,
 	},
 	{
@@ -255,6 +264,7 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_PEER_REMOVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_peer_rm,
 	},
 #ifdef CONFIG_TIPC_MEDIA_UDP
@@ -269,11 +279,13 @@ static const struct genl_ops tipc_genl_v2_ops[] = {
 	{
 		.cmd	= TIPC_NL_KEY_SET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_set_key,
 	},
 	{
 		.cmd	= TIPC_NL_KEY_FLUSH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.flags	= GENL_UNS_ADMIN_PERM,
 		.doit	= tipc_nl_node_flush_key,
 	},
 #endif

