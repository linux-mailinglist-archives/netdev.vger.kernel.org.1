Return-Path: <netdev+bounces-240607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0767C76C2F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08D24E68A4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D82741A0;
	Fri, 21 Nov 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rh5ORHk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1A26ED41
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684475; cv=none; b=YEV+Jw41yhPA62STvN232at0oBlttQR9VLFroap4MYebrT2SKu3tz6kJ/T7/bunx2tOfVExsNd7zyVAODrvLYB3hldqKvPjIcBm+h0oXM/cA+/C1HZIf+fdC27FFnSHh5+wOA11B/w+cXXBGUmd0Fm5N7LpunV0fvei+bmDGGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684475; c=relaxed/simple;
	bh=Z+75JxhIayB2QDvUMkri+7f/852+SalPIhPb00SKhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPMHuxW/gaUTlhQbueZTYR9mlMSuT+TsPaw95zopEdOBhIhja9cSc1wI9s5VWQ2rD7DwdW6ksd1E83H+w+9vb/GbMJ8gURzpiveAY11oNMzKRR1hLPhqc6cLZdzp6PeF3kFuci4GsoeKPhMKkI3+w71BmuFRIpkQfvT6No1mpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rh5ORHk8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779d47be12so11551815e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684472; x=1764289272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxPi8+qAmmslD+H99ZF2plxkvdD2p2sBI/iOvixsuCI=;
        b=Rh5ORHk8781dgLqbSWwX+y9xIqhY2cMquJGA439SAmyd+q2LgYfVUrCchgD3hfDV8b
         kr5aiCY2DiPHN9W4HaIxMNZVAQw82vwj61Dj6GtBs4aXNMJH7XITGGxyVahjFjSQtO5i
         UxlHOekoCkDB0NvBxv9HEi1TaMqquULXq+c7SFN++yH4bJ7tseDNMhHBh1OOXw5lzMil
         Dfd24eOni1bItLNosp88AAkyYxOrbwqdB1tNE/Mw5dn1yKDXzJg7FiDk4cFP9VxoEyXQ
         1sFcn180f7YJZA5fSLI3RSM8Pnspvw7u4xnrXdJeJVNXzltYtFVpNZN4zTntFC5Dt7Nx
         iFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684472; x=1764289272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxPi8+qAmmslD+H99ZF2plxkvdD2p2sBI/iOvixsuCI=;
        b=i/Uq2QQl8TWkfpo+tCqj+gVGhmMOWOrmC1VVlkW1f4sppKp8dSBYHVteVd/Rv6B74N
         gLZkXG9/a+y5pgUrWjycEcUEh9rGltVYj0aJzA36tesWUEa00krB2N7izyZ6bvlldOjc
         zA8ic2vvLsW5Z7X/Yy8e47zFOH/xfcDdQ2tBRGrWedYL5NttZem1HMQdXm+Nj40rd5u2
         qiqEtSPaVK8bUsXbNDPWIfQ6WqWAF+lh2dp1KGRUB1HJNt0PuygHSW5/fPDTX/gsQCuS
         /D9kFgRDu1i6Cw4+o6dcjs7hVz+rflbSjSGnMZ2g4+XBjYhvrl1O2vhkzjiWLd2du80T
         mvMw==
X-Gm-Message-State: AOJu0Yw6eYHBbXjN+VOLWCLv27SEKJDLvIS8B/4MGhlyPtrjMLm4WB5x
	2zqYVbisFLPEGtDd0pLK4iLH8es6tiyYFE3RBTDTy5A3dckpDvZN39imP+E0Ee123lw2+++GpaT
	jVkFFMCz172RUIsU6U9imVM1mOB4upgLG1v85iXPkYQN9/G04AZL3CIc0y5A0DZwXla4=
X-Gm-Gg: ASbGnctpAjxKYKVFImv9+fEfLERkSbBeL1eh+h4C8wA2tRUVySknEKKzEosHDXAWcCk
	HIKEkbkLbeEri+2Nb80deNNk1V1G/Y0rIwoHKCWxMm2Z2PZ8qV+CLf9XtXlpaiuWmxvMcCe+x4i
	yFLz23EnRH9rUeikKiGL2zdDMwGjoIcSSMAIntzpJXWuDlNPmIM3rQEMDol8ijmuXjLdyTBmVbL
	zFNtyVzxl/ZozugQyiGfUBeIc2glNZOXId8OTx7jpsUeVXx+ixKbVZz0EbDpKCZrOOHoIyUbDcW
	Ux8n8ZNfDFoduHNq7vi5t84S4ADsJ0L7NqtfVdhV/24EEVuDg19mXJRbFF/6EitnGL8hJosyGbp
	gqD31C7AN96CQXIgugAzdNKPxKUdj3rAaqznTMHCoPHUI3zzYadaV5/TdgsTzgKTxrgDMuznJkX
	E5rOIBRxMoQt/De1WFEpvRMBE3KIoVKkFYSWY=
X-Google-Smtp-Source: AGHT+IGPCAfzGDpSi+6j1/8RLPhpb+xFzZ1QrfahgeQ65WX/PHh6/ColYCdlVsnAZvBQSQUg3Azy4A==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr4247765e9.26.1763684472032;
        Thu, 20 Nov 2025 16:21:12 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 12/13] ovpn: use bound address in UDP when available
Date: Fri, 21 Nov 2025 01:20:43 +0100
Message-ID: <20251121002044.16071-13-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Use the socket's locally bound address if it's explicitly specified via
the --local option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 328819f27e1e..42798aca7bce 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -148,7 +148,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
-		.saddr = bind->local.ipv4.s_addr,
+		.saddr = inet_sk(sk)->inet_rcv_saddr ?: bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
 		.fl4_sport = inet_sk(sk)->inet_sport,
 		.fl4_dport = bind->remote.in4.sin_port,
@@ -226,7 +226,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	struct flowi6 fl = {
-		.saddr = bind->local.ipv6,
+		.saddr = ipv6_addr_any(&sk->sk_v6_rcv_saddr) ?
+				 bind->local.ipv6 :
+				 sk->sk_v6_rcv_saddr,
 		.daddr = bind->remote.in6.sin6_addr,
 		.fl6_sport = inet_sk(sk)->inet_sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
-- 
2.51.2


