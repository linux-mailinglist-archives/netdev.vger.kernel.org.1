Return-Path: <netdev+bounces-127701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE69761F2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD51F23391
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE0189535;
	Thu, 12 Sep 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="LRVO80j/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93860374CC
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124217; cv=none; b=BXkVAPmvSi2UUVK4afP50aITQQ8TNLF86KExwSnJrnf2u4KN1TAmQrNr+1WSE8Ijur+F4mNxkWTmdehzMTEQIURcXYxr6w7+Q45UlEPVejeccu3NkNmDiWh08NIO3YWwq9/DbGuYe+liNzNGy4x9tH8BogzgV37QdTt4WUlS0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124217; c=relaxed/simple;
	bh=ciMzWboGr+29g+fW7ea1xgFdXJsGF1szJ30d5NXUcy8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Q4u1g5QHbnq2sHr88XJU/ZYRpMO5d5wPZXZNCGayURvE6gssF25wSyfuZHvS0oW+hI/Qy0RTCYHSVs8Cim6eAsfTaKf95Ur6+66Z4ZUfxB9CytatnpaJZRw+zC6JKcfvZGQck7iEnPagst4pQYTwDEI6C7vMCPwEUS48G+6xVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=LRVO80j/; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6ukqE020184
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:56:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726124209; bh=EWkMn4k2O78sJOFUhT+Qq7xP4w33Tn3YZzfbaGTDcXg=;
	h=Date:From:To:Cc:Subject;
	b=LRVO80j/wpCYQ8yAcih0oyCOt6gairADqEpc7h9NtSQGoyCLzmGhEupy+UpZvrmQN
	 ZjfI1sPM9mLfIUKvs45TNvzpsSmy1qseEotDGzBTw7Je2tmQbjI6ybhs8JSZVDHFPc
	 lW7XpwouUCxycflYMFtkZqW/UHZfQxnyymRZIRBA=
Message-ID: <810dd96b-aff6-403a-88e5-3608ef248b90@ans.pl>
Date: Wed, 11 Sep 2024 23:56:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH ethtool 1/2] Add runtime support for disabling netlink
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Provide --disable-netlink option for disabling netlink during runtime,
without the need to recompile the binary.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 ethtool.8.in      | 6 ++++++
 ethtool.c         | 6 ++++++
 internal.h        | 1 +
 netlink/netlink.c | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 11bb0f9..0b54983 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -137,6 +137,9 @@ ethtool \- query or control network driver and hardware settings
 .BN --debug
 .I args
 .HP
+.B ethtool [--disable-netlink]
+.I args
+.HP
 .B ethtool [--json]
 .I args
 .HP
@@ -579,6 +582,9 @@ lB	l.
 0x10  Structure of netlink messages
 .TE
 .TP
+.BI \-\-disable-netlink
+Do not use netlink and fall back to the ioctl interface if possible.
+.TP
 .BI \-\-json
 Output results in JavaScript Object Notation (JSON). Only a subset of
 options support this. Those which do not will continue to output
diff --git a/ethtool.c b/ethtool.c
index 7f47407..dc28069 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6537,6 +6537,12 @@ int main(int argc, char **argp)
 			argc -= 2;
 			continue;
 		}
+		if (*argp && !strcmp(*argp, "--disable-netlink")) {
+			ctx.nl_disable = true;
+			argp += 1;
+			argc -= 1;
+			continue;
+		}
 		if (*argp && !strcmp(*argp, "--json")) {
 			ctx.json = true;
 			argp += 1;
diff --git a/internal.h b/internal.h
index 4b994f5..84c64be 100644
--- a/internal.h
+++ b/internal.h
@@ -221,6 +221,7 @@ struct cmd_context {
 	char **argp;		/* arguments to the sub-command */
 	unsigned long debug;	/* debugging mask */
 	bool json;		/* Output JSON, if supported */
+	bool nl_disable;	/* Disable netlink even if available */
 	bool show_stats;	/* include command-specific stats */
 #ifdef ETHTOOL_ENABLE_NETLINK
 	struct nl_context *nlctx;	/* netlink context (opaque) */
diff --git a/netlink/netlink.c b/netlink/netlink.c
index ef0d825..3cf1710 100644
--- a/netlink/netlink.c
+++ b/netlink/netlink.c
@@ -470,6 +470,11 @@ void netlink_run_handler(struct cmd_context *ctx, nl_chk_t nlchk,
 	const char *reason;
 	int ret;
 
+	if (ctx->nl_disable) {
+		reason = "netlink disabled";
+		goto no_support;
+	}
+
 	if (nlchk && !nlchk(ctx)) {
 		reason = "ioctl-only request";
 		goto no_support;
-- 
2.46.0

