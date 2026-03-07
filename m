Return-Path: <netdev+bounces-265101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH+cFkfKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:48:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C722A770
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47F263062EC9
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415A37B03C;
	Sat,  7 Mar 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4c8jrBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB637FF4E
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865891; cv=none; b=SkEf4wetx4nO4mnFI33f1Wwpadu8FVYUAgOUKjHn5F7AT5E5gnaFM5wLAK3F6irDCXbiBkqwdYpuBxHqHnkVfaUjZXwO+p1bM6Hi4y+AK30tDgoK3b6UQGBd0iuG967clNoOuqEjRvVlcbexBL398yVpqXSzswm/0YNUKnIEx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865891; c=relaxed/simple;
	bh=+lr2vlS6ETl2QkmquAVBxAjL9FC2dwcWWpltl/omZjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCM0skcvshrg8pywlZ8+1uPFgGClSgPk27cjjXiHjcOJnCLSe5hH8bnsghwOl/a6vJ7MBbkL2aofhPuhvEl6rHt3mybwAI0N0l/clF+ZQXoyFWfDE3N3dmIrEcKAIif3o1b195ZS4zJsIBDZqpRDdbn+mZSUizShFicqBByvB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4c8jrBP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae8979dbb2so4725465ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865890; x=1773470690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAvuWZcmmyV939xPdlaiE2LYkNV1C8x4Vf2BYdbK888=;
        b=X4c8jrBPZxBiVmD8cScK4r9cd0pR4FlAGStGR+iMiPWrzn25+4hgaeelW27MJ7XauC
         lAB6FVO/OqLrgcMIznET9V2shl+Xm5czY4Is7brBsHt0LWxd+KrZjJ4Lv9Mr/SyPVT0Z
         UM6QvAIPN1evO8UKqR83AvjzNbTiyLFC74s9uK1azthlk5xzs1VgC3Uf31itfXw3CL90
         o7FFqzlfQjIg+css98DGEr/sgtL8Pi7K7P2E2K6+Xx27/uGIumYnoOZPhw9oQ1PvZASt
         xFqMYyEW1VZS3jWBcWOhpaRql4LWBUh/cuou0F5Ax1VLb/GaVhVf3DnF9g0T6yHwbLov
         MkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865890; x=1773470690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAvuWZcmmyV939xPdlaiE2LYkNV1C8x4Vf2BYdbK888=;
        b=nFTT03hOlvz01fvHSlXgETN0mZA/YNxlawNJCR6utXDVt/oMAVJdvAq1UCDKh0nVzC
         9Ccash8oP0/80YCSQ5uTRMqCpnoCtctrFnPc7SZtoqEF8lnzcplLeSoZE2HhCiwjXupF
         D1MSFPsGTy04YIEsPI5iwaTOzIC7XgDWgc/B8YtAmeQQ2plLtiQAA1GriC0GRAhENBxy
         H8oHOFIb+NDTYT34uzDbO4EQP9rasrb68J3DLDmqK+JH27SC7o/Sf148YJJrZLgGYMRL
         sXcGrj3Aduvov60sYkdKVsk91je4KMEZsAn1ajraKGmsr/p6oqWW9XWh+076jjpAAD8e
         +TaQ==
X-Gm-Message-State: AOJu0YzO7+90+wNZrEdB8Cp34p2Kq8sF/KQTojo3jtPgB3X04X5dWWIZ
	hoBeAk0B/vl/xOZnPK+W+Fx8omHpU+L3DNmLxOotl1BMaiosCA2oPcYg
X-Gm-Gg: ATEYQzzZjiFDXbv9zp29HjMQYG2/gSPU1I88xjPInIMrkY+5BP7v8gXDAAPFs4WFjU+
	O1AvLobvreP3MERV8hnetxars38qakVh1seQvQ8ViHixQ8/KseXi+SN1NR2/UhebbiHVwOBjksF
	rKk9dJy55kOUThTkQBbvsp4XyfjXuzgLirEIIJ6kJXyW4p4tSbSZnHiyeLyt5v1neD1BQqgIZZA
	ekO5S0sZRQrL5x3U1kh67xoFdOL8tdpI/XxkHQFnKIF3JbUlVcX0Gglv8F5D1qeHhGiLiiNlLXu
	zGWSW866Y6Xd1mR60YOFCd5u9xJ5gipzlotL+1mPbnOl4y5m67sN17XBABwGM53hb2XP0f0wjld
	d7ieS77DsBMBb2xZgSqD1O4CR34PKci5VCvNZNQyQTM1HUHwybOX7X8bLnU5Enyq9s3QK2SSHug
	2rSWkf83XMbD1Feg==
X-Received: by 2002:a17:902:ef08:b0:2ae:5b64:12da with SMTP id d9443c01a7336-2ae82506badmr52343715ad.45.1772865889893;
        Fri, 06 Mar 2026 22:44:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm53870265ad.61.2026.03.06.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:49 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 08/11] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Fri,  6 Mar 2026 22:44:36 -0800
Message-ID: <20260307064439.3247440-9-ameryhung@gmail.com>
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
X-Rspamd-Queue-Id: 2E3C722A770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265101-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 631e37500ec6..6b162512b0c9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -704,6 +704,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
 	return 0;
 }
 
+/* Cannot create dynptr from dynptr data */
+SEC("?raw_tp")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_data(void *ctx)
+{
+	struct bpf_dynptr ptr, ptr2;
+	__u8 *data;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data)
+		return 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(data, sizeof(__u32), 0, &ptr2);
+
+	return 0;
+}
+
+/* Cannot create dynptr from dynptr slice */
+SEC("?tc")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr, ptr2;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(hdr, sizeof(*hdr), 0, &ptr2);
+
+	return SK_PASS;
+}
+
 SEC("?tc")
 __failure __msg("cannot overwrite referenced dynptr") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.47.3


