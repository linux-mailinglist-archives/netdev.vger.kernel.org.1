Return-Path: <netdev+bounces-109492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF29289C1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FCF1F219EA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F214BF9B;
	Fri,  5 Jul 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="YKSD0XDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CD147C9E;
	Fri,  5 Jul 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186456; cv=none; b=LMkR3j5lszHW6BqFR+ZtmXxbwnqpwHvvbBIH+u1jstkDiys6f9zT3jQ1gWx6RJOBtJhMXmwVi0P60sQXZr35Ge8fFGvP+QShz2VT7iSgFdzyNwqdeB5Yuyw/eXZUwUcfg/x0ZXDEk3yxMeMHCSplu5al6VsJ67UPk/N44LwXsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186456; c=relaxed/simple;
	bh=WQvcmcR5yHifzr47skJIiXUoYESrckFNFBxiMIM1XOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDzNZRNTLkYpAoPhcB13bfQK1Z9Qss+oi77JPh06BjPkekaDTuWy+8dZk1YKqBsCxHYzo+cDb4HR/9cPW+BTDyWOTxRX8X0/Rcltr6r/FS9Z8G921C86GxqGhRZQYi1cU+LUD+o7SKX+KPa67y938tuE1FDYjBvgKmjNEcNgv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=YKSD0XDW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186450;
	bh=WQvcmcR5yHifzr47skJIiXUoYESrckFNFBxiMIM1XOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKSD0XDWkz9KtUopWJduguUJYINY8NMSoJxMDqyj5Zwdls6VBbqNCTxscU9eDRq1w
	 dRAX2bzRApz5urmXnM49bxnR8jIT+/Jd3Oz0dCT4N3+8US+jkIWObgP+Uxs3+3opOH
	 w9W5SXaeKdfl1OfJQ/SE+b1vKVVqcu5MWtfE36YHb3VsrkDbZLsWiiIf7RxzdOzA0a
	 rYEPgoOeK7Yg8732Ld3xZixsHxWtxJ1LVZns+SmTdzynYkgavpMz3bMT2cJ88TCXP+
	 jjHO4lT6YVWkWRGLclw7g3MfZOorimvax/8LQ4OQWJ+Ld9D0RHjskyV3E9JmPq7J2o
	 kOuJ7wFysBpaA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 70BDA6007A;
	Fri,  5 Jul 2024 13:34:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D7CF1204863; Fri, 05 Jul 2024 13:33:50 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 06/10] flow_dissector: set encapsulated control flags from tun_flags
Date: Fri,  5 Jul 2024 13:33:42 +0000
Message-ID: <20240705133348.728901-7-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705133348.728901-1-ast@fiberby.net>
References: <20240705133348.728901-1-ast@fiberby.net>
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


