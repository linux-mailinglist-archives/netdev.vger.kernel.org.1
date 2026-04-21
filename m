Return-Path: <netdev+bounces-280259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B+eCuD152kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64944001A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FB473033A7F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B23A542C;
	Tue, 21 Apr 2026 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLlV1vzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189E3A0B13
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809422; cv=none; b=rYvzL2DPjCGMs8JdSL3sl46dUzMW8UDGF10q3yEQrkuZ1HHdm/RD15jMmb8BjzMmqAZ4cKFrEwMRctcT37uHwObECtNrsArG1R+hgQQiutROdbk7d+aBjhGoV55PGIzXFSzFRP3qPn9aRcAH3cT2baiZByL1Qj5O0oJ3POIu6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809422; c=relaxed/simple;
	bh=8P7GcnAnWIUAzSkkjW9oX7NjlLj6pYx0OwoExnLCh7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9tmiqrazexlWyn49rtop2A+/+XbQCy3W7bbnRPI854uTegXdYJEpmKmoGICGiKyfuf4lag62CY2JjudJHG+FpZitkuZYMzoMUsibvI1w0zxj5dGQPMoIVjO/2SSXIpRxlI4WDX9tdPtMRdKJHBkeEb2r+5K+fb6IAvYPBcf7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLlV1vzr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35e576110adso3195979a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809421; x=1777414221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4ZOy56vWlLqlNhtiTENtyLjo+fmzW/yKvl1RKvS848=;
        b=pLlV1vzr3rPHGyIZ2L7Ae5xqfq6SXc9GX0UaVwbv33vityeVQkirC8Pm905MIXhgo6
         y+jjMf8OgQsMNC3SxPa6hmmeHLnnUuNyyvFB+z3z+9wV1cpafSnzpmX7aZ7mBXLDodMD
         9z2ve86WRHMn2oihYQ9LqS9/PPkTGjNDoTc/Haev8NPeKV8WPdhzkU7XS99odeVWG9jz
         y1TMHZ6uxRMj1QX6tKGpMUw5pQoT4Wzu4/GydL4JbV44QcTkvPrAboN8eXPE31lPgR9s
         XcyWlB66VMeT+cTzcjloEaWLy5cLCs+XikLxx03Mp9UslUY7DPDNle+KzoyVXywKH8AG
         LG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809421; x=1777414221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4ZOy56vWlLqlNhtiTENtyLjo+fmzW/yKvl1RKvS848=;
        b=DjziQAy8QZdlzAnE53iNMpkfobrDYO6C8kAVxpVTrFd/W7f2ufuIKRx6a1cW3tDFsW
         ukIMoAGnb3qfWCn+xtvnnzYuTD16qFEWAdOFvPNyjPXVSJ/bveU+tSdGbVeYqW5xepBg
         GTi0P3V6vZIqvMprVpn5n9uYisH9lZ+90qq2LaZki1MkB3+wvAVxUGLrTBybbUHKTpoo
         hcw76X4aaxze6wGU40pqqRMndXQB3ox5QxdNbWIw7bHHa1/Irpi1YPSO7hrL7fi7Lkpt
         2gjUtoi4z17gpc8Xu+jpS+5Mze4JOnYoMZnts65NJr29Dnla5cd64Egh964nIbPtJmFX
         k5XA==
X-Gm-Message-State: AOJu0YzbpSODWUDgOBeOJih3kV8twAvPAEnw3LjKlIJLqlQPvdB8ID/z
	9Is4/82aBvTBar17sp7xdSriHdScKx0XqJPFqY0lAOXShNBwPqkoUe7zksjjKg==
X-Gm-Gg: AeBDietSCVWJkFkHdHP/WLtYOvMBc/RLQVmn720YdfrcOYLg5fm4JQ7Znz96MHiTtZY
	fdb/rVCE7jnSHxUrWKDGqmJj4G4C/DIbfSsJ18HL4/ctb7oC2Y3otnGzAmhpKuaE8J3LuA+79OG
	FI98nVz/G5X4xyNhbqoedJe+Mn6S34TEsFel4KJrdyA8zkVtQX+IBllhxZJNlKEBjPPpeO0rQre
	by+AEPXuXecnodwLJ+W21+NRdTcgTTfeF0Xx6b7QUlI41rUhxvgXFp5HPUyclnxVKUbq8sGRM7f
	UknURIOEO5OVk5IWrqik4k4BfRYopPAs0Ibuv5B3lrkMyuHmxvkHQNqS7PtbaCQgDe46pSGBHKV
	JOvL5Z+Ye7QfY6mnb/P6fs8kx+HBxbdIEdgBAdzxKcJ+0uT8hSRwbLr/b4btg6Ip3AZK2D3XJo8
	wujvp1JES99IAAEL5rovrPwf6G
X-Received: by 2002:a17:90b:2884:b0:35b:e4f0:f9b4 with SMTP id 98e67ed59e1d1-361402908eamr15151234a91.10.1776809420957;
        Tue, 21 Apr 2026 15:10:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141869e88sm14437574a91.1.2026.04.21.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Tue, 21 Apr 2026 15:10:09 -0700
Message-ID: <20260421221016.2967924-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280259-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB64944001A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41e4ea41c72e..93003a2a96b0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].id = info.ref_obj_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
+				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
+					regs[value_regno].id = ++env->id_gen;
 			}
 			regs[value_regno].type = info.reg_type;
 		}
-- 
2.52.0


