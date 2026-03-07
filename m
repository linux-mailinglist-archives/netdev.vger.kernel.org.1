Return-Path: <netdev+bounces-265097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKDYNJTKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1822A7BF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0387D3040DA2
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787237B40E;
	Sat,  7 Mar 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLCorju/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3237AA79
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865887; cv=none; b=SINXAA9B/11qXMXSNp6KKZ3VWs+aDe0SkYDWB+uw/I5BUTncOD5ezwLA8kBc0ByeR4qx1r0DSCdoLVEt1QEimgUCMiUMqis+5mDndpNMWwOzOJVUJbtoxgFZDxQYJF4WzNxHrltcoge0Ck1TS0PJ2irjaF+weuHpcQ5H0eEOTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865887; c=relaxed/simple;
	bh=78mFUcjNUhU+/beghqjp/7We/0Zd0ZYpScLfFzhKku8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1/ItFiLhJ/t0kM+ce3XnE056DRViJbD0EEdaGhoDM9NONgEj7fgzHUsGcI1lTBeOjptcqmP87Z+Xq7gJL92//Gh5+bJbPQHTYNxM0jCH8SUsGfOxbn2R1Cmkoe8Ydz0yVvojaN9MP0BlvbdcONJUYfvW34+z42G2cIURDGGqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLCorju/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829afe24fb5so447075b3a.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865885; x=1773470685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvUn/zlTI4nC36Csjw0hz3VgIHs5jPtoGtL/EDdDIEQ=;
        b=gLCorju/JcfDx48KQbpliV0/ksiZq9JQsu6FVX+ysJgx2bp1u7eoxBSY2IJ0ZN8vvy
         YFMvaWbBW5tAXVVsf8tlZDt1v5umB0bUSGy9UPK8fzHbQ0DJrwk5AGzwvaV26MlNUfVX
         n7GXuoVQ1JiXEwdeJfm7f2U7tflnGiSX/GPmZtQvOa9MPG10iUFCQAyaFDxC5IC64zK4
         mW1fH5o/ao1Le1nZFsBPJsVczxmDrHz1jUZkCVDd0c9MGWfkfQVdvWk5WAc7sioau7cG
         RJseB/1SYfwvmL01/vVZMVgnFokk8X0I6mvIUl3AgfVmwA1NOnAAkzqOWJEEBRGojb0d
         i5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865885; x=1773470685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvUn/zlTI4nC36Csjw0hz3VgIHs5jPtoGtL/EDdDIEQ=;
        b=ah7TXmyJq8XV3cXRIJ5NNDCmE+WGtFp32N1FJhGQ1V9M450r0M0PetZ2kj+moCXIcu
         OtzWmbBngoMUIk5/ZdMOTmjCCVwkDP5Yzr1fmca1FDFzXHgl1EJ68BaPnscObl2y69wP
         Kgc6eS+Md2KFc+NipGzTpahmsckHzexdeYfnoSCrzryBb0ghFXmqjr1bxiHrXXXBl+0r
         7036OTqxzrrwiujy+0Oawc2MIgNWTGw1oTicJQf4qhCsX/U0ig1dVEe9kxjwr4n0wG6x
         AXAAzZEfEz2svTlNyg8GUIpH9t7HTm56TZ6IX0KkAKLXFnifaWLNiVPTDSMiaw0vn4ti
         Hk/g==
X-Gm-Message-State: AOJu0Yy/7/8X/A5zyJnCP8JeKOXesaLLkTJLFieS6p0+DbUnsFN+aM2O
	5x/J/AmlaxRi6elHYn6TthgQhawKG15WfA1puMR8bIVZLE6RWQjaKuTR
X-Gm-Gg: ATEYQzx98PjPKN6qMaNptZKqh+DA9Kf7QIxxKI/A96mYZi0JPwuYYqsIzrqBelf5nOb
	RH1ZgOQYvwF1iIORozk8UuL1Ou5TcYGkFYrd+74eImDjRelXlNmGMOhO9ILKMjxRv0pG8BBibtZ
	a/XxVa+FZV2ZTxeQGmSe9b7QTXAy3iAR6qw2go8AlD7wStNyVlomOJdOxUGf0W42O9yUjk+YF3U
	w1goaak4lPsP2HbaNJwc9sX4tZT8hbgxpKuDHtxxfgAXw421Lht13whx8oQPtFLwvxftc+uwoKg
	Y9QsREp+VxDucP42QRsbmhkDXq1KSg8/4uGVENPxQoCMENznwWbmCbdOIhQuah5102H+4qBH7KA
	8nfOJnrdbKNPkWZoYGQ6NIY2nf220kuqgfK4uhvE7d2Dj+25A1rZN+QaFrwis0Id1kWJ0wyqHOg
	1IzsDr2PMk3BT2
X-Received: by 2002:a05:6a00:4006:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-829a2d6e529mr4224203b3a.6.1772865885305;
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4656f36sm3463022b3a.14.2026.03.06.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 04/11] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Fri,  6 Mar 2026 22:44:32 -0800
Message-ID: <20260307064439.3247440-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19B1822A7BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265097-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d52780962adb..ea10dd611df2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7754,8 +7754,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -7765,8 +7763,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
2.47.3


