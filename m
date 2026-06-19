Return-Path: <netdev+bounces-300610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44PWEUbiNGoQjQYAu9opvQ
	(envelope-from <netdev+bounces-300610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB6C6A41DE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nilrkEAu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300610-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300610-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A771230819EC
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A9634DCD2;
	Fri, 19 Jun 2026 06:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC23242AC
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:30:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850651; cv=none; b=PcVBkoEW54YGao/rbc5SdAIlkgAjPdX56BBH/YEdDawaVblK1Uo6F6ivcZgtIFksPmgyth5pJfNMTLqlSQFl1wXpI1VtS3E9UoHrm6Q9w1gtNxdeNS+vUEtPv/m0Ve8MwGTX5wEFyy3f6PsaJgRXyMJG7N5Nk6DOTw7WLXOdjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850651; c=relaxed/simple;
	bh=JMv1VF0ekCwbw9SWvhd6zEKji0osX8O3WfZ/H6jfaoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmeC7/p3eyS+yiRXalL82he8LkaAwnd6nEvMBEYnzsHhes7kusgvOzk/qOdm+oqJc5ZrF8hq9bpwo1SilrlLjoE3ilaRHlz9L+C0BIEQv/3jBxmaQEXyKVRbFg9CxtrZrpAd3aAg0Pr7H1Xukp216HxmHLA3Mp4Sq/OjS2db+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nilrkEAu; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8422f395a4aso1194028b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850649; x=1782455449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpvtH/MELQ6WeOgVZKeeEGkQECkK0rlO9TvkyMUA8ZQ=;
        b=nilrkEAuWoJ7MFTezcUlCY7ckcxMgAfp1VNp7b+63JIlpE+xhvs8n9sLM2vHIMQQVj
         88twXW4UDh+1TRfsnUn4W5IxNTG3ApRtfmX4jLrfRgKeAHfIlQlX+jWrx6sXVBMsJnhg
         RF5w4Fx/BfzOylBFVEPjFpcIpZtCM+Y3kxTBhugjjeZ6N7vkkBeuavKpHgrhDUt/B8xh
         +dngGk9DwiuQ7hHfOVPfhuOTWFL/I7wxmV1DHfBSCjcyZfwqUge0cWt7X1bNBZhdx6FU
         UCaREDVwyfe/TM+o7ADplmB1lY2RH+1RndD3tiu66myP+Ho8GvfpUuaOqB+rAx/DtBK8
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850649; x=1782455449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vpvtH/MELQ6WeOgVZKeeEGkQECkK0rlO9TvkyMUA8ZQ=;
        b=d+JD5DneNQyxOKcZdrar3aLdxl6yWBSFdfIPqwTmrqJVa5lJV9ls1QDyiZnyw3BZSR
         eKgOQMdft4DWcn+BnZ4j294FQ+spvw+OhsVvfbLiY7GZzUts4O2CfmswIXfl7LrC4+rk
         e0Y0GZDL8tYmlNTNTuNVBVYeSAjSqwCpI83KrkYO2FxWPEbInDktIDX3gbJDLdhN1yjz
         0rilFPRfLfvc6wKQ+09Fa+9w80+nwBGMtcaHjaVCy8mH1QKy4tFLqkjl1IivCrt7JGey
         k1H/zrf9+2yeGsBmrU1we4UV/bgom/LjTfC9pDT+xJofOa5y9oQltiyvvTvSHc6C57d9
         FkJA==
X-Forwarded-Encrypted: i=1; AFNElJ+wQ0tUEBqk2QL6cuwqAqJpcXzAh46FWkv2jSHqeEkb3TLXqiQrLZpaP2NZyElcA+lCRtn/3h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjLVd8x8L8uRwr67YMzQHs4r+xv+ZjpL2+Q+138geWXeWyOBx
	u64E6uIJbCvQ5M2MZjjQwyUuoL8Us1PtJ5UtGm1t0AeJKY5hYhCpx+70
X-Gm-Gg: AfdE7cmmqb/rgCIDO5DxNBZ/jbxgxCczCvQudhoRYE5i/PCLao/XIKtMsdqG4aLkO90
	9D/dlqB/mqrl8ONdpjO1oklsIe4xu0eVMkiXzF6y/8QrE6+bNH5hDlGYNbnIwO43Ss4kYwlIX9e
	+Svfb8sLdwC2khnmZgHlRtZrgugLSpk3aOfmBKxy3mkvxrNMf9bVQI04U94xQ7Sbrw/MGrJWhED
	Fmz4qWEhBtFvXA1ehGfDhN4KYMVw5c4+BaPucVfepnVV/cxBQOjqBikRtBXum2hNbH8zuU85VCC
	GNooXLb+YFMbDJuWFS8WAHweIUSDdS9o5yXh/bE5hGjDcWGs549nYkCBmkoOQf0KNjBLyvh/X3z
	d5pxfUixKYzQ4ZC9KF+pQ10vtxTuNLyBVw19aTVRUluPbw7TVFyr47gIL06tFOlYaCv53qGrI12
	nAUOM8MbryH4acd0q93BhstYrFuKhEf2WuxK0Fe8Ktd0kwgm8whdU=
X-Received: by 2002:a05:6a00:418a:b0:82f:51e8:b38e with SMTP id d2e1a72fcca58-845502b9401mr1949687b3a.24.1781850649563;
        Thu, 18 Jun 2026 23:30:49 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:30:49 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 1/3] selftests/bpf: don't modify the skb in the strparser parser prog
Date: Fri, 19 Jun 2026 06:29:50 +0000
Message-ID: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300610-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFB6C6A41DE

sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
the skb. It calls bpf_skb_pull_data() and writes a byte into the packet.
A stream parser runs on strparser's message head and must not modify it.
A resize frees the frag_list segments strparser still tracks, leading to
a use-after-free.

Make the parser read-only. It only needs to return the message length,
which keeps it attaching once packet-modifying parsers are rejected.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c b/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
index c9abfe3a11af..56e9aebf05f2 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
@@ -5,28 +5,6 @@
 SEC("sk_skb1")
 int bpf_prog1(struct __sk_buff *skb)
 {
-	void *data_end = (void *)(long) skb->data_end;
-	void *data = (void *)(long) skb->data;
-	__u8 *d = data;
-	int err;
-
-	if (data + 10 > data_end) {
-		err = bpf_skb_pull_data(skb, 10);
-		if (err)
-			return SK_DROP;
-
-		data_end = (void *)(long)skb->data_end;
-		data = (void *)(long)skb->data;
-		if (data + 10 > data_end)
-			return SK_DROP;
-	}
-
-	/* This write/read is a bit pointless but tests the verifier and
-	 * strparser handler for read/write pkt data and access into sk
-	 * fields.
-	 */
-	d = data;
-	d[7] = 1;
 	return skb->len;
 }
 
-- 
2.43.0


