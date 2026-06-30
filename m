Return-Path: <netdev+bounces-303367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y3OJA74sRGocqAoAu9opvQ
	(envelope-from <netdev+bounces-303367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877C6E7F0D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k0hIWX4p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303367-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA36A308C292
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1947AF6B;
	Tue, 30 Jun 2026 20:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0F34DCC7
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 20:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852671; cv=none; b=XaFxM9so1Rg4YCPBZCUChcEXCNkH+0CQoP2UWZNLESRXD7at7wVE0bBLVoZGdaMwiFiJ3wf1eLuLz8u+wxNayg8Rw8XC1D+XUXJmyrILrg83QSorHo3mSRHS189nc1y45de8vIWDAyrT3w1ebE4z7g7OQO32Xg2D8FZkhXaxjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852671; c=relaxed/simple;
	bh=vIZVPtoekYXA97ar0f3RVpNBTUnPvEkA2N5XD+HOG7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnCDN4g/WvhYIWOBINUACzq5GIi8x5X3ZMEa3CgcqPe5jX+cN4cbnEq5Y3ltAszue+M3TG28DZqFfPne7sKOhqEeVMIqtTTTGnDeII6gJsgXwg2/V4RXlGrf8wM6AzPofwzqc9nfg7SHfqfzaUPrjkNiZHg7hXHulTjgUhKjFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0hIWX4p; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9cb97e178so29710105ad.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852669; x=1783457469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+9mrYL3HnxDWYVBXM/qgCi1xc+LI25f9+ZzQtFcgdQ=;
        b=k0hIWX4pvkl2yOfEqWeywoYdPHqAdSHQYqwJT7PGfZ7lxZwb2N/nD/tkBHHZgbjNv2
         TK2B/Zj1UHEvtRpuBtnREbHJnA92RKNFpYAXgM7T6HoSoyLmj7uosYMbi7PBNg56KfSr
         mvbkrKHo0PgBpVNMUH7+zd4nuH97Y1J3biLUCeKtPJ/tsr0BemKev+gP4YDOxZLRc25l
         +PeWHc0Xdi6O1QzaTBeCuWAmW64EX3OuEzyty8m5bW8tsUbcWN8Q526fRe1uF0CjWKTK
         PSEEGGGqpVKe05nkEJ0wjqJ0nM7Q2AyVbq749RYRDLu/Q0nuhK8kIcItYSlvH30Chrs8
         9x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852669; x=1783457469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+9mrYL3HnxDWYVBXM/qgCi1xc+LI25f9+ZzQtFcgdQ=;
        b=kLCf+tceQI92ng0rJBIvLn8ZF1pRMTxZmmORwdjSebBu/Wwk1gbMmolzt9kY8pSpan
         Dj3u9TFT6t1xoKHkCIEAZqSxJFLFV/HIebqtYV+evi0PtuVMUNjp/0N0NNjb25Ao8Wws
         x1zfNkXODfyy+0T7biEACu6+2AM6y6Xy5Or068f1pM9uHPFAV1EPYfPWLRo8YPykz+FD
         vAJeIbongODTU4uhpaJ6akJ81mS5ZEuXgF6FNjfWJPDWYNQtiEbQsqx2YlEVR2NX0U4C
         jxuEA5QWQSZ7d6rhJ2YLMBot8g03DN/V9n+YXFb9am+wcf3vWL1/AEDux8Hrj3gKmkvL
         RibA==
X-Forwarded-Encrypted: i=1; AHgh+RompVdhYLHcpx1dpwx2bAa0X6ix5J6eib7Gi+p1LQLka8gXo+4vMxR/R5RHivxTwPh9XV+X9AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/wo3xAKl6WnZ7pSRpmU/95yegcigjcP5JGohQvXSYaUwe7yT
	GaV7zNIIhTdlBcFrq4xhhYii7UjT3NCDlGbpwZ8hF+EUH7hkAvfECPEd
X-Gm-Gg: AfdE7cnOCE5mkYAxUxTQngQPa5+ndIuawKfY0FLjsTelQF3YRCQ8nZuy2JDuAmepyAE
	0H4I7+CgJzVhfL9Qmm24RrI2nRGMjbwYCo3T+wzek0Dp71DscxKMBZBtnlgYBWPykBRHaCMU7eI
	vmv3u4o4EGyZ0mJJUBouGZt09gpZDwAS0jxrfc6Y2yQ2uA5YlTZwIIn++hZ8riJ92e1xCM/UTOj
	qtR64pyqm0uWA02DLtQROw8JxygNmd3DGPrGdopXds/Z0PRSzeP4ggHv2D4bSf/TAgGbBdhQ9JJ
	g4R4v//4qU5jM+wZayG4vFavxhhdpeEEA0GOLr9KJuGuo9Y/muZ0Ouu5T+ZXIJz0XUgCko5Cva/
	zOCIutzPTIad5o4mzRnVnR6LQA/T4MuOHPfrG/TIsIcXgab9OKxPdRTNP/5i9b6F8gQhlu3YDTW
	Q0ycMJ8aa4LVPr2lDUdMS6J0GjSW2wISK7OkHHcFx9AP8KQ0kzocY=
X-Received: by 2002:a17:903:1b03:b0:2c8:1c05:16bb with SMTP id d9443c01a7336-2ca2e71bf72mr41313975ad.24.1782852669354;
        Tue, 30 Jun 2026 13:51:09 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:51:08 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test sockmap strparser recover with undelivered ingress
Date: Tue, 30 Jun 2026 20:50:35 +0000
Message-ID: <20260630205043.184894-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
References: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	SUBJ_BOUNCE_WORDS(0.00)[];
	TAGGED_FROM(0.00)[bounces-303367-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:shuah@kernel.org,m:kuniyu@google.com,m:horms@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:ihor.solodrai@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5877C6E7F0D

Park SK_PASS data on a stream-parser socket's ingress_msg queue, drop the
socket from the sockmap without reading it, then check the native stack
still delivers data queued afterwards. Without the fix copied_seq is left
behind sk_receive_queue and tcp_recvmsg_locked() warns instead of
delivering.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..86b584f5491e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1292,6 +1292,63 @@ static int wait_for_fionread(int fd, int expected, unsigned int timeout_ms)
 	return avail;
 }
 
+static void test_sockmap_strp_recover_undelivered(void)
+{
+	struct test_sockmap_pass_prog *skel = NULL;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	char buf[10] = "0123456789", rcv[11];
+	int err, map, verdict, parser, sent, recvd, avail, zero = 0;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1))
+		goto out;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	parser = bpf_program__fd(skel->progs.prog_skb_verdict_ingress_strp);
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p1, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update(p1)"))
+		goto out;
+
+	sent = xsend(c1, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1) bpf"))
+		goto out;
+
+	avail = wait_for_fionread(p1, sizeof(buf), 1000);
+	if (!ASSERT_EQ(avail, sizeof(buf), "fionread"))
+		goto out;
+
+	err = bpf_map_delete_elem(map, &zero);
+	if (!ASSERT_OK(err, "map_delete(p1)"))
+		goto out;
+
+	sent = xsend(c1, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1) native"))
+		goto out;
+	recvd = recv_timeout(p1, rcv, sizeof(buf), MSG_DONTWAIT, 1);
+	ASSERT_EQ(recvd, sent, "recv(p1) native after drop");
+
+out:
+	close(c0);
+	close(p0);
+	close(c1);
+	close(p1);
+
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 /* it is used to send data to via native stack and BPF redirecting */
 static void test_sockmap_multi_channels(int sotype)
 {
@@ -1447,6 +1504,8 @@ void test_sockmap_basic(void)
 		test_sockmap_copied_seq(false);
 	if (test__start_subtest("sockmap recover with strp"))
 		test_sockmap_copied_seq(true);
+	if (test__start_subtest("sockmap strp recover undelivered"))
+		test_sockmap_strp_recover_undelivered();
 	if (test__start_subtest("sockmap tcp multi channels"))
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
-- 
2.43.0


