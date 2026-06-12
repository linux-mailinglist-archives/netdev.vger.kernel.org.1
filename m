Return-Path: <netdev+bounces-298608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iBcAAQ/xK2q4IAQAu9opvQ
	(envelope-from <netdev+bounces-298608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:44:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860C6790D0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:44:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ZkQQ/xls";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298608-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298608-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FCE731F2ECD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01B3E833F;
	Fri, 12 Jun 2026 11:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DF3E929C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:40:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264460; cv=none; b=HU+mPPaqyv1bNed5irNgNxocY+ewLaOUEQd+NYauByLb5v/tAy6btlBSSCIrSimqaPrwHQi61qOojAEI9UXzFVGGYDgfc6jQLS/mykzNspSQQ0IAYClnLFMBf6RvsOOuhDg8uX3IXeY+TH2q8TOk/uZvfy67OwCJspg7p63cb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264460; c=relaxed/simple;
	bh=pJ/QyvoAyb5v+r2U61ucd8SlUzxeU1gohB/ziTC8eW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYk0hV0W1u6D1HivDEy3Y4e7SWe8ZVOkgVEVIyAsqE1ws51Z4un+odvdCwalU75gSgcepF5uE/CWnzmdiCBUyPnOd3Bogbhg3xdhuVqfA4K+qjP/3oKL32xgzGeMAiyczolAHFc4uW1d2JXNM9/dZR52BiRRfUSfZBUq9ImUde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkQQ/xls; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so548202a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264459; x=1781869259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO5l5ehIJQy/8ncJAgfC2hVtehf0lOaUgVls6srL24o=;
        b=ZkQQ/xlsyAwV63tXS5gGgEoLPqFO2FFqpYWTrlvJbfQ3QDDldjuSOoIraAWjf3zc3g
         kiEqaOoXH2AlJcJUe7joYbPgE74K+zhAdZ5KDAuyjob0jHOtVJfjs+VGFOMBLbbLy00a
         PJrftoY7AxGuH8u49YdcaGiEyntBZt0oHYm9sjapdCudqkESCTueI53y4rch1VUSQ1jp
         jNmPln79sxzuSiNKUOhQiXxH5kl8BbyhW6xWLNiu1Wr9t6E/jF+s66lEE0MtQAQ6PAZH
         kvPDDRM3V/CZRuR/M+fAjlvDgfksh1/pCaA6pq39glLaalUTvHLqLh9grTd+fZ/sCal2
         GzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264459; x=1781869259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO5l5ehIJQy/8ncJAgfC2hVtehf0lOaUgVls6srL24o=;
        b=Cmf1IhvTodqtANj5NdzuEDQnzID/zXVLMSKJRxWYfzRo4FViw5gkjDYCUbd+Y64O7+
         CsRDfLaWNYTzgDpny3zVlgq4LviSSNCGNASHlGwp78pQ6dLWS8+QQ2n9YdF5Q/L3fTYj
         nmGZqBjLb+Aprhd8SVtWVphmPixwYaCRKL8XnBnDVeNpW1eZpGE9ztDjC55hIi3d96IJ
         ksm0YEGRKOlsyrU2q3WUw7PuwJ5G6yZ6o+Bp3hJpAvlKTj8Buut1/WLrCc5gQR5Rk6py
         Fufpbfn8h6NTRIQDteCxlzwCvncWU2qaQQKF9XLZvFhHLaM0XIf1zRXPZvlFiZb5gRRI
         CpZg==
X-Gm-Message-State: AOJu0Yxu/gGCZS0uLYweeDFQC5R4EBXskCmpkXstVBFTwIrCOA8Ll079
	/HBWNysge1Vsv7p1qWVsajwWomdaC0IkLigl6UBCVvVETLYS8JxCe6a8
X-Gm-Gg: Acq92OETD0bLJf4JjO+My5KxZQAg/Jx736pNaJlnwbUqW7C/ceocbEvUjzxLb/I1whi
	S+n7yUauRonE1+8GO6OTtNu1N4pPabfxaVSf3Oo01MvrUbAH4hrJRGaRuD7DWxdjrVHER7r9TYQ
	M1W7iffeiIwqfF0yVFkzMFxd9qX22SeFXkxo/9Bj8QBjEWT0ibw4a2ohrVM0rt+n0B398cJ9pGU
	hdRiZMl/N/o2yTuxli6fjUtdL5bG3KVPEBnm2bZoEiL4u6onJ84ndHDd8+8NICIpKNniI7bHkjD
	jWvIYppuUihvjXteKCsfu+d8T8BPQeJQEyfuBJyw3VWtMweUiF0Ocw8sft3xVYFoOCbErgmxCns
	cvaEd2LM7FgZ83SOCFLGi/WI/d8G3mNBlb1pzFCgKo099XkJ0ajcQtGPqUUnfzkO5egs+QAIJvT
	KtaAjKighLGFfSswVA0ahPgjemQs58P2xHdZc7qME+Pr6wJsSzpia3l5ab/35/PbwXdFWYZXZq9
	/CPkfldeHv9AcYSNsU7KmY=
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr33621575ad.15.1781264458780;
        Fri, 12 Jun 2026 04:40:58 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:40:58 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
Date: Fri, 12 Jun 2026 19:40:31 +0800
Message-ID: <20260612114032.244616-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6860C6790D0

Generic XDP devmap multi redirect uses skb_clone() for intermediate
destinations and sends the last destination with the original skb. This
can leave multiple destinations sharing the same packet data.

This becomes visible after generic devmap egress-program support was
added: a devmap egress program may mutate packet data, and another
destination sharing the same data can observe that mutation.

Native XDP broadcast redirect does not have this issue because
xdpf_clone() copies the frame data for each destination. Generic XDP
should provide the same per-destination isolation before running a
devmap egress program.

Fix this by making cloned skbs private before running the generic devmap
egress program. Use skb_copy() instead of skb_unshare() so allocation
failure does not consume the skb and the existing caller error paths keep
their ownership semantics.

Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for generic XDP")
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..28bd44591ce4 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -706,6 +706,18 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 	if (unlikely(err))
 		return err;
 
+	if (dst->xdp_prog && skb_cloned(skb)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		nskb->mac_len = skb->mac_len;
+		consume_skb(skb);
+		skb = nskb;
+	}
+
 	/* Redirect has already succeeded semantically at this point, so we just
 	 * return 0 even if packet is dropped. Helper below takes care of
 	 * freeing skb.
-- 
2.43.0


