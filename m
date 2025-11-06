Return-Path: <netdev+bounces-236419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337FC3C039
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F5422B38
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC751DE2A7;
	Thu,  6 Nov 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jKlaADnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C52224FA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442138; cv=none; b=bPENYEZ2MF6NlMxVUGbTW7IruscnphDU6tLhCc31zfovY8XB7NJ5gt1SFveefrz/YM5wRMZKmp/yH9PaJWAFjWh5aIqYXtSe4z4SMBFohN+hFm2GB8+X9zDXOa1yG6wfNvD3J2Goe81l4TAcDJAO4O0/uofh057BY7yattWB5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442138; c=relaxed/simple;
	bh=R+9PrhMQKta2FkWBvn4PW9GC4HipdHymrZwt9J8OGnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnbeC2Z4S4Glxdw6Z/C9xgFBFIwcLPPcYASpeG6qQsmViQCvyYLGnk5a2v6WjvsRn+Q6kHpaKFsrsRxxZPsVpus3Uvh2vStIdg/SjUlIKa0js9ClkdmfIVDJtR+LaLp8ZD0+wcrozRSU1gB5z9TVG2bgFT+qcScfvDl8erhTTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jKlaADnV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso3747067a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762442135; x=1763046935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz2EFQwv6JJTInNpimwzT++IkPzCkrbLgsS7XMnfmhQ=;
        b=jKlaADnVA0YSMk+Aj6KE4JhdPAxXnrnpBFOw4mpuA2escvx9Nbc13IEi+3BKXsRl13
         V5g/OG6okVMyoJo/5oGgZYJkcQYhiIbqUtNSRVwslxuDD9fFzrj2xgywOgkwekaRN2sW
         aqLDIFFo7+w1+7z7uRGNBlaqiVEq61IhlzN137w13vNmiDPAkoDfauH+WdcOW+JmqV7i
         BrZ/sMDQ0DO0//EiWdrdV5Y8f9oYMl0nezbT7mCDwreY8Arfr7oe1uk6EJyIjtE3dwT0
         lojmDzU1Jkw71p0C3W1uxwzIuRbxFor/U+LyCPLKhLfAqt55ztwfc5U3dnyqTDd2YMKw
         YJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442135; x=1763046935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz2EFQwv6JJTInNpimwzT++IkPzCkrbLgsS7XMnfmhQ=;
        b=qSNMtzwcRlbTbSY93nMatqD6B74FNBZU1Vr/3Cqu3kPeXDdjAYybogXG5bUzp4xuwX
         P9pz+nfDWJxcQYyV5sgftMQnY2wkfYH4ZNNcG6TWEf6zqDkxQnPWyw2rqGpYDDfrzZEx
         4qOcwjpBiR/ezTtNViQhfJNYpST/JBCizhGJ8FSdAzOgABqmmyDcFu1wOsL7snmORMb+
         juZ48qak0Y8yMhtTd+SMICioK+Lw0CFCOKiItQlm0G+BdXf7uXw21V+pbE+u8NM5QeTW
         bg9kch5BCLh9DXc0HxujUok8XKuKPziVaxB2t2q/jBRrLxii0PThEssyxovLzgtS+UFN
         5qZg==
X-Forwarded-Encrypted: i=1; AJvYcCVJzCfRnxZLzObMVGK75cQMJFU6/IK6Kv2qgkeD4sWIh9k2o6dbqWnya8YuYJ9/evnIDIoTJxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HsUsE890jgZUyHYcPLlwj085j0Qm/VOCA3Rr4L11iFxbop6M
	epsxw7UT36Pd6/ZKtT8SWY0Q0bsfCJz6MZGP95FaUR4dCz/bxne6nXWW
X-Gm-Gg: ASbGnct1JYP/jaMb1wPgw9faoyVV4qS0MZqSaDcMaoD5704w2rJDnY2WJueeIYy9ZUu
	9vOUIqNSdWeqaLOLXlAJgCHU0dO/TITlgnHCyQ358rtcuoRraSYgRbA6M4UMNdSvVDpf6vsc9u0
	AjZ1nWYupitiqQ4+NHeTgbw2FR0U7mXoIPa4xOO9riVZvR4XK9voKMljfOQNtOQKmi8ZjhHjQvb
	Iyk+a/lyVpvoo1YpTs8yb6ZRp0yPbNJw5YDcDXfsqk9BuI1B+FcKQ6cgd/yh6qrwlIHjXbGk3xu
	69H83kBHZj1HXED+fc+x0m2oUzCsbWHQ1N4WSqWmGRTs90ajnxgoasmA+bIJPlIU3+DTWLAXkX4
	FyNdUsFy/YV9gtZ1FMv2A4OQgcVx86SHYYwQ8OFau0s1OCvv/9AmD56Ow6hi65BAv+jgpfsRKJn
	kwbvUdOCRSl1ggy1O/TE7ZTJ+2TjdG+EmlBky5zegSe77F5LJX7WuE8rR/zZ0OpOs/RpA4W9Mkg
	g==
X-Google-Smtp-Source: AGHT+IETRBSYTrnBGOtSPCGXZA54bF91EL4EvIZmwWkL66/ElCEbJSbS2Qbv1mSAogSd+957q5mO6w==
X-Received: by 2002:a17:907:d0e:b0:b6d:51d4:802 with SMTP id a640c23a62f3a-b72896041b5mr396304366b.25.1762442134775;
        Thu, 06 Nov 2025 07:15:34 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c6f95sm234012566b.64.2025.11.06.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:15:34 -0800 (PST)
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
Subject: [PATCH v2 1/3] ynl: samples: add tc filter example
Date: Thu,  6 Nov 2025 16:15:27 +0100
Message-ID: <20251106151529.453026-2-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106151529.453026-1-zahari.doychev@linux.com>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
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

  # ./tc-filter-add p2

   flower pref 2211
   flower vlan_id: 255
   action order: 1 vlan push id 255
   action order: 2 vlan push id 555

This verifies correct handling of tc action attributes for
multiple VLAN push actions.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/Makefile.deps           |   1 +
 tools/net/ynl/samples/.gitignore      |   1 +
 tools/net/ynl/samples/tc-filter-add.c | 308 ++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)
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
index 000000000000..297f8151ca86
--- /dev/null
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -0,0 +1,308 @@
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
+		printf("protocol %x ", ntohs(vlan->push_vlan_protocol));
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
+	printf("%s ", kind);
+
+	if (flower->_present.key_vlan_id)
+		printf("vlan_id: %u\n", flower->key_vlan_id);
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
+		printf("%s pref %u\n", f->kind, (f->_hdr.tcm_info >> 16));
+}
+
+static int tc_filter_add(struct ynl_sock *ys, int ifi)
+{
+	struct tc_newtfilter_req *req;
+	struct tc_act_attrs *acts;
+	struct tc_vlan p = { .v_action = TCA_VLAN_ACT_PUSH };
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
+	acts = tc_act_attrs_alloc(2);
+	if (!acts) {
+		fprintf(stderr, "tc_act_attrs_alloc\n");
+		tc_newtfilter_req_free(req);
+		return -1;
+	}
+	memset(acts, 0, sizeof(*acts) * 2);
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE(1 << 16, htons(ETH_P_8021Q));
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
+	if (tc_filter_add(ys, ifi))
+		goto err_destroy;
+
+	if (tc_filter_show(ys, ifi))
+		goto err_destroy;
+
+	tc_filter_del(ys, ifi);
+	tc_clsact_del(ys, ifi);
+
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.51.0


