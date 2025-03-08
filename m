Return-Path: <netdev+bounces-173191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA50A57C99
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3864C16D1D3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB51A8403;
	Sat,  8 Mar 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nosDHBm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAA2A8C1
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457147; cv=none; b=bfK68IM2Jo8cLD7LOaWv54Kns1UzB3ljFv77FHuFvdOdUB0xq0Tav6wRH2wphMaps/Lg5I2+u8lEVmpb2J8yKNid1PyqeyjzmC7NYzA/dTlHfv5SxfoPxb9pPslMKsMe5YPeXInuJozEqrJW6uaQKxzNq6zARMEkt8GFXDTfHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457147; c=relaxed/simple;
	bh=Uuhfy5QH6UXAKMCIOkltOl6ViUx163iJRQn7ipMgb34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDzkum3DE593ear30h/YJs0C6rkaUGZjE44hG2hKAgoMkW0K32Qjc11uadKQH3NSUEREINviYRg3wIfVokZZhVKGLd31aYP/yNKrHrAwlwcQMxPHB/tPl7x/08sTeXq+rB01KQQCqsHUxQYMXYwBJTq1aMeVrZbmhFbRnC3/J8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nosDHBm7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c2303a56d6so334743385a.3
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741457144; x=1742061944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYgIXRvfEDGWKUHb7UP2pmkB9dFTGhBswExBKtuosS8=;
        b=nosDHBm7q0JNCERGiOiMxFGMIIadkoUZ3h1H18yWIAJMMRLOke0NMh2/43FQXwOdvg
         ftRY9o2HCf3CZa1eMEvrlwaP4nOC0/SnOV5K47/vWAeKi8WXv7yjIeuvnlmvPqcClnSW
         lItfFIhzuZuIqiZOl74WmUygCHeGszwpPtMqPHeuPf4eedaRVfNxupbghv/35z15NmYG
         Xnm27oCy4/ly/lYaPp+9oyA26Zao2M6e4UQtLNpg8fhUi/kWaDnPMmGMi1h23yAcE2uW
         N3y290IhoJWFPLPE01OsnTUIdc+q3dbTfuXRAi39GBalCLOOZCelD3boG5Mo9HujFQNg
         S2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457144; x=1742061944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYgIXRvfEDGWKUHb7UP2pmkB9dFTGhBswExBKtuosS8=;
        b=NylJ/TmOG1Gw7oMbO+gAmO17guC1b6nRKo1leo96xKdNm4PniJjtY2cw3VFrCk5K2D
         4W+LmKbcQDLGEkKhEtvf2TlaQRK4xR9Jnf2v/0ZwgE8B1q9/GNpA5nnTMhxOpiBnOaPn
         k7rW4RlhBy4pOf9865c+PC4xqDshnfvIAPrug+03zsDsSXrb+Qx7uUbaiX/zA+fFXaaj
         /nVzE7J2NwG+ZjFf55NoOcdVGE5ZnSVn8cjdmRJBVou+5Wqz8SNAtXpKQ3hXnQFmqAq1
         cwdWixAAsgJA4MqvD+T15aXgnD229ole5Mg0++7CwHQ7u2haUFh2aulWkdr8Gv7mfFf7
         /xpA==
X-Gm-Message-State: AOJu0YwC5ubjEsJD24dFt2f6kI1IYbTnvlnrxA11DUQH9l4sfCDbDNIt
	w/79jxkjAnBubes7S7rW4+DX1Nkey8ikwbjWW1D7aYlV0Ez+VRnvBLqM1A==
X-Gm-Gg: ASbGncvQpepULeQ+i1t/bo9XQUdeBP1xQ040IrUw53KuzTs+K8TrvFMZLejlFvJAPlP
	QkPK4XROsv2ZNvnjP1XALf8Gmp2hV/j30ngSi89zPMAWwwYTmCnptJmn+biikQkKWdC3oReA8VR
	lfr3Kzsf5i41n3WXgEogMHhbCCas27gy7PHc/O/IcK4ZwTXY4fe5OCPf6qRgmddFyPxMMxiDqER
	ZZkxMGJk8hE0xw2oOiwJ+kyKGy2vbdhGzI70zTY/APBfYw/GqBSvrTOL9bbYEXbKsxaAZnvWdz1
	gDtilX/3+uJeTbHNkJbIO/EstuP1eMpVrZy23WFb6LOG4UUGSp4oyRhvsJ77Eui6+yHUyrfudIT
	s4Cq3p+Xm
X-Google-Smtp-Source: AGHT+IHBKkiUfMTMDqQJTgLijZD6dZ4lfV/YlmRwAwh3Sx/hipPGEfP7LIqXBxHqt9aV+jy1oZVJ0g==
X-Received: by 2002:a05:620a:8904:b0:7c5:48bc:8c7d with SMTP id af79cd13be357-7c548bc8f29mr233221085a.36.1741457144393;
        Sat, 08 Mar 2025 10:05:44 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e54ff935sm399857585a.89.2025.03.08.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 10:05:44 -0800 (PST)
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
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] Revert "openvswitch: switch to per-action label counting in conntrack"
Date: Sat,  8 Mar 2025 13:05:43 -0500
Message-ID: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, ovs_ct_set_labels() is only called for confirmed conntrack
entries (ct) within ovs_ct_commit(). However, if the conntrack entry
does not have the labels_ext extension, attempting to allocate it in
ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
nf_ct_ext_add():

  WARN_ON(nf_ct_is_confirmed(ct));

This happens when the conntrack entry is created externally before OVS
increments net->ct.labels_used. The issue has become more likely since
commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
in conntrack"), which changed to use per-action label counting and
increment net->ct.labels_used when a flow with ct action is added.

Since there’s no straightforward way to fully resolve this issue at the
moment, this reverts the commit to avoid breaking existing use cases.

Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
Reported-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/openvswitch/conntrack.c | 30 ++++++++++++++++++------------
 net/openvswitch/datapath.h  |  3 +++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3bb4810234aa..e573e9221302 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1368,8 +1368,11 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
 	    attr == OVS_KEY_ATTR_CT_MARK)
 		return true;
 	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
-	    attr == OVS_KEY_ATTR_CT_LABELS)
-		return true;
+	    attr == OVS_KEY_ATTR_CT_LABELS) {
+		struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
+
+		return ovs_net->xt_label;
+	}
 
 	return false;
 }
@@ -1378,7 +1381,6 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 		       const struct sw_flow_key *key,
 		       struct sw_flow_actions **sfa,  bool log)
 {
-	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
 	struct ovs_conntrack_info ct_info;
 	const char *helper = NULL;
 	u16 family;
@@ -1407,12 +1409,6 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 		return -ENOMEM;
 	}
 
-	if (nf_connlabels_get(net, n_bits - 1)) {
-		nf_ct_tmpl_free(ct_info.ct);
-		OVS_NLERR(log, "Failed to set connlabel length");
-		return -EOPNOTSUPP;
-	}
-
 	if (ct_info.timeout[0]) {
 		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
 				      ct_info.timeout))
@@ -1581,7 +1577,6 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 	if (ct_info->ct) {
 		if (ct_info->timeout[0])
 			nf_ct_destroy_timeout(ct_info->ct);
-		nf_connlabels_put(nf_ct_net(ct_info->ct));
 		nf_ct_tmpl_free(ct_info->ct);
 	}
 }
@@ -2006,9 +2001,17 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
 
 int ovs_ct_init(struct net *net)
 {
-#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
+	if (nf_connlabels_get(net, n_bits - 1)) {
+		ovs_net->xt_label = false;
+		OVS_NLERR(true, "Failed to set connlabel length");
+	} else {
+		ovs_net->xt_label = true;
+	}
+
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	return ovs_ct_limit_init(net, ovs_net);
 #else
 	return 0;
@@ -2017,9 +2020,12 @@ int ovs_ct_init(struct net *net)
 
 void ovs_ct_exit(struct net *net)
 {
-#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	ovs_ct_limit_exit(net, ovs_net);
 #endif
+
+	if (ovs_net->xt_label)
+		nf_connlabels_put(net);
 }
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 365b9bb7f546..9ca6231ea647 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -160,6 +160,9 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
+
+	/* Module reference for configuring conntrack. */
+	bool xt_label;
 };
 
 /**
-- 
2.47.1


