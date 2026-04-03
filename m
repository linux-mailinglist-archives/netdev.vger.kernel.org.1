Return-Path: <netdev+bounces-275165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEnOG8AM0Gkp2wYAu9opvQ
	(envelope-from <netdev+bounces-275165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6E239765E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C4DF3008C3E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB123CAE65;
	Fri,  3 Apr 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtK5YBSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99A3C3445
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242429; cv=none; b=bIzkSma7bcNPcIESfPs0pwp4AKH8OzUPMR4AqlfHQEyEQtaZYTaNZBFEhKV3KPdIVkcPhJn/SQRpMGB9CmNenJGyUa4hx/mXvIyYmHFkgnZ88cDlM8b1vHfMARnGxwXfegqeaI5FsuT7YlJ2F3yrI009IHft3yDrVty4zL2nDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242429; c=relaxed/simple;
	bh=/jVVlaYZFAwlin52R+2Ey9DOou+ZLFQYY+l+kE8eSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mszJkJyG3pCKma2cj09h4sn8MeGeIacAbaUfXYZuhuA3PlzWRNbiDhce3j7OYzmlEetCU+B9JZyMy95014YtEMO3d8Ly6v2QL5NA0KeFpycEcsueQIj62OrpaoQoVY2YntUc9QUTv0HJ8DhYlMhQFQw7t3kK0/uOHZ5xIEoLbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtK5YBSn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so1989200f8f.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775242427; x=1775847227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maeNfYkM/3PGyOug4UakihZPv8oRILxVm2J09dLBdmo=;
        b=KtK5YBSnLPeC3oqAHwG2IFdDU6RrqXWDmlCpSUYaeo9plyoWLTvCpiB4IpOzZMW8XP
         8DHrhlwvzYkpfb2eZUIkV71iwRK5X4IMSo6LJOoSqCmz2HyjDcheHkaYyBcr0YHnCzap
         zfIUBtw6W8e1+w+lnicYEE6M+Uz3R8DvyZL7XXhpzfxfXnWg79iwr2aNO94/sF8FmIJ8
         oL+HvTWvZIFMxMqp/LKsdf3tm8cs8zTTrNMPukaOEB83JpbPH8qSxwFlvzsZMMuwoQbT
         Uf4KPTLab4Nx1NudHdA0sW7Bi8sEAur4hLgl2t1QiFKvBjcvmxFfpHeP87fL3C594O5T
         dTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242427; x=1775847227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maeNfYkM/3PGyOug4UakihZPv8oRILxVm2J09dLBdmo=;
        b=a42LXqY4hhtVLpYynAfssK7/8OGjyJuvOLF5kCb4GtQY8Yn6uOaGfWaRWMpnTU+Vcg
         q6AAr1QW2UtpsbMpqxM8D/jgMlrGrkkiJWu/6SAiX2ne/zKRKBk1hvZszqHWpkfdzvzD
         PbpaHicmtjH+fqwamuFesT+rBYqo5gDG/F3C/72EdsG/CGvt79kttk+nWdkw3/4YFBYK
         tqqWplDLGmxIhTHMoFiqvyP2v2X1hxPxOP0JA1EsPA0ciIPy6Wvnb/4cM2NtkUoGyFGK
         pqnFPYAwd7xU2pbySOOStMfeSuJvaNQlH+EL7UrSBtn4D1C3gvzGgpeCUtUODrkkp5xA
         VzRw==
X-Forwarded-Encrypted: i=1; AJvYcCXV4bceKk87u7tSJ9vQgKAZo/MP6423dGoyeYRyGyFLJrY5PUTiS8PVV0MVIGUqWibHgB0qyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jhF2B/d1HDn5vgpiVlTf4VkBuAwNDoWc/qy0TX4FAbA4ciDw
	5siUVXqk1fUHb7PfyoGRX+sxC2MVLbimyQ4L/Irz6zVJL0yMXJii4btN
X-Gm-Gg: AeBDiesWqoS3u28v8g4BSJ9BC6aOj8M7pcOVeIVRqqVgHQK8Wpk71spxC+wSfu620/Q
	VMOH6oqxMweuVf1jFzYKqAR0FxU1D9Rf4WFQeQQsBG1hCRknn9R5kD1ElJWUj459qal8O//1SJ0
	oU5LGKYREeU65mR19TD2VTclXQc4Yr/nBSwX9xG1NbqIEj8dUNRqlX3UXvfkH9pm2cgRKAPVGP7
	7fQsKaVD74Q7KG9nMrso0wSrIcnzG6UN8NyZrZ9KjpIhB/7JYE7LH6C3aVU0ZaStger1alMWuQ0
	Ry8S0CvCy1BKTrrqQ8xJY8gOaXtTTnyhVaFCWddLiPgrHUxOae9EqGFH2PjFdv2tvn3/14nQ3Od
	hfXxQGE3iArMi5oyb5YnhEVUqHEladp7t+ghzDYaDr6oxRSYI3PTNFwev3u41JS/E1luPdHwlzo
	WUe+7jo7VdpZDEeygVrtTQN29hKxsIJbePhluwRZIHUMyQWHZhDUyoIFTSJIN0Q7qoqWJrm7KAE
	4gBzYl7UWiAFPNtGFXGt9Anrn0BtGmPyQMUOLyweJ5/LyOxShE=
X-Received: by 2002:a05:6000:401f:b0:43d:2be:e4e with SMTP id ffacd0b85a97d-43d292ff520mr6572751f8f.46.1775242426634;
        Fri, 03 Apr 2026 11:53:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-188-129-81-72.dynamic.amis.hr. [188.129.81.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm17855349f8f.19.2026.04.03.11.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 11:53:46 -0700 (PDT)
From: Marino Dzalto <marino.dzalto@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marino Dzalto <marino.dzalto@icloud.com>
Subject: [PATCH] netfilter: xt_dscp: replace -EDOM with -EINVAL and unify match functions
Date: Fri,  3 Apr 2026 20:53:37 +0200
Message-ID: <20260403185337.87676-1-marino.dzalto@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,icloud.com];
	TAGGED_FROM(0.00)[bounces-275165-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[marinodzalto@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E6E239765E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marino Dzalto <marino.dzalto@icloud.com>

Signed-off-by: Marino Dzalto <marino.dzalto@icloud.com>
---
 net/netfilter/xt_dscp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/xt_dscp.c b/net/netfilter/xt_dscp.c
index fb0169a8f..00137bff3 100644
--- a/net/netfilter/xt_dscp.c
+++ b/net/netfilter/xt_dscp.c
@@ -25,16 +25,12 @@ static bool
 dscp_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_dscp_info *info = par->matchinfo;
-	u_int8_t dscp = ipv4_get_dsfield(ip_hdr(skb)) >> XT_DSCP_SHIFT;
+	u8 dscp;
 
-	return (dscp == info->dscp) ^ !!info->invert;
-}
-
-static bool
-dscp_mt6(const struct sk_buff *skb, struct xt_action_param *par)
-{
-	const struct xt_dscp_info *info = par->matchinfo;
-	u_int8_t dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> XT_DSCP_SHIFT;
+	if (xt_family(par) == NFPROTO_IPV4)
+		dscp = ipv4_get_dsfield(ip_hdr(skb)) >> XT_DSCP_SHIFT;
+	else
+		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> XT_DSCP_SHIFT;
 
 	return (dscp == info->dscp) ^ !!info->invert;
 }
@@ -44,7 +40,7 @@ static int dscp_mt_check(const struct xt_mtchk_param *par)
 	const struct xt_dscp_info *info = par->matchinfo;
 
 	if (info->dscp > XT_DSCP_MAX)
-		return -EDOM;
+		return -EINVAL;
 
 	return 0;
 }
@@ -74,7 +70,7 @@ static struct xt_match dscp_mt_reg[] __read_mostly = {
 		.name		= "dscp",
 		.family		= NFPROTO_IPV6,
 		.checkentry	= dscp_mt_check,
-		.match		= dscp_mt6,
+		.match		= dscp_mt,
 		.matchsize	= sizeof(struct xt_dscp_info),
 		.me		= THIS_MODULE,
 	},
-- 
2.50.1 (Apple Git-155)


