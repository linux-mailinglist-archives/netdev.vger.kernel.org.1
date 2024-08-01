Return-Path: <netdev+bounces-114983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582E944D80
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41839281F12
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53131A38E7;
	Thu,  1 Aug 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HAa5+eCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139241A38C1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520410; cv=none; b=QdedMhMlvn6BJmL6a/gGHRbAcvx2WnAFrAsWeOUtsbrgeCNApuWejpd6EsJ7fwQkROMD5/WavkKfhJ5Fk+paZAoYwRwvtB+/bvxcQa9+BzCzqPiPOa1V46CvQKFSi0Iq/FIT/s6L8G7D3WZQqowzCDlZmtpaxMYLP52U/8X7zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520410; c=relaxed/simple;
	bh=gWWdO5xBWX5tU7fXTnRIHBQdQkp9TESMBHiNigorEHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfuUSBMV81hfJr2qxrsP2i+VR+L/MuZPTUfVOkOfKZ8ALcpu9KHUhpxxnN3ZapEU5Sm2NzAvbSWJTaD83yX2QXf8L91BD5lHjWDMkTke2gIKfhOkCCU1X8cifg0JkZfROhfamchQighcfdAlN/SPRN9rB5iXK8QJ3o7KwJdN0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HAa5+eCv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso10183039a12.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722520407; x=1723125207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7D0AJSGl0P0jq0Bi/L5OZ1HP+papERMI7L86hsLZjQ=;
        b=HAa5+eCvOLgUVnJvfbhwqz8Z1l5tLrPhMh7H/BDp1RItVc1KvcNlX6/Fw6VZ9oDyaB
         TLLoPiTRbC4otJSbrZa15mR/hDfp2e6QjH49GMuAETR1a/Qu280iFTJrVPph0+VDRHet
         +RnINa+cFILPWM6uR6eG5ixevATCuOtUceQ4fe5w688f46arm94mDNVNNup4TNZZ1oXI
         bEVtmuwhhjWDc4cwW9wlybUrpnHMGgF+1RtvCxKDLuN7J+azQJm5c9UeoXJwRY2nonaX
         oLbUC4LRDkLhzlClGVuFRPcmPlGiBpT4E6q0vefB1CxLC9vRWH9+DR8MM4JhNuHXOL/C
         91TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520407; x=1723125207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7D0AJSGl0P0jq0Bi/L5OZ1HP+papERMI7L86hsLZjQ=;
        b=M0aNgJXyGVzdG1JSOZb85qp2ney01bRCWL5Ky4nnn0PYIk/B94OHE2afQuyCMcjaWS
         OQOcQZP1NT/ilgRufMQlWdaRjBePfNY79+cWEU3VlrJotWC2UiI2MNFt6rVBVKHjSSKA
         RLkNvgLFTH7YSVs4FKW4He+2A7NLoOOk5QyUcgMcYZGjgN0bei5dkrvq5NZSzjjitsjD
         c87q35Pm9OFydnNEJ0ANtbl/ewaKQoR20uHs8zxKLN+fUS24RMljkVOhJ7emS+dc6+qr
         prDNsRHTnpfodVpctKdbnM28YUbLrvbTvHC8al7+ykiqxODNflR7waL1XnH19HuT/VsO
         WDrA==
X-Gm-Message-State: AOJu0YwvyrUwP26OReHTzf1UwrlBVMWqPPR3P+LEgfDzr2HTDgtdjv7K
	8MyGAn58Og2uPtLVm4fySNdNhSomW37N+sk/ClVmNy7OZSF0RQeOTYU2AEWT+rQ=
X-Google-Smtp-Source: AGHT+IH+yacwyAUQPqgzg0lVvZIIxA7JqngOa1jL/lnwNp2hFFya9gzj9Z8wbfNvyhXdzxbnLX6PJw==
X-Received: by 2002:aa7:d357:0:b0:5a3:2af5:c722 with SMTP id 4fb4d7f45d1cf-5b7f38ebb2dmr279070a12.13.1722520400691;
        Thu, 01 Aug 2024 06:53:20 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63593a8esm10198000a12.30.2024.08.01.06.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:53:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 01 Aug 2024 15:52:54 +0200
Subject: [PATCH net v2 2/2] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-udp-gso-egress-from-tunnel-v2-2-9a2af2f15d8d@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

After enabling UDP GSO for devices not offering checksum offload, we have
hit a regression where a bad offload warning can be triggered when sending
a datagram with IPv6 extension headers.

Extend the UDP GSO IPv6 tests to cover this scenario.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/udpgso.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 3e74cfa1a2bf..3f2fca02fec5 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -67,6 +67,7 @@ struct testcase {
 	int gso_len;		/* mss after applying gso */
 	int r_num_mss;		/* recv(): number of calls of full mss */
 	int r_len_last;		/* recv(): size of last non-mss dgram, if any */
+	bool v6_ext_hdr;	/* send() dgrams with IPv6 extension headers */
 };
 
 const struct in6_addr addr6 = {
@@ -77,6 +78,8 @@ const struct in_addr addr4 = {
 	__constant_htonl(0x0a000001), /* 10.0.0.1 */
 };
 
+static const char ipv6_hopopts_pad1[8] = { 0 };
+
 struct testcase testcases_v4[] = {
 	{
 		/* no GSO: send a single byte */
@@ -255,6 +258,13 @@ struct testcase testcases_v6[] = {
 		.gso_len = 1,
 		.r_num_mss = 2,
 	},
+	{
+		/* send 2 1B segments with extension headers */
+		.tlen = 2,
+		.gso_len = 1,
+		.r_num_mss = 2,
+		.v6_ext_hdr = true,
+	},
 	{
 		/* send 2B + 2B + 1B segments */
 		.tlen = 5,
@@ -396,11 +406,18 @@ static void run_one(struct testcase *test, int fdt, int fdr,
 	int i, ret, val, mss;
 	bool sent;
 
-	fprintf(stderr, "ipv%d tx:%d gso:%d %s\n",
+	fprintf(stderr, "ipv%d tx:%d gso:%d %s%s\n",
 			addr->sa_family == AF_INET ? 4 : 6,
 			test->tlen, test->gso_len,
+			test->v6_ext_hdr ? "ext-hdr " : "",
 			test->tfail ? "(fail)" : "");
 
+	if (test->v6_ext_hdr) {
+		if (setsockopt(fdt, IPPROTO_IPV6, IPV6_HOPOPTS,
+			       ipv6_hopopts_pad1, sizeof(ipv6_hopopts_pad1)))
+			error(1, errno, "setsockopt ipv6 hopopts");
+	}
+
 	val = test->gso_len;
 	if (cfg_do_setsockopt) {
 		if (setsockopt(fdt, SOL_UDP, UDP_SEGMENT, &val, sizeof(val)))
@@ -412,6 +429,12 @@ static void run_one(struct testcase *test, int fdt, int fdr,
 		error(1, 0, "send succeeded while expecting failure");
 	if (!sent && !test->tfail)
 		error(1, 0, "send failed while expecting success");
+
+	if (test->v6_ext_hdr) {
+		if (setsockopt(fdt, IPPROTO_IPV6, IPV6_HOPOPTS, NULL, 0))
+			error(1, errno, "setsockopt ipv6 hopopts clear");
+	}
+
 	if (!sent)
 		return;
 

-- 
2.40.1


