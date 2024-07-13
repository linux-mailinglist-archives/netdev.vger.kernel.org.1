Return-Path: <netdev+bounces-111193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D9930345
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECE6283688
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442149633;
	Sat, 13 Jul 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="vOoh7bcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB820328;
	Sat, 13 Jul 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837168; cv=none; b=aIaSim0aspQH2rTl5XI3hn/NpieB1suvq6aP/YDtlS0TnobfgUPAfa3XzptxQquNSDNTwD7ci5aq+8r+S5wUvLchhhVYwbrmn3jiX6+5u/ys0KC62YYJMat41U6pOg4fB/RF2uGAa9REw4gjOLiMOF5ylkWNLEYvLUzflUSHXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837168; c=relaxed/simple;
	bh=0oXrAqaLRc8r6eOka7Lu+JeTrPM0sGdE1nkvpFvZ/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+lxui3SlKayK6ZLKLTPCiJTaaBuopjdEguwLFdkIZE5BnaDELuH/iwbZ/dxOAcot95agQQOBW0U0xI67DAdvHow5Bk2BIbtYyTlS7lNDnttvnLbinWDlMcV4jmfQioj9C1JlNVtGCQ5gHxAS8f3ntMD18l/0+WSjFiDD/HgUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=vOoh7bcm; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=0oXrAqaLRc8r6eOka7Lu+JeTrPM0sGdE1nkvpFvZ/sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOoh7bcmOPBD5sLTcB31op2YXem+ovjzeeNcyFxEAV6LobUNvFjpbA5FDVCwVES/E
	 oFpp1Y0Dv3dRxn/gi8i1B5w+yuwAs3OIRf+/Tkfd+36WvUHPyQ0jAowXgOt6LKmIiW
	 3waI69Zbw6oylxutxXpqSEFsseh0I/fMxjXeqnwmhpH370QBEOWhpXMSh+MNUsKmJJ
	 jAs04peNg0Q5iQzK1AXie+SQXji0iQJhx4OPkx4Q4QcP9CyCx9eGiZeOzqIaN/RnZw
	 mhbcL4tOt7ttjssm45vk1pZV1TMACRlvxJNh4FqrSGHt2IUNU8JBoFchbYbIaHqEFv
	 YxUzAZ8NDU6hg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 632CB6008D;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3CC99204A30; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
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
Subject: [PATCH net-next v4 08/13] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
Date: Sat, 13 Jul 2024 02:19:05 +0000
Message-ID: <20240713021911.1631517-9-ast@fiberby.net>
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

Prepare to set and dump the tunnel flags.

This code won't see any of these flags yet, as these flags
aren't allowed by the NLA_POLICY_MASK, and the functions
doesn't get called with encap set to true yet.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/cls_flower.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index fc9a9a0b4897c..2a440f11fe1fa 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1204,6 +1204,21 @@ static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
 			TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
 			FLOW_DIS_FIRST_FRAG);
 
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+			FLOW_DIS_F_TUNNEL_CSUM);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+			FLOW_DIS_F_TUNNEL_DONT_FRAGMENT);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOW_DIS_F_TUNNEL_OAM);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
+			FLOW_DIS_F_TUNNEL_CRIT_OPT);
+
 	return 0;
 }
 
@@ -3127,6 +3142,21 @@ static int fl_dump_key_flags(struct sk_buff *skb, bool encap,
 			TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
 			FLOW_DIS_FIRST_FRAG);
 
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+			FLOW_DIS_F_TUNNEL_CSUM);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+			FLOW_DIS_F_TUNNEL_DONT_FRAGMENT);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOW_DIS_F_TUNNEL_OAM);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
+			FLOW_DIS_F_TUNNEL_CRIT_OPT);
+
 	_key = cpu_to_be32(key);
 	_mask = cpu_to_be32(mask);
 
-- 
2.45.2


