Return-Path: <netdev+bounces-102762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EB9047D6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4E31F23D96
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45294156F39;
	Tue, 11 Jun 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ikGFchdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E36156883;
	Tue, 11 Jun 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150068; cv=none; b=rrnBzi6fdawfmGEED+iSxQQIYB1+OhtNaMyu6OvTS+NJ/cTNflSY8WE+1VLC8obaM/+OqC8yTLQ14XZAvAinq4adh8ccQZBxtQY/NA/vkeCRqFEO35MPDJWDKrdJETEeca76+zQDnJxlQAM24wyLdAeHchHS7qsO/T4AsaXLnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150068; c=relaxed/simple;
	bh=uQ3bxVY+0T6qnIHKOOb0Ur6SpvSb5e5xHUZ/3GTatt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVeCWynK+Vthfktmit8eMPQw9ToeIE4SPQCqN9ARh2imC+Drz1iV0fpIROiqpCmfnSb0MPFgiE6dJQZeooVZ9bTzBL7w6sSAfK7Hgh+ej1a47jIUHk204ZKzoMY40rHA74zgks+u525gaS6ANAaQpVJMTgH9NdQBtcitFuvUgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ikGFchdz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150057;
	bh=uQ3bxVY+0T6qnIHKOOb0Ur6SpvSb5e5xHUZ/3GTatt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikGFchdz4a38gulfVPIs0gavYDQsF52n6fpopDkeVBG3GnGXy2GzQjmg8MtaPEi3T
	 KVCmVlyyfIVt0py69aDC87oXnrQfZklHEqBB1Xhx1EDKCsgTiNMBslbEFvpFVeuwnW
	 ccXX9vLYRYFz7nKW633s57R7gMuRdbCZbQMwFXIgxMUqhngoKMhoS/sq2uQDpjno6L
	 cV6HLZo8jig+wTLAbTXJk8kRlaJPYdEx7N/YN3um7zDQoiV8k5H2TZVnM1ab5TIXfX
	 vIhW+YG6ojcFLD1cQ7Akh84em4k5O2Pmclm5rH9osMuK1KdabYgVaYl1cOwiPM4dLo
	 Ug8rGlRFC7KDw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id AEF5560085;
	Tue, 11 Jun 2024 23:54:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8297A202FA5; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 5/9] flow_dissector: set encapsulated control flags from tun_flags
Date: Tue, 11 Jun 2024 23:53:38 +0000
Message-ID: <20240611235355.177667-6-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
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
index 86a11a01445ad..6e9bd4cecab66 100644
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
2.45.1


