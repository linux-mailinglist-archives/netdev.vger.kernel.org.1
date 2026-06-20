Return-Path: <netdev+bounces-300773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id acqtNsP+NWru6gYAu9opvQ
	(envelope-from <netdev+bounces-300773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 04:45:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384246A838A
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 04:45:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dXr0xoqZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300773-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300773-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81410303768C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E91B87C0;
	Sat, 20 Jun 2026 02:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6185CA5A
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923483; cv=none; b=UqC4g+81j/99XmWh+KJgYjfCLHwbRv+VBL8D8wJlA5plg73rvLuRY/U5gHL4KFS7Wm2bO4Kv36YyH2YXvya7LWX42d3MGIZUW2jo3vOcBYKUlXiHXWIs8NZbSTO2cEYW7RiEaOUtqjrZFn2wmnoJDldUqMcB4fpp0AaojgqYCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923483; c=relaxed/simple;
	bh=m/iiaSixnfb83KYCCVPaoDdsHHEYkoZLQwm1uMN5ZmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDW3Dsd2FYNr/7WiBWFOlgzmX7DL+BmM7ieOPEL0YZengUP4hT2E5xgYnsWHJ2okMhaH9UGY9rAUqNtoxIADMSYgB8d2N2ZCH8hluzYiaj6MmuMeINdunqAVYDxyg//R+Ij7tNcPP/mZ6t1QdJNmvuB1MkdpCItNXPAtbilnBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXr0xoqZ; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36c68964315so1339907a91.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923482; x=1782528282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5XmdnIL5m1N2UxN+NzNP0kc0ABgydLtyGivJ9LKVXo=;
        b=dXr0xoqZG4ZQRF/uDv70mNaSstEMhgyY8UeArvahH5mEp2bXQOKIl3atUrbj0ryY9s
         pnF4R1ZTOmde8mgHe4hwiisOFWcgRYsLXU2XDXW1kbXLvy55PVK6oYhSFpufbWQ3usLN
         qLG/Zd0/ZWOw0QPDZVEZ3GMCJIwbjcC42LIsfvan2IOrDUCXy4QbG9pdeEdu7OMns1L2
         RWXoMDaz87o1wwEu87WWjGcOwZ+X9a0DT4PSmKMf/5pEyzvlblyVJtCpcbB828oN2Sty
         WfP19HxQtC7/6AmJquzuNAvwMprt1p8VBWDe9uWxH54HWLO/euQN3b48azYwUWbZxZZf
         MEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923482; x=1782528282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5XmdnIL5m1N2UxN+NzNP0kc0ABgydLtyGivJ9LKVXo=;
        b=nTNGnqODlIOTdZoX7eTpk3qZ4ovmcpgySP0rsU5X+XUnp3YZmYVE/4c6BUcxFPtBgN
         oxjavOCxn1AsbyG4RYM/POgN8+DDfIjMM0F4rCMRZQ4p9zXJUvxe08rjn4i+RGRyw02x
         43/hpsK/AUVyNHaos9xGEDYn8Co+AG/iVs4a1v64b0HMMooXPFzZd83ImwA9hRHOtb5G
         OgvkL43G9yprv3lopB+Ym9AJR0UWg7g4Xmr/lI+54o+XOe6cW2coal7HGt573kFo1xhD
         VHveILOaNqN0nN8KXPNt4JFw2Askl6dvw6wvNj51WlJ/5QKV6BYJgOSpzc2BianPPUa6
         NU/g==
X-Forwarded-Encrypted: i=1; AFNElJ9vB1Sgu1/GG6RKVCSPj3ckiMDuwEmciwPT5Yz5PHOOYySEWTjDYAHufRSnC5cK0poZOzAoW5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrs+6+Je+swYHZqXKnXuJpczUfs9bZ2GrdgOGZ9Po3xn9Gjvu
	8eti3bIvpbZuAVxOueFPRq4dmUJG/Le4y19QKwOLKn0XzprYNcmsB5r9
X-Gm-Gg: AfdE7cmWWhiaW3TfPSRy5dGgESIvO9uGMH3QM42dzv9+kBDye7TQxmrWn2M2OLBGPQr
	9fPxw9AFQ8IXS8FB7NogM6nWkqTyMtB2mw3Jyb1bpEzhj4l4GgSU6fbSsDpHiEAX/e6hNn6LK6k
	EGgRmv3ivLsFFwpNWBZWOrkMD9njVkBfri/lvttidBITf/Q68r3dp14IIgJ8PT/Cm9CF49Ujcqf
	8qLr1t5vmRQx6p/OffKvd088sjSBAq5XkOUbibzZFUNM7D22dKoplsPyZJlPKlAFA3ybiu3gp1i
	AZzpB/bR8u9Bk3Th+dkZBp5A0AfiFD4MudDeOBm2YxcHGhUrzU6f2E2tsms7wPYQmS7oG2xUQAL
	bMcgFFbL4MxGTRAvLza/dYDX0RRi8SU7mRf9PyZi6t3GJMRtoOMX+1az37ZnsJfFLLq5w1Hf/5M
	pGia1ZbZnIRDaOGYaMyw/bZ4PkAOJufjQpKsEhedC5PXrsxs948WV1RNcQ9LGGAA==
X-Received: by 2002:a17:90b:4ad2:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-37d4e8588e2mr1766868a91.22.1781923482074;
        Fri, 19 Jun 2026 19:44:42 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:41 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: don't modify the skb in the strparser parser prog
Date: Sat, 20 Jun 2026 02:44:16 +0000
Message-ID: <20260620024423.4141004-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:eddyz87@gmail.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:memxor@gmail.com,m:horms@kernel.org,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:bobby.eshleman@bytedance.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,linux.dev,gmail.com,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 384246A838A

sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
the skb: it calls bpf_skb_pull_data() and writes a byte into the packet.
A stream parser runs on strparser's message head and must not modify it.
A resize frees the frag_list segments strparser still tracks, leading to
a use-after-free.

Make the parser read-only. It only needs to return the message length,
which keeps it attaching once packet-modifying parsers are rejected.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
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


