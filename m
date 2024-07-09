Return-Path: <netdev+bounces-110366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E592C1D0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791FC1F21E15
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B351C0DF5;
	Tue,  9 Jul 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="nsBeW3fo"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98E1C0932;
	Tue,  9 Jul 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543125; cv=none; b=hP2wZ+AcAyAJTJQuiQ3ZQr3YTUAKcYIHR4W8/Hq3nYDnBn44KDVkvlBrL+Uhd/z9LQOKiszkwCWgcZqvPJAV4sAnH/mbuezSnQxPusCXMiNdYhzPBz0ShcHM4WfEUtXztTc4FwX8AShDd5lktENhhvpO1NpYpDsgffIoeLgWcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543125; c=relaxed/simple;
	bh=WQvcmcR5yHifzr47skJIiXUoYESrckFNFBxiMIM1XOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6gJcShRsUF4NX40euorZ/WCQ/jz6Y1g9tVyg4ApQ1q2SxJYHXMMBzI+n7YYP7WU8fX3wn6SSmaD4OJEKXOxP3DvVydhjtvl8cnm7GMV9tSUkb1jAxV+/uBecPN7+n7/G1UE3BRp5ElNllgwerpxHgXf91BeVB34Pfmknxlgfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=nsBeW3fo; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543112;
	bh=WQvcmcR5yHifzr47skJIiXUoYESrckFNFBxiMIM1XOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsBeW3foEeBNP5y94DydMgqXJFMp2yAGTM16wlBIQ29erth1p1ytPM3R0Aio0QIYu
	 0r5N50ClL/HjSOV/CPtpbnEzj6do8QCjSYeB2NWGp+RuZOBaTMUKl8fu5UMRIqC56S
	 uePogD3RHAmdxHpk/yAqHpdsEqQnb9TvYrt/s+9Ivrk8/XLvGEKj2Mw3S/3Vzxl2TA
	 bYgN5xBn2Sd3bjwp5HGN+RN9EjEKE84ThefCPov7n2s0UpeGaf/BEtqMW0lbrCK0+k
	 5NBiWl2VCCCWg58sdb284jIwbGOrjG68qN9hspsaLJ7Zjl/jFr6Cs8XLd0Ek7ebMOx
	 btPtBcxACjJZw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 04A7660089;
	Tue,  9 Jul 2024 16:38:32 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E309520499A; Tue, 09 Jul 2024 16:38:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 06/10] flow_dissector: set encapsulated control flags from tun_flags
Date: Tue,  9 Jul 2024 16:38:20 +0000
Message-ID: <20240709163825.1210046-7-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
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


