Return-Path: <netdev+bounces-256016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJyjMeMbgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:49:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045BD1D18
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59B69300BB8A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99E314A6F;
	Mon,  2 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfnkupnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78221E7C18
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068901; cv=none; b=s4LWzRoUvhZG8IVfHTA5FgHRRDqEAHx0Z2E00D/CoY7UPDcXGprMKttdt/TVQqD/hM8/kYrEFmlTRcp0AjECgucKroDMF4XZNVF3tweEx6W5GYpi+1nTc0VkNuoMF2wjQVAZ5nFo9kE/nfo94e8orjCNuznyv/FKTCRgEKa4+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068901; c=relaxed/simple;
	bh=+AlW4KUibtTEL7aTM7Y9a8q6iUSg1IHY5nxcd67yjd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDzUdLJ3VazRE0rDl3jQbOWUaLNGBZaVPYlr047iLcHo9xrPZOYsdAovIXShowABteavMirVtAdKhZu/9+6Af8p6FAH1ManrBPkRfOL83byYoS1j3LIVf+MOXvzdEUiIMlOFPg8DF3bauOnD8pTVdy4MHMrEFd+vtUsG59/XcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfnkupnR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso106790a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068899; x=1770673699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG68PqzRGVsT32Sf0QIjL6C9Zittl7Tzt3slozf/1sw=;
        b=CfnkupnRtnTZ4O+RhR4f0P33BV7x1WXRU9Uc9/daSSIRaH30M5SMoWQ3MGeDvMrZ/U
         hCws1KAfLOBT2LzN366qXcDE26n+iJhFTtkuN0nkUIRhq4/a8V8ViZz54J7+u7ACLaQ0
         VMT5emnFmsAkF3d9pQrSxwj5YRF66uJvhHlwPnMVBzXDhA/5L6ollB0xW/hG52KEsjSW
         9fnEWje8AOW5UsUWaXknKv6Cbai++daR9qmGVVGe/LVnxOv5mUROMPHqyk0UrYdOHDKT
         NrBNTZA3GAc5z/zLrDlUTaUPWDBXsrgZdjDX6uTr4EGRBfUGHn74AYJBPQ4/zhvdbiXl
         gECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068899; x=1770673699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG68PqzRGVsT32Sf0QIjL6C9Zittl7Tzt3slozf/1sw=;
        b=HU/A/rQkYXvyTvvhyggc0HmdDHbl50xpgy9c7dYZyi7t4V3P3wZmUE+trBvKBNc69+
         q6y1dtrorLbZoRkPZV6f3yCBV74irtq/nUuBVm0/tqITj8+d1/7KPc5DoB2rwpD1ij1h
         s0ltXe74yXlVBvEdh6I5j3eLiZw6Ov2Cy2ZXc4qWdaDWbNGRrfoF2E6GfXKRPRTDklYY
         /tZTDIeLKWUgIjzIk8ZZMWDKmLx4z0zVOz0V0IdP2rw3MXhZXxzhCSeg9yhkUGKsVPio
         sJuV1ARRmLjYK2BPidGVfzSc5sSanAB9L2Ge2DPbaciojR/ukJICtEukyOXIs9znOnaK
         5HIA==
X-Gm-Message-State: AOJu0YyC3yenpZEdg2wkiLgufHj8N/3BFUv1EleW7ePStrmXa9HHRDL3
	b7E1lpS/g1W7ew03YsMGQvJO7piBieqq8ifhRn0Yp4Obj/V9PScNDWJT
X-Gm-Gg: AZuq6aKGmVrqQ+Wou+rHl8UW/xFtKrDEyQ37Ly/BUf2YpEuUozrunkTz7trkEF9Ou8V
	GItm3lpSGtxRO78TkO7CrJNKzaEYKtLTs/4q+4ec0KrigJAm5jenNuVjIcITwVp/jTrFoDDSx0j
	jLM+dKaSqbktehOqtOe8QDB5oAarKGMqS8ulmU8pQxlwaXFAANiZSnK3jLTjXuFhmANaEDxVPhA
	gA4FvYbnPjwcMkOSStpvyu1vvnN4fAO6madXfvYUUYR9a4/qPJ4Q1QrW1odTbnNlKWUckMZytXn
	9zpDsuO/xHI9gMnPCo5p9e4NQJak8qXdHx/mjpWJX+xYE8+UkILnltHeb9WQaQsEbRjAjJWVzSc
	qLAI+kDdn1tzTuLj8jYgRNUx4Cw5crYjPyOmSmdGiv57poORo646D7lDJLI7AxJv2FjttDWkJOx
	uf
X-Received: by 2002:a17:90b:3c8c:b0:34f:6312:f225 with SMTP id 98e67ed59e1d1-35477838424mr595504a91.14.1770068899271;
        Mon, 02 Feb 2026 13:48:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d72cccbsm4716889a91.13.2026.02.02.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:18 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v1 2/4] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Mon,  2 Feb 2026 13:48:15 -0800
Message-ID: <20260202214817.2853236-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256016-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9045BD1D18
X-Rspamd-Action: no action

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f2ae9640886..b44372cac40b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -705,6 +705,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
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


