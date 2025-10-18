Return-Path: <netdev+bounces-230679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B00BED260
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311844E67D3
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FA225A39;
	Sat, 18 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QWkqATuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB0225397
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800685; cv=none; b=O+q3ASPwzEHiGNXOhH6w4InQ32Rx9cm+jBa+P3dkv8vqFGNYkJM+MvMVgnkxQ4uSKE1YBvFeESpZ9QhOZyV63Cocf2+wkgEfFNDBZCQSQ0sELwuWJI/c7LmjJCSJySiJHF3UeWctVMYFb8nPWd0qXbZT2qzn8ENMaaBOZDUZFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800685; c=relaxed/simple;
	bh=UeRLzxSTtKouZ2KsT3hkb4b+OwXStm7lt7fTIc9MGFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uETr1nrVXGcuZjnHcPoRljbHQIejF+33ZRtvlhirSzGri+8KJz+34DdLs9f56PlP8U3eF9fhd5uRKtmjbCL6WOa0sU0cEQszuUzIMfS3fulojQhY57kRy1Go80uHV4Lmy7w5XD7uibPen3VnHB3IjIO9ivEzPiGtNXeg6FxCw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QWkqATuf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3ee18913c0so527877366b.3
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800681; x=1761405481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrN3fMwOLPZu29auA7WsZPkfHarxsXcDGhOuMV9Gxus=;
        b=QWkqATufxIHXa1hbeOx6EwVjxa0ilIhis5E5PNAANAIImKTQ3orQy2RLBKaoqYqPcq
         mpMEMvrUWlnNNKAmb5wETkGfhZ230Zu8/6Yzl3fmhDZEXW6wAvzXLWOC6kFs6Or2OF53
         iDKIhkAbvROwYWBdLRr8rJoxFsz7NiCTzy4x3yHD/TGCieCjmvCh6N84/HGcp2NFFxKT
         QK9ZcZPH400TjZSNZEkcLRUuQL+ydM2vfQYghummz6EbNO473f1jCl+5PNOS4/xWuGxO
         5Uzc1UXJe7AGhUg6oDws3cEoAH6dO80jjS3rsH84gMoqqaNWHaLDpHbrBjw4tZUIi1to
         ltYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800681; x=1761405481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrN3fMwOLPZu29auA7WsZPkfHarxsXcDGhOuMV9Gxus=;
        b=nv7Omj3b667tQnp9kDLHuZrDkbCKlfBUVOOnjmqH9DLK5gt7lpAxPbfoG/WkE5+Cu9
         w7tG2EXrKyzHIT3WrlJ7quW+65wmf/w8wfNd12tVaTH5dL/4F+ua0EWwRC3m8FCLfIEV
         fJUBH+4TzjBMKEHK228MQtobN8lli7i//bYhk95ZLs+jQCeWcR5mTVPaeZ8dpNAXWh6k
         qHXuS3UOfHx6HGuOQGtgU5V87UFFrtgJquO1ZlgKwkX4PFdmjG54vRaeVdQApO1kwneA
         faFtdhP1u8X+pQLsOrFaRFbqTa4WxBlnvHLRsAfF373pFdRaxVmqWjfGimfkbVyO7dRH
         36eg==
X-Forwarded-Encrypted: i=1; AJvYcCUbQpEpDsCUGoT7e/4nEwHGv1avZUYZP7MbwUWA/UdEbYBqsE1gT/iLim8n3jrptk+eV3VCjLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIB8AravhppH5c80usQXcLvskdXdk1+GU+wn2YKCkiVF3X5tb9
	zWEgrmvCerAJbta6hDfprr+yH7/DMLC2lWdlw+8Pw+GhuYioL45MA96t
X-Gm-Gg: ASbGnctpeIu72LcvS/CO7B9gqnKEsdIEYtvXzbJiTlTy8DQA+7tcSL9oDhEesVf3xC2
	XI+2wbOEJJ2u8LiD7lfqtON/x1EwzT+3iQvWyqmB16EF2/JKvFXE2N+jwVP9wXnpHhNAZC7dZ9h
	5dsfdC2yoj7lCgbzY6WYyAqVuUnTvEa41YBNEFc03a7LgP3qE33QC3quZZKGVTffzSNQwT2yOR1
	n/8KWJ2Yln1AbSY1ogwc0LW7AlNCgkcfV09RyVmzfPK8IAZN6nCG11AUxDim/a4Mjm3bP+63B54
	Db4vC2zj4OxTxpYMtv+lOw7WfbUs+jBy+fLQiHBA7GBDrToaiEkOrwIR1mfOVoVrYbHsIQfOEZD
	Ppq7IyVE47Cq6Roxl78S48FHCJEWhWWmarzAo2jWLkGqxE1lHy9v1vmSvkr0drWgfihOEVbkaoX
	MuOsbN8n9vb11R8y914s9GSSNlsYNqJbSH0DQFg0m/TV6OE3HQlQwm19HT81vZtPdHeQWw//Xnn
	g==
X-Google-Smtp-Source: AGHT+IE0GjjqomwD9ou8fGZFtmJFWtZFMZxl/gZzYCOgNQM91Qb7zfcpfiyOckxUCtZmVWiY1V/tyw==
X-Received: by 2002:a17:907:1c85:b0:b3e:5f20:888d with SMTP id a640c23a62f3a-b647304516amr947340466b.27.1760800680470;
        Sat, 18 Oct 2025 08:18:00 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:00 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 1/4] ynl: samples: add tc filter add example
Date: Sat, 18 Oct 2025 17:17:34 +0200
Message-ID: <20251018151737.365485-2-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple tool that demonstrates adding a flower filter with two
VLAN push actions. This example can be invoked as:

  # ./tools/samples/tc-filter-add p2

  # tc -j -p filter show dev p2 ingress pref 2211

	[ {
		"protocol": "802.1Q",
		"kind": "flower",
		"chain": 0
	    },{
		"protocol": "802.1Q",
		"kind": "flower",
		"chain": 0,
		"options": {
		    "handle": 1,
		    "keys": {
			"num_of_vlans": 3,
			"vlan_id": 255,
			"vlan_prio": 5
		    },
		    "not_in_hw": true,
		    "actions": [ {
			    "order": 1,
			    "kind": "vlan",
			    "vlan_action": "push",
			    "id": 255,
			    "control_action": {
				"type": "pass"
			    },
			    "index": 5,
			    "ref": 1,
			    "bind": 1
			},{
			    "order": 2,
			    "kind": "vlan",
			    "vlan_action": "push",
			    "id": 555,
			    "control_action": {
				"type": "pass"
			    },
			    "index": 6,
			    "ref": 1,
			    "bind": 1
			} ]
		}
	    } ]

This shows the filter with two VLAN push actions, verifying that tc action
attributes are handled correctly.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/Makefile.deps           |  1 +
 tools/net/ynl/samples/.gitignore      |  1 +
 tools/net/ynl/samples/tc-filter-add.c | 92 +++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 865fd2e8519e..96c390af060e 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -47,4 +47,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
+CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 7f5fca7682d7..05087ee323ba 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -7,3 +7,4 @@ rt-addr
 rt-link
 rt-route
 tc
+tc-filter-add
diff --git a/tools/net/ynl/samples/tc-filter-add.c b/tools/net/ynl/samples/tc-filter-add.c
new file mode 100644
index 000000000000..b9c6f30f2a30
--- /dev/null
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <arpa/inet.h>
+#include <linux/pkt_sched.h>
+#include <linux/tc_act/tc_vlan.h>
+#include <linux/tc_act/tc_gact.h>
+#include <net/if.h>
+
+#include <ynl.h>
+
+#include "tc-user.h"
+
+int main(int argc, char **argv)
+{
+	struct tc_newtfilter_req *req;
+	struct tc_act_attrs *acts;
+	struct tc_vlan p = {
+		.v_action = TCA_VLAN_ACT_PUSH
+	};
+	__u16 flags = NLM_F_EXCL | NLM_F_CREATE;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ifi;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <interface_name>\n", argv[0]);
+		return 1;
+	}
+	ifi = if_nametoindex(argv[1]);
+	if (!ifi) {
+		perror("if_nametoindex");
+		return 1;
+	}
+
+	ys = ynl_sock_create(&ynl_tc_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = tc_newtfilter_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_newtfilter_req_alloc failed\n");
+		goto err_destroy;
+	}
+	memset(req, 0, sizeof(*req));
+
+	acts = tc_act_attrs_alloc(2);
+	if (!acts) {
+		fprintf(stderr, "tc_act_attrs_alloc\n");
+		goto err_act;
+	}
+	memset(acts, 0, sizeof(*acts));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE((2211 << 16), htons(0x8100));
+	req->chain = 0;
+
+	tc_newtfilter_req_set_nlflags(req, flags);
+	tc_newtfilter_req_set_kind(req, "flower");
+	tc_newtfilter_req_set_options_flower_key_vlan_id(req, 255);
+	tc_newtfilter_req_set_options_flower_key_vlan_prio(req, 5);
+	tc_newtfilter_req_set_options_flower_key_num_of_vlans(req, 3);
+
+	__tc_newtfilter_req_set_options_flower_act(req, acts, 2);
+
+	tc_act_attrs_set_kind(&acts[0], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[0], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[0], 255);
+	tc_act_attrs_set_kind(&acts[1], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[1], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[1], 555);
+
+	tc_newtfilter_req_set_options_flower_flags(req, 0);
+	tc_newtfilter_req_set_options_flower_key_eth_type(req, htons(0x8100));
+
+	if (tc_newtfilter(ys, req))
+		fprintf(stderr, "YNL: %s\n", ys->err.msg);
+
+	tc_newtfilter_req_free(req);
+	ynl_sock_destroy(ys);
+	return 0;
+
+err_act:
+	tc_newtfilter_req_free(req);
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.51.0


