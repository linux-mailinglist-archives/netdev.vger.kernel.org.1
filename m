Return-Path: <netdev+bounces-109496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0F9289CA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5891C20CB4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979A155327;
	Fri,  5 Jul 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bCOm/ar/"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5A14B945;
	Fri,  5 Jul 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186457; cv=none; b=FCaLpu4awmkMbPxi4LPJ5Skf+g4rGLx2dMnYZT4AXwYaTfOcPe39kWgjYpvWJBv4UJaCBTASENfym5+KLAU/YRpFy4Na7ppqxkYysrd+nviilZxZJW06AF6M6/wU6/KpOwl2bwoNcbp8mxWLa81jfUsVQf18fEkEStVjes7Cm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186457; c=relaxed/simple;
	bh=LOODhtsR95I0F9IFBdCOwy9wo67VLpNk6PUcw7BPFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mplCAAHV9SvdU6d6/4DLsB0opFPLcoenJapvmdEwkYJDdgp+HePpu5ykjWOhIrcLldBAir0w9H5/kPU5nCl0Wosh/1dnvv4gFWKtEmvWAHmP+3oBzxttTmyB2+86BMk9P/Fv2OaUSwF48sibEYJBI55wByGKBLLrWKbRw+1hYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bCOm/ar/; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=LOODhtsR95I0F9IFBdCOwy9wo67VLpNk6PUcw7BPFec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCOm/ar/t4aSUKwRU0s/xaRlTwC/j1ZCpCMFGfsYHCCM2C6FdF1J9SM0rRarLPPRP
	 q8FWt+KaevVkiO9Eo6UIqvvn78YyYKvIRRTrKlmpw6IurrrJ8tjElhG7i8baDYSddO
	 8wBV0D+HA8IMrH7gxkrir5RrD4p8JgSuv5OBcLZ3vqfY9cebv2Em7xo8bDrLqTVyNV
	 rbpTYLRkKtdbLae28zBR3CYEX1zrAYvVIB2oqwbyCf/cbSRQCqKaAHGUOqieRNqid4
	 OdxFc3TwyaVUwpxpNOqQhim5h6wtO1KmEzfq0VBIjFo92ewqh7gQ8/xjE4W5ocakzK
	 KWhhUvAuQneuQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E69CB60085;
	Fri,  5 Jul 2024 13:34:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 2B8EE204766; Fri, 05 Jul 2024 13:33:50 +0000 (UTC)
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
Subject: [PATCH net-next v2 02/10] net/sched: flower: define new tunnel flags
Date: Fri,  5 Jul 2024 13:33:38 +0000
Message-ID: <20240705133348.728901-3-ast@fiberby.net>
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

Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
flow_dissector_key_control, covering the same flags as
currently exposed through TCA_FLOWER_KEY_ENC_FLAGS.

Put the new flags under FLOW_DIS_F_*. The idea is that we can
later, move the existing flags under FLOW_DIS_F_* as well.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_dissector.h | 7 ++++++-
 include/uapi/linux/pkt_cls.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index c3fce070b9129..460ea65b9e592 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -17,7 +17,8 @@ struct sk_buff;
  * struct flow_dissector_key_control:
  * @thoff:     Transport header offset
  * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
- * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
+ * @flags:     Key flags.
+ *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAG|ENCAPSULATION|F_*)
  */
 struct flow_dissector_key_control {
 	u16	thoff;
@@ -31,6 +32,10 @@ struct flow_dissector_key_control {
 enum flow_dissector_ctrl_flags {
 	FLOW_DIS_IS_FRAGMENT		= TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT,
 	FLOW_DIS_FIRST_FRAG		= TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
+	FLOW_DIS_F_TUNNEL_CSUM		= TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+	FLOW_DIS_F_TUNNEL_DONT_FRAGMENT	= TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+	FLOW_DIS_F_TUNNEL_OAM		= TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM,
+	FLOW_DIS_F_TUNNEL_CRIT_OPT	= TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
 
 	/* These flags are internal to the kernel */
 	FLOW_DIS_ENCAPSULATION		= (TCA_FLOWER_KEY_FLAGS_MAX << 1),
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 12db276f0c11e..3dc4388e944cb 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,10 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 2),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 5),
 	__TCA_FLOWER_KEY_FLAGS_MAX,
 };
 
-- 
2.45.2


