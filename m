Return-Path: <netdev+bounces-171774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F12A4EBFB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30308E6016
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F729CB2A;
	Tue,  4 Mar 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML8tCO9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0E25EFA1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108511; cv=none; b=J92/UFBFec1TUh9zxrJSOt9ncjvRuHcrjoS3dtv5MTyPl1zZ6458kecsplCAhYVyFxjLqTQZZGtp2IKvkYSs4e5u9jhuUqnd9JWDp52T3V7aQFwd/Dsj6POhXt1Fz9OoLzIG85STk8JI2KTgmFHnnouAHWb1DaguyhZ2ZvBRmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108511; c=relaxed/simple;
	bh=FRGJgtODLKIa6y5uhDrtlfv6ygNIu+BarxE51kKOkhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7p6BrVcUtOpHykErmTFmn2UWlfbcw/OhcdHZGgFX+hLIq0tLOynbCWg1PMCObz/cgFsg6+23K2hfTaRNDpP1Bvmb3i8VZ5kiygsXrVWBeQKYVH5CqWHVW5xn+zt4tcty2OJ98LUC2pEhm08ce8E4Tw6FegnqMITZpljNLUmijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML8tCO9d; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8a8d6c38fso56710146d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108509; x=1741713309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyKVwYN3BbDjMx0ocjwFU79MtM8sT+naACzplnS8NRE=;
        b=ML8tCO9d5HYVT80/5gQb8mv2no8ViY3U4FuIQozpENNk/TK3X6wEHDCwDSReIEwAVJ
         fr5OddLuuIDBbwvbiZFhzSgGE2hrP8k9d20aIwjJs7Ft0Za6SZj6ysPyiVZmqTQyVScH
         pwU9fxBoLgHycpRQAkQazWuK8p4Yc5J6vJCxMlKm1Szw+qXve//qP6SZDfoRyTeAIxc8
         /7zmKdlTaBkT6r3SoPmVEU3sW6/w7Wt/TpxmxyzFXEmwJqkfagOw2Lm0DcyllG/Kqnsm
         JAEdHQiof2vxj9A0j7JHTUCC5M7GA+xKkCcwae8A3WMdi0cN2fVZiCca87h/xvAguCEe
         1Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108509; x=1741713309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyKVwYN3BbDjMx0ocjwFU79MtM8sT+naACzplnS8NRE=;
        b=s2+5gKzgfbfwSIDeVFADvVdgBf18t/bOqXge4opKrqQ28ExoaPsKbu8x2m+4CPJ1Y/
         RdDkKpoeiuaxEddAcWKJORu40yfKS6Qm8+wDWkTcxHxbT7UZoM7NQJx6tQUe6E5RGr+A
         79/Y3gEWefqy82+H+7rjOexPVwXpoTh4oTOLen/i78nmUOvh2h2ogsnNcBjHhAHIc92n
         jVW5fgf7aMspEwwchFdNESgt7azsBqEKhaf2LZDzN0NgygNIKdSJZVVdGRhdLXq8udwF
         OQpHYLP49LoLe5zWVymDI1G4a5f0uTUIyJeYV/0v56Qw3JvOsjjM8JwGqa2bTES0kJt6
         tEjQ==
X-Gm-Message-State: AOJu0Yx4Qho/IUfroZhmHvtXkhY25kiP9yjybkCJCl7XLpdS2ufg6vFb
	3L0EbMNvy/qJxhWkY+VFZ+qXiEhoE+JiMr5U75Aza4NLSwAY2xsBQoS6i0dp
X-Gm-Gg: ASbGncvEpMVc7yW/X31EqvZZfWT/vHjbEyWpDlv2QZdvtCAG1XMtBT2NlfL465mL1cu
	QG9azMjeEv5tv2Rw4AAUHziwnQJESOld4l9Qj2UdIC1A2QpTn92Iyr0hBYWgqAukI6Nk9OiRVAk
	8aopt/J8+08grxNFNhmVP3qYkMsW734qochi8NdM0tDR8xBnQdGnkjPQ/uljj/DsBn/+wcD4Sz0
	oIe6AFyfXqqNXMPR/fTHc3UsDSJvuEWBGWlzjQTQ4d907y1WpKGXK+ma8v36t4bZpx++joNFZfy
	1yZCwYDC9FuQl182GjALennxVuVdM3OjuDwPqqva4hq/smYzKlf43BZJV7ekYxy8WGR+pfPBBAF
	gu8n1dxuq
X-Google-Smtp-Source: AGHT+IH21KYlYJEdOmi/QBxB9500XuTsIV6c4gnHDn+uNV1PmAG3Wh0GcJ8Sens1Er6A34xpxtrLdg==
X-Received: by 2002:ad4:5cc5:0:b0:6e6:656f:3c34 with SMTP id 6a1803df08f44-6e8e6cd1c6emr1128096d6.12.1741108509061;
        Tue, 04 Mar 2025 09:15:09 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89766166esm68766396d6.61.2025.03.04.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:15:08 -0800 (PST)
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
Subject: [PATCH net] openvswitch: avoid allocating labels_ext in ovs_ct_set_labels
Date: Tue,  4 Mar 2025 12:15:08 -0500
Message-ID: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
entries (ct) within ovs_ct_commit(). However, if the conntrack entry
does not have the labels_ext extension, attempting to allocate it in
ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
nf_ct_ext_add():

  WARN_ON(nf_ct_is_confirmed(ct));

This happens when the conntrack entry is created externally before OVS
increases net->ct.labels_used. The issue has become more likely since
commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
in conntrack"), which switched to per-action label counting.

To prevent this warning, this patch modifies ovs_ct_set_labels() to
call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
it allocates the labels_ext if it does not exist, aligning its
behavior with tcf_ct_act_set_labels().

Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
Reported-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/openvswitch/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3bb4810234aa..f13fbab4c942 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, struct sw_flow_key *key,
 	struct nf_conn_labels *cl;
 	int err;
 
-	cl = ovs_ct_get_conn_labels(ct);
+	cl = nf_ct_labels_find(ct);
 	if (!cl)
 		return -ENOSPC;
 
-- 
2.47.1


