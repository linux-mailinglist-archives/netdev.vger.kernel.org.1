Return-Path: <netdev+bounces-151920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742E9F1A06
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24820166E47
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002231F427A;
	Fri, 13 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Htq04AlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CD1F3D3E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132612; cv=none; b=qeF79eGz6GMI/FzdHbvA74yr0tnaTFlB/SZ09gw5erCqce+AF6iRVb7mupUc4/OIeGGS7O0GBhH2xdPAOIgRQhqwmtGNkaOLBTHVV81AhpexsDV5tvhcpHkOfbpwPaTcr4X6JbiM474h5V0YhYr//0ThasalSaUWYnTQ4SQRR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132612; c=relaxed/simple;
	bh=u4js09ZrJprP9Ct6KS/KG66aSEf0301PiPjx92HhRYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htfR8+g/h3IQUAk9iudg8Fkq6eImKNlhVCg/bmF0pNw8rsuZqLlVtiExU8L64VVvZaJvZi5j5sw86rP5pm6oJ+obcdlpUSRYX8E/ojrJ8CI4OCDVVbW/P4yy6VVRqZMGg8+WL4PQBSjFd2oFbVA9K4lXWAXBWaOwXJc8gy2RZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Htq04AlO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46772a0f8fbso20220291cf.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132610; x=1734737410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsUHCw4T0E7XChR9WsYxTd868449t9RXx5ZWu1kInUM=;
        b=Htq04AlOlj5VkevqSqDPSSvoCiTKcpm6D8OxycxzNdf2rOBwvdi3CVGm+vHVWOhJco
         hcGd8rJJFIyd4JbBBsOdiopBHK7SY5NmXv3S5Tg2mPAdTbb3wzCKwVPdJzixgnWk/oS/
         GqqHR5B2e47DnK2zX1yexsMPvMZm3syERf0yTEVeHG9XQ+SnJT8bkX5UjT8m3gymNbS9
         6bo5K8xMzDRDKl8mgqmQMPmRppiWDqZUMuhPYx+/xw73TKhOY9WD6axBr6QjNQfubXVp
         Ir5G0vKpGJqq6dvA3wYATAgEQMrIcHaknqYePY0yLNQWcJb/v1SQwvItkvkc7gNEjOMY
         dqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132610; x=1734737410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsUHCw4T0E7XChR9WsYxTd868449t9RXx5ZWu1kInUM=;
        b=w9qodQtmLCRKbiI+UZjLbEWrz5r5HiuYxbACXNRUjpJAdshDJ6RNzps5CLx8P0Af7t
         WrjLuGsibCX03W/ghKqw2uhQuqqbeTE1BxDyIhm7R2O1tGslnT3jAsepX2VVZCF8bAKl
         c907hMdbbVj9OHjiRJvmPz62zne5Xx/H9ol79oMw6iMBBrkH310iFpML0DEu5vbmnjiP
         bcIWBLuANkec/9UU4n9Gbbu65l794Q2ly1PiSwUl3mG5+18RRLT0QIjq3rGQ2/91VuJm
         jwpGPJOaJH7Y9a2P8WvMFMqUsuc7UHHQ6JK9kiIol1BJBAaoG/9UJBlpjS/oUd0BsP4M
         H6qA==
X-Gm-Message-State: AOJu0Yz6uFmVUaq8PVtnulGq3gudHvsb/TCFKgVSNXcPOd/O5lX9h25N
	3a97yKv+aM5A0zezh4jDqfV9l4hHVqwr3/xumHxNlqs3VASv5437FtHyonBVzsWkDc8/vfrBRvd
	wOh7qOA==
X-Gm-Gg: ASbGncuS4ssu8Gwg5O7ox0Wwdl1jYLV3h64mOoItURMvwYnA4FlaIOPMccPqfCXg2Qb
	nbcWCpJ/cln3vR58BrTLN1FAY1/LodQsmrHjTKECgkgmCJH4Ew1XMoQVgOg5WPEZUw4igweK9LV
	+Zggh2/TNaI8EflEGp6xlYtP2Vtqq3tvcdNM8AAXBZVDXP33h6LW3mre0k5B2zB4MGaH1FpDrF6
	6T2ED4TVTJGV0OraeWLsuZtfo90QYDutMVi/aoGGDiHdfUxO/BJwABlnGPR7jH/IOI086Jx3cD2
X-Google-Smtp-Source: AGHT+IF1w0JRYjaYuWkP2HsGdMaLVD3k7SbV34NZbx2XywOZUx4L6+IKiXSlKL9dxXI81FbxYMYgIQ==
X-Received: by 2002:ac8:7dd6:0:b0:466:96ef:90c with SMTP id d75a77b69052e-467a5829a18mr66297661cf.41.1734132609973;
        Fri, 13 Dec 2024 15:30:09 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:09 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 08/13] bpf: net_sched: Support updating bstats
Date: Fri, 13 Dec 2024 23:29:53 +0000
Message-Id: <20241213232958.2388301-9-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7c155207fe1e..b5ac3b9923fb 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -176,6 +176,15 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
 }
 
+/* bpf_qdisc_bstats_update - Update Qdisc basic statistics
+ * @sch: The qdisc from which an skb is dequeued.
+ * @skb: The skb to be dequeued.
+ */
+__bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+
 __bpf_kfunc_end_defs();
 
 #define BPF_QDISC_KFUNC_xxx \
@@ -183,6 +192,7 @@ __bpf_kfunc_end_defs();
 	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
 	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
 	BPF_QDISC_KFUNC(bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS) \
+	BPF_QDISC_KFUNC(bpf_qdisc_bstats_update, KF_TRUSTED_ARGS) \
 
 BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
 #define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
@@ -204,6 +214,9 @@ static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		if (strcmp(prog->aux->attach_func_name, "enqueue") &&
 		    strcmp(prog->aux->attach_func_name, "dequeue"))
 			return -EACCES;
+	} else if (kfunc_id == bpf_qdisc_bstats_update_ids[0]) {
+		if (strcmp(prog->aux->attach_func_name, "dequeue"))
+			return -EACCES;
 	}
 
 	return 0;
-- 
2.20.1


