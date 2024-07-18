Return-Path: <netdev+bounces-111987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACE934608
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F11B2124D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224F1B86F1;
	Thu, 18 Jul 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbLlqrpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EE186A
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268619; cv=none; b=NMaRtQBGZZl98fjio4UP3e8trYYhLDz0okXIvh8M/FF8sJIy11yZDxYjiwXLze8XovQRugcOFC+XjkQBoKQ3ENHXEiykrWRXxxyin64eN/e8j1kekIh+FuhdKbJXSY8ySij7XSEyjwV5e9GZJB8TLIQ33849NGapoTUdwNxdUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268619; c=relaxed/simple;
	bh=bhRUiSYnZXoAUKdUlnk3UHcFX8A5f01bnWJPVEi+aq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5V7PEjNFesIJT9ihwgb94V9+AxUw1gz/OG84QcR9fQzTVulUIG0dZsa1HvLDjDWMap4+81MTCaQWi1RB6rtwyjs4kvnwRRAeFsMFd4QAmShp95OlB2o15rlGCrV6ruxW7qFjs4Ny8xIy0WjjokNTSFjyGfVB6sZychhg7DqERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbLlqrpy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4494d41090bso1495911cf.3
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 19:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721268617; x=1721873417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUVeC7uEabBIHrV8Zthpwwrh/3SAngLdiEUX16thuiU=;
        b=SbLlqrpyBeGHV9aU2prsgets76828E2qO558nJA0CoXIpMeMiH/vtvusMrkFW7ICh+
         hsLXwbzUKvKqAbJNoT25jIZkKMnSQHSCCdHk3t1fAuEDIIpTPvaFNNBKzSZN1R5THORt
         EC0BHc9nE/kd7PSY1PyKGLtr9vRzR9lBVSm9XU/ahgmUhcuX/6baT0XXJeVyPvggrBU6
         Q2/xMQo3v7ostREMFwdm3pLRFpxCXuY1nO39Lpvczs4H+nVRUWS6DNTQ9NsKkfG/Zngk
         aGNKQkQ3S7sNA1vHYN+/SrVReh1ZYIEZHauymM2yVMCeAkSG4+UJM7FoXBJKrWtS0HAK
         XCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721268617; x=1721873417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUVeC7uEabBIHrV8Zthpwwrh/3SAngLdiEUX16thuiU=;
        b=Bk9eDeZ0scwJYHEb8ULSgHetTbPAf/pfBqoGUuf9yVY/6kX+j3rTMuEe+28O/krnTh
         vWeSy7oP7q2/n0tVl0/lQ42Vdxltd7/RswDHNMdtFrMrW0y0TNCEncv9XocVujeeZeuT
         8Y8200C23ERwSAnz9YUQyThK8Tg2GERzt+R66YvWjB1Lub6bn8De30Tdyy6phgHMkXDA
         XLc5cPZp6XAjEG1dVUwI9DPpUW/ecghB0Fpcena6mW5617HjVGpzo4ANfALKgocjQVKy
         Viqj2Pae2VxjVyOtC/0wQjOn4c1mRcAEP8tHI3sEgekch6u2IMMsa39AxOTGxloymFhR
         /zGw==
X-Gm-Message-State: AOJu0YwBwD07RtYEwpFQhxXSj0KEn0/o83TDUly6+WvP8qst/lmaCza+
	iXDs5aV79n51GsVLaoCiMOOyc3CK49TFSG0sKVZQNMyQUqPGc4lwx2Otir7I
X-Google-Smtp-Source: AGHT+IF8753bPoowzXSJU4Co0P6CmGmDWHJE8KdpXiP4yq8lSfHC32MzVf/gsmy+0ym0ohn1/28FDg==
X-Received: by 2002:a05:622a:1482:b0:447:ea03:453e with SMTP id d75a77b69052e-44f86194c04mr34393231cf.20.1721268616763;
        Wed, 17 Jul 2024 19:10:16 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f9b4asm54980551cf.54.2024.07.17.19.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 19:10:16 -0700 (PDT)
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
Subject: [PATCH net-next] openvswitch: switch to per-action label counting in conntrack
Date: Wed, 17 Jul 2024 22:10:15 -0400
Message-ID: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
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
 net/openvswitch/conntrack.c | 28 +++++++++++-----------------
 net/openvswitch/datapath.h  |  3 ---
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 8eb1d644b741..2cc38faab682 100644
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
@@ -2026,7 +2023,4 @@ void ovs_ct_exit(struct net *net)
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
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


