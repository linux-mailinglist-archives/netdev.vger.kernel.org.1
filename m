Return-Path: <netdev+bounces-110500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74ED92CA2F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EDF1F22F66
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE709347B4;
	Wed, 10 Jul 2024 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="atojdmWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AE2209D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589893; cv=none; b=WRhKDGCbtDh5YAIxQfXvrQl+Uc++1dtmIBBtM6i6bRUQCjUwILjqhaxAf0m0JsGXl+8TAD91LCCurwSYl+IHXzuGhF/lqexfWN0r3YAVCRoKGT1YT/EiHkmQWmizBJO38OkPq4kFmy2W0NFDza2JocLnlbgXdIBulbRrxfU7pE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589893; c=relaxed/simple;
	bh=v5VCPr4Du+pG2S8CBTFMueLiD63oz+ch5gWQHFG3Dk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbHvraCDKTFYdAmRWJ7KpioMzP4IaRfrwqvmGzVX32kZe3quVyPzfdQRiyjTu+7QedzGCEHSX6XarvFVpSrE8y4/IiooZLFBqqyMEPO+0WK9JPePClc/VKvv2X/n5UXUqAavxZu06ZfL4qaO0XlG3DhwVuWKBptRwFMNGH4m3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=atojdmWD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 181933F6B5
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720589889;
	bh=+BF9ZXP/6SofqOnqF6IHHCxggKe9TmXoQxOW1LVv8SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=atojdmWDTOFGvZyUfWnlKfORRoONPBk4Phfo/DLW6ykw0EJ3hZ6O7EKf5wA81bemb
	 fhARHjfr9lHii5oR/7gZSWu10y9eX70BCGba4cUvGL792Qn7yzrv9mFnCe8XOSuVb9
	 C1fSp5yOEsR6QBs3IRegwBqvlK2iWepmh59jTOQ7yFn6tIoik15sX2d0lQoqDLJp9c
	 IYWoemGWqXLixiQfLT+hVcVBJeeV7m4+Zr6HI+FBoF9JZ1WmxdPGeZnb9FsbciL9qX
	 AJMuiAmAfLYSvW7YNxBcQP8FjdtgdNrJdN2hVPia21HGLm0rQkzUAidKsJEsouJFf1
	 jDc5aelDhtyZw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af5f8def2so4420447b3a.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720589886; x=1721194686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BF9ZXP/6SofqOnqF6IHHCxggKe9TmXoQxOW1LVv8SE=;
        b=IK32acjRVUwGTNq6rRcE++xDmVYu5QszKCkxJ8O7vSmspBqobg64LF5hpLqBNyohOh
         edLjMG+oK7XozDsrPTdxBr7Ac0vpmXqiuooWgBxKJI9Ffm62SKKxxt6jpII0T+piwrX+
         uVynXZ8iIcfJFXtadESjIyxyCxYPTxzfc0MUr+IZ4GupuSfhHd/9+OtMSAEvO5LKvQu8
         ecSh6ZDk965RkP9eHCRk+TS7zUAF4UkPszcdi0/VaxkKFClSIiGu87b4h3aw5TDQqR0H
         aZU/g3KBv2vtfO+MtkbXs5/ru1JptT88tKv4xEsKulCi/dIMuzTP/sDpkxLv8q+f4SGw
         pfKw==
X-Forwarded-Encrypted: i=1; AJvYcCV0leRiXVDzOrcl2NlBRQaMOK25DmdX8yCFBnaNuNFWL0i/H4d8Mjx+WMw5+tXk05v5FYB3bGEc3rCV1qfegy1+ryDPvtTP
X-Gm-Message-State: AOJu0YwrSKaTBe8aWHyi3x32wh9XqXkeFEqJUt+QSuEzeX8hzOYimabY
	FwhMTybagZh4htwDQATyXgxbNAfXK4K48rkymX9seqxGpQwdCTHPH6Mx+HPLPdzLjg6ze4OLep5
	C3qXVZrbrwun/j+URqu3YlgaN+PGKDWNN+xGIMfdzWFI72/8FiriAme0WFiE2jhj7PtLn2Vyg+w
	26wUJf
X-Received: by 2002:a05:6a20:9183:b0:1c1:30fc:90d1 with SMTP id adf61e73a8af0-1c2981fc184mr5447950637.9.1720589886087;
        Tue, 09 Jul 2024 22:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJuCGK8/xtZc2b2Vy7+1+XxNriBbpYB2hIAm404IKG/1XEhZkvb91fSu75wDnS+j81WJEqeQ==
X-Received: by 2002:a05:6a20:9183:b0:1c1:30fc:90d1 with SMTP id adf61e73a8af0-1c2981fc184mr5447933637.9.1720589885678;
        Tue, 09 Jul 2024 22:38:05 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-5abd-cde4-4d48-00d6-a4b4.dynamic-ip6.hinet.net. [2001:b011:381c:5abd:cde4:4d48:d6:a4b4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7c66sm25018475ad.121.2024.07.09.22.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 22:38:05 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: jhs@mojatatu.com
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ozsh@nvidia.com,
	paulb@nvidia.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	Gerald Yang <gerald.yang@canonical.com>
Subject: [PATCH net v3] net/sched: Fix UAF when resolving a clash
Date: Wed, 10 Jul 2024 13:37:47 +0800
Message-ID: <20240710053747.13223-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports the following UAF:

 BUG: KASAN: slab-use-after-free in tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
 Read of size 1 at addr ffff888c07603600 by task handler130/6469

 Call Trace:
  <IRQ>
  dump_stack_lvl+0x48/0x70
  print_address_description.constprop.0+0x33/0x3d0
  print_report+0xc0/0x2b0
  kasan_report+0xd0/0x120
  __asan_load1+0x6c/0x80
  tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
  tcf_ct_act+0x886/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491
  __irq_exit_rcu+0x82/0xc0
  irq_exit_rcu+0xe/0x20
  common_interrupt+0xa1/0xb0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x27/0x40

 Allocated by task 6469:
  kasan_save_stack+0x38/0x70
  kasan_set_track+0x25/0x40
  kasan_save_alloc_info+0x1e/0x40
  __kasan_krealloc+0x133/0x190
  krealloc+0xaa/0x130
  nf_ct_ext_add+0xed/0x230 [nf_conntrack]
  tcf_ct_act+0x1095/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491

 Freed by task 6469:
  kasan_save_stack+0x38/0x70
  kasan_set_track+0x25/0x40
  kasan_save_free_info+0x2b/0x60
  ____kasan_slab_free+0x180/0x1f0
  __kasan_slab_free+0x12/0x30
  slab_free_freelist_hook+0xd2/0x1a0
  __kmem_cache_free+0x1a2/0x2f0
  kfree+0x78/0x120
  nf_conntrack_free+0x74/0x130 [nf_conntrack]
  nf_ct_destroy+0xb2/0x140 [nf_conntrack]
  __nf_ct_resolve_clash+0x529/0x5d0 [nf_conntrack]
  nf_ct_resolve_clash+0xf6/0x490 [nf_conntrack]
  __nf_conntrack_confirm+0x2c6/0x770 [nf_conntrack]
  tcf_ct_act+0x12ad/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491

The ct may be dropped if a clash has been resolved but is still passed to
the tcf_ct_flow_table_process_conn function for further usage. This issue
can be fixed by retrieving ct from skb again after confirming conntrack.

Fixes: 0cc254e5aa37 ("net/sched: act_ct: Offload connections with commit action")
Co-developed-by: Gerald Yang <gerald.yang@canonical.com>
Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/sched/act_ct.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2a96d9c1db65..6fa3cca87d34 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		 */
 		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
 			goto drop;
+
+		/* The ct may be dropped if a clash has been resolved,
+		 * so it's necessary to retrieve it from skb again to
+		 * prevent UAF.
+		 */
+		ct = nf_ct_get(skb, &ctinfo);
+		if (!ct)
+			skip_add = true;
 	}
 
 	if (!skip_add)
-- 
2.43.0


