Return-Path: <netdev+bounces-240182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E17C710BD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id E823C296C2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CE35E55E;
	Wed, 19 Nov 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Gu2FtYR/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCA2E9EBB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584586; cv=none; b=UL5gERKAZeMoESyplUw6FcaxX0jlTyCM2ciOWa7q6JnPMHijzVTni4dIN7pxqYs6N6xKf6wXbCGsc4jfNoKKFNFYGQx5890q51lRuJ6TSlgXnJ8KLG7TDYUGLS7o6nMcKrACe/bLvLAXjlfBOeX/26CVgECZf63MaIYOBt+M+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584586; c=relaxed/simple;
	bh=W7Jd0Osdu2kVVY+MHibry+Pji1n/kI44wcTlORnoYf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg8UAm9jYWSN4HQInYKVhElstGwzmtPQ7i8KB2hINLGkq7j14+s8qzXRDkqGNpqu4GR0REZ+dvpS/Ji5HUvw78CCrsjrQo5hSl2hUr0m93VQHsSjtsTDGElvzX8nTRIRq/OXpPWWbV4PIYPNtyOIskv28TZpJLR/+KEFJyfERmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Gu2FtYR/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c82bf86bso95969f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763584583; x=1764189383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utq4jMNSJ93HG6IrUkHOln/2L5e8kODiHg/RjpN9KsY=;
        b=Gu2FtYR/5TemfSScaHR80jkFthXDvn0Tj33XSjpXP9ymBzakqaRNFEHitB7XpGZtek
         sng2q4wWuX5aXyHmRlzu/K7QyJ8yRbUyTCrro9I6mC9QfXzEheutvo7w5ksG8xD0B3Ub
         6QF3aKryBra9q6knE6D4JCg62UqkrdSfqPwEIP+L7A0+Uq1jzynsqC17rocz+9dJtB1F
         8LejpQQDlgXYe92BVotGkyIjovsns7JyX+l5hvvdzRlKPSaMQlUcMxiyw0TyPnF6vDAA
         miSgrGy/744BwLfLg8bqJupu8cKoLc2uMEaVADt8bec6GNx1fIEIMuBIStJnatCWaQLz
         cykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763584583; x=1764189383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Utq4jMNSJ93HG6IrUkHOln/2L5e8kODiHg/RjpN9KsY=;
        b=MIRZA6MQ4SkfyBBd8PjiHP8Fpmh1ALqsn2ojDmMYrvM/ZwleKecvMUHZcgEWB85D3z
         fU4aeG8D1LDH+pEE29MwcPJX7MjKIr78cFvtvX9CfocAzjpEkJvnk4tyXw3VU45VaIxU
         oiPs1X0gQcrnWOR9Z6ocrv6oRRc7mFRCIi1k04FhyLlZcZeNZCUt7VQUD1JT6WsotVWx
         l8nAgi30b5Fx8yyDW1GCH5PM6NXdtQOB7iXcAGSf1eRgamec8k2/GZBVCKpA1ewj+U2a
         ZZALPaGFLw30qA3dQNf4rfFs5/lLakn57uDqBmIS7WkjLMk3VJbIbWRnqD9vVcx68V+C
         FyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq1iI5uedHxWwsFJdLeSrUxTjZvfH9Xouu1iP+2/YIOoPNOG8/cTHbfRZ231rGpY8olQqZBLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJywE1WobtKhvs7fICjTn0E1ndioxv56oUAtgJ7w68goO16sl
	9EtVSiMFPhb60WydnMzwh7UH/3Uz8pHO/c3/jh9wpAv4ln88RtPzn6LQ
X-Gm-Gg: ASbGncst402wxuwk5gBw69G4JhWZ0WyFOuyQpQ2UH35T+Kak5YZW9yG61H0c7GD0haw
	GbuSVj2QpGjgu9lrYuWoRNYxAInj1MaHbthQ3MiIOULLvbyX+JIES3cv8KETxKP1ZfIKxIdYrB+
	8+5q7nK90JdBHLMwhalEVaGfvKoUrmxDjcavOY38kxHj8jBp/1kE+dRxz/U6TvNj62QUeKZRJbN
	o3SCl5ZTnupMuh93EyyJwSShyYk5xar/HCJQKzVlfhA+gq+2KPhYDZBqzqyCesO76N/hzPXOUKR
	eUz6yVrwcrfpsxfOOUO1WBMJzLcpT0LXfWcir5FpGUnzh1TJ3wzscCiwXa7pK1wjkrYJVVBoNrC
	SdWavLJ02snkbKNlP3OOHVxyvxtm3x2mmwOP0p+RL/nNG/hAnL8KhstAwHQnckzklMTtAKQkIU/
	Bj44tKv43J5ot5Dzl7A9gCB+YZK2pPmbMX5SeREteAxH6smSk5OTkhxDVHW4Q6ORPvXhmOiFKdr
	xCQyc2f7jI9
X-Google-Smtp-Source: AGHT+IH/4H0TGgxOn/KdPk6KDWmGWTp8ir5hs9Ymxn9R2qjI9hs79ItyvYjQFYs1lUs6WW1eGeSxUg==
X-Received: by 2002:a05:6000:2893:b0:42b:2b07:8630 with SMTP id ffacd0b85a97d-42cb9a3f211mr88357f8f.31.1763584582774;
        Wed, 19 Nov 2025 12:36:22 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm1067910f8f.33.2025.11.19.12.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:36:22 -0800 (PST)
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
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH v4 1/1] ynl: samples: add tc filter example
Date: Wed, 19 Nov 2025 21:36:18 +0100
Message-ID: <20251119203618.263780-2-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251119203618.263780-1-zahari.doychev@linux.com>
References: <20251119203618.263780-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sample tool demonstrating how to add, dump, and delete a
flower filter with two VLAN push actions. The example can be
invoked as:

  # samples/tc-filter-add p2

    flower pref 1 proto: 0x8100
    flower:
      vlan_id: 100
      vlan_prio: 5
      num_of_vlans: 3
    action order: 1 vlan push id 200 protocol 0x8100 priority 0
    action order: 2 vlan push id 300 protocol 0x8100 priority 0

This verifies correct handling of tc action attributes for multiple
VLAN push actions. The tc action indexed arrays start from index 1,
and the index defines the action order. This behavior differs from
the YNL specification, which expects arrays to be zero-based. To
accommodate this, the example adds a dummy action at index 0, which
is ignored by the kernel.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/samples/.gitignore      |   1 +
 tools/net/ynl/samples/Makefile        |   1 +
 tools/net/ynl/samples/tc-filter-add.c | 335 ++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 7f5fca7682d7..05087ee323ba 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -7,3 +7,4 @@ rt-addr
 rt-link
 rt-route
 tc
+tc-filter-add
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index c9494a564da4..d76cbd41cbb1 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -19,6 +19,7 @@ include $(wildcard *.d)
 all: $(BINS)
 
 CFLAGS_page-pool=$(CFLAGS_netdev)
+CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 
 $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
 	@echo -e '\tCC sample $@'
diff --git a/tools/net/ynl/samples/tc-filter-add.c b/tools/net/ynl/samples/tc-filter-add.c
new file mode 100644
index 000000000000..1f9cd3f62df6
--- /dev/null
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <arpa/inet.h>
+#include <linux/pkt_sched.h>
+#include <linux/tc_act/tc_vlan.h>
+#include <linux/tc_act/tc_gact.h>
+#include <linux/if_ether.h>
+#include <net/if.h>
+
+#include <ynl.h>
+
+#include "tc-user.h"
+
+#define TC_HANDLE (0xFFFF << 16)
+
+const char *vlan_act_name(struct tc_vlan *p)
+{
+	switch (p->v_action) {
+	case TCA_VLAN_ACT_POP:
+		return "pop";
+	case TCA_VLAN_ACT_PUSH:
+		return "push";
+	case TCA_VLAN_ACT_MODIFY:
+		return "modify";
+	default:
+		break;
+	}
+
+	return "not supported";
+}
+
+const char *gact_act_name(struct tc_gact *p)
+{
+	switch (p->action) {
+	case TC_ACT_SHOT:
+		return "drop";
+	case TC_ACT_OK:
+		return "ok";
+	case TC_ACT_PIPE:
+		return "pipe";
+	default:
+		break;
+	}
+
+	return "not supported";
+}
+
+static void print_vlan(struct tc_act_vlan_attrs *vlan)
+{
+	printf("%s ", vlan_act_name(vlan->parms));
+	if (vlan->_present.push_vlan_id)
+		printf("id %u ", vlan->push_vlan_id);
+	if (vlan->_present.push_vlan_protocol)
+		printf("protocol %#x ", ntohs(vlan->push_vlan_protocol));
+	if (vlan->_present.push_vlan_priority)
+		printf("priority %u ", vlan->push_vlan_priority);
+}
+
+static void print_gact(struct tc_act_gact_attrs *gact)
+{
+	struct tc_gact *p = gact->parms;
+
+	printf("%s ", gact_act_name(p));
+}
+
+static void flower_print(struct tc_flower_attrs *flower, const char *kind)
+{
+	struct tc_act_attrs *a;
+	unsigned int i;
+
+	printf("%s:\n", kind);
+
+	if (flower->_present.key_vlan_id)
+		printf("  vlan_id: %u\n", flower->key_vlan_id);
+	if (flower->_present.key_vlan_prio)
+		printf("  vlan_prio: %u\n", flower->key_vlan_prio);
+	if (flower->_present.key_num_of_vlans)
+		printf("  num_of_vlans: %u\n", flower->key_num_of_vlans);
+
+	for (i = 0; i < flower->_count.act; i++) {
+		a = &flower->act[i];
+		printf("action order: %i %s ", i + 1, a->kind);
+		if (a->options._present.vlan)
+			print_vlan(&a->options.vlan);
+		else if (a->options._present.gact)
+			print_gact(&a->options.gact);
+		printf("\n");
+	}
+	printf("\n");
+}
+
+static void tc_filter_print(struct tc_gettfilter_rsp *f)
+{
+	struct tc_options_msg *opt = &f->options;
+
+	if (opt->_present.flower)
+		flower_print(&opt->flower, f->kind);
+	else if (f->_len.kind)
+		printf("%s pref %u proto: %#x\n", f->kind,
+		       (f->_hdr.tcm_info >> 16),
+			ntohs(TC_H_MIN(f->_hdr.tcm_info)));
+}
+
+static int tc_filter_add(struct ynl_sock *ys, int ifi)
+{
+	struct tc_newtfilter_req *req;
+	struct tc_act_attrs *acts;
+	struct tc_vlan p = {
+		.action = TC_ACT_PIPE,
+		.v_action = TCA_VLAN_ACT_PUSH
+	};
+	__u16 flags = NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE;
+	int ret;
+
+	req = tc_newtfilter_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_newtfilter_req_alloc failed\n");
+		return -1;
+	}
+	memset(req, 0, sizeof(*req));
+
+	acts = tc_act_attrs_alloc(3);
+	if (!acts) {
+		fprintf(stderr, "tc_act_attrs_alloc\n");
+		tc_newtfilter_req_free(req);
+		return -1;
+	}
+	memset(acts, 0, sizeof(*acts) * 3);
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
+	req->chain = 0;
+
+	tc_newtfilter_req_set_nlflags(req, flags);
+	tc_newtfilter_req_set_kind(req, "flower");
+	tc_newtfilter_req_set_options_flower_key_vlan_id(req, 100);
+	tc_newtfilter_req_set_options_flower_key_vlan_prio(req, 5);
+	tc_newtfilter_req_set_options_flower_key_num_of_vlans(req, 3);
+
+	__tc_newtfilter_req_set_options_flower_act(req, acts, 3);
+
+	/* Skip action at index 0 because in TC, the action array
+	 * index starts at 1, with each index defining the action's
+	 * order. In contrast, in YNL indexed arrays start at index 0.
+	 */
+	tc_act_attrs_set_kind(&acts[1], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[1], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[1], 200);
+	tc_act_attrs_set_kind(&acts[2], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[2], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[2], 300);
+
+	tc_newtfilter_req_set_options_flower_flags(req, 0);
+	tc_newtfilter_req_set_options_flower_key_eth_type(req, htons(0x8100));
+
+	ret = tc_newtfilter(ys, req);
+	if (ret)
+		fprintf(stderr, "tc_newtfilter: %s\n", ys->err.msg);
+
+	tc_newtfilter_req_free(req);
+
+	return ret;
+}
+
+static int tc_filter_show(struct ynl_sock *ys, int ifi)
+{
+	struct tc_gettfilter_req_dump *req;
+	struct tc_gettfilter_list *rsp;
+
+	req = tc_gettfilter_req_dump_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_gettfilter_req_dump_alloc failed\n");
+		return -1;
+	}
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_present.chain = 1;
+	req->chain = 0;
+
+	rsp = tc_gettfilter_dump(ys, req);
+	tc_gettfilter_req_dump_free(req);
+	if (!rsp) {
+		fprintf(stderr, "YNL: %s\n", ys->err.msg);
+		return -1;
+	}
+
+	if (ynl_dump_empty(rsp))
+		fprintf(stderr, "Error: no filters reported\n");
+	else
+		ynl_dump_foreach(rsp, flt) tc_filter_print(flt);
+
+	tc_gettfilter_list_free(rsp);
+
+	return 0;
+}
+
+static int tc_filter_del(struct ynl_sock *ys, int ifi)
+{
+	struct tc_deltfilter_req *req;
+	__u16 flags = NLM_F_REQUEST;
+	int ret;
+
+	req = tc_deltfilter_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_deltfilter_req_alloc failedq\n");
+		return -1;
+	}
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
+	tc_deltfilter_req_set_nlflags(req, flags);
+
+	ret = tc_deltfilter(ys, req);
+	if (ret)
+		fprintf(stderr, "tc_deltfilter failed: %s\n", ys->err.msg);
+
+	tc_deltfilter_req_free(req);
+
+	return ret;
+}
+
+static int tc_clsact_add(struct ynl_sock *ys, int ifi)
+{
+	struct tc_newqdisc_req *req;
+	__u16 flags = NLM_F_REQUEST | NLM_F_EXCL | NLM_F_CREATE;
+	int ret;
+
+	req = tc_newqdisc_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_newqdisc_req_alloc failed\n");
+		return -1;
+	}
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_CLSACT;
+	req->_hdr.tcm_handle = TC_HANDLE;
+	tc_newqdisc_req_set_nlflags(req, flags);
+	tc_newqdisc_req_set_kind(req, "clsact");
+
+	ret = tc_newqdisc(ys, req);
+	if (ret)
+		fprintf(stderr, "tc_newqdisc failed: %s\n", ys->err.msg);
+
+	tc_newqdisc_req_free(req);
+
+	return ret;
+}
+
+static int tc_clsact_del(struct ynl_sock *ys, int ifi)
+{
+	struct tc_delqdisc_req *req;
+	__u16 flags = NLM_F_REQUEST;
+	int ret;
+
+	req = tc_delqdisc_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_delqdisc_req_alloc failed\n");
+		return -1;
+	}
+	memset(req, 0, sizeof(*req));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_CLSACT;
+	req->_hdr.tcm_handle = TC_HANDLE;
+	tc_delqdisc_req_set_nlflags(req, flags);
+
+	ret = tc_delqdisc(ys, req);
+	if (ret)
+		fprintf(stderr, "tc_delqdisc failed: %s\n", ys->err.msg);
+
+	tc_delqdisc_req_free(req);
+
+	return ret;
+}
+
+static int tc_filter_config(struct ynl_sock *ys, int ifi)
+{
+	int ret = 0;
+
+	if (tc_filter_add(ys, ifi))
+		return -1;
+
+	ret = tc_filter_show(ys, ifi);
+
+	if (tc_filter_del(ys, ifi))
+		return -1;
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ifi, ret = 0;
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
+	if (tc_clsact_add(ys, ifi)) {
+		ret = 2;
+		goto err_destroy;
+	}
+
+	if (tc_filter_config(ys, ifi))
+		ret = 3;
+
+	if (tc_clsact_del(ys, ifi))
+		ret = 4;
+
+err_destroy:
+	ynl_sock_destroy(ys);
+	return ret;
+}
-- 
2.51.2


