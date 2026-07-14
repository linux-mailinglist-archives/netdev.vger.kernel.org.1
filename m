Return-Path: <netdev+bounces-307550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gyYiDZ53Vmoe6QAAu9opvQ
	(envelope-from <netdev+bounces-307550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:53:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93C757A1C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:53:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b="Z9r4cc/1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307550-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7040731C48B6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069C327C09;
	Tue, 14 Jul 2026 17:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9E32D7F1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051336; cv=none; b=Y0Z7PaEC54746rMnJNNtxBuvh1lUMBSjoySBXxCVqaR8XfHsnG9HlXzSbFcpxa0E8lkYTsWrKWUwti1IvJLhM3w4XFZ5s70ih3Ex8oRd7XGWKIitQtH9PP72ua5dpoLOI6RARWZDeXDaOorGKLP2RXnpIkpKaSY10LZb91rvj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051336; c=relaxed/simple;
	bh=oEKUFe6He9YyzYnObHI4KSO0XtXvJ3JdBWqhH2AueLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCh1qwp4aH1Ht/Vj+uyApnkYfI9kpinQKVgSilsBFGPmQeaxhBJF2/ORTxD11uLq90KwWjwqK1loWXK2G+wzNVimhtzj5YXy2SnJSHVWJd6k0lfGLYsj7gqlEw79H+grUqGYJu0TqybNtARu33td77gOlKtBeQtpE1tN+AVmF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z9r4cc/1; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b7612475so35697765e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051316; x=1784656116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raWiwRZEQQqDhRSvhhJ/GJekPfKvlCApx6athB+xse0=;
        b=Z9r4cc/11Doh09LsOwsxu+BBuXgz9odTIa4OHFm/VPxcppfihsCR2dKswqqLDu1FBD
         mpqOV5QeO95y83NZgcsZNHagudNnFmocRsfw8Iw79oWKoFhG6OHdOUz7X+IyLeY2M9FU
         7dqMFpkSjgBP+1xfchRXPk8vTzybsYT4PR6kF3iCUkPhJPvCaFYp+rEnBPu3kwhifw6k
         LA4LpqbV12hrHndNj0F3xX73cTqiQoF2E7KT/YsqWItGIETWbk5nd+saiqkPilyhM9/x
         homJRv4XO2/qPw3UViINJN/2PweX2wX9VrCBFJmuFKbKFHOyDe4Uh+A71rtZBVMpsBsC
         ESLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051316; x=1784656116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raWiwRZEQQqDhRSvhhJ/GJekPfKvlCApx6athB+xse0=;
        b=NAQoqL//tVQabx+sWwP5FNta4DoUPjmbKcGvl+PWPXEeBoBfejhrJ//vbOifNe7FRG
         jadFiO0RapQHR5MNDJRS65oBbJ0ZGZRJfY6/pU+t/l25y2BjjOX00Yz0jr8eJBFJllEe
         WDdPAbLowDWclzMyRgJYeqxl7UxyPtNg+dQiAqzQnO9hmDs/5Je8hhtC2e8yfatLbC44
         VblWuSC4P5Itqza8YBjuEnQJFvHKhGh2blDrqmtB771U1TgU++ZouyD49+HD1FXVxIns
         lEO1GIxsQ3O/AxJn2+6FD4IpsmnQOFeezkhzZqOMBP3h5xjk/a5+6/CkPJ7luTnYPcpd
         Glfg==
X-Gm-Message-State: AOJu0Yw7SDSt/z4ijUic+rb60T9wVXhSayKxQerzrhO4ba0yKsSNwZFs
	1QkkUkiAKCKkMNHrv6qsySDvpUuoAxCWyy3zN2OOb1IZg8LPx4PbdCMBk3WHTcBkUdQ=
X-Gm-Gg: AfdE7cmvLVm8Vuas9AI1KVed1VW3Pql/ikNV1aHb2K0vxZKsvOiILkmRVMWks7t95uj
	bXUTeL9e7rCNTnsfgYNci8vkrNNceEs1DZEDYsMI66T0NXUhlxUipHJLhJinAjw9P9hq/jvSfJ6
	GmfCghiv77wCOCRO0vCXnpp9rqT/GJsDR6tb0ykzStwxiuvcO9oZvvYiyMV41lNgRjmmfL/hGJx
	CfwWDjLl/KxFc8/EJu34LirIb3PBENQl1YS1X1EvZy44stznhNsjwzYBn1T/4zBRVJBfr/3UOF7
	KzXBfC5Q0pXxhmZuj8c6Ul0zNg5PDXxaVL5aZy6oi8/cd/zBCccEa7vZvP+HSgGLxMvITqL0Jls
	gF3XH0aMhwYPEkjwvYLYhUwSy0c/ejISRVKF7HK7aXjcDx9QAYbU/q6l1eqetdAJNT4b+wJO5KD
	8JHkAAEpHC7aaYLtCxnNavqRPP+z4+ePaRoe9Y8/WNGSJRkQ8=
X-Received: by 2002:a05:600c:37ce:b0:490:b189:212d with SMTP id 5b1f17b1804b1-49518314f0cmr53886715e9.33.1784051316176;
        Tue, 14 Jul 2026 10:48:36 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322c86sm83493315e9.11.2026.07.14.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:25 +0200
Subject: [PATCH RFC net-next 6/6] selftests/bpf: Use non-trivial test
 payload in xdp_context tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-6-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307550-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB93C757A1C

Replace the sequential test payload pattern (0x01..0x38) with
higher-entropy values that don't alias common protocol header fields
such as IP version/IHL or ethertype LSBs. This reduces the chance of
false positives from stray packets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a697e8f63722..0a73035dd855 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -14,10 +14,10 @@
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index a1a3cbdb85bc..7e5a9d14b572 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -28,10 +28,10 @@ static const __u8 smac_want[ETH_ALEN] = {
 };
 
 static const __u8 meta_want[META_SIZE] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 static bool check_smac(const struct ethhdr *eth)

-- 
2.43.0


