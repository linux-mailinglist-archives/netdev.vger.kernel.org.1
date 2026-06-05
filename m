Return-Path: <netdev+bounces-295970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJooDvAvI2pwjwEAu9opvQ
	(envelope-from <netdev+bounces-295970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39464B22E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JAsmLVWp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295970-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295970-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92864302260E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582340629F;
	Fri,  5 Jun 2026 20:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1683C0605
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690861; cv=none; b=iRNIQFRLGJjElbI1LCH/qmtKfjDa0Ivy4jU9l0IERTxSF7/1oL7hstbIZfaRqRbFUqBeWEdz+nL78f6g7rrfnOFSyIHI8SQZSUJXk+Hz0jV61Px+qJqqOcdDISwlYKZuznmuEaG+KPfuQaUw9ht+E656PzB8z7KkUIXIePPnoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690861; c=relaxed/simple;
	bh=5vyxLhszd4pc8MOuDhTfCuGbXmG0d81B+H2+kf+qRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb1aCQvsMBiDYrOqdVXgnRzHbopUSBPq3HVZEQ2UyYYLupLC33LvRfGumoeKgeNUss0vdnwyMYh7pjGtWhIg+esBzRsJz7crjjszW0COI6K3qek2fmiXq9E8Sb3W97Yd2QLde27HGf/TnHTJ/3EN8RJLpUolEQl4SyU8tx0+Ozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAsmLVWp; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f869421so1757772b3a.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690859; x=1781295659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/qqVZz0MXMbG2AkjLHGnH5V3pnHRKsmfhFOzzneMQo=;
        b=JAsmLVWpv67sNnMt1R/lSYnu/3Bz+ncPsC1pi3rvL9w0/xoP3VOVYAKCmSIlmdpnV1
         /TpGA/T3rM8vtDZ5Q5rAJfU1l6kreRiStXNEokmQnKn98z8X7CTVTwRnc7n7bBUZCwfZ
         LmzjHH1bhHg5N0p2KZSObRl3bH54x7ST6g6rRS7/8FG1ajDg33NyrFw6T/vQ4hFF8Bg+
         tyEAZF7+0R0lDe4JLSTJt7nwFBhXYvc9ZnqAy/0Q504MKLs0Sv1G9phNbTVZEUxqp02p
         rz6DoQ9hKUgpUviveJUoVy8GuQr4Uzd5SkXIwJJb1mjbRZPDOmI8LBV3zmqxew2wGMe9
         hETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690859; x=1781295659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/qqVZz0MXMbG2AkjLHGnH5V3pnHRKsmfhFOzzneMQo=;
        b=GRHyuBmaScLuYrcotC1+Z8aN2tFABHjzhbB/ynH1dtan2FMqp56i+XkoXyK78I6dF5
         RvzOeA3+HCvGIl1Jw2JY1JG6a2WtdW48bM169eRD33Fzr216iQT+HcL8vd8SftayhL7b
         dC0gioodeAtGFRsH6PZxn36MBkZ4YQz8Z5M5Uh5VbWSyE/VlEHtrnM+1sHN7PmcRKRH/
         Iiu8BfhIFQKX5Ak6t7obggCkXxhJPmmV9vpghdaR324pnSryW7TE35IACiIqPP4Qm/To
         2943CAc49+G5nlw+MyQrWO53EDclSYgau9I8EBwxKRpiJXEd5ckVLrLSy3yfzkfRqLoB
         41Hg==
X-Gm-Message-State: AOJu0Yx+M9bCgD9A5YErHr1nwq3e1/qJCANwU4anhw6jmij4xuQJvw7W
	EWR8glliQBRmwof8MgrHpi+cGltDGCi/V+UWk0eOC4VQ/k+cK2WWilvR
X-Gm-Gg: Acq92OEgzVcq3sqMHyH7nsTrAP88Wq3rfZn/oXev9bQPRC3uaRZVxxg3fapzmzEcTYO
	tIWk9Yj3OiidlsQh8BjPh7GEDdXcc/AJMyJxeBM47DS+BEY9ron5mcCDYEMeWTGG9B+UuPqV8Ni
	ye5NoOdrglux8pxl+d9yvyBNVCetSKLMpnbaZWk75oPAnWQlu8Oxqm2fBgbGxQ7FM329g2tNP9j
	5gOAutlqA5ZF9UfTDghkxg/VGN+EIppKlRupZoXbDWvcifYDlCAptWmdfabCPljhhgMcCh9aVPx
	1JdVAWXftKd6Sf5iomjGyH6CVtyWNzx1V4IHs3g6jn/aH8gSljwPxVB6iO6d5GsIKZd6rWD49Gf
	Zel60tUlpfI2DfcSpKhmsNT7Odq5oLJDl+cK3M+6xd/x4V1u4DhxtvEEnMwcDOo+Z3pnO5nwftZ
	uBHpggt2FEmQZEWVOZ+UYO2lA=
X-Received: by 2002:a05:6a00:909d:b0:842:7e71:b74 with SMTP id d2e1a72fcca58-842b0feef31mr5186787b3a.44.1780690859330;
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e1e5bsm9955003b3a.46.2026.06.05.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
Date: Fri,  5 Jun 2026 13:20:53 -0700
Message-ID: <20260605202056.1780352-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295970-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D39464B22E

When acquiring references for struct_ops program arguments tagged with
"__ref", the return value of acquire_reference() was stored directly
into u32 ctx_arg_info[i].ref_id without checking for failure.
acquire_reference() returns -ENOMEM when acquire_reference_state() fails
to allocate, so the error was silently stored as a ref_id instead of
aborting verification. Fix it by checking the return.

Fixes: a687df2008f6 ("bpf: Support getting referenced kptr from struct_ops argument")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6446db9628ae..80a72402463d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18362,9 +18362,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
-		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
-						      acquire_reference(env, 0, 0) : 0;
+		for (i = 0; i < aux->ctx_arg_info_size; i++) {
+			ret = aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0) : 0;
+			if (ret < 0)
+				goto out;
+
+			aux->ctx_arg_info[i].ref_id = ret;
+		}
 	}
 
 	ret = do_check(env);
-- 
2.53.0-Meta


