Return-Path: <netdev+bounces-108809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB6925A61
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311BB1F21B2B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD91194123;
	Wed,  3 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hKSBzmXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83B1891D3;
	Wed,  3 Jul 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003650; cv=none; b=YlSlte0EN0+qGlfBAyfAO2+r70m3tNkVqqwUuGHAJbgWQCDEO2A/OhMId1MekljMuM37TLRIdH4Lufqezlozpk8xzhsaO49dkj4RFeuL620Kivu3vie/ohmtCC+MQprLEz6VdgQ0yFNdJOX8kGIwWGw6puGuNVznmb4ta20diR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003650; c=relaxed/simple;
	bh=HEzDk260gZTEzAVb8XsblwCVREcXtrcbTyhdVlnuPoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf4PqU84cArwMcMzvrGF76EaPiO3nrnR68clIJtnIBHiAAqQ6P31xZhgK2NnmYEGssJF1x+AH76XEbEewLPhiKn+Jny8CxL3dZOzDBhEHsqCWiLnRpemvwPZQwlgo6I+Tt0h75bfvZIGxN+BnsLcvEa5SIWQoKVNYq4GUrQKtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hKSBzmXy; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003636;
	bh=HEzDk260gZTEzAVb8XsblwCVREcXtrcbTyhdVlnuPoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKSBzmXyYw1s7Eq65U2pjGRIa+jLyhJhxqW+in8Is8vsc+R9YYE9adlG+P2zH3qBo
	 K/VUyzJimXXcwd2ZY4A3P+oTpNn/RG352+djTlN7aJUnvZEiyvglEA0Z+hkmOVyerT
	 yl1qKJm76Qa68FQ+UHFQPgG3OZwLDsIZAIXCfzss5R6yJUNo3uXTnu31LYkQ5SaJ3o
	 kPq2mvyoSmGF8PDd2w6BDatUU01r0hHUkTaUvl6yVe2yxm7rIkp4aMn+OnxVs3lpaV
	 iXU9tphTIMFqxg3T0uDO3YPe3qXm89uSEDffffvQdN4FhUzBVEbIFOgTjvHiBHeTjX
	 isabespAloT5Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 297B960085;
	Wed,  3 Jul 2024 10:47:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id A8215204564; Wed, 03 Jul 2024 10:46:29 +0000 (UTC)
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
Subject: [PATCH net-next 5/9] flow_dissector: set encapsulated control flags from tun_flags
Date: Wed,  3 Jul 2024 10:45:54 +0000
Message-ID: <20240703104600.455125-6-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
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
---
 net/core/flow_dissector.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1614c6708ea7..a0263a4c5489 100644
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


