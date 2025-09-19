Return-Path: <netdev+bounces-224919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A8B8B9AA
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A32D58689E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453142D3ED5;
	Fri, 19 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvGK1B2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88521ABC9
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323396; cv=none; b=hgm75l4aSnBIsvn04VKZ3lPNFlZUAwsPw3q/8wFev3nTnu/Wnez7rXcusVHa6g6NH2ChudVv5iY3FL0p14U6b8+UIvtMDyou0R9LWNu0N8U4gifeAlkaC5XhQ161eU7Uyw/RFnXtFh+YSgBmD530kgqdsybOGXjW/S2tiWs9nSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323396; c=relaxed/simple;
	bh=5Wh1I62F1f9o/ydZ0qw8dXoBNDdZQT9dEqo+DcjIuWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1cH5uAd1zJ3ct7Tu38tte1sHOshC6cyhcZ5neLP/qfZJXx21qf63q2MrwHwjqlcKNQcmmq2hAOpc0Bu74DNrnKSOyHnEsze107VrOZMP0CRNCcVGP4WiDue4E3/9CPManqIU6ZHlsQAA1NrTFC3lb9oKcAgaUyLNxEAVMOj8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvGK1B2w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so30373185ad.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323394; x=1758928194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=KvGK1B2wLkX3jggfXCvauEdFJa60UVj0Lg4RSj/1X2SBArSS2hzdurrD9hjSAQJFPm
         kM6eLYhemthnr3CfyQ/OoIx9klcbT2m9S2vjL073xFLSiiOfZGkf578ajyMYYpu08kEp
         tA+nJupFJKeq9r+o57EHGQSWrAFGy+RYUBmPoNHgI8HIFjDPl5utfm2EJ64n7htUVEk1
         aP/GqNOPgxOR7YyiLFS3URJomMog4W+aKGBD+7RaKuYvLUfwBQh5gFUBGhE4t8OpL9we
         MhOVj6pe8owAcMV0AUlk/yeCBglTsI9I8vjngADkeIGhk+9A+9h72VYorpB1ix6FkCCQ
         OW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323394; x=1758928194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=R1g5BJtJz1Jnxd1pychgu87GdqEXCgQACZHwFzGSRV3lIPnFSL79RprQgFUY1x4CRX
         /Ta46yd6LdadllusH2NaRHEpvuco0DWCCMa861FTwT5ADJ+gll2bQOoIHfgb/CBE8w0R
         +Bk6iIeorvOa8+49QzmUGIP17ziTLHgG4qqtSGB2ANjKtU0nFeKJJKpf4djenkCqqBd+
         K77uJTTnHMFXxqux2Ei7GnHDb1SwY75EhqBGybTnf/YdSg5uF1RZEvmHs2JVuPitx8/+
         DD0Tc380LBUGCjtW/AD9JoF5fI3pS+FjndNgv3G8KgML0qBGjgwR09whyz+YmrYjtI/K
         Zxdw==
X-Gm-Message-State: AOJu0Yw8ElT7Ya6Y2dsMu0I0sO4/kpZ/ryMzbnwc+vEawjrAIAMSqkLw
	Idq9dzpw0O9TZYwKaT1dLM1eZ4Ns9hsAuYUea+qsgN3GxspOBbYIrD3A
X-Gm-Gg: ASbGnct265gF0S/xPbdUzY1fuz4Yeert8AWH5MQe5m1sSv8A1D3dqgU0HBxXjzsqHy2
	/jz6Z5Xm99qCBroKWEf9RZxnyRnq/8tjHFllUUHELZj50yo9vtpFeezUv6y/pkTwGMNNlwnVW2P
	2K8zXrScnuV+9CO16EHmp36IjERYjKf2B0Y4IY1t98+4Ywy8In0hBOAszC8vBEojmIR2I6z0Es1
	e7SRR65qcl1z4aSax/ebe9zoDXlqJWLnRnvVVD2jLqHkFDreGrFMr4z/vx5e6tOSEsaF37TvX5t
	7qBPL1bRAGVr6TZVjlrekRmxsmGBwXmADNppP+OqYIWr2wkmzhcHKZzgiuwtQDh7kmQIpMMtZW/
	FNgoOiuXNe/He
X-Google-Smtp-Source: AGHT+IH8P/DkShMI85EvZJ5v6MDd9+mObIek7fIZqM+CU2TsUvLqgYAhWUIqbWS1GKSbuWmJDThg7w==
X-Received: by 2002:a17:902:ea12:b0:269:68c2:a23a with SMTP id d9443c01a7336-2697c829e97mr130771425ad.11.1758323394000;
        Fri, 19 Sep 2025 16:09:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e0cb100fesm14969115ad.1.2025.09.19.16.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 1/7] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Fri, 19 Sep 2025 16:09:46 -0700
Message-ID: <20250919230952.3628709-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for bpf_xdp_adjust_tail() to free all fragments. The
kfunc currently clears the XDP_FLAGS_HAS_FRAGS bit, but not
XDP_FLAGS_FRAGS_PF_MEMALLOC. So far, this has not caused a issue when
building sk_buff from xdp_buff since all readers of xdp_buff->flags
use the flag only when there are fragments. Clear the
XDP_FLAGS_FRAGS_PF_MEMALLOC bit as well to make the flags correct.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp.h | 5 +++++
 net/core/filter.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..f288c348a6c1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -115,6 +115,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..5837534f4352 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4210,6 +4210,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 	if (unlikely(!sinfo->nr_frags)) {
 		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
 		xdp->data_end -= offset;
 	}
 
-- 
2.47.3


