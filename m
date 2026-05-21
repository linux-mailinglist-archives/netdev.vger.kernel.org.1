Return-Path: <netdev+bounces-290219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICUTOdlwDmq8+gUAu9opvQ
	(envelope-from <netdev+bounces-290219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:41:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0759E2BB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB2D300B627
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64399379C28;
	Thu, 21 May 2026 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiiwEuFg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AF3783AE;
	Thu, 21 May 2026 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331197; cv=none; b=gLCqz0eyIt0XXpTycxFHp3OA1DhjId1BoAlmBJTp+6sPCP4AdWOcd6b0RejCLQoEryfVJQouPxgj1ihXr4MmkffenOo3TIOV3d5iZwMiIPsiPJiNHk1/eILGN2gSREr9rL6Mb3LGROJUvgwBdiraffctYvP1XWWoESklGK6NnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331197; c=relaxed/simple;
	bh=5cVK05PEcA6CIcb26iVWaOL7bkg5UVjtbcg151aabvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjYYuGWzJ0PTZSmUG9B7efdDDUFcTSv2vdW/6Haxpwbr1nHilkzH/qO5H5QvzVrviroWluydaCMk5q0TtqUCNB9xCcAt8y1od9O9BwF4zKWpgkrxWfdSD4d1PkpVks4cYo0mcvYfgnDhepls2+kdergO4eqfrxFTxxXbadc9a9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiiwEuFg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17471F000E9;
	Thu, 21 May 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779331192;
	bh=U6Q8xj489RtrXIm3D1Cyqo7DlIfd9zKBGghkGDH9x+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HiiwEuFgSSmUI/4Pl3sAqOvhcRfK40zCwLovVZP8NigLWeZaVdp/ufhFtBUbCscDg
	 UcZVp98KxeO8dTkHeoP2RmQKqyxqh601h28ivi6MVztBAMQYS5c0UTkMmjEPLakAf1
	 T97ehoHRGLyML9a+rS0ZCgh12PL/H7FmEJdIwx2voYGEGO/vLBxtgxH81y0qwGKPPN
	 4o2lne+PwZLCl3hmyB2Bogw3gBqvE+DZK+NpRDHvJkALLyz8Ev3uA0Wb+zE+5wt2V9
	 1uciGHwuNEbw1Mtdicfp/ScasmxtdX/OhA33fTBoa8TyAi0fhgRo5OKSnSNHfbHPmm
	 5mXYtx2q4c7hA==
Date: Wed, 20 May 2026 19:39:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chris Mason <clm@meta.com>, Christian Brauner
 <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH net 3/7] net/handshake: Pass negative errno through
 handshake_complete()
Message-ID: <20260520193946.0d56882b@kernel.org>
In-Reply-To: <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
	<20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290219-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12C0759E2BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 14:24:30 -0400 Chuck Lever wrote:
> -	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
> -		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
> +	if (info->attrs[HANDSHAKE_A_DONE_STATUS]) {
> +		u32 val = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
> +
> +		/* Values above MAX_ERRNO would overflow on negation. */
> +		if (val <= MAX_ERRNO)
> +			status = -(int)val;
> +	}

Why not set a policy so that user space can't pass invalid stuff?

(note - sashiko has some more comments but AFAICT they are either
addressed throughout the series or false positives)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..1024297b3851 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,12 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    type: const
+    name: max-errno
+    value: 4095
+    header: linux/err.h
+    scope: kernel
   -
     type: enum
     name: handler-class
@@ -80,6 +86,8 @@ doc: Netlink protocol to request a transport layer security handshake.
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index 8d3e18672daf..46b65f131669 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info);
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..4b20cd9cdd0e 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -10,6 +10,7 @@
 #include "genl.h"
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
@@ -18,7 +19,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
-	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };

