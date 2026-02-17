Return-Path: <netdev+bounces-259056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jb4NUJ8lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:33:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF814D314
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B61493012844
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21136C5B2;
	Tue, 17 Feb 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blm4aGhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59936BCEB
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338789; cv=none; b=jnI1ydoKDvKxstgk+MAxvHqJb7aC2mhoSxe32iTG5UW8TjszxWpqWtTzTN62U+oj/uSjvdbd/YGcDvW9PFULpXpH5++ipEIuEL27FXsVImntnzxh8JS0yPBi4Vk5KLbXy3cWbWuXTduh9LlCnNRwPpEuCNCFXHlTQFC9lREtd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338789; c=relaxed/simple;
	bh=7wYcnvlwXxMtmytoFvwS0gIZLk/ErVQm+KTlcn7X1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwJGbKU38CcmWqC6/YcP/0HaX00+81vHwgwdMQ4IBuvdX766Fnd8IvYyqi8/ru/XdMocaRI6NPorH+rn/2UW2LC1hY2MkpJWGVfN5rVELyLj4fSofDISoHnE75YQDGGEZt7CC/ccvALyraVjxr5J2c+fIH+JIOffbIyODfBCa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blm4aGhE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824a9348603so1584646b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338787; x=1771943587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmaglD0okUceIHjkPS7+EHjYvS/v7GixIVmf6reFCj8=;
        b=blm4aGhE3QsvvH6GIsyY2akUDAUMd4aDeNTrh45Yp5wV2EizVvNxAr9pHj95279jN2
         QsXppE/lXoav9mcW3/EOpY5tHxJLiidNqtgsp3FQOsb53pmcP3zsYm6Bzfz9GER91PC2
         5PjEs6fGy5mjReOsVc5EdWz8EgOB+HbBWU565rD7Fn4kKPklZr+6BB1Mg3uOKGXGCmyy
         ZmqGVcQvk6fkS+azd/AsNcGlwVHeOxBaCoJ6mieWeCP6KFtb1LftbrBLBsNt3SzjtMDk
         OKkcPO6eLZVqkISz719BEpLOaYtIMlmK7Zi2i1mH2RuSeJJWEvLKxu8dcu2Rmudh0WnN
         UVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338787; x=1771943587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmaglD0okUceIHjkPS7+EHjYvS/v7GixIVmf6reFCj8=;
        b=laSQqr5qmINB2i1BM686VJMh4ch/QR48rTmQil/VdtfnjzaIzaXiRl7mI/eB7SfOl9
         zk+LSYbf5LH1zImjAthl8FioNgtpOhgeMnVzj3rlf4mUKnsgv+v4y4hlwPsTHHD5DYLC
         IXbogvMwkOMAIuzgetqNUBen+aTtyNMCYMpNHrXzbfbdaOXnTSJrP/PwNn0zZ49jfvg0
         tod7oBpJF2y9KKRpJDGHi6rU22SUCOJ0Cbeo5ylqs0+5IjUJpKt9PkqyaJ5Deeit1ihY
         mt9AA5iNIE06bpnO9ykA/aZJuE/r74uN64K3Fsw7hBnpH+c6o3l5Y+hTNtA5f8QaEDDD
         ITeA==
X-Forwarded-Encrypted: i=1; AJvYcCUejHEpUOmnoskijkDrinMAkLmBTQb9tnEJil8xiNq6wnbOF1Dkbid945JWFwUWEYxg14ofRhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BoGL5gXDnnJkNO9AbpG4ZP+vZZV5qkLJG1uz3we+evUbh45R
	fRquZHsgjeoXCMe91VegrmZ1eYLlaQ+vynC1guTTSj331OVVIrz39VD+
X-Gm-Gg: AZuq6aKML1FFMzoQNEQcODfrb0dXn1Pp9WETnAGmSFPvmdcH/fw2m+xFxc5jkU/Gk7N
	Cgku6xrrxinGeGVvoyka2iXRpFe/LtCG0iKclxb3qOBao51i6xfNq/jPbldjb4ODMa/1JI+nHCU
	hmtfJpwTK8ZEnwZotYkWqdioqSjo/8nejpN/w80jFddHJyjx2RVNsk8eZ4wjXeYBXbAgozBxYnx
	iSQ0FHQFMbPxNNNzg2ysS0AvYKH2oBH/NIMIvLHiZimGnvLmq5xeWybN+x2P8VjziXrs9jZr9TE
	jND4FzUgomQ4+PkuNjspy9weY3ZRY2v0sxY7j3a5e1CPVlhGFJxf6nF6K2VKsKkCFJYegtE5v2b
	dCmoZo7BKI7XnKqdMA+FPtBuAcbl0iG30KYt4sx5XpbpP27rXAE+HIOZF0tEQzVi/0FnyffbOAK
	pf2DsFEAObCpKE96No5Py+hunUjBTcfFn0p/d1BI5GtPhIOaD+3eVEbxp/O6nt//rJTFYJ/kVPA
	XEPQHiBP83LCGLWoYmh
X-Received: by 2002:a05:6a00:9289:b0:7e8:4398:b36c with SMTP id d2e1a72fcca58-824c963e848mr12234784b3a.63.1771338786467;
        Tue, 17 Feb 2026 06:33:06 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b935c6sm14770821b3a.47.2026.02.17.06.32.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 06:33:06 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH 2/2] bpf: report queue_index to xdp_rxq_info in cpumap and devmap
Date: Tue, 17 Feb 2026 20:02:42 +0530
Message-Id: <a44f6bff92b7f2d0f86c10214c2e861164e52a03.1771338602.git.anandkumarshaw@users.noreply.github.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
References: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259056-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,google.com,redhat.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,users.noreply.github.com:mid,rxq.dev:url]
X-Rspamd-Queue-Id: 7CCF814D314
X-Rspamd-Action: no action

When a second-stage XDP program runs on a cpumap or devmap redirected
frame, ctx->rx_queue_index always returns 0 because the reconstructed
xdp_rxq_info never had queue_index set.

Now that xdp_frame carries queue_index, set rxq.queue_index from
xdpf->queue_index in both cpu_map_bpf_prog_run_xdp() and
dev_map_bpf_prog_run(). This allows BPF programs to correctly identify
the original hardware RX queue after a cpumap or devmap redirect.

Resolves a TODO left since the cpumap implementation.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..aa2e929792c8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -346,6 +346,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		u32 act;
 		int err;
 
+		rxq.queue_index = xdpf->queue_index;
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
-- 
2.39.5 (Apple Git-154)


