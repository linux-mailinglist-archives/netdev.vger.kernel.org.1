Return-Path: <netdev+bounces-239091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE9C63A5A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F117434E09A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975CD30E0C8;
	Mon, 17 Nov 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UrozkL41"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D42F6929
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377036; cv=none; b=jX+iClWeBWIGSIt/3A2D7ZqycBmdqgozxDTTds4Zn/+8nUsZ3mXjMvSoT0XjRczSU3pM5++Alk/swa81rHve4bGzlEPICryJS2Wnoh7e3kjOW1qGiman5SyjfRicfvSBui9sM/HatqYlP4nEUjmjxNwcgT3gWozAfi4b27frDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377036; c=relaxed/simple;
	bh=F7zebn/LOxvBl0WPMDEuulBn7Ohg+quAK71mVfFpWaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPQMiQrNFltYiFnSp46jeYXkLB8O04WR54cih3/MVD8JZGgeMiox6GEjHmZtHft5mYiz1EfdObW3H/VtsED1Vh5iPSEzS2Le6god/t5AR0dbiaZiTAaH62JfK11KhluQtYGxEVWWMy4NrVelbwoo8I8ymnKxVhaouqlxceAoZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UrozkL41; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2824088f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763377033; x=1763981833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wILir+K6M0TK6FFt0KIhBKZ6eo4NP86z6vMDIn/3nqw=;
        b=UrozkL41dv/I7+gdGrN3hwirENazkLGT4wVAu3ZpLJ/t933W1Ab4LX4vkKoleDE5c3
         Xwc70TgiiwkN8PL+8U9OTxcfb+n1/+zAxiPbBHgxQYcMn9h2Z1tess+Q4FqO5yNofmIR
         y8Rr30/dfejeBPJ6vpLcO+dSrYOCUGfen77JwEpCW7N4KsBZIRhy0JhTSXcyTOyhMtsd
         1hFpYvXg6rjltnqUWya+G6Z54nC5SgGU/0pEiG96P7FTWft4va1z/Sbdk9kS1KY3FZM/
         mmHqalFkAQmUIE9bNRkgZmxtTnsXsD2OI2geMnCBuNwizcZT1qIlCju9f4YSnNq+ZMeK
         /YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763377033; x=1763981833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wILir+K6M0TK6FFt0KIhBKZ6eo4NP86z6vMDIn/3nqw=;
        b=whYFnXy3CWrJb7jxF6ifxe0BntJliIN81/5JDWt/cLhGVudO4lNidjthrUpvrZQ6HR
         8CMoGq+WZ8bWoFCet53XVz/6k7extgZmXg47ZxzAANlE1RvzqRuCrRCuyJNQOdwl0sQ0
         4T3tTBuYCkD0sExOqU215rGmF6VNvyO2+puD8Bg699fkISPVfeyySP4vmGnj4VHr08Jj
         sAj9EGqD8Xn8UzyS2t7f0km7tYi4A6H8j2a234pKI7XMy/AjKLzh73eTTm+dbqw1a4+r
         xahJc4uJ27rMD3U8s0j8W1piQx5BLZWH/10v6aLxyjMVxsH4ajyUHM+i7WDvO9AIRg4y
         Ptpg==
X-Forwarded-Encrypted: i=1; AJvYcCUZNwPQOBDtsBdWxU9KN8yfuDoDjBS3LQrHmltorqMaO+sFI7aCFyeELNrRWsXHVic6ggKNMh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERW1ct2uSXqHV25qfa3vKjNYasXx/LdMlFvJPnSLMgz2RrOW3
	Usud2BfE30Anqh4jFftXllqFF6iv9VZWHwcYu/Wq82GdqwttNCvNHil0
X-Gm-Gg: ASbGncvI7LroUdQ66m0aosTvz/qWOmlXvkZT+jDWdS7aWq6MWxGQM4pXnCmEmdMX4m5
	QcQ9h6164ufh89/WAwq7jSVcPNLOl3KL0OCP+VLMr4lY2pZF2wD6hBQqbjBczwEmQ3aHjuzvj6a
	A6ZogzxZzku3n8ZdXVofNzrW5dlzf1ZZWLaA4nabWwvPI1ozHXKePO9giKTHeSSbrtGLdU+eM4h
	f7sqnXA0DVOkcOH2Fx6MAHC+F5EtasVG24OE4/WcXEFVONwi1gd5TusfIZKDG6WzCZRJwdtmph2
	s8RnPcu50B08/LQvWzE4Tz2iCR/+3Aoo/puVPsD1XI22F7xGonkjYDkOrAX8ly3gaeAMGWkFcZu
	0NO/qvkJafeJ/vGUBg/p/5/Qxb9QFHWccobQXawnTMI39BMv3OguA8fimPklO7DjkSUmApeT7f2
	G/RAkZRIeFcX3wsNctPLW2MJ8Zdm8llkazOzL5bjLmcPkpCW/PuM8tnoBZMy9nFVQyz/SsGVZtH
	g==
X-Google-Smtp-Source: AGHT+IGKTC8f6VpBaJ+8zc3FTeQa3ykFLtcBMewmIakXS5uIAQ0y//CeZTxKPnTFO2tFK0OATmrBiQ==
X-Received: by 2002:a05:6000:2401:b0:42b:3e60:18ba with SMTP id ffacd0b85a97d-42b5933e3f9mr9840436f8f.8.1763377032405;
        Mon, 17 Nov 2025 02:57:12 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b617sm25397802f8f.31.2025.11.17.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:57:12 -0800 (PST)
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
Subject: [PATCH v3 1/1] ynl: samples: add tc filter example
Date: Mon, 17 Nov 2025 11:57:08 +0100
Message-ID: <20251117105708.133020-2-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117105708.133020-1-zahari.doychev@linux.com>
References: <20251117105708.133020-1-zahari.doychev@linux.com>
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
 tools/net/ynl/samples/tc-filter-add.c | 327 ++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)
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
index 000000000000..82231aab6c1c
--- /dev/null
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -0,0 +1,327 @@
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
+	if (tc_filter_add(ys, ifi))
+		return -1;
+
+	tc_filter_show(ys, ifi);
+	tc_filter_del(ys, ifi);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
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
+	if (tc_clsact_add(ys, ifi))
+		goto err_destroy;
+
+	tc_filter_config(ys, ifi);
+
+	tc_clsact_del(ys, ifi);
+
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.51.2


