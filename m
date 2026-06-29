Return-Path: <netdev+bounces-302754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ddQ5MGWsQmoi/gkAu9opvQ
	(envelope-from <netdev+bounces-302754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992E6DDC40
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mcNUeaGr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 460193078B58
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226547CC94;
	Mon, 29 Jun 2026 17:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D0477E24
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:27:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754046; cv=none; b=hXa4cSLawDr80QeD63eFj/jSxKH2Nj1MO+oERW56yfwOW7cfXPA5+3IK96NAxlked73PRyx3mTphEo4mumOs9sy/iXF5R70Qqhlg7ApRyMA6USuS8VWuWpuz0wIfXOkOIf+VPjUO6ev/oq7V1HiNy/gJs+oWzrKGn3rj5jYVXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754046; c=relaxed/simple;
	bh=vmfVuXC1Kci8WIGxW5bjMPz0qeJm5HtuIa4PggV5cAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abP//8TuUUQHabIrFV4A6FF0vfwdu+b4uhRH0ncj8jG+jEoMiKYilAM5WxQV4y3AVYaqEpGzOegnvbkeggMzakSxE9hCIFg1NjHfcoeLem1wdyDkmasYS6qOYIyX959mGdwsWlFw5KdndlRVjnB55cFhDUi5cHzDom3eME5wUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcNUeaGr; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b733e82cso2282114b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754045; x=1783358845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijO00ApSrJ4JfinG+iOaoegiY2Fv72WhceXqrwbihis=;
        b=mcNUeaGrwHHb6mK4agvncycFBMAzRnpl5U8HcrFILADiR4xjAZunvQLS9JtT91sna+
         ZmTIB6i8TmMEIpPLjQaF4C7CJb55CWm3dOu3CRmVl7qab0OG8tsjiZ499IEQ/DI6Ie2w
         7diXSoyvOQT7vw1ly68lKN56qtxbJXEP+HLUsimUYjbvtGiMmasThZRzX5XSI6n28T2K
         l/dG06PLj85SqUgYDBaCsKDxEbbO3s+TfaTet6eTTPVkUuD3uW5GLsqKdXeYmJyeGi/o
         LUtAlQZcMc+I8x4KTeKrdKe+F1ZAprrP8m8z8pIX4pgbicAh4DezcndQZM1TgQCIBPWK
         juQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754045; x=1783358845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijO00ApSrJ4JfinG+iOaoegiY2Fv72WhceXqrwbihis=;
        b=JfCN89oHZKCTTh13OMzYoMlfhI6yFm84wdmMSzlEZ7aBW6SiHZoJq4jpU4xjfhv85A
         AtP1hslAT/DhaKypcTmElUUQ1t3s2APTlbVOK7Ptt+gEOSTvLOCUY2p+TZ+Mxnyx0kTf
         vGmUrob45CwxYGUt0ElM+x8oxN9Jy9K2b0GAtz4643iHHP1RF+dnijG0v29vDuD3PF1O
         Uq/i1A5GPDSdsr4mnYQJROt0A/1qP2Y7U30EpIRZFTrPIbVuQPhCDpEIv4008U9I/ttr
         2SYu0LuDhnysezzH4ZkJPw1eV/0fScakiNn51mgIw/uHVCNaJW4HD626Yy7V2O5CyWPE
         fJnQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvTS3xGOadycpfvoAvU1WEImZyqJIaYllMkWGE0wdMtlrfJ9+L6ul3D+N3tLMxhwfriZ1Kg9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZ9QAuyRw0tL6JRcNnyBRdsoPkR7kPTGWRcSFRkighNJ27J9D
	TZabwlP/s1BIj5AJR05PwSzkiUYXb8V0iHNv5D4ltsblv4vBkl/1bpNc
X-Gm-Gg: AfdE7clZfq4HoOdIQ7gcpHLRoGjM7VQrEvQM+ZkMoGZrRkxaCWbxQ7ScOOi9PGJzEcr
	SdDBHtrnChm82N4uWe/BQdMfi6FY4ybZmvR2MiLDwVVwzWmlz1lHG6B+Pkbd+ler/B5NXtMhZ89
	EQcBFR/qY0TVCsbqJ0vr25mXP010xjEhyg52Mnw8u13pdrAyG0v/AdDQbX5iBeAvKlEpqRdDRlU
	dHhyO0PmjgsfnYnEOJMa6ebak9L71yXr92Jy/zl5PKv5VDtzXx2fRoyJOXGOkq87J3es0EptAcj
	MCudx2IQzpXkeEWojyEHSu0ZFAxfPMFXKulAdIAf8uUj++lQtSQdc2zXiCqHRdzdG3nuSp9lvua
	+S63JU0Ygqbnlg+beia4VmQHldjXOfYHmHKenL8xrX7zriIka5SwtNCWNBbodJERQEHh/NtwcUl
	PZFJnANH4ep0hTiietW/C2sDxA286SVXhTolHzJZCpmuop5XrYHmE=
X-Received: by 2002:a05:6a00:809:b0:847:9151:3409 with SMTP id d2e1a72fcca58-8479f28fe73mr310446b3a.55.1782754044625;
        Mon, 29 Jun 2026 10:27:24 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:24 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Lorenz Bauer <lmb@isovalent.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector
Date: Mon, 29 Jun 2026 17:27:00 +0000
Message-ID: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302754-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:emil@etsalapatis.com,m:lmb@isovalent.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5992E6DDC40

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
write. That gives the order stab->lock -> sk_callback_lock.

The reverse order comes from the SK_SKB stream parser.
sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
__tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
deletes from the sockmap and takes stab->lock:

  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  syz.9.8824 is trying to acquire lock:
  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
  but task is already holding lock:
  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173

  -> #1 (clock-AF_INET){++.-}-{3:3}:
         _raw_write_lock_bh
         sock_map_del_link net/core/sock_map.c:167
         sock_map_unref net/core/sock_map.c:184
         sock_map_update_common net/core/sock_map.c:509
         sock_map_update_elem_sys net/core/sock_map.c:588
         map_update_elem kernel/bpf/syscall.c:1805

  -> #0 (&stab->lock){+.-.}-{3:3}:
         _raw_spin_lock_bh
         __sock_map_delete net/core/sock_map.c:421
         sock_map_delete_elem net/core/sock_map.c:452
         bpf_prog_06044d24140080b6
         tcx_run net/core/dev.c:4451
         sch_handle_egress net/core/dev.c:4541
         __dev_queue_xmit net/core/dev.c:4808
         ...
         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
         strp_data_ready net/strparser/strparser.c:402
         sk_psock_strp_data_ready net/core/skmsg.c:1174
         tcp_data_queue net/ipv4/tcp_input.c:5661

  Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(clock-AF_INET);
                                 lock(&stab->lock);
                                 lock(clock-AF_INET);
    lock(&stab->lock);

   *** DEADLOCK ***

A tc, xdp or flow_dissector program has no reason to update or delete a
sockmap, and redirect does not go through here. Drop them from
may_update_sockmap() so the verifier rejects it. It also closes the
matching sockhash inversion.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/verifier.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..58d766c34626 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8489,11 +8489,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 			return true;
 		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
-	case BPF_PROG_TYPE_SCHED_CLS:
-	case BPF_PROG_TYPE_SCHED_ACT:
-	case BPF_PROG_TYPE_XDP:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
-	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return true;
 	default:
-- 
2.43.0


