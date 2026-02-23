Return-Path: <netdev+bounces-259938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHwCHNEQnGna/QMAu9opvQ
	(envelope-from <netdev+bounces-259938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:33:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C6173141
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B79302415A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F334B40C;
	Mon, 23 Feb 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="E9tEI4Yd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA925B30D;
	Mon, 23 Feb 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835546; cv=none; b=Smqd5DxZbBAsxTpeuZ5oZLsRrNkhAbZCpM/Emzb5yV+rKMsYDT9cATWA93OtY6NLqK2efwkkS3C9sGf0xSL8HG+cB6OUGPpNghdsdcpfmG+dpxJWgNz3w0L3RZO2+Ky3h55irC5+eq9XqAJtB+VmdqM965dPOd0EhW6vuUjrfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835546; c=relaxed/simple;
	bh=4ieYK3cRf1tZwlyQChJjd4gD7zfKRU8fr8eKjJ9PXgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asLxm+p1GyVeEUmo9S0bLAb6pIMjxhGQcW3SQJyIo1PyIgE1eNzUIYbScjNHiVcHYI6dk9mjhY/xp0LOJ7zOGErmx3tVwxji1aTCkMZWpchbqJzZqduBdmoc9Rey9OmpShISGKyWWh2SeyCOvZXWASgaGKcpD2rAaO1erQX0mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=E9tEI4Yd; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8KlEj878227;
	Mon, 23 Feb 2026 08:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=vYx/jH9GitWnsBNFZ6gIWwT1tUF7qtMtnlpm5bKI1ao=; b=E9tE
	I4YdMdgamm6S1NJDj0eH2ZTux/AOLa/uLDWIIJzakq5zncTd+WAfXJDhHCYH+/g6
	+ndvWTS0L9YSqypWyxp1PgXXpizgh4Kj0v3TPb8GGAr7EyaPLuKXDAFINmzQaFPj
	e3lPB1XvmzDAfh92GQNHYg8rWr+gwgvWGWC+oBZhLDbSftouqYXoCvwre83JBG8k
	tvG3eoDX2EAFn7p9JuL6QrzDLzoY2tC0hUUsViAfmm/xVOe52FGPgUq4Jhc//Nzl
	+r+EV50xKCcaS/91ttxnfd2/b2ZMgGxdYJs2mAVUEL8hZhFVTJY3h2goMJH2vJjX
	D0dT7pE7kd1YOuhcAw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cfs69uq9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:31:43 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:31:37 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer params via SCALAR_VALUE for trampolines
Date: Mon, 23 Feb 2026 19:31:19 +1100
Message-ID: <20260223083120.23776-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083120.23776-1-slava.imameev@crowdstrike.com>
References: <20260223083120.23776-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: NkhjyTNwDmIHDp7QeUP4Lx0iCQt85Vfx
X-Authority-Analysis: v=2.4 cv=COInnBrD c=1 sm=1 tr=0 ts=699c106f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=XeiW-fLPYlId-uVOQeEA:9
X-Proofpoint-ORIG-GUID: NkhjyTNwDmIHDp7QeUP4Lx0iCQt85Vfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NSBTYWx0ZWRfX5+S+U54PN+KX
 0N6UXL7F6CXHAhyff63vBySjDi4f6aWtZGcIu4ybTY6RCjV1PocOKjSz9XKDe1wfyU2WsSw+xwv
 VA8NQzpIzmW9u8jq0HgEAbCpTwfsp/s1VTaNTRQXbM6vApd4G5+jlAeSwxTfDRk0CWkoMZCGztd
 XtZjA9AYYdi/FxXM3HYWU/HBnl3vIamVT8rztZiI6N/C2LfLddE9tKX+2LhPQEj9+urnP6yGTjm
 kDiXAnIDc2CaXz2RlZwuubfTxtgLgn6AFKfF1kdiACLxkRik1gm//eVmFsrNLppZqlm/ZjCq6IX
 ca1cvgupou5UbP9vHWNJ2lgUH3TMD+4Kv87eTNKe2SfFpwpw5lmuz1+YAd7iwTSSWbEYMNFHMJ0
 5U1o6eDro+GB251lF1vmmdKd95lG3JrrDKHZthm77KU6rTwVm0AhCtYgkL4h6AOjLwThJHMdo4w
 UixnucLSgRW1yUM8lAw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11709
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259938-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crowdstrike.com:mid,crowdstrike.com:dkim,crowdstrike.com:email]
X-Rspamd-Queue-Id: C84C6173141
X-Rspamd-Action: no action

Add BPF verifier support for multi-level pointer parameters and return
values in BPF trampolines. The implementation treats these parameters as
SCALAR_VALUE.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 kernel/bpf/btf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7708958e3fb8..ebb1b0c3f993 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -760,6 +760,21 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 	return NULL;
 }
 
+static bool is_multilevel_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	u32 depth = 0;
+
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	do {
+		depth += 1;
+		t = btf_type_skip_modifiers(btf, t->type, NULL);
+	} while (btf_type_is_ptr(t) && depth < 2);
+
+	return depth > 1;
+}
+
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
  */
@@ -6905,8 +6920,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/*
 	 * If it's a pointer to void, it's the same as scalar from the verifier
 	 * safety POV. Either way, no futher pointer walking is allowed.
+	 * Multilevel pointers (e.g., int**, struct foo**, char***) of any type
+	 * are treated as scalars because the verifier lacks the context to infer
+	 * the size of their target memory regions.
 	 */
-	if (is_void_or_int_ptr(btf, t))
+	if (is_void_or_int_ptr(btf, t) || is_multilevel_ptr(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.34.1


