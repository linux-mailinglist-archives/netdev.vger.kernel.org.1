Return-Path: <netdev+bounces-242096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C26C8C306
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2646344ACA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D4C345CB9;
	Wed, 26 Nov 2025 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgX7RuO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CF3451D4
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195459; cv=none; b=k76R0XFJdCgGyP4xFMOyIC0aAqSyiW3cbNL2RzZPcvXUw8kDr/JnWk3pjTHEcWObcdR+hKNXAaugU8NPjHeyVXeglAYxa145hEC+ikB1vPyCg7oPnz9wWIBKXHo9z4GQlPchJDSws1N68uDdR79qAeGCf+OjoAR1BUw+Dald4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195459; c=relaxed/simple;
	bh=WoPr0D480sRfz6MWlBIwr0fT3bxHa92NetIHpnkS2K0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVXCpXZBDauCmMiHTbDPR4tS8iuMcfIGU/keNLpuaRZifQhyPpu7HY6jXn1I+mcptKAmIieEyCrayx8Nm7M/HtoN9lOkReqerHyGeHUCrohzn5Ar5etePFicN9HSJuHPB6EQf2FKrMNEW/MRbc5n91C8G1dJBcUI7k8/zTqk72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgX7RuO7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso180905a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195457; x=1764800257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsdGxAHy7+Lr8WP2LpE73bfJe0tYWCB0gy6QVRcQ+0k=;
        b=lgX7RuO7SM7jiqM614v6//XiOAUOAV8QkOjwNyL1PN6upp8KGWCoOLqH9qZiRG5ZdU
         PMJzgRGNHvkNvZqL+gln6DNlxlSNMCTQDqN9tsS2/vrh5udt0SxBmnNy1ddthB7RHf/u
         Gd1vrwwyXCY+2dnnabFYjigwG/UXIf7fuX7x0IGxT1PPrVP/WuKtB49/nVnQKGZa+vFe
         0r+JUQr82cHTXDM/PgkWHaZ6DrNf0d7eaTLmtDOHWfMCXcwu9pN7NUwH3Nt8y2JvykIg
         yxDrHnLhc2FQRq8XwD4b6q2AMuUR3PdoCINUp1AT+46JnS+Vaj4ew3vnDW8XAWyG7PhU
         PQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195457; x=1764800257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsdGxAHy7+Lr8WP2LpE73bfJe0tYWCB0gy6QVRcQ+0k=;
        b=EAeV2ttSfnaWY4xGk5RUoTVse25fkJeE9yT1/cjxchClGTRLKei/qTbHbytMjXZw/F
         5jHdQgvCp7eo69wPmojaUkfgpaWaHBOWcSpEsftEmvTQxq2DpXv+epy3H7AV06UNmb+d
         QYfDVgflzPoLzTGV0JMlVGkYpXfHuq+uDFxRJizmZoRaJYVrHctW5YjBCPyped7c9IWf
         SoMwnCtnI15ZnjSuQuSf6Yr8QDPMerjSwbuX7GnGeCY5GgRkdikl/P3Q1zCMMD+v5AyG
         v62o2UqmPV1icuZsI2ab6hKiOQE5otSrfDOwnf1NwnbtjW5I5CBkRfbAsU9YEMbMt8bj
         VE5A==
X-Forwarded-Encrypted: i=1; AJvYcCWq380Rr9/SBsXbaDcFB/jodFlPhoCxESUSuV+f6cm+XQ0tNM96v4LYz5ZPzCn/ibAQgQYpsPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20KK4XmOo/aKjolsfdmDA/lcYA0G1P1cXMtRNdJ43azJEcttf
	bhbCM0aN5sSFtmAzcHC9C4/zx6Dk7KUnl6dXTIZ0pktnDXF1MCYBySrgykn5occsaP3Hv+EQNAA
	sNfBSxgRrf90QC6Hpmv3VhYoLgsl3Bw==
X-Google-Smtp-Source: AGHT+IF+NJvGtMUf7g2ELzHlH7eqyOms5MRbRzRX3sg4jry5QurPb9wZ/lrXsK3lya/WwBfrnvChARM33YajCsYgIpg=
X-Received: from dyu1.prod.google.com ([2002:a05:693c:8101:b0:2a4:5178:f11f])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1014:b0:2a4:3593:4664 with SMTP id 5a478bee46e88-2a9413bc7a6mr4857020eec.0.1764195457160;
 Wed, 26 Nov 2025 14:17:37 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:29 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=samitolvanen@google.com;
 h=from:subject; bh=WoPr0D480sRfz6MWlBIwr0fT3bxHa92NetIHpnkS2K0=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNWU2kmKOZhdXtB690uwVv6L7v/qjOgFzz7NXjD6c4
 70U4b+jo5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEykWJjhf+ZlF/E3bzy643Ji
 giKXMGbbsbQEtv3YtzD8QWH2In6FTkaGP2E/gr+r6dbOXqv6v/CVpvabbQ2mapNV+Nzi+m7Z8a5 kBwA=
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-10-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 4/4] bpf, btf: Enforce destructor kfunc type with CFI
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..0346658172ec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8845,6 +8845,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.52.0.487.g5c8c507ade-goog


