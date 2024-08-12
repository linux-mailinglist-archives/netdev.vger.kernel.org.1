Return-Path: <netdev+bounces-117796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4967A94F5BC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D99A1C210F4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158518784F;
	Mon, 12 Aug 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUfn5mlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDC16D4DF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483077; cv=none; b=Z6an3DgRP2SF8H5JbFsnl4194vL7BG+QF66GiKQZ5UBe6x4r0JyWmRgZFWUFvzq0TZaHVF21GOTe4+dUzfPolBl+BxvuROL2GM3oTNDLrgTW95qTmLHOUmDC1+bkec2ku9yR7T58lmo4U3vmon4X8tPbo7Fz+ceOQmDka3lx0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483077; c=relaxed/simple;
	bh=VD9pVw3g4qeIhGkgRO8wH9PHeZe69I6fReE5cil8Q0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kc4e/I2WsvtZse9KyijMqaFfqbrSWgmh283SPLjD1IJzkKy/atpU4esuh55nTofm2trNo17ZIiwlWJvQsHFzDgSe7XqguTnF5ySXUYx6iIpX9EZq3ZNmJcx5aC2t5bkTokhbt2WYAiZ1HdrtDHJzCOTFiaR3UyCMvlCAiYa8a24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUfn5mlP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093705c708so4467425a34.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723483075; x=1724087875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1tTD4zyQSoNiv2tsnqpH5QUHzb4nJIdV/QAQHbYYqU=;
        b=EUfn5mlPlJe/fnvw9XYTqCvkWlReAMJUpqDZk9Q5f19o6lusikG9sCYtDSrQJEiO+U
         3EzgP8P7YTr/TSCbPB21fP4S3hde5fpurMpry5CuD+lUc/XIOCRqGdI+ghRB7v88f6//
         UHTiF5ovZ44tYpuy3CO3cmljvYY3XPf64OgPhF3DGXUcUBqFbzQOI6r5eDz+ieFvSFRP
         uompiu8+5uXKK6bYmY/FL3Pexxf1T4ybqsquotEmXWfkwXe+nunTIlV6DDo8QEsqDDeT
         z21LwmypuYsEBhEwhriHDPJ/amgjV85z1YMKNEAmVW57j57aH1q44yIZOnZd6AjhOBo0
         al0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723483075; x=1724087875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1tTD4zyQSoNiv2tsnqpH5QUHzb4nJIdV/QAQHbYYqU=;
        b=PChQdyal6LEtzfS2yDFL+ggnoTO0JYWYU8iU9k1m9ibx4PuhU29l5Be5aWFgV9SkC8
         mvfwV/jlwFdm3FyCu5E6FkbN8XegMaTurqw0AO/XlBCnwLsfLx9IdZ2daGhOtncYggKu
         G2sHwkFoK45X5M2/SQICkvYhrg2Wgwa9OOrGEsB62f5SrNgVXLbxfVglbXK5UmjxCT2M
         McCHAQFz/Wgmu6eIRlCQOkSaG8Vliez2qD9AuzqWVPjv62bsxxkIoO2esfu2ND4W/cwm
         utyMkNLwVFYEF7/EIjWjW5i3nzqIXBjbIPW9NRp+EbkqLyg4Yn8nsATvUq97/gaiJOUo
         2okw==
X-Gm-Message-State: AOJu0YyVOUjZlUYr43+fw1+tRtxEtT9vsB4GRkJ+v7U9KZyI/TyEYn7J
	ygGmk6PVzCAmS/wxrKl9Fhj7K/es2PW6u2gcMr0IbyJWRJahwAkPrqjWGw==
X-Google-Smtp-Source: AGHT+IHw7XsVsG6b2Vt/9qL9IZCMezbbNTK6eeS+FglWt3nv5WJl+MfRKz5Rg9jdp8fmRi/knmiiCA==
X-Received: by 2002:a05:6830:8d2:b0:709:3ea3:e2d1 with SMTP id 46e09a7af769-70c93948ce1mr1332028a34.27.1723483075214;
        Mon, 12 Aug 2024 10:17:55 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e2f51fsm26532696d6.76.2024.08.12.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:17:54 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	dev@openvswitch.org,
	ovs-dev@openvswitch.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCHv2 net-next] openvswitch: switch to per-action label counting in conntrack
Date: Mon, 12 Aug 2024 13:17:53 -0400
Message-ID: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
label counting"), we should also switch to per-action label counting
in openvswitch conntrack, as Florian suggested.

The difference is that nf_connlabels_get() is called unconditionally
when creating an ct action in ovs_ct_copy_action(). As with these
flows:

  table=0,ip,actions=ct(commit,table=1)
  table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)

it needs to make sure the label ext is created in the 1st flow before
the ct is committed in ovs_ct_commit(). Otherwise, the warning in
nf_ct_ext_add() when creating the label ext in the 2nd flow will
be triggered:

   WARN_ON(nf_ct_is_confirmed(ct));

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
---
 net/openvswitch/conntrack.c | 30 ++++++++++++------------------
 net/openvswitch/datapath.h  |  3 ---
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 8eb1d644b741..a3da5ee34f92 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
 	    attr == OVS_KEY_ATTR_CT_MARK)
 		return true;
 	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
-	    attr == OVS_KEY_ATTR_CT_LABELS) {
-		struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-
-		return ovs_net->xt_label;
-	}
+	    attr == OVS_KEY_ATTR_CT_LABELS)
+		return true;
 
 	return false;
 }
@@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 		       const struct sw_flow_key *key,
 		       struct sw_flow_actions **sfa,  bool log)
 {
+	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
 	struct ovs_conntrack_info ct_info;
 	const char *helper = NULL;
 	u16 family;
@@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 		return -ENOMEM;
 	}
 
+	if (nf_connlabels_get(net, n_bits - 1)) {
+		nf_ct_tmpl_free(ct_info.ct);
+		OVS_NLERR(log, "Failed to set connlabel length");
+		return -EOPNOTSUPP;
+	}
+
 	if (ct_info.timeout[0]) {
 		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
 				      ct_info.timeout))
@@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 	if (ct_info->ct) {
 		if (ct_info->timeout[0])
 			nf_ct_destroy_timeout(ct_info->ct);
+		nf_connlabels_put(nf_ct_net(ct_info->ct));
 		nf_ct_tmpl_free(ct_info->ct);
 	}
 }
@@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
 
 int ovs_ct_init(struct net *net)
 {
-	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
-	if (nf_connlabels_get(net, n_bits - 1)) {
-		ovs_net->xt_label = false;
-		OVS_NLERR(true, "Failed to set connlabel length");
-	} else {
-		ovs_net->xt_label = true;
-	}
-
-#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	return ovs_ct_limit_init(net, ovs_net);
 #else
 	return 0;
@@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
 
 void ovs_ct_exit(struct net *net)
 {
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
-#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	ovs_ct_limit_exit(net, ovs_net);
 #endif
-
-	if (ovs_net->xt_label)
-		nf_connlabels_put(net);
 }
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 9ca6231ea647..365b9bb7f546 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -160,9 +160,6 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
-
-	/* Module reference for configuring conntrack. */
-	bool xt_label;
 };
 
 /**
-- 
2.43.0


