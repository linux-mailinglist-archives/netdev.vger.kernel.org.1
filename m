Return-Path: <netdev+bounces-251789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIpECiWBcGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:32:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B798B52D99
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280E64E7F6F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AD466B4A;
	Wed, 21 Jan 2026 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma9br3DJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A964611CC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980758; cv=none; b=k7dhLhT2egIH3SKtPiaAYpQVkoUg9OyrZR3NO4jOtrmvlMaoymn67mDnOT5qZg/1pLKrTNNfn6mJiBAqpi5hwbRdcT5iPKTCFjO6ReP2J0ku1BQJw+x3+/7ZH8OGUwLvbQTmQHgmONYNq9/uchKEjfNKknoKhcNf7RaAMBKhutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980758; c=relaxed/simple;
	bh=K8RrU+Wb8YJxZojVdorLJF0hxxkJ9QnqfN5f0fhKlww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syIAQt9e6ek67OzTP9C2BUvOhSxvvZhY3XbVnjfKOVIpPN+P+seLaGYS4l472jmPTBkbGENMQsS5cr3JtnZo2yBOxUehH1lqViaEtOImqRnCJBwCLcTZOsb+4fipPmt9dKnCoRPOHQ7ALsFCCmMurzu1p9Nvzious10NiGfxlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma9br3DJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f3c14027cso326666b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768980747; x=1769585547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OgknG98lYGQ4DDCgWzz5ngQeI/Q8MCK+R+spum1Ndw=;
        b=Ma9br3DJu0Nm987BTQnGEqDvhcFwkxxY5uS3EW/5jeW4bzZGqqxyEvVCStxK9tXtxR
         w+CsyJG9I1ujhLlJ6ZdQnnf/RWkSSUTMksWMZ6vtGRDuoOFSQq3ufkJR2kbe5i1a7+Sj
         ue/ZixGNiqKb2sTmc5PcmlTuVXdrioeTPoAZT4+VRllAsxOfQpFe+9DE4w7rVGmOTZvq
         TKHt9CMHs2q5XReZ7trmglss95cIl477bcrClMCK33jf0Zlk58Iv7qB8xk3UxgWv2Okv
         p2QOQzqwqKr0TVlTYFdb5acKqTseEHTCIvihVnpytvfX1AWaBio81UzwXBJ5+AHqmdCU
         bdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980747; x=1769585547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OgknG98lYGQ4DDCgWzz5ngQeI/Q8MCK+R+spum1Ndw=;
        b=FcY4akqs4t0rs6rRqkwuFD5X5fsO/H67hO1UsgX6+HD0ni5i12F2kz5sshk3qoP9M7
         vhnyQ4D0GsfUuZNWwTFnhlvDml7KDdtcsp4/I16gMZnRWBAnCH4sC3sFQ1dtTSsQcTW9
         XonJH9lYmnUOLJ+q6sDUTf9+fGoSgvIYXFZMKEhMJ1VEFC+ODKsTpc3l5h0NetpHZPoJ
         ztO89fxkJWRKhXjW2Tte9hekrjVvtEWpVrVi3ri9OnfLe4ZApWSaGz0NQnuj7DHy+QjR
         IghTi+A7irT+6psXwva0v2jeFD6b1IbUIausjmvDzxjbP8tOZG2pRK4cuhepMDw0BRSx
         2SMw==
X-Gm-Message-State: AOJu0YwD5rVWG3CTE3ZLWkloGiwL7NYX9sE2zg67bCbvG4ISzZPfqLKx
	wqr+GFEsWpYtEtRuD8FhObcr3lsVCfgAeUES6PoNDGNope3WPv0BHuP1LuDIOQ==
X-Gm-Gg: AZuq6aI1VbsODA/bytonbTEO8PN5MIhLMRlK1xdsG7r52FBT+jArZyySqR9T+NoU+GY
	39MwMDXw1dEMRGlTPqwrXBUqye1zeWbE+THlKEdJ9vgbRtr25e3CrEzAk0BQSRKDF76XKpDFr7Q
	lVLDPEHiiY5LAnUQuShiUzF+X+J/tSFKUQXgIE7dc2GHOD9ZkJAU7eePVrODdU/MzCSszRUUQ4Q
	qVZlwzQM/svE4BpHqcibOucbYADOX3Qd4GknDIJSaWAltH3v6JakFw2ehVvIbuPQI3+9P96UwsL
	kmMzPlM/cG2fruUoUYGFGmZtGDF8fv7bn7fkH4tFuvoUZYU4JMlD0khkC9sSdNvb4x0drpCsf0Q
	+zyqhXLPk/c47up+bkk2ItSt47WxwtVbNA7AdzVdFMx2o7O8UpY6+q9k2f9+EJ92pttB16+eXnz
	o3X7dkq73IlEBUEraJZd20q71wmizzLdgQOeQwpshJ/0MmQbD4BMCaGQ==
X-Received: by 2002:a05:6a00:b45:b0:81d:8872:941 with SMTP id d2e1a72fcca58-81f8f151963mr17850434b3a.26.1768980746781;
        Tue, 20 Jan 2026 23:32:26 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108c51dsm14125283b3a.14.2026.01.20.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:32:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	wangchuanlei <wangchuanlei@inspur.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
Date: Wed, 21 Jan 2026 15:29:26 +0800
Message-ID: <20260121072932.2360971-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251789-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,inspur.com,openvswitch.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B798B52D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ovs_vport_get_upcall_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics are already accumulated
by u64_stats_inc(). Fix this by reading them into temporary variables
first.

Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v1: https://lore.kernel.org/r/20260119181339.1847451-1-mmyangfl@gmail.com
  - use u64 instead of __u64
 net/openvswitch/vport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 6bbbc16ab778..f0ce8ce1dce0 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -310,22 +310,23 @@ void ovs_vport_get_stats(struct vport *vport, struct ovs_vport_stats *stats)
  */
 int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 {
+	u64 tx_success = 0, tx_fail = 0;
 	struct nlattr *nla;
 	int i;
 
-	__u64 tx_success = 0;
-	__u64 tx_fail = 0;
-
 	for_each_possible_cpu(i) {
 		const struct vport_upcall_stats_percpu *stats;
+		u64 n_success, n_fail;
 		unsigned int start;
 
 		stats = per_cpu_ptr(vport->upcall_stats, i);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			tx_success += u64_stats_read(&stats->n_success);
-			tx_fail += u64_stats_read(&stats->n_fail);
+			n_success = u64_stats_read(&stats->n_success);
+			n_fail = u64_stats_read(&stats->n_fail);
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
+		tx_success += n_success;
+		tx_fail += n_fail;
 	}
 
 	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_UPCALL_STATS);
-- 
2.51.0


