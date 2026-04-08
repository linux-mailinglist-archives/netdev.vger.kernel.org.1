Return-Path: <netdev+bounces-276309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIVMOOv+1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417043B7E58
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 719F93034B11
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06767366549;
	Wed,  8 Apr 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cogtInlb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C436C0DC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631919; cv=none; b=IjgWl8RFVALrVZgC/RPmQD9XBEbfO5mj0eMcLQ08OZ/bA8/C09sv7lEYbpQGq1+hpPxa+KHyVqsLF63VN0tVzCMT/kG+Kd0W4OIKl7jZatWidA0DOTGjf7iXJAt7JnJMe71zgiWXvgy6rOw7rqaJQB1byONTVGc0sMmGI4jX7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631919; c=relaxed/simple;
	bh=KR/T7YviX6UrlNKw6AFlPmhydARpXt/p2up5lC3XWuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgRTFY/NfIQm+D6ySJ5LUk6iOCdL7jAG7pNqde4xH8x0MmNaOtRUgZQYswpVVJEKGVnWlu8OYusCg6tgGeH9jSz6+IviAlmtthDTJcltxO5GldK7cmBGYXRk1oF1zYKJfkJCJKoeQARgYa2M8K7WPcgdbVAwM8oZKwEkn4ZeqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cogtInlb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Jigwd2462286
	for <netdev@vger.kernel.org>; Wed, 8 Apr 2026 00:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sO49szDcSJeq7BUw0LkZ22DZ6b590AjVnZTg10aLnzw=; b=cogtInlbJ2Gl
	xKAKjZII+cMRQSrZWihPvObR5towxKcIu5KPrYJu+WFbdwjLM22HyLiNoRg5pL5P
	FlEk9dGUEc674Fpv3qay9VieFtDr7UyDlFsTVK3FinCMEA0d0wdBMjzznGOf+IKc
	vsBitt3WBlsxBtem5779wP+j16gyPZyYernjGB31uxqZall1Gd4RTul0oJjVSs+r
	MGCLSADJCp+9Hf2xTa7vzBiopqUDdLMI//hSkZ/HJHML+FRcibQhkbTHnRqIMlmg
	p6qURz/2dkiPkAllfo18HJlq7LyBtBOmOSVaRcspCODRzEVnopVEbsU06aXXFgGa
	xhXgp6QkGQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcmsj9cc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:17 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbb7625a6eso13186175a34.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631916; x=1776236716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sO49szDcSJeq7BUw0LkZ22DZ6b590AjVnZTg10aLnzw=;
        b=G6nrJbJvZPY0YaeuzcpG/BM7sOU3TDlddFBS5BmhzQKKRElIfNsNJMBXVPbD54W26B
         KiJOVSxRbs3w5yzGI2W11E99wOgjKF40xfxDaR8HOlAXcGEV1KNCbye0UNHtd8dDkHQV
         NQKiNsLdLhaCIyR6B0Pp8jRHZruJ9xvvy1pwYam/v4TKoUi15SOgzF2bu61azGxiEgYd
         1jt2tN0QiZl0OYC2IB9Y6QL8d422yE9YHB80AE8UlW7ND+J8QOI6otlJkpTQicJB+AoO
         a7JjwIWvRTwIiU8a3BxedCQ0im4+mg4JbDEwSxoEebzn0jTy8EgBbulRHYWFmZbi/3ok
         iFKA==
X-Gm-Message-State: AOJu0Yyfm3sWH7c1qVxp5G9FHhwVhLhgQ1+3vEwGPsBx6zxjzKq3fDlY
	e2p7V8gB0CSBU3Tv9KA2wo9DBCgziAN8dq0M5H+kKjzttjL+ZQ5M1phxMGFbtNCsnKfEPIrng04
	jl6YOhClV1xVXECYxyPow18jjf8KSHLSl8mN+DE9G+ZihDuIXPxnafOc+0xrwuCFhnHvtzf+awo
	QrQRKkiL0SIuYd9TwOxXrR6m0+0g43B4Jv9ynW
X-Gm-Gg: AeBDieuKpMIXZ8Vo8TWutOx0KI1d+s4YvnmK4RJSa0+BWgkBzaxYE+S5RTiOqaEUqHc
	iPb2ksoLR6hIOGr+yuG8UJY7clZMZuprnG3f1eQUP6LcyLLfUo3oMckgFNzTJhD32X4ZvA+7i0m
	ytVnoSN8jCay0pu5CyIrFgktJyxQuVtI03wjo3wcGSn8qMEEQHonkm6F+KnL7HqG9ahg4PHj3uH
	Rg4yfEvdx2uixN0Bo4LOaIRzSLBoNmuhdxqPCdrmkkOYdLe/Ebv8iALBRL8gnBxFs1J8aB9Vnj0
	Iz09jcQNNcvV+4HdT/6nY3o3WQwxdJs4v8viqcMeEjHvtuN4P0geBh+FnVZsJgMFDZgqtnwUJlz
	kKl2kRUAzdw==
X-Received: by 2002:a05:6830:3c0e:b0:7d7:c985:3a30 with SMTP id 46e09a7af769-7dbb739693amr13410952a34.11.1775631916102;
        Wed, 08 Apr 2026 00:05:16 -0700 (PDT)
X-Received: by 2002:a05:6830:3c0e:b0:7d7:c985:3a30 with SMTP id 46e09a7af769-7dbb739693amr13410939a34.11.1775631915570;
        Wed, 08 Apr 2026 00:05:15 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fd29bsm13373680a34.17.2026.04.08.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:05:15 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org
Subject: [PATCH net-next v2 0/2] tcp: rehash onto different ECMP path on retransmit timeout
Date: Wed,  8 Apr 2026 00:05:12 -0700
Message-ID: <20260408070514.1840227-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408002802.2448424-1-ntspring@meta.com>
References: <20260408002802.2448424-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AqHeGu9P c=1 sm=1 tr=0 ts=69d5fe2d cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=HInknw1SORMIDQQeiggA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: bxq2cZ5hFSMF8NFb-bZNuz_EL06OUSa-
X-Proofpoint-GUID: bxq2cZ5hFSMF8NFb-bZNuz_EL06OUSa-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2MSBTYWx0ZWRfX313SV6XEsu5O
 dyhEWfVV8n5fROjY+Pb1j6nTyrrOEL/usQY1h14qchOIXDiglKB27fk4IBKvyn46WgxrLuNQh1b
 udxhEpqu3CSR6qYQ9eqFHfXck9V0gcZEu29KCU80So7kK3p+lz02NJh0RRaLkfDTXF8g1nMLMZU
 NI9qjnZXzc9qjJmiiAorkGZkhNbJXruMGPR2Uvs0b8sKxEPoCnUMXB36GhsLtAF7U7+TlU+LyPS
 xsuxpCqR+ZScs1L5VIFQTVv5oPlMIDJDxi7hOL2e1Ved1A+/q6qQi+MvcPjfwYoJ5ghEW0RTrXm
 OrE8th2BZgeUyIoQcD1dTrfHQo9lTml2IHCeGhMeAcBcaQl4gBSDKP8m1RiSHPW0Lvt1L6t/V/H
 ufWoZx1Luw//KsYdCD7YsEc6y4eOpZV/2xcYa1o0K2S+v7fJy/I0894xHxXzSt2RJvIF+mpzl/O
 +rj/6biCuM9Gw6Inn8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276309-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 417043B7E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make TCP retransmission timeouts select a different ECMP path for IPv6.

Currently sk_rethink_txhash() changes the socket's txhash on RTO, but the
cached route is reused and the new hash is not propagated into the ECMP
path selection logic.  This series adds sk_dst_reset() alongside
sk_rethink_txhash() to force a fresh route lookup, and sets fl6->mp_hash
from sk_txhash so fib6_select_path() picks a path based on the new hash.

Three selftest scenarios verify the behavior: SYN retransmission, SYN/ACK
retransmission (server-side), and midstream RTO on an established
connection.

Changes since v1:
- Use tcp_rsk(req)->txhash instead of jhash_1word(req->num_retrans, ...)
  for ECMP path selection in inet6_csk_route_req(), making the request
  socket path consistent with the established socket path (Eric Dumazet)
- Add comments explaining the >> 1 shift for 31-bit mp_hash range
- Add comment explaining the ir_iif update rationale in tcp_check_req()
- Use socat -u (unidirectional) in selftest to avoid SIGPIPE race
- Increase tcp_syn_retries and tcp_syn_linear_timeouts to 25 for
  better rehash coverage; add tcp_synack_retries=10 on the server

Neil Spring (2):
  tcp: rehash onto different ECMP path on retransmit timeout
  selftests: net: add ECMP rehash test

 net/ipv4/tcp_input.c                       |   4 +-
 net/ipv4/tcp_minisocks.c                   |  13 +
 net/ipv4/tcp_plb.c                         |   1 +
 net/ipv4/tcp_timer.c                       |   1 +
 net/ipv6/inet6_connection_sock.c           |  11 +
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 361 +++++++++++++++++++++
 7 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.52.0


