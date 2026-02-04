Return-Path: <netdev+bounces-256694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD/dOXA7g2ngjwMAu9opvQ
	(envelope-from <netdev+bounces-256694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:28:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A0E5C97
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A2B303CC1E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609A3EDAAA;
	Wed,  4 Feb 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PW9jpWSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A33D5230
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207935; cv=none; b=iYlaJiXSPLkHcwsBUVwKulmXtz9IGcqiyXTvYjXALBsnIgJVPTgwyM01/6zvxR5+oh8uL7R1H4maOtOnSkA9YpsMbgNhMMkR11O1ymHGfRoK7iEfMnTvnFLIQy9fBU5faCbcTmCqziqY/Sn/hHvG0gn+wPnehx1h+4xgtTe6QcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207935; c=relaxed/simple;
	bh=442GijrACNIyhOO1PCXlk5yOxBA5l2sO0BEtkSrO/ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qOQt9ysfLUWPcGvuE3pa3hFUTvSfzmXUoQZNs1Wkyw3u9xjldZibFtMSzN5kIh5WIfiNqvoxYEkMU1E4Q5sKd60FqX7V6NqCrVu6MO7UjJp+cSPVn21EWh4GXR98iDrwrlIE9DxXqjtnnDtV6qTG1/RK/RAKHbxDlU48u+uD5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PW9jpWSq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4308533f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770207934; x=1770812734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH8MXVCKtWqJdP7mij43Xe3QvXlt93YlWk5c/5DsI+Y=;
        b=PW9jpWSqEFr9vYeuiN1hEZNBDMAP07jDPrQVot+jcRcfJegIBAUAvqPFVp7nBjrQQI
         RcRvvRS1Y+fiGd7s69W7A0f0LWwQPy77iG6HMiUJ0gwA789dYIpkIEjTWNiuhG6ujT0b
         EwJvgAqMJpLi4o7lUxJAlAgjgNGjyWTAs0X+IiYYkrdyf4YmiYceQGpaVZGthYxXKxTZ
         BhB47D8lOh+ef4Yr5tVL4P26LAqdtzFj0X1KjVj6DBTAUD6yhQ60gjCgyRU3BihFfo/7
         jkeVDJzkiV84q6ClqArOmpmeMyawUu3Ti2iTIA7eebIk1fADUJFFRbKSMe+00e41LzD7
         C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207934; x=1770812734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH8MXVCKtWqJdP7mij43Xe3QvXlt93YlWk5c/5DsI+Y=;
        b=rZ5h4UDAqpx8E4q7aep+MAz8GkMbPtoEYXpzPwXYEVCsKFAwamV71dqiJcugUB8uEa
         jEK3AsSWvmAt/px1lTcw9drRxkfIJUba3SD0mrTI8rsSObhOaNjsQD+G8XMj8SIrHnoi
         viOui2PtptoUNNNDFhi48PXiC4n/2mVVPJFz1uORcTEtVUP9FiwhsvB10VnlIJrV2rXx
         7YdVIpVcQKWS9nHjICFNSr/kZPbrC3lwUo2Nj0VcD+bCgD9Y3NyJvhuJCTH6aX/ijcDv
         E/hlF8KfSnMBVXFr7jliHMMf1hNZLyU34Ocvb3+gLxozOvNu2oU3dAOstSbUpZVoOZG+
         OgFA==
X-Forwarded-Encrypted: i=1; AJvYcCWWWQ6bW0OBeBC57A/YHYo7T4aSYvdNIOTPqoeZ+HMV9QBNJJJ+TrmqQq5hHfkX2CHTuIsBAOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RMT9Abotjqlr6JgvjESTW2pX4oPLfGdip08d2xtSAVE2MFFU
	7XsAHgZTyL0KvbuK1NYsuDrTSXFtp0Bed5+shdCVRatSbI+/JjaKsfa0CRABJSKjgYg=
X-Gm-Gg: AZuq6aKRpC1e/lDwoYQzFV6k7FZjfmRgl7tqjZRDUVK4XAeFdKljwtEgWZ1GYN+IoTt
	xiiRup8TfHpIbpQFdEst5qJ/Ah5E5pRZMCWtrrBuc6vP3sYk8v4zce2QYNsIcwGQtzFaKnnjje3
	MxKAzmKg+N72G2RTiQVPj0+cEjQvbVN9hOefYaFLSqY8+GaNfUI4KZHwqvO2X//gKvcdb08zDVk
	7YrdCgPpuvr7fg7g7KagSXb2gwGbGO3STOikMekKsN/o4M9pngwoBcwBygjSrYqsaAbL9SubTX7
	UYgW6jSBa4ndM+ajBHrOk6204l85lU6sZk+IbB9aw6KFtyWSzygCnj/yZOd6EGPb4IGHqGoreLI
	SniAW29mpxMFF+lM41spNCjUCWHvbZwpuy4Z8/lBqw3g2Y61rOKpxXnCJnTJWHk5v61kuVAyHyq
	rXzeiGC/DQbQG32Oyrnejz5gsIUzdpt72+unh7uDnruVaa
X-Received: by 2002:a05:6000:240b:b0:435:9a4a:9b79 with SMTP id ffacd0b85a97d-43618052a8bmr3855745f8f.31.1770207933548;
        Wed, 04 Feb 2026 04:25:33 -0800 (PST)
Received: from [127.0.1.1] (24.162.85.79.rev.sfr.net. [79.85.162.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm6377318f8f.29.2026.02.04.04.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:25:33 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
Date: Wed, 04 Feb 2026 13:24:56 +0100
Subject: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAJc6g2kC/x2MQQqAIBAAvxJ7bmHVKOgrEWG21hKYaEQQ/T3pO
 DAzD2ROwhn66oHEl2Q5QgFVV+A2G1ZGWQqDJt2Spgatt3NinKOfThenfLgdleoWMq71xAZKGRN
 7uf/rAMXEwPcJ4/t+BgR9928AAAA=
X-Change-ID: 20260204-afabre-bpf_tcp_sock-117d03c6f0e3
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 wferguson@cloudflare.com, Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256694-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afabre@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E6A0E5C97
X-Rspamd-Action: no action

We can already lookup sockets in XDP via the bpf_sk(c)_lookup_(udp|tcp)
helpers. This can be used to determine if a received packet is for an
established socket or not, for example in a load balancer.

But the TCP TIME-WAIT state needs special handling for this: packets
received for a TIME-WAIT socket can either belong to the current
incarnation of the connection, or a new incarnation. The only way to
determine this is to compare the sequence numbers.

Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
numbers to be read.

---
Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index f04982d79d72e92f1b46ccd87633391e38c3da81..5e3a1951130369f070c3a373ea649bd10db412b6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8506,6 +8506,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_xdp_skc_lookup_tcp_proto;
+	case BPF_FUNC_tcp_sock:
+		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
 	case BPF_FUNC_tcp_gen_syncookie:

---
base-commit: d95d76aa772bf94df353b015b1cb38303d4a415d
change-id: 20260204-afabre-bpf_tcp_sock-117d03c6f0e3

Best regards,
-- 
Arthur Fabre <afabre@cloudflare.com>


