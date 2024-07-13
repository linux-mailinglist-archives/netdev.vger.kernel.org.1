Return-Path: <netdev+bounces-111187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAF93033A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F138A1F21C18
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0F179BF;
	Sat, 13 Jul 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="i3OBSXhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9E125BA;
	Sat, 13 Jul 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837164; cv=none; b=HPTYr6/cRUvUYC8srbWiqSdCUI/tDHUhLnOVYCXrplErXEPVnWgvUShjM1lPTbfZBORIYUEZe7JzLe51emVGzP2AZo7z4TyCZRp+PlpSU+CJ265tuu7beFnBL0sl9slQW41nde4BLSalXukrubQejDqTuD/y1/aP+KYyIc4g3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837164; c=relaxed/simple;
	bh=4E4yZXx8jCUbakXcIoD1t29dMzRRXIiEsqKxbHkysPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNhwOYcMOAsUHqIyc6BvUg8Sfd2kNHhGobJUklNcXsry0yGOQsgkGaFMsWtHq+C6S4ISm8r+euJocyuu/b0+bGaD9NzK/H/uCbXYLQja2pc7A7uIUs8ehkvbeW3KaL75F7GkLKsrdCwsfRlvHtzBcq+6BYUgNgYQd2+bgBcJyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=i3OBSXhO; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=4E4yZXx8jCUbakXcIoD1t29dMzRRXIiEsqKxbHkysPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3OBSXhOyoPARgVaHefU0wgOYduI6cohW58aCOdq8UkMhiaBIZQl01vmlu3+EhMx7
	 wBu3AL2/3tfUmRbDP4bWK07L0KMpxNWpdYDkZAx5FAPMuHSEU6ePzuP9rZ3bcbJotZ
	 onee1GcZ1k1WGY3dWd8YwTNrWNfTs01gPetihh9f7V5wG+O4ZJG4itVc73QNfeL937
	 G8wpj+WYOKtF0A3mP53kgLKsG3ced7XErlvMZqiq5sKmqTKPgyfjsZXIvWzyMdCIJU
	 OwoVaWtFqCmvAEClSEDhi/Rt1miNuAJbe1AJmes0X6/mih7KGKXVumKTZhrVdf8pFi
	 Mm3W32A7KbzAw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4054360089;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 1695920498F; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 07/13] flow_dissector: set encapsulated control flags from tun_flags
Date: Sat, 13 Jul 2024 02:19:04 +0000
Message-ID: <20240713021911.1631517-8-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the new FLOW_DIS_F_TUNNEL_* encapsulated control flags, based
on if their counter-part is set in tun_flags.

These flags are not userspace visible yet, as the code to dump
encapsulated control flags will first be added, and later activated
in the following patches.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
---
 net/core/flow_dissector.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1614c6708ea7c..a0263a4c5489e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -396,6 +396,15 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 
 	key = &info->key;
 
+	if (test_bit(IP_TUNNEL_CSUM_BIT, key->tun_flags))
+		ctrl_flags |= FLOW_DIS_F_TUNNEL_CSUM;
+	if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags))
+		ctrl_flags |= FLOW_DIS_F_TUNNEL_DONT_FRAGMENT;
+	if (test_bit(IP_TUNNEL_OAM_BIT, key->tun_flags))
+		ctrl_flags |= FLOW_DIS_F_TUNNEL_OAM;
+	if (test_bit(IP_TUNNEL_CRIT_OPT_BIT, key->tun_flags))
+		ctrl_flags |= FLOW_DIS_F_TUNNEL_CRIT_OPT;
+
 	switch (ip_tunnel_info_af(info)) {
 	case AF_INET:
 		skb_flow_dissect_set_enc_control(FLOW_DISSECTOR_KEY_IPV4_ADDRS,
-- 
2.45.2


