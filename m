Return-Path: <netdev+bounces-298537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICibJKvLK2qnFAQAu9opvQ
	(envelope-from <netdev+bounces-298537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:04:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107876780AA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:04:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ko/XLJVA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298537-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C24348F5C0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF057383991;
	Fri, 12 Jun 2026 09:00:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A23815D1
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254809; cv=none; b=GV5d1KO/2O69U1LMS3eVjP4asArohU5OxCv2oX7fzTg/u3aqZbvc6slv7DZWgRgErQ1tB1kpVt2JmeuXYUz2iy2/aFPon/bbYygtuVP/UvflPbp+sm+2ah6cW0cWFCsTiR0iOof8zb6zwDORTjeVXBId3oaAe+YUHTMoUde/HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254809; c=relaxed/simple;
	bh=c5Ovqn0fbu1jXKNfhzl7xwQ/WtrZQNup6EQ6zkDC9cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0XVD8TNVMrb4EI8J+QgJgGBnG/mrzhoRE+CJqF2kRuW/8z8nQ13gaWgDvFucgryqx6fdzY0Vh6oCVdAdZF6WvJNzhGwAVS4dlbt34laxUYnVltUM7C6WIp1GM111n5mCOmqjsK8pxFf+viopwAH08DSdKl3CBxjE2weJW2LZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko/XLJVA; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8434840cea8so371261b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254808; x=1781859608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=islszk4qO02xP4bfqkbmrVfs4AwnzsoexkuUe8m8IY8=;
        b=ko/XLJVAQPBcxOYWiDwYphXme+qpPBceg/HdV+LhJzd8dPqxpkf8KZ+gX18b5qj5nC
         TdbON+cjXi3Hm5wTSZGqmP1f98nAy4KgxIDVP3pE+TlRuOQU3+sLET/I6dQGjff7P0An
         1G5bRMwifxEyKgHpm01Sjk53fxKjjeIb7QSE0nB841lJRp0uscQ+G82RkrYUdndayKwB
         kN0bwJnLydjJ9evH+FydfFbt7ufNSmj9+XdTAONjfTlcfUvZrejXD0Hk7b0nhT7ALMi1
         4966Q2dTpBioYFEdIfK5BM925i+18G24vsHYklajFuyuJXnBU2+XMAjzrT3KIdvuvP/C
         2J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254808; x=1781859608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=islszk4qO02xP4bfqkbmrVfs4AwnzsoexkuUe8m8IY8=;
        b=PWONFW2LI1w9+wnJgcTchB6+RzxzeotUrQSb35emmGFI+9uJPHKvoDopnXcFKyXQ2T
         e+1IjxmHgs0Bow9yMPj81jE/LTuZZfh6ogAFg0Ox5Eay7N/A6NW6h7SLVlmPDS/ohbNr
         SF3D/4aLexaxus12tR7Aw+bL2gQ+h1bs3mDK/bykutVQo2Fzi4Cd9eQlcS1HeswNKzLu
         jEPQ/fav1SsvSungNkZNbklMQaAhresX0syRRPe3pCG1LgDEYE/DOGrkjyC1kf66CGLW
         ZUdblYHfqkX94cOf869StP7XYJc5UtTyn3saEfwqCrUd28q4Rvp5im69HztovjPSLXBU
         UPNw==
X-Forwarded-Encrypted: i=1; AFNElJ9aelFySnsBnkeB7clykhyU2ota8q8PO95l3UuIqock12uzBCvAkSiBHbedwo7UY9b8zaJ2HRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6blfJEA301xPjk9UNKV8Dk1u+BwDzFx76/iTKELsTpOT4Ij4
	dzmiPGfMgRzTNlBg+0UViXXbxz9k7JEEcl444kje0R7Ziky/izYPFkhu
X-Gm-Gg: Acq92OGH8BfrHWUMcDoF0IjBMY9KoZZVnthId0YyorHfyp97kZJa1ixNPvErDQWfHBF
	rDI8h0FFSsiw1UXLujB4KezGLNOazHjsP2tZeU0duUbCLULQRQI6bwbqGFmTOjdaEcqUVLd9a5a
	mQZGWa1VE6in27bzXW6cMMC1tPMl8Vha/ywd7hrNxzuX19PIUMdzRRpUAKtDI/xhZGjQUu9FyXH
	gYDB5DcWzTCLwTAzZx4lgVSU+AmCF8cHPYRYCac6uYobfEwmkSDGnFjns6NIiFS6IrzkBPISt3g
	nv6dzi3Qsqxfk18YCT5vbQjsQD8nvYYWQkWJq2T6oV0ih1lM94uAQXjcCKyxDkglJeC2rZ0Ilvb
	gzfU62LddnJ3v2Ftv3BSWHoA0sWPP2eqcUc9vTDwjt9ypNWeBE4tP6iipH68IFb2kKivbsV9OOG
	zDfDVPibeoQYpa59T9EOdXHXX11d1mVu51R54alejbUO1Q/ip3
X-Received: by 2002:a05:6a00:2ea5:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-8434cd5cf1dmr2207276b3a.20.1781254804923;
        Fri, 12 Jun 2026 02:00:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:39 +0800
Message-Id: <20260612085941.3158249-6-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298537-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,google.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107876780AA

ip6gre_changelink() and ip6erspan_changelink() operate on at most two
netns, dev_net(dev) and the tunnel link netns t->net. They differ once
the device is created in or moved to a netns other than the one the
request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
against dev_net(dev), so a caller privileged there but not in t->net can
rewrite a tunnel that lives in t->net.

Gate both ops on rtnl_dev_link_net_capable() at their top, before any
attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..8ebc99a299c9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1


